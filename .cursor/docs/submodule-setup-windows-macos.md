# Setup do Cursor (Windows e macOS) em modo submodule

Este guia assume que **todo este repositório foi adicionado como `.cursor/` via git submodule** no projeto hospedeiro.

## Premissas

- Estrutura esperada:
  - `host-project/.cursor/` (submodule com regras, scripts, docs e templates)
  - `host-project/reports/` (reports do projeto hospedeiro)
- Todos os comandos devem ser executados da raiz do projeto hospedeiro.

## 1) Configurar `settings.json` no Cursor

Voce pode configurar pelo editor de settings (UI) ou diretamente no arquivo.

### Windows

- Caminho: `%APPDATA%\Cursor\User\settings.json`
- Exemplo real: `C:\Users\<seu-usuario>\AppData\Roaming\Cursor\User\settings.json`

### macOS

- Caminho: `~/Library/Application Support/Cursor/User/settings.json`

## 2) Configurar pela UI (recomendado)

1. Abra o Cursor.
2. Abra **Settings**.
3. Habilite uso de regras do projeto (`.cursor/rules`).
4. Marque o projeto como trusted workspace.
5. Habilite auto-run para comandos seguros no agente.
6. Mantenha confirmações para ações destrutivas (git reset hard, rm -rf, etc.).

## 3) Bloco sugerido para `settings.json`

Observacao: algumas chaves podem variar por versao do Cursor.

```json
{
  "cursor.ai.rules.enabled": true,
  "cursor.ai.rules.paths": [
    ".cursor/rules"
  ],
  "cursor.agent.autoRun.enabled": true,
  "cursor.agent.autoRun.requireConfirmation": false,
  "cursor.terminal.autoApproveTrustedCommands": true,
  "cursor.workspace.trustByDefaultForCurrentRepo": true
}
```

Se alguma chave nao existir na sua versao, mantenha os objetivos:

- regras ativas;
- workspace trusted;
- auto-execucao para comandos seguros;
- confirmação apenas para operações de alto risco.

## 4) Comandos slash (`/generate-report`, `/run-gates`, etc.)

Comandos slash sao arquivos Markdown em:

- `.cursor/commands/` (no projeto)
- `~/.cursor/commands/` (global da maquina)

Ao digitar `/` no chat do Cursor, os comandos aparecem na lista.

### Criar um comando slash

1. Crie o arquivo `.cursor/commands/generate-report.md`.
2. Escreva instrucoes claras para o agente executar comando real.
3. No chat, digite `/generate-report`.

Exemplo de conteudo:

```markdown
# Generate Report

Objetivo: gerar/atualizar report do dia no projeto hospedeiro.

Passos:
1) Executar `node .cursor/scripts/generate-report.js`
2) Confirmar arquivo criado em `reports/YYYY-MM-DD.report.json`
3) Exibir resumo do resultado
```

### Como usar os comandos slash

- `/generate-report`: gera report diario.
- `/policy-check`: executa policy check.
- `/run-gates`: executa pipeline completo de gates.
- `/release-readiness`: roda checks de prontidao para release.

## 5) Comandos de terminal no modo submodule

Use sempre com prefixo `.cursor/scripts`:

```bash
node .cursor/scripts/generate-report.js
node .cursor/scripts/policy-check.js --scan-imports
node .cursor/scripts/lint-gate.js
node .cursor/scripts/test-gate.js
node .cursor/scripts/validate-skeleton.js
node .cursor/scripts/metrics-collector.js
node .cursor/scripts/run-gates.js
```

## 6) Setup automatizado

Use os scripts de setup para validar ambiente e comandos slash:

- Windows: `.\.cursor\scripts\setup-cursor.ps1`
- Linux/macOS: `./.cursor/scripts/setup-cursor.sh`

Os scripts:

- validam Node/npm;
- validam existencia de `.cursor/commands`;
- exibem os comandos slash encontrados;
- orientam o uso no chat (`/`).

## 7) Troubleshooting rapido

- **Comando slash nao aparece**: verificar se arquivo esta em `.cursor/commands/*.md`.
- **Agent pede confirmacao em excesso**: revisar trust do workspace e auto-run.
- **Script nao encontrado**: confirmar que esta rodando da raiz do projeto hospedeiro.
- **Report nao gerado**: executar `node .cursor/scripts/generate-report.js`.
