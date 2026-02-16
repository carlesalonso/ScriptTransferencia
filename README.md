# 📦 Script de Transferencia Masiva de Repositorios

Script de PowerShell para transferir repositorios de GitHub Classroom a estudiantes de forma automática y masiva.

## 📋 Descripción

Este script automatiza el proceso de transferencia de repositorios de una organización de GitHub Classroom a las cuentas personales de los estudiantes. Es especialmente útil cuando necesitas devolver la propiedad de los repositorios de tareas finales a los alumnos.

## ✨ Características

- 🔍 Búsqueda automática de repositorios por prefijo
- 👤 Extracción automática del nombre de usuario del estudiante
- 🚀 Transferencia masiva con confirmación automática
- ✅ Validación de errores y feedback visual
- 📊 Reporte detallado del proceso

## 🔧 Prerequisitos

Antes de ejecutar el script, asegúrate de tener:

1. **PowerShell** instalado (versión 5.1 o superior)
2. **GitHub CLI (`gh`)** instalado y configurado
   - Descárgalo desde: <https://cli.github.com/>
3. **Autenticación** con GitHub CLI:

   ```powershell
   gh auth login
   ```

4. **Permisos de administrador** en la organización de GitHub

## ⚙️ Configuración

Antes de ejecutar el script, edita las variables de configuración en `transfer.ps1`:

```powershell
# Nombre de tu organización en GitHub
$Org = "Nombre-De-Tu-Organizacion"

# Prefijo de los repositorios a transferir
$Prefix = "tarea-final-"
```

### Ejemplo de configuración

Si tus repositorios se llaman:

- `tarea-final-juanperez`
- `tarea-final-mariagarcia`
- `tarea-final-pedrolopez`

Entonces configura:

```powershell
$Org = "EscuelaTecnica2024"
$Prefix = "tarea-final-"
```

El script extraerá automáticamente los usuarios: `juanperez`, `mariagarcia`, `pedrolopez`

## 🚀 Uso

1. **Clona o descarga** este repositorio
2. **Configura** las variables como se explicó anteriormente
3. **Ejecuta** el script:

   ```powershell
   .\transfer.ps1
   ```

## 📝 Ejemplo de Ejecución

``` shell
🔍 Buscando repositorios en 'EscuelaTecnica2024' que empiecen por 'tarea-final-'...
---------------------------------------------------
📦 Repositorio: tarea-final-juanperez
👤 Alumno detectado: juanperez
🚀 Enviando solicitud de transferencia...
✅ Solicitud enviada correctamente.
---------------------------------------------------
📦 Repositorio: tarea-final-mariagarcia
👤 Alumno detectado: mariagarcia
🚀 Enviando solicitud de transferencia...
✅ Solicitud enviada correctamente.
---------------------------------------------------
🏁 Proceso finalizado.
IMPORTANTE: Recuerda a los alumnos que deben revisar su email para ACEPTAR la transferencia.
```

## ⚠️ Advertencias Importantes

- **Los estudiantes deben ACEPTAR la transferencia** desde su correo electrónico para completar el proceso
- **El nombre de usuario** debe coincidir exactamente con el username de GitHub del estudiante
- **Verifica los nombres** antes de ejecutar el script para evitar transferencias erróneas
- Si un usuario no existe, el script mostrará un error pero continuará con los demás
- **Aumenta el límite** en la línea `--limit 200` si tienes más de 200 estudiantes

## 🔍 Solución de Problemas

### Error de autenticación

```powershell
gh auth login
gh auth status
```

### No se encuentran repositorios

- Verifica que el prefijo sea correcto (incluyendo guiones)
- Confirma que los repositorios existen en la organización

### Error al transferir

- Verifica que el usuario de GitHub existe
- Confirma que tienes permisos de administrador
- Asegúrate de que el repositorio no haya sido transferido previamente

## 📄 Licencia

Este script es de uso libre para propósitos educativos.

## 👨‍💻 Autor

Carlos Alonso Martínez - 2026

---
