#import "@preview/codly:0.1.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/ilm:1.3.1": *
#import "@preview/tblr:0.1.0": *
#import "@preview/colorful-boxes:1.4.2": *
#import "@preview/codly:1.3.0": *

#import "table-style.typ": styled-comparison-table

#set text(lang: "es")
// https://fonts.google.com/specimen/Quicksand

#show: codly-init
#codly(number-format: none)
#codly(zebra-fill: none)
#codly(stroke: 1pt + navy)

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
#set par(leading: 0.8em)

// configurción de codigo
#show raw: set text(font: "fira mono")

// // Configuración personalizada para títulos
// #set heading(numbering: "1.1.")
#show heading.where(level: 1): it => [
  #set text(size: 20pt, font: "quicksand", weight: "extrabold")
  #text(fill: orange)[Capítulo #counter(heading).display()] #it.body
  // #v(0.5em)
]
#show heading.where(level: 2): it => [
  #set text(size: 18pt, font: "quicksand", weight: "bold")
  #it
  #v(0.2em)
]
#show heading.where(level: 3): it => [
  #set text(size: 16pt, font: "quicksand", weight: "bold")
  #it
  #v(0.2em)
]

#include "chapter-1.typ"
#include "chapter-2.typ"
#include "chapter-3.typ"