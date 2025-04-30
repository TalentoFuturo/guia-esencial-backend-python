# Guía esencial para Nuevos Desarrolladores Backend Python

## Instalación y Generación del Ebook

Este proyecto se basa en typst, por lo que necesitarás tener instalado typst para generar el ebook.

```bash
brew install typst
```

Generar el ebook:

```bash
typst compile --font-path src/fonts --format pdf src/main.typ book.pdf
```

Para volver a compilar el ebook cuando hay cambios:

```bash
typst watch --font-path src/fonts --format pdf src/main.typ book.pdf
```

