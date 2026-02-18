Param(
  [Parameter(Mandatory = $true)]
  [string]$AppName,
  [string]$TargetDir,
  [ValidateSet("tailwind", "mui")]
  [string]$Template = "tailwind",
  [ValidateSet("free", "pro")]
  [string]$Version
)

$root = Split-Path -Parent $PSScriptRoot

# Map template names to directories
$templateMap = @{
  "tailwind" = "react-vite-tailwind"
  "mui" = "react-vite-mui"
}

$templateDir = Join-Path $root "templates\$($templateMap[$Template])"

# Se MUI e versao nao especificada, perguntar
if ($Template -eq "mui" -and -not $Version) {
  $Version = Read-Host "Versao do MUI/Mantis? (free/pro)"
  if ($Version -notin @("free", "pro")) {
    Write-Host "Versao invalida. Use 'free' ou 'pro'."
    exit 1
  }
}

# Default para free se nao especificado
if (-not $Version) {
  $Version = "free"
}

# Avisar sobre versao PRO
if ($Version -eq "pro") {
  Write-Host ""
  Write-Host "⚠️  Versao PRO selecionada." -ForegroundColor Yellow
  Write-Host "   Apos 'npm install', adicione manualmente as dependencias PRO:"
  Write-Host "   - MUI X Pro: https://mui.com/store/"
  Write-Host "   - Mantis Pro: https://codedthemes.com/item/mantis-react/"
  Write-Host ""
}

if (-not $TargetDir) {
  $TargetDir = Join-Path (Get-Location) $AppName
}

if (Test-Path $TargetDir) {
  Write-Host "Destino ja existe: $TargetDir" -ForegroundColor Red
  exit 1
}

Write-Host "Criando projeto '$AppName' com template '$Template' ($Version)..." -ForegroundColor Cyan

# Criar estrutura de pastas
New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $TargetDir "src") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $TargetDir "docs") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $TargetDir "reports") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $TargetDir "scripts") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $TargetDir ".cursor\rules") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $TargetDir ".cursor\reports") | Out-Null

# Copiar src/ do template
Copy-Item -Recurse -Force -Path (Join-Path $templateDir "src\*") -Destination (Join-Path $TargetDir "src")

# Copiar examples/ se existir (MUI)
$examplesDir = Join-Path $templateDir "examples"
if (Test-Path $examplesDir) {
  Copy-Item -Recurse -Force -Path $examplesDir -Destination $TargetDir
}

# Copiar arquivos de configuracao
$configFiles = @(
  "package.json",
  "index.html",
  "vite.config.mjs",
  "vite.config.ts",
  "jsconfig.json",
  "jsconfig.node.json",
  "tsconfig.json",
  "tsconfig.node.json",
  "eslint.config.mjs",
  ".eslintrc.json",
  ".prettierrc",
  "postcss.config.js",
  "tailwind.config.ts",
  "favicon.svg",
  ".env",
  ".nvmrc"
)

foreach ($file in $configFiles) {
  $srcFile = Join-Path $templateDir $file
  if (Test-Path $srcFile) {
    Copy-Item -Force $srcFile (Join-Path $TargetDir $file)
  }
}

# Copiar .gitignore do template
$gitignoreTemplate = Join-Path $templateDir "gitignore.template"
if (Test-Path $gitignoreTemplate) {
  Copy-Item -Force $gitignoreTemplate (Join-Path $TargetDir ".gitignore")
} else {
  # Fallback: usar .gitignore existente ou criar um basico
  $existingGitignore = Join-Path $templateDir ".gitignore"
  if (Test-Path $existingGitignore) {
    Copy-Item -Force $existingGitignore (Join-Path $TargetDir ".gitignore")
  }
}

# Copiar docs/
$docsDir = Join-Path $templateDir "docs"
if (Test-Path $docsDir) {
  Copy-Item -Recurse -Force -Path (Join-Path $docsDir "*") -Destination (Join-Path $TargetDir "docs")
}

# Copiar scripts/
$scriptsDir = Join-Path $templateDir "scripts"
if (Test-Path $scriptsDir) {
  Copy-Item -Recurse -Force -Path (Join-Path $scriptsDir "*") -Destination (Join-Path $TargetDir "scripts")
}

# Copiar scripts core de quality gates
$coreScripts = @(
  "generate-report.js",
  "policy-check.js",
  "lint-gate.js",
  "test-gate.js",
  "run-gates.js",
  "validate-skeleton.js",
  "metrics-collector.js"
)

foreach ($script in $coreScripts) {
  $srcScript = Join-Path $root "scripts\$script"
  if (Test-Path $srcScript) {
    Copy-Item -Force $srcScript (Join-Path $TargetDir "scripts\$script")
  }
}

# Copiar Cursor Rules
$cursorRulesDir = Join-Path $templateDir ".cursor\rules"
if (Test-Path $cursorRulesDir) {
  Copy-Item -Recurse -Force -Path (Join-Path $cursorRulesDir "*") -Destination (Join-Path $TargetDir ".cursor\rules")
}

# Copiar politica correta
$policyFile = ""
if ($Template -eq "tailwind") {
  $policyFile = Join-Path $root "policies\tailwind.json"
} elseif ($Template -eq "mui" -and $Version -eq "free") {
  $policyFile = Join-Path $root "policies\mui-free.json"
} elseif ($Template -eq "mui" -and $Version -eq "pro") {
  $policyFile = Join-Path $root "policies\mui-pro.json"
}

if ($policyFile -and (Test-Path $policyFile)) {
  Copy-Item -Force $policyFile (Join-Path $TargetDir "policy.json")
}

# Copiar schema de report para validacao local
$reportSchemaPath = Join-Path $root "reports\report.schema.json"
if (Test-Path $reportSchemaPath) {
  Copy-Item -Force $reportSchemaPath (Join-Path $TargetDir ".cursor\reports\report.schema.json")
}

# Atualizar report com data atual
$dateStr = Get-Date -Format "yyyy-MM-dd"
$reportPlaceholder = Join-Path $TargetDir "reports\YYYY-MM-DD.report.json"
$reportTarget = Join-Path $TargetDir "reports\$dateStr.report.json"

# Copiar report template se existir
$reportTemplateDir = Join-Path $templateDir "reports"
if (Test-Path $reportTemplateDir) {
  Copy-Item -Recurse -Force -Path (Join-Path $reportTemplateDir "*") -Destination (Join-Path $TargetDir "reports")
}

if (Test-Path $reportPlaceholder) {
  Move-Item -Force $reportPlaceholder $reportTarget
}

# Copiar workflow CI e artefatos de deploy se existirem no template
$templateGithub = Join-Path $templateDir ".github"
if (Test-Path $templateGithub) {
  Copy-Item -Recurse -Force -Path $templateGithub -Destination $TargetDir
}

$templateDeploy = Join-Path $templateDir "deploy"
if (Test-Path $templateDeploy) {
  Copy-Item -Recurse -Force -Path $templateDeploy -Destination $TargetDir
}

# Substituir placeholders
$packageJson = Join-Path $TargetDir "package.json"
$indexHtml = Join-Path $TargetDir "index.html"

if (Test-Path $packageJson) {
  (Get-Content $packageJson) -replace '"name": "app-name"', "`"name`": `"$AppName`"" | Set-Content $packageJson
}

if (Test-Path $indexHtml) {
  (Get-Content $indexHtml) -replace "<title>app-name</title>", "<title>$AppName</title>" | Set-Content $indexHtml
}

# Atualizar Cursor Rules com versao
$cursorRulesFile = Join-Path $TargetDir ".cursor\rules\template-rules.mdc"
if ((Test-Path $cursorRulesFile) -and $Template -eq "mui") {
  $content = Get-Content $cursorRulesFile -Raw
  if ($Version -eq "pro") {
    $content = $content -replace "## Versao: FREE", "## Versao: PRO`n`n- Versao PRO habilitada`n- Componentes PRO permitidos apos instalacao manual"
  }
  Set-Content $cursorRulesFile $content
}

Write-Host ""
Write-Host "✅ Projeto criado em: $TargetDir" -ForegroundColor Green
Write-Host ""
Write-Host "Proximos passos:" -ForegroundColor Cyan
Write-Host "  cd `"$TargetDir`""
Write-Host "  npm install"
if ($Version -eq "pro") {
  Write-Host "  # Adicionar dependencias PRO manualmente"
}
Write-Host "  npm start"
Write-Host ""
if ($Template -eq "mui") {
  Write-Host "Dica: Consulte examples/ para padroes de UI" -ForegroundColor Yellow
  Write-Host "      Remova antes da entrega: node scripts/remove-examples.js" -ForegroundColor Yellow
}
