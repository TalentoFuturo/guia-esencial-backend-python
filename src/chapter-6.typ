#import "@preview/ilm:1.4.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/tblr:0.3.1": *
#import "@preview/colorful-boxes:1.4.2": *

#import "modules/table-style.typ": styled-comparison-table
#import "components.typ": protip, note
#set text(lang: "es")


= Introducción a FastAPI

FastAPI es un framework moderno y de alto rendimiento para la construcción de APIs con Python, basado en Python 3.7+ y en estándares como OpenAPI y JSON Schema.

Su enfoque principal es la velocidad y la facilidad de uso, aprovechando la asincronía de Python para optimizar el rendimiento.

#note(
title: "Ventajas de FastAPI:",
content: [
- Rendimiento extremadamente rápido, comparable a frameworks como Node.js y Go.
- Basado en tipos de Python, lo que mejora la validación y la documentación automática.
- Soporte nativo para `async/await`, lo que facilita la concurrencia y escalabilidad.
- Documentación automática generada con Swagger y ReDoc.
]
)

== ¿Qué es FastAPI y cuándo usarlo?

FastAPI es ideal para construir APIs RESTful y servicios de alto rendimiento.

Es una excelente opción cuando se busca *escalabilidad y velocidad*, por ejemplo:

- Microservicios y APIs altamente concurridas.
- Aplicaciones en tiempo real (WebSockets, streaming de datos).
- APIs para machine learning e inteligencia artificial.
- Plataformas backend con múltiples clientes (móviles, web, loT, etc.).

Si bien FastAPI es rápido y moderno, no es un reemplazo directo de Django.

Mientras Django es un framework full-stack con ORM, autenticación y herramientas de administración, FastAPI se enfoca en la creación de APIs y requiere integraciones adicionales para manejar bases de datos y autenticación avanzada.

#protip([
Si necesitas un backend ligero y rápido para servir datos, FastAPI es la mejor opción. Si necesitas un backend con herramientas listas para usar, Django es más adecuado.
])

== Instalación y configuración inicial

FastAPI es fácil de instalar y configurar. Solo necesitas Python 3.7+ y pip:

#codly(languages: codly-languages)
```bash
pip install fastapi[all]
```

Esto instala:
- *FastAPI:* El framework principal.
- *Uvicorn:* Un servidor ASGI ultrarrápido que ejecutará nuestra aplicación.

*Para verificar la instalación, crea un archivo `main.py` con el siguiente contenido:*

#codly(languages: codly-languages)
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
  return {"mensaje": "¡FastAPI está funcionando correctamente!"}
```

*Ejecuta el servidor con Uvicorn*:

#codly(languages: codly-languages)
```bash
uvicorn main:app --reload
```

Esto iniciará el servidor en #link("http://127.0.0.1:8000/"), donde se podrá acceder al endpoint raíz (`/`).

#protip([
    Usa `--reload` para reiniciar automáticamente el servidor en cada cambio de código durante el desarrollo.
])

== Creación de un servicio básico con FastAPI

FastAPI facilita la creación de servicios REST con un enfoque declarativo y basado en anotaciones de tipo.

Vamos a crear una API simple que gestione una lista de tareas:

#codly(languages: codly-languages)
```python
from fastapi import FastAPI
from pydantic import BaseModel
from typing import List

app = FastAPI()

# Modelo de datos
class Tarea(BaseModel):
  id: int
  titulo: str
  completado: bool = False

# Base de datos en memoria (temporal)
tareas: List[Tarea] = []

# Endpoint para obtener todas las tareas
@app.get("/tareas", response_model=List[Tarea])
def obtener_tareas():
  return tareas

# Endpoint para agregar una nueva tarea
@app.post("/tareas", response_model=Tarea)
def crear_tarea(tarea: Tarea):
  tareas.append(tarea)
  return tarea
```

Este código define:

- Un modelo de datos `Tarea` con pydantic.
- Un endpoint `POST` para agregar tareas.
- Un endpoint `GET` para listar todas las tareas.

Ejecuta el servidor y prueba los endpoints en #link("http://127.0.0.1:8000/docs/"), donde FastAPI genera documentación automática con Swagger.

#protip([
    Pydantic mejora la validación de datos y la documentación de la API de manera automática.
])

== Arquitectura de FastAPI y diferencias con Django

FastAPI sigue un enfoque modular y asincrónico, lo que lo diferencia significativamente de Django. A continuación, compararemos sus arquitecturas principales:

#styled-comparison-table(
  header: (
    [*Característica*],
    [*FastAPI*],
    [*Django*],
  ),
  data: (
    [Tipo de framework], [Microframework para APIs], [Full-stack],[Enfoque], [API-first], [Aplicaciones web completas],
    [ORM integrado], [No (pero soporta SQLAlchemy y Tortoise-ORM)], [Sí (Django ORM)],
  [Soporte para async/await], [Sí, completamente asíncrono], [Limitado (en algunas partes del ORM y vistas)],
  [Autenticación y seguridad], [Necesita configuración manual], [Integrada (usuarios, permisos, autenticación)],
  [Administración de datos], [No tiene un panel de administración nativo], [Incluye Django Admin],
  [Rendimiento], [Muy alto gracias a ASGI y async], [Menos eficiente en operaciones de I/O],
  )
)

== Comparación en el manejo de solicitudes:

*Django (sin DRF):*

#codly(languages: codly-languages)
```python
# views.py
from django.http import JsonResponse
import json

def saludo(request):
  if request.method == 'GET':
    return JsonResponse({'mensaje': 'Hola desde Django'})
```

#codly(languages: codly-languages)
```python
# urls.py
from django.urls import path
from .views import saludo

urlpatterns = [
  path('saludo/', saludo),
]
```

*FastAPI:*

#codly(languages: codly-languages)
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/saludo")
def saludo():
  return {"mensaje": "Hola desde FastAPI"}
```

Ambas funciones hacen lo mismo, pero FastAPI tiene menos código y genera documentación automática.

== ¿Cuándo usar FastAPI en lugar de Django?

*Usa FastAPI si necesitas:*

- APIs de alto rendimiento con muchas solicitudes concurrentes.
- Un backend ligero para servir datos a una aplicación frontend (React, Vue, Angular, etc.).
- Servicios de machine learning que necesiten procesamiento rápido.
- Microservicios con escalabilidad horizontal.

*Usa Django si necesitas:*

- Un backend completo con gestión de usuarios, ORM integrado y panel de administración.
- Aplicaciones web tradicionales con plantillas HTML y lógica de servidor.
- Un ecosistema con herramientas listas para usar.

#protip([
    Si quieres lo mejor de ambos mundos, usa Django para el panel administrativo y FastAPI para la API pública.
])

