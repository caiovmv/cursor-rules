# Run Gates

Objetivo: executar pipeline completo de qualidade da plataforma.

## Passos

1. Executar `node .cursor/scripts/run-gates.js`.
2. Exibir resultado de cada gate (policy, lint, test, skeleton, metrics quando disponivel).
3. Em caso de falha, indicar gate e comando de repeticao.

## Criterio de sucesso

- Todos os gates passam.
