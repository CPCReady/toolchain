# Sistema de Releases Automáticos

Este repositorio está configurado para crear releases automáticamente cuando se publican tags que siguen la convención de versionado semántico.

## Cómo crear un release

### 1. Crear y publicar un tag

Para crear un nuevo release, simplemente crea y publica un tag que siga el patrón de versionado semántico:

```bash
# Crear un tag para una nueva versión
git tag v1.0.0

# Publicar el tag a GitHub
git push origin v1.0.0
```

### 2. Patrones de tags soportados

El sistema reconoce los siguientes patrones de tags:

- **Releases estables**: `v1.0.0`, `v2.1.3`, `v1.5.12`
- **Pre-releases**: `v1.0.0-alpha`, `v2.0.0-beta.1`, `v1.5.0-rc.2`

### 3. Qué sucede automáticamente

Cuando publicas un tag, el GitHub Action:

1. **Se ejecuta automáticamente** cuando detecta un nuevo tag
2. **Genera un changelog** con todos los commits desde el tag anterior
3. **Crea un release en GitHub** con:
   - Título del release basado en el tag
   - Descripción generada automáticamente con los cambios
   - Marcado como pre-release si el tag contiene guiones (alpha, beta, etc.)
   - Enlaces para comparar cambios

### 4. Ejemplos de uso

#### Release estable
```bash
# Preparar el código para release
git add .
git commit -m "feat: nueva funcionalidad importante"

# Crear y publicar tag
git tag v1.2.0
git push origin v1.2.0
```

#### Pre-release (beta)
```bash
# Preparar versión beta
git add .
git commit -m "feat: funcionalidad experimental"

# Crear y publicar tag de pre-release
git tag v1.3.0-beta.1
git push origin v1.3.0-beta.1
```

### 5. Personalización

#### Subir archivos al release

Si quieres incluir archivos binarios o zips en el release, edita el archivo `.github/workflows/release.yml` y:

1. Cambia `if: false` a `if: true` en el paso "Subir artefactos"
2. Modifica la ruta `asset_path` para apuntar a tu archivo
3. Ajusta `asset_name` y `asset_content_type` según corresponda

#### Cambiar patrones de tags

Para modificar qué tags activan el release, edita la sección `on.push.tags` en el workflow:

```yaml
on:
  push:
    tags:
      - 'release-*'    # Para tags como release-1.0.0
      - '[0-9]+.[0-9]+.[0-9]+' # Para tags sin 'v' como 1.0.0
```

### 6. Verificar el resultado

Después de publicar un tag, puedes:

1. Ir a la pestaña **Actions** en GitHub para ver el progreso
2. Visitar la sección **Releases** para ver el nuevo release
3. Verificar que el changelog se generó correctamente

### 7. Troubleshooting

#### El workflow no se ejecuta
- Verifica que el tag siga el patrón correcto (`v*.*.*`)
- Asegúrate de haber hecho `git push origin <tag-name>`
- Revisa que el archivo `.github/workflows/release.yml` esté en la rama principal

#### Permisos insuficientes
- El workflow usa `GITHUB_TOKEN` automáticamente
- Si hay problemas, verifica la configuración de permisos del repositorio

#### Changelog vacío
- Asegúrate de tener commits entre el tag anterior y el nuevo
- Verifica que los tags estén bien formateados para la comparación

## Convenciones recomendadas

### Versionado Semántico
- **MAJOR** (v1.0.0 → v2.0.0): Cambios que rompen compatibilidad
- **MINOR** (v1.0.0 → v1.1.0): Nuevas funcionalidades compatibles
- **PATCH** (v1.0.0 → v1.0.1): Correcciones de bugs

### Mensajes de commit
Para obtener changelogs más informativos, usa mensajes de commit descriptivos:
- `feat: agregar nueva funcionalidad X`
- `fix: corregir problema con Y`
- `docs: actualizar documentación`
- `refactor: mejorar código Z`