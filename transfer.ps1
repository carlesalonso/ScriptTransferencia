<#
.SYNOPSIS
    Script para transferir repositorios de GitHub Classroom a alumnos masivamente.
#>

# --- CONFIGURACIÓN ---
# Cambia esto por el nombre de tu organización
$Org = "Nombre-De-Tu-Organizacion"

# El prefijo de la tarea (incluyendo el guion final si lo tiene)
$Prefix = "tarea-final-"
# ---------------------

Write-Host "🔍 Buscando repositorios en '$Org' que empiecen por '$Prefix'..." -ForegroundColor Cyan

# Listamos los repositorios y convertimos el JSON de respuesta a objetos de PowerShell
# Aumenta el --limit si tienes más de 200 alumnos
try {
    $Repos = gh repo list $Org --limit 200 --json name | ConvertFrom-Json
}
catch {
    Write-Host "❌ Error al conectar con GitHub. Verifica tu conexión o login." -ForegroundColor Red
    exit
}

# Filtramos solo los que coinciden con el prefijo
$TargetRepos = $Repos | Where-Object { $_.name -like "$Prefix*" }

if ($null -eq $TargetRepos) {
    Write-Host "⚠️ No se encontraron repositorios con ese prefijo." -ForegroundColor Yellow
    exit
}

foreach ($Repo in $TargetRepos) {
    $RepoName = $Repo.name
    
    # Extraemos el usuario eliminando el prefijo del nombre
    # Usamos .Substring() para cortar el string de forma precisa
    $StudentUser = $RepoName.Substring($Prefix.Length)

    Write-Host "---------------------------------------------------" -ForegroundColor Gray
    Write-Host "📦 Repositorio: $RepoName"
    Write-Host "👤 Alumno detectado: $StudentUser"
    
    Write-Host "🚀 Enviando solicitud de transferencia..." -ForegroundColor Green
    
    # Ejecutamos la transferencia
    # --yes: Confirma automáticamente
    # $LASTEXITCODE: Verifica si el comando anterior (gh) tuvo éxito (0) o falló
    gh repo transfer "$Org/$RepoName" --target "$StudentUser" --new-name "$RepoName" --yes

    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Solicitud enviada correctamente." -ForegroundColor Cyan
    } else {
        Write-Host "⚠️ Error al transferir. Es posible que el usuario '$StudentUser' no exista o el repo ya se transfirió." -ForegroundColor Red
    }
}

Write-Host "---------------------------------------------------"
Write-Host "🏁 Proceso finalizado." -ForegroundColor Cyan
Write-Host "IMPORTANTE: Recuerda a los alumnos que deben revisar su email para ACEPTAR la transferencia." -ForegroundColor Yellow