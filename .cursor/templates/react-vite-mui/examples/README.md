# Exemplos de Referência

Esta pasta contém telas de exemplo do template Mantis.
Use como referência para construir seu sistema.

## Estrutura

```
examples/
├── pages/           # Páginas de exemplo
│   ├── auth/        # Login, Register
│   ├── dashboard/   # Dashboard principal
│   ├── component-overview/  # Cores, sombras, tipografia
│   └── extra-pages/ # Páginas adicionais
└── sections/        # Seções reutilizáveis
    ├── auth/        # Componentes de autenticação
    └── dashboard/   # Componentes do dashboard
```

## Como Usar

1. **Consulte os exemplos** para entender padrões de UI do MUI
2. **Copie e adapte** componentes para seu projeto
3. **Remova esta pasta** antes de entregar o projeto

## Remover Exemplos

Quando o projeto estiver pronto para entrega:

```bash
node scripts/remove-examples.js
```

**IMPORTANTE**: Esta pasta serve apenas como referência para o agente de IA construir o sistema. Não deve fazer parte do produto final.
