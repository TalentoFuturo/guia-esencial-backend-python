#import "@preview/ilm:1.4.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/tblr:0.3.1": *
#import "@preview/colorful-boxes:1.4.2": *
#import "@preview/pintorita:0.1.4": *

#import "modules/table-style.typ": styled-comparison-table
#import "components.typ": protip

#set text(lang: "es")


= Introducción al desarrollo backend

El desarrollo backend es una pieza fundamental en la creación de aplicaciones web. Mientras que el frontend maneja la interfaz y la experiencia del usuario, el backend es responsable de la lógica del negocio, la gestión de datos y la comunicación con bases de datos y otros servicios.

== ¿Qué entendemos por desarrollo backend?

Se refiere a la implementación del lado del servidor en una aplicación web. Incluye la gestión de bases de datos, autenticación de usuarios, control de acceso, procesamiento de lógica empresarial y la comunicación con APIs externas. Un backend eficiente garantiza que el frontend pueda acceder a los datos y funcionalidades de la aplicación de manera segura y rápida.

== Frameworks en desarrollo backend

Los frameworks ayudan a los desarrolladores a estructurar su código y facilitar la creación de aplicaciones escalables y mantenibles. En el ecosistema de Python, dos de los frameworks más utilizados para el desarrollo backend son Django y FastAPI.

- *Django:* Un framework full-stack que proporciona herramientas para la gestión de bases de datos, autenticación, seguridad y más.
- *FastAPI:* Un framework moderno y asíncrono optimizado para aplicaciones API con alto rendimiento.

#pagebreak()

== Comparación entre Django y FastAPI


#styled-comparison-table(
  num-columns: 3,
  header: (
  [*CARACTERÍSTICA*], [*DJANGO*], [*FASTAPI*],
  ),
  data: (
    [Tipo de framework], [Full-stack], [Microframework],
    [Velocidad], [Moderada], [Muy rápida (gracias a ASGI y async)],
    [Soporte para bases de datos], [ORM incorporado (Django ORM)], [Compatible con SQLAlchemy y otros ORM],
    [Autenticación y seguridad], [Integrado], [Personalizable],
    [API-first], [No, aunque tiene DRF], [Diseñado para APIs],
    [Curva de aprendizaje], [Moderada], [Baja (para quienes conocen async en Python)]
  ),
  caption: [Comparación entre Django y FastAPI]
)

Entonces... ¿cuándo usar Django y cuándo usar FastAPI?

*Django es ideal si...*

- Se necesita una solución "todo en uno" con administración integrada.
- Se trabaja con aplicaciones que requieren autenticación y autorización robusta.
- Se prioriza la rapidez en el desarrollo sobre la velocidad de ejecución.

*FastAPI es ideal si...*

- Se requiere alto rendimiento y concurrencia.
- Se está construyendo una API moderna optimizada para microservicios.
- Se busca aprovechar `async/await` para operaciones de I/O intensivas.

#protip([
  No tienes que elegir entre uno y otro. Puedes combinar Django para la administración y FastAPI para servicios de alto rendimiento.
])

#pagebreak()

== Componentes de una arquitectura web

#figure(
  image("./images/web-architecture.png", width: 60%),
  caption: [Diagrama de arquitectura web con BD, Backend, API y Frontend],
)

Una arquitectura backend moderna generalmente incluye los siguientes componentes:
#set enum(numbering: "a")
+ *Servidor web:* Gestiona las peticiones de los usuarios (ej. Nginx, Apache, Uvicorn para FastAPI).
+ *Framework backend:* Procesa la lógica de negocio (ej. Django, FastAPI).
+ *Base de datos:* Almacena y recupera datos (ej. PostgreSQL, MYSQL, MongoDB).
+ *Sistema de autenticación:* Controla el acceso de usuarios (ej. Django Authentication, OAuth con FastAPI).
+ *Cache:* Acelera respuestas a peticiones repetitivas (ej. Redis, Memcached).
+ *Mensajería y colas:* Manejo de tareas asíncronas (ej. Celery con Django, RabbitMQ, Kafka).
+ *Infraestructura de despliegue:* Servidores o contenedores para la aplicación (ej. Docker, Kubernetes).

#protip([
    No necesitas todos estos componentes desde el inicio. Empieza simple y escálala a medida que crece la aplicación.
  ])