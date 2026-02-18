# Documentacao do Projeto

## Template

Este projeto foi criado usando o template **React + Vite + MUI (Mantis)**.

## Stack

- React 19+
- Vite
- Material UI (MUI) v7
- Ant Design Icons
- Formik + Yup (formularios)
- React Router DOM (roteamento)
- SWR (data fetching)

## Estrutura

```
src/
├── components/         # Componentes reutilizaveis
│   ├── @extended/      # Componentes MUI estendidos
│   ├── cards/          # Cards customizados
│   └── logo/           # Logo do app
├── contexts/           # Contextos React
├── features/           # Modulos do Product Skeleton
│   ├── identity/       # Usuarios, convites, papeis
│   ├── sharing/        # Compartilhamento
│   ├── billing/        # Faturamento
│   ├── payments/       # Stripe
│   └── ...
├── hooks/              # Custom hooks
├── layout/             # Layouts (Dashboard, Auth)
├── menu-items/         # Configuracao de menu
├── pages/              # Paginas da aplicacao
├── routes/             # Configuracao de rotas
├── sections/           # Secoes de componentes
├── templates/
│   └── email/          # Templates de e-mail HTML
├── themes/             # Configuracao de tema MUI
│   └── overrides/      # Overrides de componentes
└── utils/              # Utilitarios
```

## Comandos

```bash
npm install     # Instalar dependencias
npm start       # Iniciar dev server
npm run build   # Build de producao
npm run lint    # Verificar lint
```

## Product Skeleton

Este template inclui modulos estruturais pre-definidos:

| Modulo | Descricao |
|--------|-----------|
| identity | Usuarios, convites, papeis |
| sharing | Compartilhamento de links |
| billing | Faturamento e demonstrativos |
| payments | Integracao Stripe |
| audit | Auditoria e logs |
| security | Sessoes e seguranca |

Consulte `docs/product-skeleton.md` na raiz do cursor-sigma para detalhes.

## Templates de E-mail

Templates HTML para e-mails transacionais:

```
src/templates/email/
├── base.html           # Layout base
├── reset-password.html # Reset de senha
├── invite-member.html  # Convite de membro
├── share-link.html     # Compartilhamento
└── README.md           # Documentacao
```

## Versao Free vs Pro

Verifique `policy.json` para saber a versao:

- **Free**: Apenas componentes gratuitos do MUI
- **Pro**: Componentes Pro permitidos (instalar manualmente)

### Componentes Pro (requerem licenca)

- DataGrid Pro / Premium
- DatePicker, DateTimePicker, DateRangePicker
- Charts Pro

## Referencias

- Consulte `examples/` para padroes de UI
- Remova antes da entrega: `node scripts/remove-examples.js`

## Quality Gates

Antes de commitar, execute:

```bash
node scripts/policy-check.js reports/YYYY-MM-DD.report.json --scan-imports
```

## Links

- [MUI Documentation](https://mui.com/)
- [Mantis Dashboard](https://mantisdashboard.com/)
- [Stripe Documentation](https://stripe.com/docs)
