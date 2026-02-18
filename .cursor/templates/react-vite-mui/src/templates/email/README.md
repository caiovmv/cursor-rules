# Templates de E-mail

Templates HTML para e-mails transacionais do sistema.

## Estrutura

```
email/
├── base.html              # Layout base (wrapper)
├── reset-password.html    # Reset de senha
├── invite-member.html     # Convite de membro
├── share-link.html        # Compartilhamento de link
└── README.md
```

## Como Usar

### 1. Renderizar template

```javascript
import Handlebars from 'handlebars';
import baseTemplate from './base.html?raw';
import resetPasswordTemplate from './reset-password.html?raw';

// Compilar templates
const base = Handlebars.compile(baseTemplate);
const content = Handlebars.compile(resetPasswordTemplate);

// Renderizar conteudo
const emailContent = content({
  app_name: 'Meu App',
  user_name: 'Joao',
  reset_link: 'https://app.com/reset?token=abc123',
  expiration_hours: 24,
  current_year: new Date().getFullYear()
});

// Renderizar email completo
const emailHtml = base({
  subject: 'Redefinir sua senha',
  content: emailContent
});
```

### 2. Enviar via API

```javascript
await fetch('/api/email/send', {
  method: 'POST',
  body: JSON.stringify({
    to: 'usuario@email.com',
    subject: 'Redefinir sua senha',
    html: emailHtml
  })
});
```

## Variaveis por Template

### reset-password.html

| Variavel | Tipo | Obrigatorio |
|----------|------|-------------|
| app_name | string | Sim |
| user_name | string | Sim |
| reset_link | string | Sim |
| expiration_hours | number | Sim |
| current_year | number | Sim |

### invite-member.html

| Variavel | Tipo | Obrigatorio |
|----------|------|-------------|
| app_name | string | Sim |
| inviter_name | string | Sim |
| inviter_email | string | Sim |
| workspace_name | string | Sim |
| role | string | Sim |
| invite_link | string | Sim |
| invite_expiration | string | Sim |
| access_expiration | string | Nao |
| message | string | Nao |
| current_year | number | Sim |

### share-link.html

| Variavel | Tipo | Obrigatorio |
|----------|------|-------------|
| app_name | string | Sim |
| sharer_name | string | Sim |
| sharer_email | string | Sim |
| content_title | string | Sim |
| content_description | string | Nao |
| share_link | string | Sim |
| permission | string | Sim |
| expiration | string | Sim |
| message | string | Nao |
| current_year | number | Sim |

## Boas Praticas

1. **Sempre testar** em diferentes clientes de e-mail (Gmail, Outlook, Apple Mail)
2. **Usar estilos inline** para compatibilidade
3. **Incluir versao texto** para acessibilidade
4. **Nao usar JavaScript** em templates
5. **Otimizar imagens** para carregamento rapido
