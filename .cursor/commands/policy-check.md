# Policy Check

Objetivo: validar conformidade de politica do projeto com scan de imports proibidos.

## Passos

1. Garantir report atualizado com `node .cursor/scripts/generate-report.js`.
2. Executar `node .cursor/scripts/policy-check.js --scan-imports`.
3. Se houver violacao, listar os pontos e orientar correcao objetiva.

## Criterio de sucesso

- Policy gate passa sem violacoes.
