# TEMPLATE-RF-AI

## Como usar
1. Duplique este arquivo.
2. Renomeie para `RF-XX-AI.md`.
3. Preencha com base no RF funcional e no RF UX.

## Cabeçalho
- **RF:** `{RF_ID}` (ex.: RF-02)
- **Título:** `{TITULO_RF}`
- **Autor:** `{EQUIPE_AI}`
- **Data:** `{YYYY-MM-DD}`
- **Versão:** `{VERSAO_DOC}`
- **Status:** `{RASCUNHO|EM_REVISAO|APROVADO}`

**Referência funcional:** `{ARQUIVO_RF_FUNCIONAL}`  
**Referência UX:** `{ARQUIVO_RF_UX}`

---

## 1. Visão geral do comportamento esperado
Descreva o que o agente deve fazer e quais limites deve respeitar.

`{VISAO_GERAL_COMPORTAMENTO}`

### Comportamentos mínimos
- `{COMPORTAMENTO_MINIMO_1}`
- `{COMPORTAMENTO_MINIMO_2}`
- `{COMPORTAMENTO_MINIMO_3}`

## 2. Intents / comandos suportados
- `{INTENT_1}`
- `{INTENT_2}`
- `{INTENT_3}`

Para cada intent, documente:
1. Entendimento
2. Autorização
3. Execução (API/UI)
4. Auditoria e telemetria

## 3. Contratos API (mínimo)
- `{METODO_ENDPOINT_1}`
- `{METODO_ENDPOINT_2}`
- `{METODO_ENDPOINT_3}`

### Payloads e campos relevantes
- `{CAMPO_PAYLOAD_1}`
- `{CAMPO_PAYLOAD_2}`
- `{CAMPO_PAYLOAD_3}`

## 4. Fluxos detalhados
### Fluxo 1: `{NOME_FLUXO_1}`
1) `{PASSO_1}`  
2) `{PASSO_2}`  
3) `{PASSO_3}`

### Fluxo 2: `{NOME_FLUXO_2}`
1) `{PASSO_1}`  
2) `{PASSO_2}`

## 5. Validações e guardrails
- `{GUARDRAIL_1}`
- `{GUARDRAIL_2}`
- `{GUARDRAIL_3}`

## 6. Segurança e autorização
- `{REGRA_SEGURANCA_1}`
- `{REGRA_SEGURANCA_2}`

## 7. Telemetria e observabilidade
### Eventos recomendados
- `{EVENTO_1}`
- `{EVENTO_2}`
- `{EVENTO_3}`

### Metadata mínima
- `traceId`
- `agentId`
- `userId`
- `orgId`
- `{METRICAS_ADICIONAIS}`

## 8. Mensagens de chat (templates)
- **Confirmação:** `{TEMPLATE_CONFIRMACAO}`
- **Negação:** `{TEMPLATE_NEGACAO}`
- **Deep-link:** `{TEMPLATE_LINK}`

## 9. Critérios de aceitação (PoC/MVP)
- [ ] `{CRITERIO_AI_1}`
- [ ] `{CRITERIO_AI_2}`
- [ ] `{CRITERIO_AI_3}`

---

## Checklist de qualidade da especificação AI
- [ ] Intents mapeadas para fluxos reais
- [ ] Guardrails e RBAC explícitos
- [ ] Contratos API mínimos definidos
- [ ] Eventos e metadata de observabilidade definidos
- [ ] Critérios de aceitação objetivos e testáveis
