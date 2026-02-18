#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "== Cursor setup (bash) =="
echo "Repositorio: ${ROOT_DIR}"
HOST_ROOT="$(pwd)"
echo "Projeto hospedeiro: ${HOST_ROOT}"

if grep -qi "microsoft" /proc/version 2>/dev/null; then
  echo "WSL detectado: sim"
else
  echo "WSL detectado: nao (ok se estiver em Linux nativo)"
fi

if [[ -f /etc/os-release ]]; then
  # shellcheck disable=SC1091
  . /etc/os-release
  echo "Distro: ${NAME:-unknown} ${VERSION_ID:-unknown}"
  if [[ "${VERSION_ID:-}" != "24.04" ]]; then
    echo "Aviso: recomenda-se Ubuntu 24.04.x"
  fi
fi

if ! command -v node >/dev/null 2>&1; then
  echo "Aviso: Node.js nao encontrado"
else
  echo "Node.js: $(node -v)"
fi

if ! command -v npm >/dev/null 2>&1; then
  echo "Aviso: npm nao encontrado"
else
  echo "npm: $(npm -v)"
fi

echo "Regras do Cursor: ${ROOT_DIR}/rules"
echo "Passos no Cursor:"
echo "1) Abra Settings > Rules for AI e habilite regras do repo"
echo "2) Garanta que .cursor/rules/*.mdc esteja ativo"
echo "3) Siga .cursor/docs/guia-zero-ao-sucesso.md para o fluxo"
echo ""

COMMANDS_DIR="${ROOT_DIR}/commands"
if [[ ! -d "${COMMANDS_DIR}" ]]; then
  echo "Criando diretorio de slash commands: ${COMMANDS_DIR}"
  mkdir -p "${COMMANDS_DIR}"
fi

create_default_command() {
  local file_path="$1"
  local title="$2"
  local body="$3"
  if [[ ! -f "${file_path}" ]]; then
    {
      echo "# ${title}"
      echo ""
      echo "${body}"
    } > "${file_path}"
  fi
}

COMMAND_COUNT="$(find "${COMMANDS_DIR}" -maxdepth 1 -type f -name "*.md" | wc -l | tr -d ' ')"
if [[ "${COMMAND_COUNT}" == "0" ]]; then
  echo "Nenhum slash command encontrado. Criando comandos padrao..."
  create_default_command "${COMMANDS_DIR}/generate-report.md" "Generate Report" "Executar \`node .cursor/scripts/generate-report.js\` e resumir o resultado."
  create_default_command "${COMMANDS_DIR}/policy-check.md" "Policy Check" "Executar \`node .cursor/scripts/policy-check.js --scan-imports\` e listar violacoes."
  create_default_command "${COMMANDS_DIR}/run-gates.md" "Run Gates" "Executar \`node .cursor/scripts/run-gates.js\` e mostrar status de cada gate."
  create_default_command "${COMMANDS_DIR}/release-readiness.md" "Release Readiness" "Executar report + gates e retornar READY ou NOT_READY com justificativa."
fi

echo "Slash commands disponiveis:"
if find "${COMMANDS_DIR}" -maxdepth 1 -type f -name "*.md" | grep -q .; then
  while IFS= read -r command_file; do
    command_name="$(basename "${command_file}" .md)"
    echo "  - /${command_name}"
  done < <(find "${COMMANDS_DIR}" -maxdepth 1 -type f -name "*.md" | sort)
else
  echo "  - Nenhum comando encontrado"
fi

echo ""
echo "Uso no Cursor:"
echo "1) Abra o chat"
echo "2) Digite /"
echo "3) Selecione um comando (ex.: /generate-report, /run-gates)"
