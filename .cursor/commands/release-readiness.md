# Release Readiness

Objetivo: validar prontidao para release de forma padronizada.

## Passos

1. Executar `node .cursor/scripts/generate-report.js`.
2. Executar `node .cursor/scripts/run-gates.js`.
3. Confirmar itens obrigatorios:
   - criterios de aceite concluídos;
   - sem violacoes de politica;
   - metricas atualizadas;
   - riscos residuais documentados.
4. Retornar um status final: `READY` ou `NOT_READY`.

## Criterio de sucesso

- Status final `READY` com justificativa curta.
