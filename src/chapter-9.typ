#import "@preview/ilm:1.4.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/tblr:0.3.1": *
#import "@preview/colorful-boxes:1.4.2": *

#import "modules/table-style.typ": styled-comparison-table
#import "components.typ": protip
#set text(lang: "es")


= Implementación de operaciones avanzadas

== Long Running Operations (LROs)

Las Long Running Operations (LROs) son tareas que requieren más tiempo de ejecución y que pueden bloquear el servidor si no se manejan correctamente. En FastAPI, podemos gestionar LROs utilizando procesamiento en segundo plano con `BackgroundTasks` o herramientas como Celery.

=== Uso de Background Tasks en FastAPI

FastAPI proporciona la clase `BackgroundTasks` para ejecutar tareas en segundo plano sin bloquear la respuesta del usuario.

Ejemplo de implementación:

#codly(languages: codly-languages)
```python
from fastapi import FastAPI, BackgroundTasks
import time

app = FastAPI()

# Función de tarea en segundo plano
def guardar_log(mensaje: str):
    time.sleep(5)
    with open("registro.log", "a") as archivo:
        archivo.write(f"{mensaje}\n")

# Endpoint que lanza la tarea sin bloquear la respuesta
@app.post("/procesar")
def procesar(background_tasks: BackgroundTasks):
    mensaje_log = "Se procesó una nueva solicitud."
    background_tasks.add_task(guardar_log, mensaje_log)
    return {"mensaje": "Tarea en segundo plano iniciada"}
```

#pagebreak()

=== Uso de Celery para tareas asíncronas

Para tareas más complejas, usa Celery junto con un message broker (como Redis o RabbitMQ).

Instalación:
#codly(languages: codly-languages)
```bash
pip install celery[redis]
```

*Ejemplo de Celery* (requiere configuración adicional y un worker corriendo):

#codly(languages: codly-languages)
```python
from celery import Celery
import time

# Crear la app de Celery
# 'broker' es donde Celery envía los mensajes de tareas
# 'backend' es donde Celery guarda los resultados (opcional)
app_celery = Celery(
    'tasks',
    broker='redis://localhost:6379/0',
    backend='redis://localhost:6379/0'
)

# Definir una tarea asíncrona
@app_celery.task
def tarea_larga():
    time.sleep(10)
    return f"Tarea completada"

# En tu código FastAPI, llamarías a la tarea así:
# from tasks import tarea_larga
# tarea_larga.delay(10) # Ejecuta la tarea en segundo plano
```

#protip([
    Usa Celery para tareas programadas, procesamiento intensivo, o cuando necesites más control sobre las colas y los workers.
])

#pagebreak()

== Uso de WebSockets y eventos en FastAPI

FastAPI soporta WebSockets, permitiendo la comunicación bidireccional en tiempo real. Se usa en aplicaciones como chats, paneles en vivo y notificaciones en tiempo real.

*Ejemplo de un servidor WebSocket en FastAPI:*

#codly(languages: codly-languages)
```python
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from typing import List

app = FastAPI()

# Conexiones activas
conexiones: List[WebSocket] = []

@app.websocket("/ws/chat")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    conexiones.append(websocket)
    try:
        while True:
            mensaje = await websocket.receive_text()
            for conn in conexiones:
                await conn.send_text(f"Mensaje recibido: {mensaje}")
    except WebSocketDisconnect:
        conexiones.remove(websocket)
```

Para probarlo, usa JavaScript en el frontend:

#codly(languages: codly-languages)
```javascript
let socket = new WebSocket("ws://127.0.0.1:8000/ws/chat");

socket.onopen = function() {
  console.log("Conectado al servidor");
  socket.send("Hola servidor desde JS!");
};

socket.onmessage = function(event) {
  console.log(`Mensaje del servidor: ${event.data}`);
};

socket.onclose = function(event) {
    console.log('Conexión cerrada');
};

socket.onerror = function(error) {
  console.log(`Error en WebSocket`, error);
};
```

#protip([
    Usa WebSockets en combinación con Redis (Pub/Sub) o Kafka para manejar múltiples clientes y escalar horizontalmente.
])

#pagebreak()

== Manejo de operaciones asíncronas (async/await)

FastAPI permite ejecutar funciones asíncronas con `async/await`, lo que mejora la eficiencia cuando se manejan operaciones de I/O como consultas a bases de datos (con drivers async) y solicitudes a APIs externas.

*Ejemplo de consulta asíncrona a una API externa:*

#codly(languages: codly-languages)
```python
import aiohttp
from fastapi import FastAPI

app = FastAPI()

# Función asíncrona que consulta una API externa
async def obtener_datos():
    async with aiohttp.ClientSession() as session:
        async with session.get("https://jsonplaceholder.typicode.com/todos/1") as respuesta:
            respuesta.raise_for_status()
            return respuesta.json()

# Ruta que usa la función asíncrona anterior
@app.get("/tarea_async")
async def tarea_async():
    datos = await obtener_datos()
    return {"resultado": datos}
```

#protip([
    Si usas bases de datos, prefiere SQLAlchemy con `asyncpg` para consultas eficientes.
])


