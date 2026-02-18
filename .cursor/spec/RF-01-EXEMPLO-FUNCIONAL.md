## RF-01-EXEMPLO: Cadastro de Novos Usuários Compradores

### Objetivo

Permitir que novos usuários compradores se registrem na plataforma de forma autônoma, reduzindo a sobrecarga da equipe de TI e acelerando o onboarding.

### Descrição Funcional Detalhada

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

### Critérios de Aceitação

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
