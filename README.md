# 🔐 Script per canviar la visibilitat de repositoris

Aquest repositori conté l’script `make_public.ps1`, que permet canviar de forma massiva la visibilitat de repositoris d’una organització de GitHub segons un prefix.

## 📋 Què fa

L’script:

- Cerca repositoris dins una organització (`$Org`)
- Filtra pels que comencen amb un prefix (`$Prefix`)
- Comprova la visibilitat actual de cada repositori
- Aplica el canvi a `public` o `private` segons el paràmetre d’entrada

## ✅ Requisits

Abans d’executar-lo, cal tenir:

1. **PowerShell** (5.1 o superior)
2. **GitHub CLI (`gh`)** instal·lat: <https://cli.github.com/>
3. Sessió iniciada a GitHub CLI:

   ```powershell
   gh auth login
   gh auth status
   ```

4. Permisos per editar repositoris de l’organització

## ⚙️ Configuració

Edita aquestes variables dins `make_public.ps1`:

```powershell
$Org = "classesSMX2n"
$Prefix = "projecte5-"
```

- `$Org`: nom de l’organització de GitHub
- `$Prefix`: prefix dels repositoris sobre els quals s’aplicarà el canvi

## 🚀 Ús

L’script requereix el paràmetre obligatori `-Visibility`, amb valors possibles: `public` o `private`.

Fer públics els repositoris filtrats:

```powershell
.\make_public.ps1 -Visibility public
```

Fer-los privats:

```powershell
.\make_public.ps1 -Visibility private
```

## ⚠️ Notes importants

- El canvi de visibilitat afecta directament cada repositori filtrat.
- Si un repositori ja té la visibilitat desitjada, no es modifica.
- Si no es pot llegir o editar un repositori, l’script el salta i continua.
- Revisa bé `$Org` i `$Prefix` abans d’executar-lo.

## 🛠️ Resolució de problemes

Si tens errors d’autenticació:

```powershell
gh auth login
gh auth status
```

Si no troba repositoris:

- Verifica que `$Prefix` sigui correcte
- Confirma que hi ha repositoris amb aquest prefix a `$Org`

Si falla el canvi de visibilitat:

- Comprova permisos a l’organització
- Revisa que el repositori existeixi i sigui accessible

## 👨‍💻 Autor

Carlos Alonso Martínez - 2026
