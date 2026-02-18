# Generate Report

Objetivo: gerar ou atualizar o report diario do projeto hospedeiro.

## Passos

1. Executar `node .cursor/scripts/generate-report.js`.
2. Identificar o arquivo criado em `reports/YYYY-MM-DD.report.json`.
3. Mostrar um resumo curto do resultado (template, version e status).

## Criterio de sucesso

- O comando termina sem erro.
- Existe report diario atualizado em `reports/`.
