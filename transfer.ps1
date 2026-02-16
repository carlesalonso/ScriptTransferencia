<#
.SYNOPSIS
    Script para transferir repositorios de GitHub Classroom usando la API.
#>

# --- CONFIGURACIÓN ---
$Org = "Nombre-De-Tu-Organizacion"  # Cambia esto
$Prefix = "tarea-final-"            # El prefijo de la tarea
# ---------------------

Write-Host "🔍 Buscando repositorios en '$Org'..." -ForegroundColor Cyan

# 1. Listamos los repositorios
try {
    # Obtenemos la lista en formato JSON y la convertimos a objetos PowerShell
    $Repos = gh repo list $Org --limit 200 --json name | ConvertFrom-Json
}
catch {
    Write-Host "❌ Error al conectar con GitHub. Ejecuta 'gh auth login' primero." -ForegroundColor Red
    exit
}

# 2. Filtramos por el prefijo
$TargetRepos = $Repos | Where-Object { $_.name -like "$Prefix*" }

if ($null -eq $TargetRepos) {
    Write-Host "⚠️ No se encontraron repositorios con el prefijo '$Prefix'." -ForegroundColor Yellow
    exit
}

foreach ($Repo in $TargetRepos) {
    $RepoName = $Repo.name
    # Extraemos el usuario (ej: tarea-final-juan -> juan)
    $StudentUser = $RepoName.Substring($Prefix.Length)

    Write-Host "---------------------------------------------------" -ForegroundColor Gray
    Write-Host "📦 Repo: $RepoName | 👤 Alumno: $StudentUser"

    # 3. Usamos la API para transferir
    # Endpoint: POST /repos/{owner}/{repo}/transfer
    # Parámetros: new_owner (obligatorio), new_name (opcional, usamos el mismo)
    
    Write-Host "🚀 Enviando petición a la API..." -NoNewline
    
    # El comando gh api lanza una excepción si falla, así que usamos try/catch
    try {
        # -F (Field) envía los datos como parámetros del cuerpo (JSON)
        # --silent evita que imprima todo el JSON de respuesta si tiene éxito
        gh api "repos/$Org/$RepoName/transfer" `
            -F "new_owner=$StudentUser" `
            -F "new_name=$RepoName" `
            --silent

        Write-Host " [OK] ✅" -ForegroundColor Green
    }
    catch {
        Write-Host " [ERROR] ❌" -ForegroundColor Red
        Write-Host "   Posibles causas: El usuario '$StudentUser' no existe o ya tiene un repo con ese nombre." -ForegroundColor Gray
    }
}

Write-Host "---------------------------------------------------"
Write-Host "🏁 Proceso finalizado." -ForegroundColor Cyan
Write-Host "IMPORTANTE: Los alumnos recibirán un EMAIL de GitHub que deben ACEPTAR para completar la transferencia." -ForegroundColor Yellow