#import "@preview/ilm:1.4.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/tblr:0.3.1": *
#import "@preview/colorful-boxes:1.4.2": *

#import "modules/table-style.typ": styled-comparison-table
#import "components.typ": protip, note
#set text(lang: "es")


= Seguridad y optimización en Django

Django REST Framework (DRF) ofrece múltiples métodos de autenticación para proteger las APIs y controlar el acceso de los usuarios.

Algunos de los más utilizados son:

- *Session Authentication:* Utiliza las sesiones de Django y es ideal para aplicaciones web donde los usuarios inician sesión mediante formularios.

- *Token Authentication:* Se basa en tokens persistentes y permite a los clientes autenticarse enviando un token en los encabezados de la solicitud.

- *JWT (JSON Web Tokens):* Es un método más seguro y escalable, donde se generan tokens cifrados que pueden incluir información sobre el usuario.

*Para configurar Token Authentication, agrégalo en `settings.py`*:

#codly(languages: codly-languages)
```python
INSTALLED_APPS = [
  ...
  'rest_framework',
  'rest_framework.authtoken',
]

REST_FRAMEWORK = {
  'DEFAULT_AUTHENTICATION_CLASSES': [
    'rest_framework.authentication.TokenAuthentication',
  ],
  'DEFAULT_PERMISSION_CLASSES': [
    'rest_framework.permissions.IsAuthenticated',
  ],
}
```

#pagebreak()

*Los tokens pueden generarse y asignarse a los usuarios de la siguiente manera*:

#codly(languages: codly-languages)
```python
from rest_framework.authtoken.models import Token
from django.contrib.auth.models import User

# Obtener un usuario existente
user = User.objects.get(username='nombre_de_usuario')

# Generar o recuperar un token para ese usuario
token, created = Token.objects.get_or_create(user=user)

# Imprimir el token
print(token.key)
```

*Configura JWT en `settings.py`*:

#codly(languages: codly-languages)
```python
# settings.py
REST_FRAMEWORK = {
  'DEFAULT_AUTHENTICATION_CLASSES': (
    'rest_framework_simplejwt.authentication.JWTAuthentication',
  ),
  'DEFAULT_PERMISSION_CLASSES': (
    'rest_framework.permissions.IsAuthenticated',
  ),
}

from datetime import timedelta

SIMPLE_JWT = {
  'ACCESS_TOKEN_LIFETIME': timedelta(minutes=30),
  'REFRESH_TOKEN_LIFETIME': timedelta(days=1),
  'ROTATE_REFRESH_TOKENS': True,
  'BLACKLIST_AFTER_ROTATION': True,
  'AUTH_HEADER_TYPES': ('Bearer',),
}
```

#protip([
  Utiliza JWT para aplicaciones móviles o SPAs que necesiten autenticación sin depender de sesiones.
])

== Protección Contra Ataques Comunes (CSRF, SQL Injection, XSS)

Django incluye varias medidas de seguridad integradas para proteger contra ataques comunes:

- *CSRF (Cross-Site Request Forgery):* Protegido por defecto con el middleware `CsrfViewMiddleware`. Para vistas basadas en APIs, usa `@csrf_exempt` si es necesario, aunque no recomendado.
- *SQL Injection:* Al usar el ORM de Django, las consultas son parametrizadas y previenen inyecciones SQL.
- *XSS (Cross-Site Scripting):* El motor de plantillas de Django escapa automáticamente las variables en las plantillas, previniendo la ejecución de código malicioso.

*Ejemplo de protección CSRF en formularios*:

#codly(languages: codly-languages)
```html
<form method="post">
  {% csrf_token %}
</form>
```

#protip([
  Nunca deshabilites CSRF en producción sin una razón justificada.
])

== Optimización de consultas con Django ORM

El ORM de Django facilita las consultas a la base de datos, pero un mal uso puede afectar el rendimiento. Algunas técnicas para optimización incluyen:

*Evitar consultas repetitivas con `select_related()` y `prefetch_related()`:*

#codly(languages: codly-languages)
```python
productos = Producto.objects.select_related('categoria').all()
```

Esto carga la relación `categoria` en la misma consulta SQL en lugar de hacer múltiples consultas separadas.

*Usar `only()` y `defer()` para cargar solo los campos necesarios:*

#codly(languages: codly-languages)
```python
productos = Producto.objects.only('nombre', 'precio')
```

*Indexar columnas frecuentemente consultadas para mejorar la velocidad de búsqueda:*

#codly(languages: codly-languages)
```python
class Producto(models.Model):
  nombre = models.CharField(max_length=100, db_index=True)
```

#protip([
  Habilita `django-debug-toolbar` para identificar problemas de rendimiento en las consultas.
])

== Pruebas y Debugging en Django

Django proporciona un framework de pruebas basado en `unittest`, permitiendo validar la funcionalidad de la aplicación antes de su despliegue.

*Ejemplo de prueba para un modelo:*

#codly(languages: codly-languages)
```python
from django.test import TestCase
from .models import Producto

class ProductoModelTest(TestCase):
  def test_creacion_producto(self):
    producto = Producto.objects.create(
      nombre='Prueba',
      precio=1000,
      stock=10,
      disponible=True
    )
    self.assertEqual(producto.nombre, 'Prueba')
    self.assertTrue(producto.disponible)
```

*Para ejecutar las pruebas:*

#codly(languages: codly-languages)
```bash
python manage.py test
```

Además, Django incluye herramientas de depuración como `django-debug-toolbar`, que permite inspeccionar consultas SQL y optimizar el rendimiento.

*Para instalarlo:*

#codly(languages: codly-languages)
```bash
pip install django-debug-toolbar
```

*Configura `settings.py` para habilitarlo:*

#codly(languages: codly-languages)
```python
INSTALLED_APPS = [
  ...
  'debug_toolbar',
]

MIDDLEWARE = [
  ...
  'debug_toolbar.middleware.DebugToolbarMiddleware',
]

INTERNAL_IPS = [
  "127.0.0.1",
]
```

#protip([
  Configura logs en Django para registrar errores en producción.
])


