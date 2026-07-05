# TP Desarrollo

Matías Marquez - 51419

## 1 - Enunciado

El sistema a desarrollar es una aplicación web cliente-servidor en Java destinada a la 
gestión de jugadores y proyectos dentro del servidor BTE Cono Sur. 

Build The Earth (BTE) es un proyecto global y colaborativo que busca recrear el planeta 
Tierra en Minecraft en escala 1:1. El servidor BTE Cono Sur agrupa a los equipos de 
Argentina, Chile, Perú, Bolivia, Paraguay y Uruguay.

La aplicación web permitirá administrar jugadores, proyectos y las solicitudes de unión a 
proyectos, actuando como interfaz gráfica para las operaciones que el plugin bteCSCore,
sistema central del servidor de Minecraft, expone a través de su API REST. Toda la lógica 
de negocio y la persistencia de datos (incluyendo la caché en memoria) son gestionadas por 
dicho plugin. El sistema web se limita a presentar la información y delegar las operaciones 
mediante llamadas HTTP.

Un proyecto es una región poligonal del mundo de Minecraft que representa la construcción 
de una zona específica. Puede tener un líder, miembros y distintos estados (En Creación, 
Completado, Abandonado, etc.). Los jugadores tienen tipos (Visitante, Postulante, 
Constructor) y roles que determinan qué operaciones pueden realizar dentro del sistema:

- **Jugador (Builder)**: Constructor registrado. Puede crear y gestionar sus propios proyectos 
  y solicitar unirse a proyectos ajenos.
- **Reviewer**: Miembro del staff encargado de aprobar o rechazar proyectos nuevos y 
  finalizados.
- **Admin**: Tiene control total sobre el sistema. Puede realizar todas las operaciones 
  anteriores y además gestionar entidades base como Tipos de Usuario, Rangos y configuración 
  general.

El acceso al sistema se realiza mediante cuenta de Discord. El jugador debe haber ingresado 
al servidor de Minecraft y vinculado su cuenta de Discord para poder utilizar la aplicación 
web. El login se implementa mediante OAuth2 de Discord, que devuelve el ID de Discord del 
usuario. El sistema consulta a bteCSCore si ese ID está vinculado a un jugador registrado y 
determina su nivel de acceso.

## 2 - Modelo de dominio
<img width="751" height="901" alt="BD Cono Sur-TP_UTN drawio" src="https://github.com/user-attachments/assets/6595e626-6da6-4088-9a33-d9c6457c64ad" />

---

Las entidades principales del sistema son:
- **Player**: Representa un jugador del servidor.
-	**Proyecto**: Unidad de trabajo en el servidor.
-	**Proyecto_Miembro**: Relación entre jugadores y proyectos (participación).
-	**Tipo_Usuario**: Categorización del jugador según permisos de construcción (Visitante, Postulante, Constructor).
-	**Rango_Usuario**: Rol del jugador (Usuario, Reviewer, Moderador, Admin, etc).
-	**Tipo_Proyecto**: Categorización del proyecto según tamaño.
-	**País**: Determinado por una serie de regiones poligonales.
-	**División**: De un país. Determinado por una serie de regiones poligonales. Dependiendo del país recibe un nombre distinto (Provincia, Comuna, Barrio, etc).

## 3 - Arquitectura
La arquitectura sigue el esquema cliente-servidor en capas:
-	**Capa de presentación**: JSP/JSTL y HTML5/CSS3 (Bootstrap).
-	**Capa de control**: Servlets en Apache Tomcat, que reciben las peticiones del browser.
-	**Capa de lógica / Acceso a datos**: Los Servlets se comunican mediante HTTP con la API REST del plugin bteCSCore, que gestiona la base de datos y la caché del servidor de Minecraft.

[ Browser ]
->
[ Servlets (Tomcat) ]
-> HTTP
[ Plugin bteCSCore (Minecraft) ]
->
[ DB ]

## 4 - Alcance Funcional

### 4.1 - Regularidad

#### **ABMC Simples**

- **Tipo de Proyecto**: No depende de otras entidades.


#### **ABMC Dependientes**

- **Proyecto**: Depende de Tipo de Proyecto, País y División. Al ser una región poligonal, para la Alta o Modificación hace falta seleccionar un conjunto de lat,lon. (Charlar esto para el alcance del proyecto)


#### **Caso de Uso NO-ABMC**

| Nombre                     | Descripción | Regla de Negocio |
|----------------------------|-------------|------------------|
| Solicitud de Unión a Proyecto | Un jugador solicita unirse a un proyecto activo o en edición. El sistema verifica que el proyecto tenga ese estado y que el jugador no supere el límite de proyectos simultáneos según su Tipo de Usuario. El líder del proyecto recibe la solicitud y puede aceptarla o rechazarla desde la web. | Verificar estado del proyecto y cupo de proyectos simultáneos del jugador. |

#### **Listado**

| Tipo   | Nombre                          | Descripción |
|--------|---------------------------------|-------------|
| Simple | Listado de Proyectos por Jugador | Muestra proyectos de un jugador con su estado y tipo. Incluye datos de Proyecto y Tipo_Proyecto. |


### 4.2 - Aprobación Directa

#### **ABMC completos**

| Entidad            | Caso de Uso |
|--------------------|------------|
| Tipo de Proyecto   | ABMC completo (incluido en regularidad) |
| Proyecto           | ABMC completo (incluido en regularidad) |
| Tipo de Usuario    | ABMC completo |
| Rango de Usuario   | ABMC completo |
| Player             | Consulta y modificación de jugadores (Alta automática desde el juego) |
| Tipo de Proyecto   | ABMC Tipo de Proyecto |
| País               | ABMC de Países (Charlar esto)|
| División           | ABMC División  (Charlar esto)|

**Nota:** Proyecto, País, División describen una región poligonal sobre un mapa. En el caso de País y División pueden tener varios polígonos relacionados, por lo que tienen entidades designadas (region_pais, region_division) a guardar estas múltiples regiones.

#### **Caso de Uso Complejo**
**Flujo**: Revisión de Proyecto 
Este CU resumen involucra dos eventos distintos en momentos diferentes: 
- *Evento 1* – **Solicitud de revisión**: El líder marca el proyecto como completado el proyecto desde la web o el juego y se notifica al Reviewer.
- *Evento 2* – **Revisión por Reviewer**: El Reviewer aprueba o rechaza la solicitud dando (o no) una razón. Si se aprueba, el proyecto pasa a **Completado**. Si no, vuelve a su estado **Activo** y se le envía la razón del rechazo a los miembros.

#### **Listado Complejo**

| Nombre                         | Filtros disponibles            | Descripción |
|--------------------------------|--------------------------------|-------------|
| Listado de Proyectos con filtros | Estado, País, Tipo de Proyecto | Muestra todos los proyectos del sistema con información de Proyecto. Permite filtrar por al menos un atributo. |

#### **Niveles de Acceso**

| Nivel            | Descripción | Acceso |
|------------------|------------|--------|
| Jugador | Constructor registrado en el sistema | Puede ver proyectos, solicitar unión y gestionar sus propios proyectos |
| Reviewer  | Miembro del staff con permisos de revisión | Todo lo anterior + aprobar/rechazar proyectos |
| Admin  | Miembro del staff con permisos de revisión | Todo lo anterior + ver listados completos y gestionar entidades |

#### **Login con Discord (OAuth2)**

El sistema no implementa un login propio con usuario y contraseña. El acceso se realiza 
mediante OAuth2 de Discord:
1. El usuario hace clic en "Ingresar con Discord".
2. Discord autentica al usuario y devuelve su ID de Discord al sistema.
3. El sistema consulta a bteCSCore si ese ID está vinculado a un jugador registrado.
4. Si está vinculado, se inicia sesión y se determina el nivel de acceso según el Rango del 
   jugador. Si no está vinculado, se muestra un mensaje indicando que debe ingresar al 
   servidor de Minecraft y vincular su cuenta primero.

El control de acceso se realiza en cada Servlet verificando el nivel del usuario en sesión 
antes de ejecutar cualquier operación.

## 6. Requerimientos Extra (a definir)

| Requerimiento     | Estado     | Detalle |
|------------------|-----------|---------|
| Manejo de polígonos en el mapa | A evaluar | Poder editar y crear póligonos en un mapa. (Relacionado a Proyecto, País y División) |
