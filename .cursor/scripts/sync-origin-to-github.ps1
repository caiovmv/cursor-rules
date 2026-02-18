Param(
  [string]$SourceRemote = "origin",
  [string]$TargetRemote = "github",
  [string]$Branch = "main",
  [switch]$Force,
  [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Invoke-Git {
  Param(
    [Parameter(Mandatory = $true)]
    [string[]]$Args
  )

  & git @Args
  if ($LASTEXITCODE -ne 0) {
    throw "Falha ao executar: git $($Args -join ' ')"
  }
}

function Test-RemoteExists {
  Param(
    [Parameter(Mandatory = $true)]
    [string]$RemoteName
  )

  & git remote get-url $RemoteName *> $null
  return $LASTEXITCODE -eq 0
}

Write-Host "== Sync remotes ==" -ForegroundColor Cyan
Write-Host "Source: $SourceRemote/$Branch"
Write-Host "Target: $TargetRemote/$Branch"
Write-Host ""

& git rev-parse --is-inside-work-tree *> $null
if ($LASTEXITCODE -ne 0) {
  throw "Diretorio atual nao e um repositorio git."
}

if (-not (Test-RemoteExists -RemoteName $SourceRemote)) {
  throw "Remote de origem '$SourceRemote' nao encontrado."
}

if (-not (Test-RemoteExists -RemoteName $TargetRemote)) {
  throw "Remote de destino '$TargetRemote' nao encontrado."
}

Write-Host "Atualizando refs remotas..." -ForegroundColor Yellow
Invoke-Git -Args @("fetch", $SourceRemote, $Branch)
Invoke-Git -Args @("fetch", $TargetRemote, $Branch)

$sourceRef = "refs/remotes/$SourceRemote/$Branch"
$targetRef = "refs/heads/$Branch"

$pushArgs = @("push", $TargetRemote, "${sourceRef}:$targetRef")

if ($Force) {
  $pushArgs += "--force"
  Write-Host "Modo push: --force (destrutivo)" -ForegroundColor Red
}
else {
  $pushArgs += "--force-with-lease=$Branch"
  Write-Host "Modo push: --force-with-lease=$Branch (recomendado)" -ForegroundColor Green
}

if ($DryRun) {
  $pushArgs += "--dry-run"
  Write-Host "Dry-run habilitado: nenhuma alteracao sera enviada." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Executando: git $($pushArgs -join ' ')" -ForegroundColor Cyan
Invoke-Git -Args $pushArgs

Write-Host ""
if ($DryRun) {
  Write-Host "Dry-run concluido com sucesso." -ForegroundColor Green
}
else {
  Write-Host "Sincronizacao concluida com sucesso." -ForegroundColor Green
}
