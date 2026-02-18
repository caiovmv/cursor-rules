# Guia Zero ao Sucesso (Usuario e Desenvolvedor)

Este guia mostra como sair do zero e usar esta plataforma de regras, scripts e templates com previsibilidade.

Para configuracao detalhada do Cursor em Windows/macOS no modo submodule, consulte `.cursor/docs/submodule-setup-windows-macos.md`.

## Publico-alvo

- **Usuario normal (produto/negocio):** quer pedir funcionalidades e acompanhar entregas sem entrar em detalhes tecnicos.
- **Desenvolvedor:** quer executar o fluxo completo com qualidade, gates e deploy.

## Resultado esperado

Ao final, voce consegue:

- Criar projeto padronizado com scaffolding.
- Desenvolver com regras ativas e sem desvio de stack.
- Validar qualidade com gates automaticos.
- Gerar metricas de conformidade.
- Levar para RC em Kubernetes e preparar Go Live.

## Visao geral do fluxo

1. Escolher template/politica (`policy.json`).
2. Criar projeto com script oficial em `.cursor/scripts/`.
3. Implementar seguindo regras (`.cursor/rules`).
4. Gerar report automatico.
5. Rodar quality gates.
6. Corrigir e repetir ate passar.
7. Publicar (CI + RC Kubernetes + release).

## Trilha 1: Usuario normal (sem codar)

### 1) Como pedir uma feature corretamente

Sempre informe:

- objetivo de negocio;
- criterio de aceite (o que precisa estar pronto para considerar concluido);
- prioridade (alta/media/baixa);
- restricoes (prazo, compliance, stack, nao-regressoes).

Exemplo curto:

```text
Preciso de onboarding com convite de usuario.
Criterio: admin convida por e-mail, convite expira em 7 dias e usuario aceita no link.
Prioridade: alta. Stack: MUI Pro. Sem Tailwind.
```

### 2) Como acompanhar sem travar o time

- Peça progresso por fase: draft local -> RC -> release.
- Peça evidencias objetivas: saida dos gates, status do report, checklist de release.
- Evite mudar escopo no meio da fase sem registrar nova prioridade.

### 3) Check de qualidade para aprovacao

Antes de aprovar entrega, confirme:

- gates passaram;
- criterios de aceite foram atendidos;
- nao houve violacao de politica do template;
- existe report e registro de metricas.

## Trilha 2: Desenvolvedor (do zero ao deploy)

### 1) Preparacao de ambiente

- Node.js LTS (22+ recomendado).
- npm funcional.
- Cursor com regras do repositorio habilitadas.

Scripts de apoio:

- Windows: `.\.cursor\scripts\setup-cursor.ps1`
- Linux/Mac: `./.cursor/scripts/setup-cursor.sh`

### 2) Criar projeto padronizado

Windows:

```powershell
.\.cursor\scripts\create-project.ps1 -AppName meu-sistema -Template mui -Version pro
```

Linux/Mac:

```bash
./.cursor/scripts/create-project.sh meu-sistema . mui pro
```

### 3) Desenvolver com governanca

Ordem de referencia recomendada:

1. `.cursor/rules/00-global.mdc`
2. `.cursor/rules/05-workflow.mdc`
3. `.cursor/rules/06-planning.mdc`
4. `.cursor/rules/61-quality-gates.mdc`
5. `.cursor/rules/71-design-system-mui.mdc`
6. `.cursor/rules/72-product-skeleton.mdc`

### 4) Validar qualidade (fluxo oficial)

```bash
node .cursor/scripts/generate-report.js
node .cursor/scripts/run-gates.js
```

Executa:

- policy gate;
- lint gate;
- test gate;
- skeleton gate (quando presente);
- metrics collector (quando presente).

### 5) RC e deploy

- Use workflow de CI para bloquear merge com gate falhando.
- Para homologacao/RC, use manifests ou Helm do diretorio `deploy/` no projeto gerado.

### 6) Fechamento de release

Checklist minimo:

- todos os gates verdes;
- criterios de aceite completos;
- riscos residuais documentados;
- metricas atualizadas;
- plano de rollback definido.

## Configuracoes recomendadas do Cursor (menos interrupcao)

Objetivo: reduzir prompts de confirmacao e permitir execucao mais continua.

Observacao: nomes das opcoes podem variar por versao do Cursor.

### 1) Workspace confiavel

- Marque o repositorio como trusted workspace.
- Permita execucao de comandos no terminal para esse workspace.

### 2) Regras sempre ativas

- Em `Settings > Rules for AI`, habilite as regras de `.cursor/rules/*.mdc`.
- Garanta que regras `alwaysApply` estejam ativas.

### 3) Menos paradas de aprovacao

- Prefira modo de agente com autonomia (evitar modo de planejamento para tarefas diretas).
- Habilite auto-run/auto-approve de ferramentas para workspace confiavel.
- Reduza confirmacao manual para comandos nao destrutivos.

### 4) Politica de seguranca recomendada

Mesmo com mais autonomia, mantenha bloqueio explicito para:

- comandos destrutivos de git;
- escrita fora do workspace;
- alteracoes de segredo/credenciais;
- instalacoes globais sem necessidade.

## Exemplo de configuracao (settings.json)

Use como referencia e ajuste aos nomes reais da sua versao do Cursor:

```json
{
  "cursor.ai.rules.enabled": true,
  "cursor.ai.rules.paths": [".cursor/rules"],
  "cursor.agent.autoRun.enabled": true,
  "cursor.agent.autoRun.requireConfirmation": false,
  "cursor.terminal.autoApproveTrustedCommands": true,
  "cursor.workspace.trustByDefaultForCurrentRepo": true
}
```

Se alguma chave nao existir na sua versao, mantenha o objetivo equivalente:

- regras ativas;
- workspace trusted;
- auto-execucao habilitada;
- confirmacao reduzida para acoes seguras.

## Comandos Slash (`/`) vs comando de terminal

- **Slash command:** atalho no chat (ex.: `/generate-report`) definido em `.cursor/commands/*.md`.
- **Comando de terminal:** comando real executado no shell (ex.: `node .cursor/scripts/generate-report.js`).

Fluxo recomendado:

1. Digite `/generate-report` no chat.
2. O agente executa `node .cursor/scripts/generate-report.js`.
3. Em seguida use `/run-gates`.

## Troubleshooting rapido

- **Agent para toda hora pedindo confirmacao:** revisar trust do workspace e auto-run.
- **Gate falhando sem clareza:** rodar gate isolado (`policy-check`, `lint-gate`, `test-gate`).
- **Report ausente/invalido:** executar `node .cursor/scripts/generate-report.js`.
- **Drift de estrutura:** executar `node .cursor/scripts/validate-skeleton.js`.

## Comandos essenciais (cola rapida)

```bash
node .cursor/scripts/generate-report.js
node .cursor/scripts/policy-check.js --scan-imports
node .cursor/scripts/lint-gate.js
node .cursor/scripts/test-gate.js
node .cursor/scripts/validate-skeleton.js
node .cursor/scripts/metrics-collector.js
node .cursor/scripts/run-gates.js
```

Com este fluxo, o time consegue operar de forma padronizada, previsivel e com menos interrupcoes.
