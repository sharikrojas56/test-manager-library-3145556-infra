# test-manager-library-3145556-infra

> **Prueba técnica · Ficha ADSO 3145556**
> Entrega: **martes 13 de octubre de 2026, a las 5:00 p. m.** (17:00, hora Colombia).

Este repositorio es la **infraestructura** de *Manager Library*: contenedores, red, volúmenes y el motor de base de datos vacío. **Empieza vacío a propósito**: se construye en el fork de cada aprendiz.

## 📋 Instrucciones Rápidas

### Para empezar

1. **Clona tu fork** de este repositorio
2. **Configura el entorno**:
   ```bash
   make init-env    # Crea .env desde .env.example
   # Edita .env con tus valores si es necesario
   ```
3. **Levanta los servicios**:
   ```bash
   make dev        # O: docker-compose up -d
   ```
4. **Verifica que todo funcione**:
   ```bash
   make ps         # Ver estado de servicios
   make health     # Ver salud de servicios
   ```

### Comandos Principales (Makefile)

| Comando | Descripción |
|---------|-------------|
| `make dev` | Inicia entorno de desarrollo |
| `make down` | Detiene todos los servicios |
| `make restart` | Reinicia servicios |
| `make logs` | Muestra logs en tiempo real |
| `make clean` | **PELIGROSO**: Detiene servicios y borra TODOS los datos |
| `make shell-pg` | Abre shell de PostgreSQL |
| `make shell-pgadmin` | Muestra URL de pgAdmin |
| `make status` | Muestra estado de servicios |
| `make info` | Muestra información de conexión |

## 🐳 Servicios Disponibles

### 1. PostgreSQL 16 (Motor Vacío)
- **Puerto:** `5432`
- **Base de datos:** `manager_library`
- **Usuario:** `manager_library`
- **Contraseña:** Configurada en `.env`
- **Volumen:** Persistente en `postgres_data`

**Importante:** Este motor comienza **VACÍO** (sin tablas). Las tablas se crean mediante migraciones de la aplicación (ver ADR-001).

### 2. pgAdmin 4 (Opcional - Solo Desarrollo)
- **URL:** http://localhost:5050
- **Email:** `admin@library.local`
- **Contraseña:** Configurada en `.env`

## 🔒 Seguridad y Variables de Entorno

### Archivos importantes:
- `.env.example` → **VERSIONADO**: Plantilla con variables
- `.env` → **NO VERSIONADO**: Variables reales (agregado a .gitignore)
- `.gitignore` → Excluye `.env` y archivos sensibles

### Para configurar:
```bash
# 1. Copiar plantilla
cp .env.example .env

# 2. Editar .env con tus valores
# (No subir .env al repositorio!)
```

## 📁 Estructura del Proyecto

```
test-manager-library-3145556-infra/
├── docker-compose.yml    # Configuración de servicios Docker
├── .env.example          # Plantilla de variables de entorno
├── .gitignore           # Excluye archivos sensibles
├── Makefile             # Comandos de desarrollo
└── README.md            # Esta documentación
```

## 🎯 Principios de Diseño (Infra)

1. **Motor Vacío:** PostgreSQL comienza sin tablas
2. **Sin DDL:** No hay scripts `CREATE TABLE` en este repositorio (ADR-001)
3. **Persistencia:** Volúmenes Docker para datos persistentes
4. **Desarrollo:** Herramientas opcionales (pgAdmin) solo para desarrollo

## 🔗 Repositorios Relacionados

| Repositorio | Tecnología | Propósito |
|-------------|------------|-----------|
| [`test-manager-library-3145556-api`](https://github.com/code-sena/test-manager-library-3145556-api) | PHP/Laravel | Backend con migraciones |
| [`test-manager-library-3145556-app`](https://github.com/code-sena/test-manager-library-3145556-app) | React | Frontend |
| [`test-manager-library-3145556-docs`](https://github.com/code-sena/test-manager-library-3145556-docs) | Markdown | Especificación completa |
| [`test-manager-library-3145556-page`](https://github.com/code-sena/test-manager-library-3145556-page) | HTML/CSS | Sitio público |
| [`test-manager-library-3145556-tool`](https://github.com/code-sena/test-manager-library-3145556-tool) | (Tool) | Sembrador de datos |

## 📚 Especificación

**Leer la especificación completa en:** `test-manager-library-3145556-docs`

- **Spec PHP:** `spec-php/` (versión para Laravel)
- **API Contract:** Endpoints HTTP y convenciones
- **Data Model:** Modelo de datos completo
- **Architecture:** Arquitectura hexagonal
- **ADR:** Decisiones arquitectónicas

## ⚠️ Notas Importantes

1. **Entrega:** Todo debe estar subido antes de las 5:00 p.m. (17:00)
2. **Commits:** Subir avances parciales con commits pequeños
3. **Especificación:** Respetar el spec en docs (historias, criterios, modelo de datos)
4. **Stack:** React (frontend) + PHP/Laravel (backend)
5. **Propósito:** Demostrar capacidad con SDD (Spec-Driven Development)

## 🆘 Solución de Problemas

### Puerto en uso
```bash
make check-ports  # Verifica puertos ocupados
```

### Reset completo (borra todos los datos)
```bash
make reset  # Detiene, borra volúmenes y reinicia
```

### Ver logs específicos
```bash
make logs-postgres   # Logs de PostgreSQL
make logs-pgadmin    # Logs de pgAdmin
```

---

> **Recordatorio:** Este repositorio solo contiene infraestructura. La aplicación (migraciones, código) va en los otros repositorios.
