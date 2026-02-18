# Documentação do Projeto

## Template

Este projeto foi criado usando o template **React + Vite + Tailwind CSS v4**.

## Stack

- React 19+
- Vite
- TypeScript
- Tailwind CSS v4

## Estrutura

```
src/
├── components/     # Componentes reutilizáveis
├── pages/          # Páginas da aplicação
├── hooks/          # Custom hooks
├── utils/          # Funções utilitárias
├── types/          # Tipos TypeScript
├── constants/      # Constantes
├── contexts/       # Contextos React
├── layouts/        # Layouts de página
├── features/       # Features/módulos
├── lib/            # Bibliotecas/integrações
├── services/       # Serviços (API, etc)
├── state/          # Gerenciamento de estado
├── providers/      # Providers React
├── styles/         # Estilos globais (Tailwind)
└── assets/         # Arquivos estáticos
```

## Comandos

```bash
npm install     # Instalar dependências
npm run dev     # Iniciar dev server
npm run build   # Build de produção
npm run lint    # Verificar lint
npm run test    # Executar testes
```

## Estilização

Este projeto usa **Tailwind CSS v4**. 

- Use apenas classes Tailwind para estilização
- Evite CSS customizado e estilos inline
- Configure o tema em `tailwind.config.ts`

## Padrões

- Componentes funcionais com TypeScript
- Props tipadas com `type` ou `interface`
- Um componente por arquivo
- Nomes em PascalCase para componentes
