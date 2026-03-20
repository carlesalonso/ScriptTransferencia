# --- CONFIGURACIÓN ---
$Org = "classesSMX2n"             # Cambia esto
$Prefix = "projecte5-"            # El prefijo de la tarea
# ---------------------

Write-Host "🔍 Buscando repositorios en '$Org' que empiecen por '$Prefix'..." -ForegroundColor Cyan

# 1. Listamos los repositorios
try {
    # Obtenemos la lista en formato JSON y la convertimos a objetos PowerShell
    $Repos = gh repo list $Org --limit 200 --json name | ConvertFrom-Json
}
catch {
    Write-Host "❌ Error al conectar con GitHub. Ejecuta 'gh auth login' primero." -ForegroundColor Red
    exit 1
}

# 2. Filtramos por el prefijo
$TargetRepos = $Repos | Where-Object { $_.name -like "$Prefix*" }

if ($TargetRepos.Count -eq 0) {
    Write-Host "⚠️ No se encontraron repositorios con el prefijo '$Prefix'." -ForegroundColor Yellow
    exit 1
}

foreach ($Repo in $TargetRepos) {
    $RepoName = $Repo.name
    # Extraemos el usuario (ej: tarea-final-juan -> juan)
    $StudentUser = $RepoName.Substring($Prefix.Length)

    Write-Host "---------------------------------------------------" -ForegroundColor Gray
    Write-Host "📦 Repo: $RepoName | 👤 Alumno: $StudentUser"

    Write-Host "🔓 Cambiando visibilidad a público..." -NoNewline
    
    # Ejecutamos el comando y verificamos el código de salida
    gh repo edit "$Org/$RepoName" --visibility public --accept-visibility-change-consequences
    
    # Verificamos si el comando fue exitoso
    if ($LASTEXITCODE -eq 0) {
        Write-Host " [OK] ✅" -ForegroundColor Green
    }
    else {
        Write-Host " [ERROR] ❌" -ForegroundColor Red
        Write-Host "   Posibles causas:" -ForegroundColor Gray
        Write-Host "   - El repositorio no existe" -ForegroundColor Gray
        Write-Host "   - No tienes permisos para modificarlo" -ForegroundColor Gray
    }

}