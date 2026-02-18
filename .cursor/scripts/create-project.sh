#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Uso: ./create-project.sh <nome-do-app> [destino] [template] [version]
# template: tailwind (default) | mui
# version: free (default) | pro

APP_NAME="${1:-}"
TARGET_DIR="${2:-}"
TEMPLATE="${3:-tailwind}"
VERSION="${4:-}"

if [[ -z "${APP_NAME}" ]]; then
  echo "Uso: $0 <nome-do-app> [caminho-destino] [template] [version]"
  echo ""
  echo "Templates disponiveis:"
  echo "  tailwind  - React + Vite + Tailwind CSS v4 (padrao)"
  echo "  mui       - React + Vite + MUI (Mantis)"
  echo ""
  echo "Versoes (apenas para mui):"
  echo "  free      - Componentes gratuitos (padrao)"
  echo "  pro       - Componentes PRO (instalar manualmente)"
  echo ""
  echo "Exemplos:"
  echo "  $0 meu-app"
  echo "  $0 meu-dashboard . mui"
  echo "  $0 meu-sistema . mui pro"
  exit 1
fi

# Map template names to directories
declare -A TEMPLATE_MAP=(
  ["tailwind"]="react-vite-tailwind"
  ["mui"]="react-vite-mui"
)

if [[ -z "${TEMPLATE_MAP[$TEMPLATE]:-}" ]]; then
  echo "Template invalido: $TEMPLATE"
  echo "Use 'tailwind' ou 'mui'"
  exit 1
fi

TEMPLATE_DIR="${ROOT_DIR}/templates/${TEMPLATE_MAP[$TEMPLATE]}"

# Se MUI e versao nao especificada, perguntar
if [[ "$TEMPLATE" == "mui" && -z "$VERSION" ]]; then
  echo -n "Versao do MUI/Mantis? (free/pro): "
  read -r VERSION
  if [[ "$VERSION" != "free" && "$VERSION" != "pro" ]]; then
    echo "Versao invalida. Use 'free' ou 'pro'."
    exit 1
  fi
fi

# Default para free se nao especificado
VERSION="${VERSION:-free}"

# Avisar sobre versao PRO
if [[ "$VERSION" == "pro" ]]; then
  echo ""
  echo "⚠️  Versao PRO selecionada."
  echo "   Apos 'npm install', adicione manualmente as dependencias PRO:"
  echo "   - MUI X Pro: https://mui.com/store/"
  echo "   - Mantis Pro: https://codedthemes.com/item/mantis-react/"
  echo ""
fi

if [[ -z "${TARGET_DIR}" || "${TARGET_DIR}" == "." ]]; then
  TARGET_DIR="$(pwd)/${APP_NAME}"
fi

if [[ -e "${TARGET_DIR}" ]]; then
  echo "Destino ja existe: ${TARGET_DIR}"
  exit 1
fi

echo "Criando projeto '$APP_NAME' com template '$TEMPLATE' ($VERSION)..."

# Criar estrutura de pastas
mkdir -p "${TARGET_DIR}/src"
mkdir -p "${TARGET_DIR}/docs"
mkdir -p "${TARGET_DIR}/reports"
mkdir -p "${TARGET_DIR}/scripts"
mkdir -p "${TARGET_DIR}/.cursor/rules"
mkdir -p "${TARGET_DIR}/.cursor/reports"

# Copiar src/ do template
cp -R "${TEMPLATE_DIR}/src/." "${TARGET_DIR}/src/"

# Copiar examples/ se existir (MUI)
if [[ -d "${TEMPLATE_DIR}/examples" ]]; then
  cp -R "${TEMPLATE_DIR}/examples" "${TARGET_DIR}/"
fi

# Copiar arquivos de configuracao
CONFIG_FILES=(
  "package.json"
  "index.html"
  "vite.config.mjs"
  "vite.config.ts"
  "jsconfig.json"
  "jsconfig.node.json"
  "tsconfig.json"
  "tsconfig.node.json"
  "eslint.config.mjs"
  ".eslintrc.json"
  ".prettierrc"
  "postcss.config.js"
  "tailwind.config.ts"
  "favicon.svg"
  ".env"
  ".nvmrc"
)

for file in "${CONFIG_FILES[@]}"; do
  if [[ -f "${TEMPLATE_DIR}/${file}" ]]; then
    cp "${TEMPLATE_DIR}/${file}" "${TARGET_DIR}/${file}"
  fi
done

# Copiar .gitignore do template
if [[ -f "${TEMPLATE_DIR}/gitignore.template" ]]; then
  cp "${TEMPLATE_DIR}/gitignore.template" "${TARGET_DIR}/.gitignore"
elif [[ -f "${TEMPLATE_DIR}/.gitignore" ]]; then
  cp "${TEMPLATE_DIR}/.gitignore" "${TARGET_DIR}/.gitignore"
fi

# Copiar docs/
if [[ -d "${TEMPLATE_DIR}/docs" ]]; then
  cp -R "${TEMPLATE_DIR}/docs/." "${TARGET_DIR}/docs/"
fi

# Copiar scripts/
if [[ -d "${TEMPLATE_DIR}/scripts" ]]; then
  cp -R "${TEMPLATE_DIR}/scripts/." "${TARGET_DIR}/scripts/"
fi

# Copiar scripts core de quality gates
CORE_SCRIPTS=(
  "generate-report.js"
  "policy-check.js"
  "lint-gate.js"
  "test-gate.js"
  "run-gates.js"
  "validate-skeleton.js"
  "metrics-collector.js"
)

for script in "${CORE_SCRIPTS[@]}"; do
  if [[ -f "${ROOT_DIR}/scripts/${script}" ]]; then
    cp "${ROOT_DIR}/scripts/${script}" "${TARGET_DIR}/scripts/${script}"
  fi
done

# Copiar Cursor Rules
if [[ -d "${TEMPLATE_DIR}/.cursor/rules" ]]; then
  cp -R "${TEMPLATE_DIR}/.cursor/rules/." "${TARGET_DIR}/.cursor/rules/"
fi

# Copiar politica correta
POLICY_FILE=""
if [[ "$TEMPLATE" == "tailwind" ]]; then
  POLICY_FILE="${ROOT_DIR}/policies/tailwind.json"
elif [[ "$TEMPLATE" == "mui" && "$VERSION" == "free" ]]; then
  POLICY_FILE="${ROOT_DIR}/policies/mui-free.json"
elif [[ "$TEMPLATE" == "mui" && "$VERSION" == "pro" ]]; then
  POLICY_FILE="${ROOT_DIR}/policies/mui-pro.json"
fi

if [[ -n "$POLICY_FILE" && -f "$POLICY_FILE" ]]; then
  cp "$POLICY_FILE" "${TARGET_DIR}/policy.json"
fi

# Copiar schema de report para validacao local
if [[ -f "${ROOT_DIR}/reports/report.schema.json" ]]; then
  cp "${ROOT_DIR}/reports/report.schema.json" "${TARGET_DIR}/.cursor/reports/report.schema.json"
fi

# Atualizar report com data atual
DATE_STR="$(date +%F)"
REPORT_PLACEHOLDER="${TARGET_DIR}/reports/YYYY-MM-DD.report.json"
REPORT_TARGET="${TARGET_DIR}/reports/${DATE_STR}.report.json"

# Copiar report template se existir
if [[ -d "${TEMPLATE_DIR}/reports" ]]; then
  cp -R "${TEMPLATE_DIR}/reports/." "${TARGET_DIR}/reports/"
fi

if [[ -f "${REPORT_PLACEHOLDER}" ]]; then
  mv "${REPORT_PLACEHOLDER}" "${REPORT_TARGET}"
fi

# Copiar workflow CI e artefatos de deploy se existirem no template
if [[ -d "${TEMPLATE_DIR}/.github" ]]; then
  cp -R "${TEMPLATE_DIR}/.github" "${TARGET_DIR}/"
fi

if [[ -d "${TEMPLATE_DIR}/deploy" ]]; then
  cp -R "${TEMPLATE_DIR}/deploy" "${TARGET_DIR}/"
fi

# Substituir placeholders
PACKAGE_JSON="${TARGET_DIR}/package.json"
INDEX_HTML="${TARGET_DIR}/index.html"

if [[ -f "${PACKAGE_JSON}" ]]; then
  sed -i "s/\"name\": \"app-name\"/\"name\": \"${APP_NAME}\"/" "${PACKAGE_JSON}"
fi

if [[ -f "${INDEX_HTML}" ]]; then
  sed -i "s/<title>app-name<\\/title>/<title>${APP_NAME}<\\/title>/" "${INDEX_HTML}"
fi

# Atualizar Cursor Rules com versao
CURSOR_RULES_FILE="${TARGET_DIR}/.cursor/rules/template-rules.mdc"
if [[ -f "${CURSOR_RULES_FILE}" && "$TEMPLATE" == "mui" && "$VERSION" == "pro" ]]; then
  sed -i 's/## Versao: FREE/## Versao: PRO\n\n- Versao PRO habilitada\n- Componentes PRO permitidos apos instalacao manual/' "${CURSOR_RULES_FILE}"
fi

echo ""
echo "✅ Projeto criado em: ${TARGET_DIR}"
echo ""
echo "Proximos passos:"
echo "  cd \"${TARGET_DIR}\""
echo "  npm install"
if [[ "$VERSION" == "pro" ]]; then
  echo "  # Adicionar dependencias PRO manualmente"
fi
echo "  npm start"
echo ""
if [[ "$TEMPLATE" == "mui" ]]; then
  echo "Dica: Consulte examples/ para padroes de UI"
  echo "      Remova antes da entrega: node scripts/remove-examples.js"
fi
