<!-- generated-by: generate-rf-ux-ai.mjs -->
# RF-01-EXEMPLO-UX: Diretrizes UX/UI — Cadastro de Novos Usuários Compradores

**Referência:** `01 - RF-01 - Cadastro de Novos Usuários Compradores.md`  
**Autor:** Equipe Produto / UX  
**Data:** 2026-02-16  
**Versão:** 1.0

---

## 1. Resumo executivo

Este documento especifica diretrizes UX/UI e entrada de design para o requisito funcional RF-01 (Cadastro de Novos Usuários Compradores).

Objetivo do requisito (extraído da especificação):

Permitir que novos usuários compradores se registrem na plataforma de forma autônoma, reduzindo a sobrecarga da equipe de TI e acelerando o onboarding.

## 2. Personas e cenários principais

Personas (extraídas quando disponíveis na especificação):
- (Não encontrado explicitamente na especificação. Sugestão: Buyer/Admin/Auditoria conforme contexto.)

Cenários e fluxos principais (extraídos quando disponíveis na especificação):
O sistema deve fornecer um formulário de cadastro acessível publicamente onde compradores possam criar suas contas empresariais.

#### Dados de entrada obrigatórios

- Nome completo do usuário
- E-mail corporativo (validação de domínio)
- Empresa/Organização
- CNPJ (para Brasil) ou Tax ID
- Cargo/Função
- Telefone de contato
- Senha (com requisitos mínimos de segurança)
- Confirmação de senha

#### Dados opcionais

- Departamento
- Centro de custo
- Foto do perfil

#### Regras de negócio

- E-mail deve ser único no sistema
- E-mail deve ser corporativo (não aceitar domínios públicos como gmail.com, hotmail.com)
- CNPJ/Tax ID deve ser validado contra base de dados oficial
- Senha deve ter no mínimo 8 caracteres, incluindo maiúsculas, minúsculas, números e caracteres especiais
- Envio automático de e-mail de confirmação com link de ativação
- Conta fica inativa até confirmação do e-mail
- Após confirmação, usuário passa por fluxo de aprovação interna (se configurado)

#### Comportamentos esperados

- Validação em tempo real dos campos durante preenchimento
- Mensagens de erro claras e específicas para cada campo
- Prevenção de duplicação de contas
- Suporte a múltiplos idiomas no formulário

#### Limites e exceções

- Máximo de 3 tentativas de cadastro com mesmo e-mail antes de bloqueio temporário (24h)
- Empresas bloqueadas não podem criar novas contas
- Link de ativação expira em 24 horas

## 3. Princípios de design (KISS, segurança, previsibilidade)

- Clareza > complexidade: exibir somente o necessário; avançado fica em "Avançado".
- Feedback imediato: validações inline com mensagens orientadas à ação.
- Segurança por padrão: impedir ações inválidas; explicar o motivo.
- Consistência: usar componentes padrão (MUI) e tokens de tema.

## 4. Regras de interação e microcopy

- Botão salvar/confirmar: desabilitado até validações passarem.
- Erros: mensagem curta + correção sugerida.
- Confirmações destrutivas: 'Dialog' com "Cancelar" como ação segura padrão.
- Sucesso: 'Snackbar' com mensagem objetiva e, quando útil, link para próximo passo.

Microcopy e mensagens (extraídas quando disponíveis na especificação):
- (Não encontrado explicitamente. Manter mensagens curtas, acionáveis e consistentes.)

## 5. Acessibilidade e internacionalização

- WCAG AA: contraste, labels explícitos, foco visível e navegação por teclado.
- Screen readers: aria-live para erros/sucesso relevantes.
- i18n: textos parametrizáveis (pt-BR / en-US) e formatação de números/datas por locale.

## 6. Spec de telas (wireframes textuais)

Wireframes / mockups e descrições de tela (extraídos quando disponíveis na especificação):
O sistema deve fornecer um formulário de cadastro acessível publicamente onde compradores possam criar suas contas empresariais.

#### Dados de entrada obrigatórios

- Nome completo do usuário
- E-mail corporativo (validação de domínio)
- Empresa/Organização
- CNPJ (para Brasil) ou Tax ID
- Cargo/Função
- Telefone de contato
- Senha (com requisitos mínimos de segurança)
- Confirmação de senha

#### Dados opcionais

- Departamento
- Centro de custo
- Foto do perfil

#### Regras de negócio

- E-mail deve ser único no sistema
- E-mail deve ser corporativo (não aceitar domínios públicos como gmail.com, hotmail.com)
- CNPJ/Tax ID deve ser validado contra base de dados oficial
- Senha deve ter no mínimo 8 caracteres, incluindo maiúsculas, minúsculas, números e caracteres especiais
- Envio automático de e-mail de confirmação com link de ativação
- Conta fica inativa até confirmação do e-mail
- Após confirmação, usuário passa por fluxo de aprovação interna (se configurado)

#### Comportamentos esperados

- Validação em tempo real dos campos durante preenchimento
- Mensagens de erro claras e específicas para cada campo
- Prevenção de duplicação de contas
- Suporte a múltiplos idiomas no formulário

#### Limites e exceções

- Máximo de 3 tentativas de cadastro com mesmo e-mail antes de bloqueio temporário (24h)
- Empresas bloqueadas não podem criar novas contas
- Link de ativação expira em 24 horas

## 7. Mapeamento de componentes (MUI / MUI X + notas)

- Listas: DataGrid (server pagination quando necessário).
- Form: TextField, Autocomplete, Switch, Dialog, Snackbar.
- Tokens: usar MUI Theme (palette/spacing/typography).

## 8. Critérios de aceitação (UI / QA)

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

## 8.1 Regras de negócio e validações (referência)

- E-mail deve ser único no sistema
- E-mail deve ser corporativo (não aceitar domínios públicos como gmail.com, hotmail.com)
- CNPJ/Tax ID deve ser validado contra base de dados oficial
- Senha deve ter no mínimo 8 caracteres, incluindo maiúsculas, minúsculas, números e caracteres especiais
- Envio automático de e-mail de confirmação com link de ativação
- Conta fica inativa até confirmação do e-mail
- Após confirmação, usuário passa por fluxo de aprovação interna (se configurado)

## 9. Observações de implementação e recomendações técnicas

- Centralizar strings para i18n; não hardcodar microcopy.
- Instrumentar eventos mínimos de analytics do fluxo RF-01.
- Garantir RBAC na UI (desabilitar ações) + validação server-side.

---

*Rascunho UX pronto para revisão — favor indicar ajustes ou aprovar.*
