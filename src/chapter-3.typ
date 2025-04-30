#import "@preview/ilm:1.4.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/tblr:0.3.1": *
#import "@preview/colorful-boxes:1.4.2": *

#import "table-style.typ": styled-comparison-table
#import "components.typ": protip
#set text(lang: "es")

= Desarrollo de aplicaciones en Django

Django maneja las rutas mediante el archivo urls.py, donde se definen los patrones de URL y las vistas asociadas. Las vistas son funciones o clases que procesan las solicitudes y devuelven respuestas.

Ejemplo de configuración en urls.py:

#codly(languages: codly-languages)
```python
# urls.py
from django.urls import path
from . import views # Importa tus vistas desde el archivo views.py de la app

urlpatterns = [
    path('saludo/', views.saludo, name='saludo'),
]
```

Ejemplo de una vista en views.py:

#codly(languages: codly-languages)
```python
# views.py
from django.http import HttpResponse

def saludo(request):
    return HttpResponse("¡Hola desde Django!")
```

#protip([
  Utiliza vistas basadas en clases (class-based views) para mejorar la modularidad de tu código.
])

== Modelos y ORM en Django
Django cuenta con un ORM (Object-Relational Mapper) que permite interactuar con bases de datos mediante clases en Python.

Ejemplo de un modelo:

#codly(languages: codly-languages)
```python
# models.py
from django.db import models

class Producto(models.Model):
    nombre = models.CharField(max_length=100)
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    disponible = models.BooleanField(default=True)

    def __str__(self):
        return self.nombre
```

#protip([
  Utiliza ForeignKey para establecer relaciones entre modelos y optimizar consultas.
])

== Administración de Django
Django incluye un panel de administración automático que permite gestionar los modelos sin necesidad de escribir código adicional. Para activarlo, registra los modelos en admin.py:

#codly(languages: codly-languages)
```python
# admin.py
from django.contrib import admin
from .models import Producto # Importa tu modelo

admin.site.register(Producto)
```

Inicia sesión en http://127.0.0.1:8000/admin/ con un superusuario:

#codly(languages: codly-languages)
```bash
python manage.py createsuperuser
```


#protip([
  Personaliza el panel de administración para mejorar la usabilidad con list_display y search_fields.
])

== Plantillas y Renderización en Django
El sistema de plantillas de Django permite generar contenido dinámico en HTML utilizando el motor de plantillas integrado.

Ejemplo de una plantilla en templates/mi_template.html:

#codly(languages: codly-languages)
```html
<!DOCTYPE html>
<html>
<head>
    <title>Mi página</title>
</head>
<body>
    <h1>Hola, {{ nombre }}</h1> {# Usa variables del contexto #}
</body>
</html>
```

Renderización en una vista:

#codly(languages: codly-languages)
```python
# views.py
from django.shortcuts import render

def mostrar_nombre(request):
    contexto = {'nombre': 'Catalina'} # Datos a pasar a la plantilla
    return render(request, 'mi_template.html', contexto)
```

#protip([
  Utiliza `{% extends %}` y `{% include %}` en plantillas para evitar duplicación de código.
])

== Formularios y validaciones en Django
Django proporciona un sistema robusto para manejar formularios y validaciones.

Ejemplo de un formulario en forms.py:

#codly(languages: codly-languages)
```python
# forms.py
from django import forms

class ContactoForm(forms.Form):
    nombre = forms.CharField(max_length=100)
    email = forms.EmailField()
    mensaje = forms.CharField(widget=forms.Textarea)
```

Manejo del formulario en una vista:

#codly(languages: codly-languages)
```python
# views.py
from django.shortcuts import render
from .forms import ContactoForm # Importa tu formulario

def contacto(request):
    if request.method == 'POST':
        form = ContactoForm(request.POST) # Crea el form con datos enviados
        if form.is_valid():
            # Procesa los datos validados
            nombre = form.cleaned_data['nombre']
            email = form.cleaned_data['email']
            mensaje = form.cleaned_data['mensaje']
            print(f"Mensaje de {nombre} ({email}): {mensaje}")
            # Aquí podrías enviar un email, guardar en BD, etc.
            return render(request, 'gracias.html') # Redirige o muestra agradecimiento
    else:
        form = ContactoForm() # Crea un form vacío para GET

    return render(request, 'contacto.html', {'form': form}) # Pasa el form a la plantilla
```

#protip([
  Usa ModelForm para crear formularios basados en modelos y reducir código repetitivo.
])