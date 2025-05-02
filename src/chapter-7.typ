#import "@preview/ilm:1.4.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/tblr:0.3.1": *
#import "@preview/colorful-boxes:1.4.2": *

#import "modules/table-style.typ": styled-comparison-table
#import "components.typ": protip
#set text(lang: "es")

= Desarrollo de aplicaciones con FastAPI

En FastAPI, las rutas se definen utilizando decoradores como `@app.get()`, `@app.post()`, `@app.put()`, y `@app.delete()`. Cada ruta responde a una URL específica y puede manejar diferentes métodos HTTP.

*Ejemplo de una ruta simple en FastAPI:*

#codly(languages: codly-languages)
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def leer_raiz():
  return {"mensaje": " Hola, FastAPI!"}
```

*Manejo de respuestas personalizadas:*

FastAPI permite devolver respuestas HTTP personalizadas usando `Response`.

#codly(languages: codly-languages)
```python
from fastapi import FastAPI, Response

app = FastAPI()

@app.get("/custom")
def respuesta_personalizada():
  contenido = "<h1>Respuesta HTML personalizada</h1>"
  return Response(content=contenido, media_type="text/html")
```

#protip([
    Usa `status_code` en los decoradores para definir respuestas específicas desde la vista.
])

#pagebreak()

== Validaciones con Pydantic

Pydantic es el motor de validación de FastAPI. Permite definir modelos de datos y validar automáticamente la información entrante.

#codly(languages: codly-languages)
```python
from fastapi import FastAPI
from pydantic import BaseModel, Field

app = FastAPI()

# Definimos el modelo con validaciones
class Usuario(BaseModel):
  nombre: str = Field(min_length=3, max_length=50)
  edad: int = Field(gt=0, lt=120) # gt: greater than, lt: less than
  email: str

@app.post("/usuarios")
def crear_usuario(usuario: Usuario):
  return {"mensaje": f"Usuario {usuario.nombre} creado correctamente"}
```

#protip([
    Utiliza `Field()` para establecer restricciones como longitud mínima y valores por defecto.
])

== Manejo de Query Parameters y Path Parameters:

FastAPI permite el uso de parámetros en la URL de dos maneras:

*Path Parameters:*

Se definen dentro de la URL y deben ser especificados en la solicitud.

#codly(languages: codly-languages)
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/usuarios/{usuario_id}")
def obtener_usuario(usuario_id: int):
  return {"usuario_id": usuario_id}
```

*Query Parameters:*

Son opcionales y se pasan después del signo `?` en la URL. Se usan para filtrar, ordenar o modificar resultados.

#codly(languages: codly-languages)
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/buscar")
def buscar_usuario(nombre: str = None): // 'None' lo hace opcional
  return {"nombre_buscado": nombre}
```

#protip([
    Define valores por defecto en los parámetros para evitar errores en las solicitudes.
])

#pagebreak()

== Implementación de operaciones CRUD

FastAPI facilita la implementación de CRUD mediante modelos Pydantic y métodos HTTP.

*Ejemplo de CRUD básico para gestionar una lista de usuarios:*

#codly(languages: codly-languages)
```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List

app = FastAPI()

# Modelo de usuario
class Usuario(BaseModel):
  id: int
  nombre: str
  email: str

# "Base de datos" en memoria
usuarios: List[Usuario] = []

# CREATE - Agregar usuario
@app.post("/usuarios", response_model=Usuario)
def crear_usuario(usuario: Usuario):
  usuarios.append(usuario)
  return usuario

# READ - Obtener todos los usuarios
@app.get("/usuarios", response_model=List[Usuario])
def obtener_usuarios():
  return usuarios

# READ - Obtener un usuario por ID
@app.get("/usuarios/{usuario_id}", response_model=Usuario)
def obtener_usuario(usuario_id: int):
  for u in usuarios:
    if u.id == usuario_id:
      return u
  raise HTTPException(status_code=404, detail="Usuario no encontrado")

# UPDATE - Editar un usuario
@app.put("/usuarios/{usuario_id}", response_model=Usuario)
def actualizar_usuario(usuario_id: int, datos: Usuario):
  for index, u in enumerate(usuarios):
    if u.id == usuario_id:
      usuarios[index] = datos
      return datos
  raise HTTPException(status_code=404, detail="Usuario no encontrado")

# DELETE - Eliminar un usuario
@app.delete("/usuarios/{usuario_id}")
def eliminar_usuario(usuario_id: int):
  for index, u in enumerate(usuarios):
    if u.id == usuario_id:
      del usuarios[index]
      return {"mensaje": "Usuario eliminado"}
  raise HTTPException(status_code=404, detail="Usuario no encontrado")
```

#protip([
    Implementa respuestas personalizadas con `HTTPException` para manejar errores de manera efectiva.
])
