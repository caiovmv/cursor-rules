# Cursor Rules - Regras de Desenvolvimento

Repositório centralizado de regras do Cursor para padronização de desenvolvimento em projetos C#/.NET. Este repositório contém guidelines, padrões arquiteturais, boas práticas e convenções que devem ser aplicadas em todos os projetos da organização.

## 📋 Índice

- [Sobre o Repositório](#sobre-o-repositório)
- [Estrutura das Regras](#estrutura-das-regras)
- [Como Usar](#como-usar)
  - [Instalação via Git Submodule](#instalação-via-git-submodule)
  - [Configuração Manual](#configuração-manual)
- [Regras Disponíveis](#regras-disponíveis)
- [Manutenção](#manutenção)
- [Contribuindo](#contribuindo)

---

## 🎯 Sobre o Repositório

Este repositório centraliza todas as regras de desenvolvimento utilizadas pelo Cursor AI em projetos C#/.NET. As regras são definidas em arquivos Markdown (`.mdc`) que seguem o padrão do Cursor, permitindo que o assistente de IA aplique automaticamente padrões de código, arquitetura e boas práticas.

### Objetivos

- **Padronização**: Garantir consistência entre projetos
- **Qualidade**: Manter altos padrões de código e arquitetura
- **Produtividade**: Acelerar desenvolvimento com guidelines claras
- **Manutenibilidade**: Facilitar evolução e manutenção de código
- **Onboarding**: Reduzir curva de aprendizado para novos desenvolvedores

### Quando Usar

Este repositório deve ser utilizado em:
- ✅ Novos projetos C#/.NET
- ✅ Projetos existentes que precisam de padronização
- ✅ Equipes que desejam manter consistência entre projetos
- ✅ Projetos que usam Cursor AI como assistente de desenvolvimento

---

## 📁 Estrutura das Regras

Todas as regras estão localizadas na pasta `.cursor/rules/` e seguem o formato `.mdc` (Markdown com frontmatter):

```
.cursor/
└── rules/
    ├── roadmap-governanca.mdc
    ├── persona-sse.mdc
    ├── stack-dotnet.mdc
    ├── guideline-desenvolvimento.mdc
    ├── documentacao.mdc
    ├── restful-api.mdc
    ├── git.mdc
    └── troubleshooting.mdc
```

Cada arquivo contém:
- **Frontmatter**: Metadados (description, alwaysApply, globs)
- **Conteúdo**: Regras e guidelines em Markdown

---

## 🚀 Como Usar

### Instalação via Git Submodule (Recomendado)

A forma recomendada de usar este repositório é através de **Git Submodule**, permitindo que múltiplos projetos compartilhem as mesmas regras e recebam atualizações centralizadas.

#### 1. Adicionar como Submodule

No diretório raiz do seu projeto:

```bash
# Adicionar o submodule
git submodule add https://github.com/seu-org/cursor-rules.git .cursor/rules-source

# Ou se preferir manter na estrutura padrão do Cursor
git submodule add https://github.com/seu-org/cursor-rules.git .cursor/rules-source
```

#### 2. Criar Link Simbólico ou Copiar Regras

**Opção A: Link Simbólico (Linux/Mac/Git Bash)**

```bash
# Criar link simbólico
ln -s .cursor/rules-source/.cursor/rules .cursor/rules
```

**Opção B: Copiar Regras (Windows ou quando link não funciona)**

```bash
# Copiar regras para a pasta .cursor/rules
cp -r .cursor/rules-source/.cursor/rules .cursor/rules

# Ou no Windows PowerShell
Copy-Item -Recurse .cursor/rules-source\.cursor\rules .cursor\rules
```

**Opção C: Script de Setup (Recomendado)**

Crie um script `setup-rules.sh` (ou `.ps1` para Windows):

```bash
#!/bin/bash
# setup-rules.sh

# Verificar se o submodule existe
if [ ! -d ".cursor/rules-source" ]; then
    echo "❌ Submodule não encontrado. Execute primeiro:"
    echo "   git submodule add <url-do-repo> .cursor/rules-source"
    exit 1
fi

# Criar diretório .cursor se não existir
mkdir -p .cursor

# Copiar regras
echo "📋 Copiando regras do Cursor..."
cp -r .cursor/rules-source/.cursor/rules .cursor/rules

echo "✅ Regras instaladas com sucesso!"
echo "📝 As regras estão em: .cursor/rules/"
```

#### 3. Atualizar Regras

Quando as regras forem atualizadas no repositório central:

```bash
# Atualizar o submodule
git submodule update --remote .cursor/rules-source

# Recopiar as regras (se necessário)
# Execute novamente o script de setup ou copie manualmente
```

#### 4. Commitar no Projeto

```bash
# Adicionar o submodule ao controle de versão
git add .gitmodules .cursor/rules-source .cursor/rules
git commit -m "chore: add cursor rules as submodule"
```

### Configuração Manual

Se preferir não usar submodules, você pode copiar as regras manualmente:

```bash
# Clonar ou baixar este repositório
git clone https://github.com/seu-org/cursor-rules.git temp-rules

# Copiar regras para seu projeto
cp -r temp-rules/.cursor/rules .cursor/rules

# Remover clone temporário
rm -rf temp-rules
```

**⚠️ Atenção**: Com esta abordagem, você precisará atualizar manualmente as regras quando houver mudanças.

---

## 📚 Regras Disponíveis

### 1. `roadmap-governanca.mdc`

**Quando se aplica**: Decisões de produto e governança de fases

**Descrição**: Define o modelo de governança para evolução de produtos em quatro fases progressivas (PoC → MVP → RC → v1.0), estabelecendo critérios de avanço, personas permitidas por fase e evidências objetivas necessárias.

**Principais tópicos**:
- Política global de produto
- Critérios de transição entre fases
- Personas permitidas/proibidas por fase
- Processo de exceção (waivers)
- Checklist de decisão rápida

**Uso**: Aplicado automaticamente quando o Cursor detecta discussões sobre roadmap, fases de produto ou governança.

---

### 2. `persona-sse.mdc` ⭐

**Quando se aplica**: **SEMPRE** (`alwaysApply: true`)

**Descrição**: Define a persona de Senior Software Engineer, estabelecendo princípios fundamentais de código, arquitetura, tratamento de erros, performance e testes.

**Principais tópicos**:
- Princípios fundamentais (Clareza > esperteza)
- Padrões de código e nomenclatura
- Princípios arquiteturais (SOLID, separação de concerns)
- Tratamento de erros e segurança
- Performance e otimização
- Estratégia de testes
- Processo mental de decisão técnica

**Uso**: Esta regra é aplicada em **todas** as sessões de chat, garantindo que o Cursor sempre atue como um engenheiro sênior.

---

### 3. `stack-dotnet.mdc`

**Quando se aplica**: Arquivos C# (`.cs`, `.csproj`, `.sln`)

**Descrição**: Define padrões técnicos obrigatórios para projetos backend em C#/.NET, incluindo stack base, arquitetura em camadas, persistência, mensageria, observabilidade e CI/CD.

**Principais tópicos**:
- Stack base (.NET 9+, ASP.NET Core)
- Arquitetura em camadas (Domain, Application, Infrastructure, Presentation)
- Persistência (PostgreSQL, EF Core, Dapper)
- Cache (Redis)
- Mensageria (System.Threading.Channels, brokers externos)
- Observabilidade (Prometheus, Grafana, Loki, OpenTelemetry)
- Padrões de código C#
- Testes e documentação

**Uso**: Aplicado automaticamente ao trabalhar com arquivos C#.

---

### 4. `guideline-desenvolvimento.mdc` ⭐

**Quando se aplica**: **SEMPRE** (`alwaysApply: true`)

**Descrição**: Guideline completo de desenvolvimento para C#/.NET com princípios SOLID, Clean Architecture, padrões de design e foco em performance e segurança.

**Principais tópicos**:
- Princípios SOLID (aplicação prática)
- Arquitetura Clean/Hexagonal
- Design Patterns (Factory, Strategy, Decorator, etc.)
- Architectural Patterns (Modular Monolith, DDD, CQRS, Event-driven)
- Design by Performance (PostgreSQL, Redis, Mensageria, S3)
- Design by Security
- Stack específica (guidelines práticos)
- Convenções de código
- Testes e observabilidade
- Checklist de PR

**Uso**: Esta regra é aplicada em **todas** as sessões de chat, garantindo que todo código gerado siga os padrões estabelecidos.

---

### 5. `documentacao.mdc`

**Quando se aplica**: Arquivos de documentação (`docs/**`, `*.md`)

**Descrição**: Governança da documentação técnica, estabelecendo padrões para diagramas UML, ADRs (Architecture Decision Records) e estrutura obrigatória.

**Principais tópicos**:
- Estrutura de pastas (`/docs`)
- Padrões UML 2.0
- Nomenclatura de arquivos
- Índice mestre obrigatório
- Padrão para diagramas (Mermaid)
- ADRs (quando criar, estrutura obrigatória)
- Boas práticas de documentação

**Uso**: Aplicado automaticamente ao trabalhar com documentação.

---

### 6. `restful-api.mdc`

**Quando se aplica**: Controllers, Endpoints, arquivos OpenAPI (`**/Controllers/**`, `**/*Controller.cs`, `openapi.json`)

**Descrição**: Padrões e práticas recomendadas para design e implementação de APIs RESTful de alta qualidade, com foco em consistência, evolutividade e ergonomia.

**Principais tópicos**:
- Fundamentos da API (versionamento, content negotiation, datas, IDs)
- Paths e modelagem de recursos
- Métodos HTTP e semântica
- Consultas (filtro, ordenação, busca, paginação)
- Status codes
- Contrato de erro (RFC 9457 - Problem Details)
- HATEOAS pragmático
- Concorrência, cache e headers
- Segurança (autenticação, autorização, rate limiting)
- OpenAPI 3.1
- DTOs e validação
- Testes e qualidade

**Uso**: Aplicado automaticamente ao trabalhar com APIs REST.

---

### 7. `git.mdc`

**Quando se aplica**: Operações Git (`.git/**`, `.gitignore`)

**Descrição**: Regras BEST-IN-CLASS para uso de Git, incluindo commits, branches, PRs, versionamento semântico e boas práticas.

**Principais tópicos**:
- Princípios fundamentais do Git
- Estratégia de branches (GitHub Flow)
- Commits (Conventional Commits)
- Pull Requests (padrão obrigatório)
- Estratégia de merge (Squash and Merge)
- Rebase (uso correto)
- Versionamento semântico (SemVer)
- Tags e releases
- Conflitos, hotfix e emergências
- Segurança e boas práticas
- Automação (CI/CD)
- Git hooks

**Uso**: Aplicado automaticamente ao trabalhar com Git.

---

### 8. `troubleshooting.mdc`

**Quando se aplica**: Arquivos C# (`.cs`)

**Descrição**: Guia completo de troubleshooting para C#/.NET, incluindo diagnóstico, resolução de problemas e prevenção.

**Principais tópicos**:
- Processo de troubleshooting
- Classificação de problemas (compilação, runtime, performance, concorrência, etc.)
- Análise e diagnóstico
- Identificação da causa raiz
- Diretrizes técnicas (exceções comuns, performance, concorrência, integração)
- Ferramentas de diagnóstico
- Casos comuns e padrões
- Troubleshooting por ambiente (ASP.NET Core, IIS, Azure, Docker)
- Estrutura de resposta (Problema → Causa → Solução → Prevenção)
- Checklist de diagnóstico

**Uso**: Aplicado automaticamente ao trabalhar com código C# quando há problemas ou erros.

---

## 🔧 Manutenção

### Atualizando Regras

Quando as regras forem atualizadas no repositório central:

1. **Com Git Submodule**:
   ```bash
   # No projeto que usa as regras
   git submodule update --remote .cursor/rules-source
   
   # Recopiar regras (se necessário)
   ./setup-rules.sh
   ```

2. **Sem Submodule**:
   - Baixar manualmente as atualizações
   - Copiar para `.cursor/rules/`

### Adicionando Novas Regras

1. Criar novo arquivo `.mdc` em `.cursor/rules/`
2. Adicionar frontmatter adequado:
   ```yaml
   ---
   description: "Descrição da regra"
   alwaysApply: false  # ou true
   globs: ["**/*.ext"]  # opcional
   ---
   ```
3. Commitar e fazer push
4. Atualizar este README.md com a descrição da nova regra

### Modificando Regras Existentes

1. Editar o arquivo `.mdc` correspondente
2. Commitar com mensagem descritiva:
   ```bash
   git commit -m "docs(rules): atualiza guideline de desenvolvimento"
   ```
3. Fazer push para o repositório central
4. Projetos que usam submodule precisarão atualizar

---

## 🤝 Contribuindo

### Processo de Contribuição

1. **Fork** ou crie uma branch para sua mudança
2. **Edite** as regras necessárias
3. **Teste** as mudanças em um projeto real
4. **Documente** mudanças significativas
5. **Abra um Pull Request** com descrição clara

### Padrões de Contribuição

- **Commits**: Seguir Conventional Commits
- **PRs**: Incluir descrição do que mudou e por quê
- **Testes**: Testar em projeto real antes de mergear
- **Documentação**: Atualizar este README se adicionar novas regras

### Tipos de Mudanças Aceitas

- ✅ Correções de erros ou inconsistências
- ✅ Melhorias em clareza ou exemplos
- ✅ Adição de novas regras (após discussão)
- ✅ Atualização de padrões ou tecnologias
- ❌ Mudanças que quebram compatibilidade (requerem discussão)

---

## 📝 Exemplos de Uso

### Exemplo 1: Novo Projeto

```bash
# 1. Criar novo projeto
dotnet new webapi -n MeuProjeto
cd MeuProjeto

# 2. Adicionar regras como submodule
git init
git submodule add https://github.com/seu-org/cursor-rules.git .cursor/rules-source

# 3. Copiar regras
cp -r .cursor/rules-source/.cursor/rules .cursor/rules

# 4. Commitar
git add .cursor
git commit -m "chore: add cursor rules"
```

### Exemplo 2: Projeto Existente

```bash
# 1. Adicionar submodule
git submodule add https://github.com/seu-org/cursor-rules.git .cursor/rules-source

# 2. Copiar regras
cp -r .cursor/rules-source/.cursor/rules .cursor/rules

# 3. Adicionar ao .gitignore (opcional, se não quiser versionar)
echo ".cursor/rules/" >> .gitignore

# 4. Commitar
git add .gitmodules .cursor/rules-source
git commit -m "chore: add cursor rules as submodule"
```

### Exemplo 3: Atualizar Regras

```bash
# 1. Atualizar submodule
git submodule update --remote .cursor/rules-source

# 2. Recopiar regras
cp -r .cursor/rules-source/.cursor/rules .cursor/rules

# 3. Verificar mudanças
git status

# 4. Commitar atualização
git add .cursor/rules .cursor/rules-source
git commit -m "chore: update cursor rules"
```

---

## 🎓 Para Desenvolvedores

### Como as Regras Funcionam

O Cursor AI lê automaticamente os arquivos em `.cursor/rules/` e aplica as regras baseado em:

1. **`alwaysApply: true`**: Regra aplicada sempre (ex: `persona-sse.mdc`, `guideline-desenvolvimento.mdc`)
2. **`globs`**: Regra aplicada quando arquivos correspondem ao padrão (ex: `**/*.cs`)
3. **`description`**: Cursor decide quando aplicar baseado no contexto da conversa

### Verificando se as Regras Estão Ativas

1. Abra **Cursor Settings** (Ctrl/Cmd + ,)
2. Vá em **Rules, Commands**
3. Verifique se as regras aparecem em **Project Rules**
4. Regras com `alwaysApply: true` aparecerão marcadas

### Dicas de Uso

- **Mencione regras específicas**: Use `@nome-da-regra` para forçar aplicação
- **Combine regras**: Múltiplas regras podem ser aplicadas simultaneamente
- **Personalize localmente**: Você pode adicionar regras locais em `.cursor/rules/` que não serão versionadas
- **Desative se necessário**: Regras podem ser desativadas nas configurações do Cursor

### Troubleshooting

**Problema**: Regras não estão sendo aplicadas

**Soluções**:
1. Verificar se os arquivos estão em `.cursor/rules/`
2. Verificar se o frontmatter está correto (YAML válido)
3. Reiniciar o Cursor
4. Verificar configurações em Cursor Settings → Rules

**Problema**: Conflito entre regras

**Solução**: Regras com `alwaysApply: true` têm precedência. Revise a ordem de aplicação nas configurações.

---

## 📄 Licença

[Especificar licença do repositório]

---

## 🔗 Links Úteis

- [Documentação do Cursor - Rules](https://docs.cursor.com/rules)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
- [RFC 9457 - Problem Details](https://www.rfc-editor.org/rfc/rfc9457.html)

---

## 📧 Contato

Para dúvidas, sugestões ou problemas:
- Abra uma [Issue](../../issues)
- Entre em contato com a equipe de arquitetura
- Consulte a documentação interna

---

**Última atualização**: 2026-01-12
