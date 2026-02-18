Param(
  [switch]$InstallWsl,
  [switch]$InstallUbuntu
)

Write-Host "== Cursor setup (PowerShell) =="
$root = Split-Path -Parent $PSScriptRoot
Write-Host "Repositorio: $root"
$hostRoot = Get-Location
Write-Host "Projeto hospedeiro: $hostRoot"

if ($IsWindows) {
  Write-Host "Windows detectado: sim"
  try {
    wsl.exe --status | Out-Null
    Write-Host "WSL: instalado"
  } catch {
    Write-Host "WSL: nao instalado"
    if ($InstallWsl) {
      Write-Host "Instalando WSL..."
      wsl.exe --install
    } else {
      Write-Host "Use: .\\scripts\\setup-cursor.ps1 -InstallWsl"
    }
  }

  if ($InstallUbuntu) {
    Write-Host "Instalando Ubuntu 24.04..."
    wsl.exe --install -d Ubuntu-24.04
  } else {
    Write-Host "Para instalar Ubuntu 24.04: .\\scripts\\setup-cursor.ps1 -InstallUbuntu"
  }

  Write-Host "WSL distros:"
  try { wsl.exe -l -v } catch { Write-Host "Nao foi possivel listar distros." }
} else {
  Write-Host "Windows detectado: nao (ok se estiver em WSL/Linux)"
}

Write-Host "Passos no Cursor:"
Write-Host "1) Abra Settings > Rules for AI e habilite regras do repo"
Write-Host "2) Garanta que .cursor\rules\*.mdc esteja ativo"
Write-Host "3) Siga .cursor\docs\guia-zero-ao-sucesso.md para o fluxo"
Write-Host ""

$commandsDir = Join-Path $root "commands"
if (-not (Test-Path $commandsDir)) {
  Write-Host "Criando diretorio de slash commands: $commandsDir"
  New-Item -ItemType Directory -Path $commandsDir -Force | Out-Null
}

function Set-DefaultCommandFile {
  param(
    [string]$Path,
    [string]$Title,
    [string]$Body
  )
  if (-not (Test-Path $Path)) {
    $content = @"
# $Title

$Body
"@
    Set-Content -Path $Path -Value $content -Encoding utf8
  }
}

$commandFiles = Get-ChildItem -Path $commandsDir -Filter *.md -File -ErrorAction SilentlyContinue
if (-not $commandFiles -or $commandFiles.Count -eq 0) {
  Write-Host "Nenhum slash command encontrado. Criando comandos padrao..."
  Set-DefaultCommandFile -Path (Join-Path $commandsDir "generate-report.md") -Title "Generate Report" -Body "Executar ``node .cursor/scripts/generate-report.js`` e resumir o resultado."
  Set-DefaultCommandFile -Path (Join-Path $commandsDir "policy-check.md") -Title "Policy Check" -Body "Executar ``node .cursor/scripts/policy-check.js --scan-imports`` e listar violacoes."
  Set-DefaultCommandFile -Path (Join-Path $commandsDir "run-gates.md") -Title "Run Gates" -Body "Executar ``node .cursor/scripts/run-gates.js`` e mostrar status de cada gate."
  Set-DefaultCommandFile -Path (Join-Path $commandsDir "release-readiness.md") -Title "Release Readiness" -Body "Executar report + gates e retornar READY ou NOT_READY com justificativa."
}

Write-Host "Slash commands disponiveis:"
$commandFiles = Get-ChildItem -Path $commandsDir -Filter *.md -File -ErrorAction SilentlyContinue
if ($commandFiles -and $commandFiles.Count -gt 0) {
  $commandFiles | ForEach-Object {
    $name = $_.BaseName
    Write-Host "  - /$name"
  }
} else {
  Write-Host "  - Nenhum comando encontrado"
}

Write-Host ""
Write-Host "Uso no Cursor:"
Write-Host "1) Abra o chat"
Write-Host "2) Digite /"
Write-Host "3) Selecione um comando (ex.: /generate-report, /run-gates)"
