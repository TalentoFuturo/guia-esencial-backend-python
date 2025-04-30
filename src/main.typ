#import "@preview/codly:0.1.0": *
#import "@preview/ilm:1.3.1": *
#import "@preview/tblr:0.1.0": *
#import "@preview/colorful-boxes:1.4.2": *

#import "table-style.typ": styled-comparison-table

#set text(lang: "es")
// https://fonts.google.com/specimen/Quicksand


#show: ilm.with(
  title: [Guía esencial para Nuevos Desarrolladores Backend Python],
  author: "Talento Futuro",
  date: datetime(year: 2024, month: 03, day: 19),
  preface: [
    #align(center + horizon)[
      Proyecto realizado por Talento Futuro \ 
      Apoyado por Corfo - Becas Capital Humano \
      #emoji.heart
    ]
  ],
  paper-size: "us-letter",
//   bibliography: bibliography("refs.bib"),
  figure-index: (enabled: false),
  table-index: (enabled: false),
  listing-index: (enabled: false),
  table-of-contents: none,
)

// Configuración de fuentes
#set text(
  font: "quicksand", 
  fill: navy,
)
#set par(leading: 1em)

// Configuración personalizada para títulos
#set heading(numbering: "1.1.")
#show heading.where(level: 1): it => [
  #set text(size: 24pt, font: "quicksand", weight: "extrabold")
  #it
  #v(1em)
]
#show heading.where(level: 2): it => [
  #set text(size: 20pt, font: "quicksand", weight: "bold")
  #it
  #v(0.8em)
]
#show heading.where(level: 3): it => [
  #set text(size: 16pt, font: "quicksand", weight: "bold")
  #it
  #v(0.6em)
]

#include "chapter-1.typ"