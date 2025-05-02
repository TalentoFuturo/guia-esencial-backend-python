#import "@preview/ilm:1.4.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/tblr:0.3.1": *
#import "@preview/colorful-boxes:1.4.2": *

#import "modules/table-style.typ": styled-comparison-table
#import "components.typ": protip
#set text(lang: "es")


= Seguridad y optimización en FastAPI

FastAPI proporciona varias formas de autenticación para proteger las APIs, incluyendo autenticación basada en OAuth2, JWT (JSON Web Tokens), y API Keys.

== Autenticación con OAuth2 y JWT

La autenticación con OAuth2 en FastAPI se implementa fácilmente usando `OAuth2PasswordBearer`, que es un flujo estándar para la autenticación basada en tokens.

Instala la dependencia necesaria:

#codly(languages: codly-languages)
```bash
pip install python-jose[cryptography] passlib[bcrypt]
```

Ejemplo de autenticación con JWT:

#codly(languages: codly-languages)
```python
from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt
from datetime import datetime, timedelta

app = FastAPI()

# Configuración básica del token
SECRET_KEY = "mi_clave_secreta" # ¡ADVERTENCIA! Nunca uses esta clave en producción. Genera una clave segura y almacénala como variable de entorno.
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

# OAuth2 usando token por contraseña
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token") # "token" es la URL para obtener el token

# Función para verificar el token
def verificar_token(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except JWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token inválido",
            headers={"WWW-Authenticate": "Bearer"},
        )

# Ruta protegida
@app.get("/usuarios/protegido")
def usuario_protegido(usuario: dict = Depends(verificar_token)):
    return {
        "mensaje": "Acceso permitido",
        "usuario": usuario
    }
```

#protip([
    JWT permite autenticación sin necesidad de almacenar sesiones en el servidor, ideal para microservicios.
])

== Protección contra ataques comunes en FastAPI

FastAPI incluye medidas de seguridad integradas para prevenir ataques como CSRF, SQL Injection y XSS.

=== Prevención de SQL Injection

FastAPI recomienda usar SQLAlchemy con consultas parametrizadas para evitar inyecciones SQL:

#codly(languages: codly-languages)
```python
from sqlalchemy.orm import Session
from sqlalchemy import text

def obtener_usuario(db: Session, usuario_id: int):
    return db.execute(
        text("SELECT * FROM usuarios WHERE id = :id"),
        {"id": usuario_id}
    ).fetchone()
```

=== Protección contra CSRF

A diferencia de Django, FastAPI no incluye CSRF por defecto porque no usa sesiones. Sin embargo, si necesitas proteger formularios web, puedes incluir un token CSRF manualmente o usar librerías específicas.

#protip([
    Configura CORS en FastAPI para evitar ataques de orígenes cruzados (Cross-Origin Resource Sharing).
])

#codly(languages: codly-languages)
```python
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # Solo en desarrollo
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

== Pruebas y debugging en FastAPI

FastAPI es compatible con `pytest` para realizar pruebas automatizadas. Para instalarlo:

#codly(languages: codly-languages)
```bash
pip install pytest httpx
```

*Ejemplo básico de prueba con `pytest`:*

#codly(languages: codly-languages)
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/ping")
def ping():
    return {"mensaje": "pong"}
```

*Ahora crea un archivo llamado `test_main.py` con esta prueba:*

#codly(languages: codly-languages)
```python
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_ping():
    response = client.get("/ping")
    assert response.status_code == 200
    assert response.json() == {"mensaje": "pong"}
```

*Ejecuta las pruebas:*

#codly(languages: codly-languages)
```bash
pytest
```

Resultado esperado:

#codly(languages: codly-languages)
```text
========================= test session starts ========
...
collected 1 item

test_main.py .                                                    [100%]

========================== 1 passed in ...s ===========================
```
