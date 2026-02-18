<!-- generated-by: generate-rf-ux-ai.mjs -->
# RF-01-EXEMPLO-AI: Especificação do Agente de IA — Cadastro de Novos Usuários Compradores (RF-01)

**Referência:** `01 - RF-01 - Cadastro de Novos Usuários Compradores.md`  
**Objetivo:** Permitir que o agente de IA (chat da aplicação) execute e oriente operações relacionadas ao RF-01, via API, com guardrails de autorização, logs e deep-links para a UI quando necessário.

---

## 1. Visão geral do comportamento esperado

Objetivo do requisito (extraído da especificação):

Permitir que novos usuários compradores se registrem na plataforma de forma autônoma, reduzindo a sobrecarga da equipe de TI e acelerando o onboarding.

Comportamentos mínimos:
- Identificar intenção do usuário (NLP) e confirmar parâmetros críticos.
- Respeitar RBAC/escopo organizacional; negar com mensagem útil quando não permitido.
- Preferir deep-links para ações destrutivas/sensíveis (confirmação na UI).
- Registrar telemetria e auditoria de todas as ações do agente.

## 2. Intents / comandos suportados (chat)

- explicar_rf_01: explicar o que o RF faz e como usar.
- gerar_deeplink_rf_01:{contexto}: gerar URL temporária para abrir a tela relevante.
- validar_rf_01:{payload}: validar regras e retornar erros/sugestões.
- executar_rf_01:{payload}: executar ação operacional (requer confirmação explícita).

Cada intent segue: (1) entendimento, (2) autorização, (3) execução via API + resposta, (4) audit/telemetria.

## 3. Contratos API (mínimo PoC)

- GET /api/rf-01/context?...
- POST /api/rf-01/validate
- POST /api/rf-01/execute
- POST /api/rf-01/link (deep-link, TTL curto)

Observação: ajustar nomes reais dos endpoints conforme rotas existentes do backend.

Payloads e dados relevantes (extraídos quando disponíveis na especificação):
- Nome completo do usuário
- E-mail corporativo (validação de domínio)
- Empresa/Organização
- CNPJ (para Brasil) ou Tax ID
- Cargo/Função
- Telefone de contato
- Senha (com requisitos mínimos de segurança)
- Confirmação de senha

## 4. Fluxos detalhados (exemplos)

- Fluxo: validar antes de executar
  1) Usuário descreve a ação desejada no chat.
  2) Agente valida via /validate e retorna erros/sugestões.
  3) Usuário confirma e agente executa via /execute.

- Fluxo: ação sensível via deep-link
  1) Agente gera link temporário para confirmação/edição na UI.
  2) Usuário executa na UI; o sistema audita e retorna status.

## 5. Validações e guardrails

- Antes de qualquer escrita: validar userId/orgId e permissões.
- Conflito de versão (409): apresentar diff resumido e opções (Mesclar/Substituir/Cancelar).
- Rate limit do agente e limites de payload.

## 6. Segurança e autorização

- Credenciais do agente com escopo mínimo.
- Impersonation (X-Act-As-User) apenas quando permitido e auditável.
- Deep-links assinados com TTL curto (ex.: 10min), opcionalmente one-time.

## 7. Telemetria e observabilidade

- Eventos recomendados: rf_01_intent_detected, rf_01_validated, rf_01_executed, rf_01_deeplink_generated, rf_01_denied.
- Metadata: traceId, agentId, userId, orgId, latency, status, errorCode.

## 8. Mensagens de chat (templates)

- Confirmação: "Posso executar X com estes parâmetros: ... Confirma?"
- Negação: "Não tenho permissão para executar X. Caminho sugerido: ..."
- Link: "Abra a tela para continuar — link válido por {ttl} minutos: {url}"

## 9. Critérios de aceitação (PoC)

- [ ] Formulário de cadastro acessível sem autenticação prévia
- [ ] Validação de todos os campos obrigatórios com mensagens de erro específicas
- [ ] E-mail de confirmação enviado automaticamente após submissão
- [ ] Link de ativação funcional e com prazo de expiração de 24h
- [ ] Validação de CNPJ/Tax ID contra base oficial implementada
- [ ] Senha criptografada utilizando algoritmo bcrypt ou similar (hash + salt)
- [ ] Conta criada em estado 'pendente' até confirmação de e-mail
- [ ] Após confirmação, conta fica 'ativa' ou entra em fluxo de aprovação conforme configuração
- [ ] Prevenção de cadastros duplicados por e-mail
- [ ] Bloqueio temporário após 3 tentativas com mesmo e-mail
- [ ] Interface responsiva funcionando em desktop, tablet e mobile

---

*Rascunho AI pronto para revisão — indicar ajustes ou aprovar para implementação do PoC.*
