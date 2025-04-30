#import "@preview/ilm:1.4.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/tblr:0.3.1": *
#import "@preview/colorful-boxes:1.4.2": *

#import "table-style.typ": styled-comparison-table
#import "components.typ": protip, note
#set text(lang: "es")


= Introducción a Backend con Django

Django es un framework de alto nivel para desarrollo web en Python que fomenta un desarrollo rápido y limpio. Entrega herramientas integradas para manejar bases de datos, autenticación, seguridad y más.

== ¿Qué es Django y por qué usarlo?

Django se basa en el principio DRY (Don't Repeat Yourself), lo que significa que facilita la reutilización de código y minimiza la redundancia. Es una opción popular por su facilidad de uso y su robusto ecosistema de paquetes.

#note(
  title: "💡 Ventajas de Django",
  content: [
    - Rápido desarrollo con una estructura bien organizada.
    - Incluye un ORM poderoso para manejar bases de datos.
    - Seguridad integrada (protección contra SQL Injection, CSRF, XSS).
    - Extensa documentación y una comunidad activa.
  ]
)


== Instalación y configuración inicial

Para instalar Django, primero necesitas tener Python y pip instalados en tu sistema.

*Creación de un nuevo proyecto Django*

+  *Crea un entorno virtual:*
  #codly(languages: codly-languages)
  ```bash
  python -m venv venv
  source venv/bin/activate # En Windows: venv\Scripts\activate
  ```
+  *Instala Django:*
    #codly(languages: codly-languages)
    ```bash
    pip install django
    ```
+  *Verifica la instalación:*
    ```bash
    django-admin --version
    ```

#protip([
  Usa entornos virtuales siempre. Evitarás conflictos de dependencias con otros proyectos.
])

Una vez instalado Django, puedes crear un nuevo proyecto con:

#codly(languages: codly-languages)
```bash
django-admin startproject mi_proyecto
```

Esto creará una estructura como:

#codly(languages: codly-languages)
```bash
mi_proyecto/
├── manage.py
└── mi_proyecto/
    ├── __init__.py
    ├── settings.py
    ├── urls.py
    └── wsgi.py
```

Luego, para verificar que todo está funcionando:

#codly(languages: codly-languages)
```bash
python manage.py runserver
```

Abre tu navegador en #link("http://127.0.0.1:8000") y verás la pantalla de bienvenida de Django.

#figure(
  image("./images/django-welcome.png", width: 60%),
  caption: [Pantalla de bienvenida de Django con cohete],
)

== Arquitectura MVT (Model-View-Template) en Django

Django sigue el patrón MVT (Model-View-Template):

- Model: Define la estructura de la base de datos mediante clases Python.
- View: Contiene la lógica de negocio y maneja las solicitudes del usuario.
- Template: Se encarga de la representación visual de los datos.

#figure(
  image("./images/mvt-architecture.png", width: 60%),
  caption: [Diagrama de flujo de la arquitectura MVT (Model -> View -> Template)],
)

Este patrón permite una separación clara de responsabilidades y facilita el mantenimiento del código.

#protip([
  Django automatiza muchas tareas comunes. Aprovecha su ORM y autenticación integrada para ahorrar tiempo.
])