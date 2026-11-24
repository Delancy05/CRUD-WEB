# CRUD-WEB
# 👥 CRUD de Usuarios · ASP.NET Web Forms + MySQL

Aplicación web para **crear, leer, actualizar y eliminar usuarios (CRUD)**, desarrollada con **ASP.NET Web Forms (.NET Framework 4.8)**, **C#**, **MySQL** y **Bootstrap 5**.

Proyecto de la asignatura **HPA III** · Universidad Tecnológica de Panamá · 2026

<!-- 🖼️ IMAGEN PRINCIPAL: captura de la pantalla del listado completo -->
<img width="1917" height="922" alt="image" src="https://github.com/user-attachments/assets/adff08d2-1a0c-4f3b-874c-9c06f0acdcf3" />

---

## 📋 Tabla de contenido

- [Características](#-características)
- [Tecnologías](#-tecnologías)
- [Vistas de la aplicación](#-vistas-de-la-aplicación)
- [Estructura del proyecto](#-estructura-del-proyecto)
- [Base de datos](#-base-de-datos)
- [Requisitos previos](#-requisitos-previos)
- [Instalación y ejecución](#-instalación-y-ejecución)
- [Validaciones](#-validaciones)
- [Autor](#-autor)

---

## ✨ Características

- **Create:** registro de nuevos usuarios mediante un formulario validado.
- **Read:** listado de usuarios activos y vista de detalle de cada registro.
- **Update:** edición de los datos de un usuario existente.
- **Delete:** eliminación **lógica** (el registro no se borra: se marca como anulado y se guarda la fecha de eliminación).
- **Búsqueda** por nombre o correo electrónico.
- **Validaciones** de datos en el servidor (nombre, edad, correo y fecha de nacimiento).
- **Mensajes de confirmación** al crear, modificar o eliminar.
- Acceso a datos mediante **procedimientos almacenados**.
- Diseño **responsive** con tema oscuro usando Bootstrap 5.

---

## 🛠 Tecnologías

| Capa | Tecnología |
|------|-----------|
| Frontend | HTML5, CSS3, Bootstrap 5, JavaScript |
| Backend | ASP.NET Web Forms, C# (.NET Framework 4.8) |
| Base de datos | MySQL 8 |
| Conector | MySql.Data (NuGet) |
| IDE | Visual Studio 2022 |
| Servidor local | IIS Express |

---

## 🖥 Vistas de la aplicación

### 📄 Listado de usuarios
Muestra todos los usuarios activos, con buscador y botones de acción (Read, Update, Delete).

<!-- 🖼️ IMAGEN: captura de pages/Index.aspx con los 3 usuarios -->
<img width="1917" height="831" alt="image" src="https://github.com/user-attachments/assets/fa6fb932-4ecd-497a-ab1f-551609a2d70a" />

### ➕ Crear usuario
Formulario para registrar un nuevo usuario.

<!-- 🖼️ IMAGEN: captura de Crud.aspx?op=C con el formulario vacío -->
<img width="1916" height="923" alt="image" src="https://github.com/user-attachments/assets/e7243032-1c4c-4480-88fd-aba9d1640b49" />

### 🔍 Leer usuario
Vista de solo lectura con los datos completos del registro.

<!-- 🖼️ IMAGEN: captura de Crud.aspx?op=R con un usuario -->
<img width="1917" height="918" alt="image" src="https://github.com/user-attachments/assets/beda9eaa-8e73-4848-ac81-532d9256064d" />

### ✏️ Actualizar usuario
Formulario con los datos cargados para modificarlos.

<!-- 🖼️ IMAGEN: captura de Crud.aspx?op=U con un usuario -->
<img width="1917" height="915" alt="image" src="https://github.com/user-attachments/assets/6e2cb105-a393-4099-b407-568e59286247" />

### 🗑 Eliminar usuario
Pantalla de confirmación antes de eliminar el registro.

<!-- 🖼️ IMAGEN: captura de Crud.aspx?op=D -->
<img width="1917" height="1075" alt="image" src="https://github.com/user-attachments/assets/6ab41b58-3f24-437a-b9e5-b07be4889384" />

### 🔎 Búsqueda
Filtrado de usuarios por nombre o correo.

<!-- 🖼️ IMAGEN: captura del listado con un texto escrito en el buscador -->
<img width="1917" height="913" alt="image" src="https://github.com/user-attachments/assets/6cb1618b-5e46-48d2-8ef8-a9b1f9b467bd" />

### ⚠️ Validaciones
Mensajes de error cuando falta un campo.

<!-- 🖼️ IMAGEN: captura del formulario mostrando errores de validación -->
<img width="1570" height="661" alt="image" src="https://github.com/user-attachments/assets/ee242688-192e-4b64-bb82-635b5f915e17" />

### ✅ Mensajes de confirmación
Alertas que aparecen al crear, modificar o eliminar un usuario.

<!-- 🖼️ IMAGEN: captura del listado con el mensaje verde de éxito -->
<img width="1562" height="788" alt="image" src="https://github.com/user-attachments/assets/bd5974ef-4922-465a-984a-37ded3cb04a2" />

---

## 📁 Estructura del proyecto

```
CRUD/
├── BaseDeDatos/
│   └── crudasp.sql            # Script de la base de datos
├── capturas/                  # Imágenes del README
├── css/                       # Bootstrap y estilos propios
├── img/                       # Logo e imágenes
├── js/                        # Scripts
├── pages/
│   ├── Index.aspx             # Listado y búsqueda de usuarios
│   └── Crud.aspx              # Formulario Crear / Leer / Actualizar / Eliminar
├── Biblioteca/
│   ├── Usuario.cs             # Modelo de usuario
│   └── ValidadorUsuario.cs    # Reglas de validación
├── Default.aspx               # Página de inicio (redirige al listado)
├── Site.Master                # Master Page (menú, encabezado y pie)
└── Web.config                 # Configuración y cadena de conexión
```

---

## 🗄 Base de datos

Base de datos: **`crudasp`** · Tabla principal: **`usuarios`**

<!-- 🖼️ IMAGEN: captura de MySQL Workbench mostrando la base de datos crudasp, la tabla usuarios y los procedimientos -->
![Base de datos en MySQL Workbench](capturas/base-de-datos.png)

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `idUsuario` | INT, PK, AUTO_INCREMENT | Identificador único |
| `Nombre` | VARCHAR(150) | Nombre completo |
| `Edad` | INT | Edad en años |
| `correo` | VARCHAR(150), UNIQUE | Correo electrónico |
| `FechaNacimiento` | DATE | Fecha de nacimiento |
| `FechaDeInsercion` | DATETIME | Fecha de creación del registro |
| `FechaModificacion` | DATETIME | Se actualiza automáticamente |
| `Anulado` | TINYINT(1) | `1` = activo · `0` = eliminado |
| `FechaEliminacion` | DATETIME | Fecha de la eliminación lógica |

### Procedimientos almacenados

| Procedimiento | Función |
|---------------|---------|
| `sp_load` | Lista los usuarios activos |
| `sp_search` | Busca por nombre o correo |
| `sp_read` | Obtiene un usuario por su id |
| `insert_user` | Inserta un nuevo usuario |
| `sp_update` | Modifica un usuario |
| `sp_delete` | Eliminación lógica de un usuario |

---

## ✅ Requisitos previos

- Windows con **Visual Studio 2022** (carga de trabajo *Desarrollo web y ASP.NET*)
- **.NET Framework 4.8**
- **MySQL Server 8** y **MySQL Workbench**

---

## 🚀 Instalación y ejecución

### 1. Clonar el repositorio

```bash
git clone https://github.com/Delancy05/[NOMBRE-DEL-REPOSITORIO].git
```

### 2. Crear la base de datos

1. Abre **MySQL Workbench** y entra a tu conexión local.
2. Abre el archivo `BaseDeDatos/crudasp.sql` (**File > Open SQL Script**).
3. Ejecútalo completo con el botón del rayo ⚡.
4. Verifica que exista la base de datos `crudasp` con la tabla `usuarios` y sus procedimientos almacenados.

### 3. Configurar la cadena de conexión

En el archivo `Web.config`, dentro de `<configuration>`, agrega o edita:

```xml
<connectionStrings>
  <add name="conexion"
       connectionString="Server=localhost; Port=3306; Database=crudasp; Uid=root; Pwd=TU_CONTRASEÑA; CharSet=utf8mb4; AllowPublicKeyRetrieval=true;"
       providerName="MySql.Data.MySqlClient" />
</connectionStrings>
```

> ⚠️ Reemplaza `TU_CONTRASEÑA` por la contraseña de tu usuario de MySQL. **No subas tu contraseña real a GitHub.**

### 4. Instalar el conector de MySQL

En Visual Studio, abre **Herramientas > Administrador de paquetes NuGet > Consola del Administrador de paquetes** y ejecuta:

```
Install-Package MySql.Data
```

### 5. Ejecutar

1. Abre la solución `CRUD.slnx` en Visual Studio.
2. Compila con **Compilar > Volver a compilar solución**.
3. Presiona **F5**. La aplicación se abrirá en `https://localhost:44303/`.

---

## 🔒 Validaciones

| Campo | Regla |
|-------|-------|
| Nombre | Obligatorio, máximo 150 caracteres |
| Edad | Número entero entre 1 y 120 |
| Correo | Obligatorio, con formato válido y único |
| Fecha de nacimiento | Fecha válida y no futura |

---

## 👤 Autor

**Chelsy Rios,**
Universidad Tecnológica de Panamá,
GitHub: [@Delancy05](https://github.com/Delancy05)

---

## 📄 Licencia

Proyecto con fines académicos.
