#import "@preview/ilm:1.4.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/tblr:0.3.1": *
#import "@preview/colorful-boxes:1.4.2": *

#import "modules/table-style.typ": styled-comparison-table
#import "components.typ": protip, note
#set text(lang: "es")


= Django REST Framework (DRF)

Django REST Framework (DRF) es una biblioteca poderosa y flexible que facilita la creación de APIs RESTful en Django. *Esto extiende las capacidades del framework Django* proporcionando herramientas para la serialización de datos, autenticación, permisos y creación de endpoints de manera sencilla.

Una API RESTful es un servicio web que sigue los principios de REST (Representational State Transfer). Con *DRF, puedes crear endpoints que permitan a los clientes (como aplicaciones móviles, frontend o servicios externos) interactuar con tu aplicación* de manera estructurada y eficiente.

#note(
  title: "💡 Entre las principales ventajas de DRF destacan:",
  content: [
    - Facilidad de uso: Permite crear APIs con un mínimo de código.
    - Seguridad integrada: Soporte para autenticación mediante tokens, OAuth y permisos personalizados.
    - Soporte para navegadores: DRF incluye una interfaz de usuario para probar los endpoints desde el navegador.
    - Alta flexibilidad: Soporta JSON, XML y otros formatos de respuesta.
  ]
)

#protip([
  Si necesitas exponer datos en formato JSON de manera eficiente, DRF es la mejor opción sobre Django puro.
])

== Creación de Serializers en DRF

Los serializers en DRF permiten transformar objetos Django en JSON y viceversa. 

Actúan como un puente entre el ORM de Django y la API,  asegurando que los datos se formateen correctamente y cumplan con las validaciones necesarias.

#pagebreak()

*Ejemplo de un serializer básico*:

#codly(languages: codly-languages)
```python
from rest_framework import serializers
from .models import Producto

class ProductoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Producto
        fields = ['id', 'nombre', 'precio', 'disponible']
```

En este caso, `ProductoSerializer` *convierte objetos del modelo Producto en JSON y viceversa*. Usar ModelSerializer simplifica la tarea, ya que automáticamente mapea los campos del modelo a la API.

#protip([
  Define validaciones personalizadas en los serializers para asegurar la integridad de los datos desde la API.
])

== Uso de ViewSets y Routers

En DRF, `ViewSets` permiten agrupar la lógica CRUD (Crear, Leer, Actualizar y Eliminar) en una sola clase, evitando la necesidad de escribir múltiples vistas individuales.

*Ejemplo de un `ViewSet` para gestionar productos*:

#codly(languages: codly-languages)
```python
from rest_framework import viewsets
from .models import Producto
from .serializers import ProductoSerializer

class ProductoViewSet(viewsets.ModelViewSet):
    """
    API endpoint que permite ver o editar productos.
    """
    queryset = Producto.objects.all()
    serializer_class = ProductoSerializer
```

#pagebreak()

*Para registrar estos ViewSets en las rutas de Django, se utilizan Routers*:

#codly(languages: codly-languages)
```python
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ProductoViewSet

router = DefaultRouter()
router.register(r'productos', ProductoViewSet, basename='producto')

urlpatterns = [
    path('', include(router.urls)),
]
```

Esto genera automáticamente las rutas necesarias para manejar productos mediante la API.

#protip([
  Usa ViewSets para reducir la cantidad de código repetitivo y mejorar la mantenibilidad de la API CRUD.
])

== Creación de Endpoints RESTful

Aunque los ViewSets facilitan la gestión de modelos completos, a veces es necesario definir vistas más específicas. Para ello, DRF proporciona `APIView`.

*Ejemplo de un endpoint personalizado*:

#codly(languages: codly-languages)
```python
from rest_framework.views import APIView
from rest_framework.response import Response
from .models import Producto
from .serializers import ProductoSerializer

class ListaProductos(APIView):
    def get(self, request):
        productos = Producto.objects.all()
        serializer = ProductoSerializer(productos, many=True)
        return Response(serializer.data)
```

Este código define un endpoint `GET` `/productos/` que devuelve una lista de productos en formato JSON.

#protip([
  Usa `APIView` o `@api_view` cuando necesites control total sobre la lógica de negocio en los endpoints.
])

DRF facilita la implementación de operaciones CRUD mediante `ModelViewSet`.

Al usarlo, se generan automáticamente las siguientes rutas:

#styled-comparison-table(
  num-columns: 3,
  header: ([MÉTODO HTTP], [RUTA], [ACCIÓN]),
  data: (
    [GET], [/productos/], [Lista todos los productos],
    [POST], [/productos/], [Crea un nuevo producto],
    [GET], [/productos/{id}/], [Obtiene un producto específico],
    [PUT], [/productos/{id}/], [Actualiza un producto (completo)],
    [PATCH], [/productos/{id}/], [Actualiza un producto (parcial)],
    [DELETE], [/productos/{id}/], [Elimina un producto]
  ),
  caption: [Operaciones CRUD con ModelViewSet]
)

*Ejemplo de implementación de CRUD con `ModelViewSet`*:

#codly(languages: codly-languages)
```python
from rest_framework import viewsets
from .models import Producto
from .serializers import ProductoSerializer

class ProductoViewSet(viewsets.ModelViewSet):
    queryset = Producto.objects.all()
    serializer_class = ProductoSerializer
```

No se requiere código adicional en la vista para estas operaciones básicas.

#protip([
  Si no necesitas todas las operaciones CRUD, usa `ViewSets` más específicos como `ReadOnlyModelViewSet` (solo list y retrieve) o combina Mixins (`CreateModelMixin`, `ListModelMixin`, etc.) con `GenericViewSet`.
])

== Autenticación y permisos en APIs

Para proteger las APIs, DRF incluye mecanismos de autenticación (quién es el usuario) y permisos (qué puede hacer el usuario). Se pueden configurar globalmente en `settings.py` o por vista.

*Configuración global en `settings.py`*:

#codly(languages: codly-languages)
```python
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [
        'rest_framework.authentication.SessionAuthentication',
        'rest_framework.authentication.BasicAuthentication',
    ],
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAuthenticated',
    ]
}
```

*Ejemplo de restricción de permisos en un `ViewSet`*:

#codly(languages: codly-languages)
```python
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated

from .models import Producto
from .serializers import ProductoSerializer

class ProductoViewSet(viewsets.ModelViewSet):
    queryset = Producto.objects.all()
    serializer_class = ProductoSerializer
    permission_classes = [IsAuthenticated]
```

Los permisos se pueden personalizar creando clases propias heredadas de `BasePermission`.

#protip([
  Si deseas una autenticación moderna y stateless, implementa JWT (JSON Web Tokens) usando una librería como djangorestframework-simplejwt.
])

#pagebreak()

== Validaciones Personalizadas en DRF

Las validaciones personalizadas en DRF permiten asegurar que los datos enviados a la API cumplan ciertos requisitos antes de ser procesados.

*Ejemplo de validación en un serializer*:

#codly(languages: codly-languages)
```python
from rest_framework import serializers
from .models import Producto

class ProductoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Producto
        fields = '__all__'

    def validate_precio(self, value):
        if value <= 0:
            raise serializers.ValidationError("El precio debe ser mayor a cero.")
        return value

    def validate(self, data):
        if data.get('disponible') and data.get('stock', 0) == 0:
            raise serializers.ValidationError("No puede estar disponible si no hay stock.")
        return data
```

Esta validación garantiza que el precio de un producto no pueda ser menor o igual a cero o que un producto aparezca disponible si es que no hay stock.

#protip([
  Las validaciones también pueden definirse a nivel de modelo usando el método `clean()` en Django.
])
