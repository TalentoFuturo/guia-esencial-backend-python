#import "@preview/codly:0.1.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/tblr:0.1.0": *
#import "@preview/colorful-boxes:1.4.2": *
#import "@preview/codly:1.3.0": *
#import "@preview/pintorita:0.1.4": *
#import "modules/style.typ": *

#import "modules/table-style.typ": styled-comparison-table

#set text(lang: "es")
// https://fonts.google.com/specimen/Quicksand

#show: codly-init
#codly(number-format: none)
#codly(zebra-fill: none)
#codly(stroke: 1pt + navy)

#show outline.entry: it => {
   v(1em)
   it
}

#show: ilm.with(
  title: [Guía esencial para \ Nuevos Desarrolladores],
  subtitle: [Backend Python],
  author: "Talento Futuro",
  date: datetime(year: 2024, month: 03, day: 1),
  paper-size: "us-letter",
  figure-index: (enabled: false),
  table-index: (enabled: false),
  listing-index: (enabled: true),
  table-of-contents: outline(
    depth: 1,
  ),
  external-link-circle: false,
)

// Configuración de fuentes
#set text(
  font: "quicksand", 
  fill: navy,
  size: 12pt
)
#set par(leading: 0.8em)

// configurción de codigo
#show raw: set text(font: "fira mono", size: 10pt)
// #show raw.where(block: true): it => block(breakable: false, it)

// Pintorita
#show raw.where(lang: "pintora"): it => pintorita.render(it.text)

// // Configuración personalizada para títulos
// #set heading(numbering: "1.1.")
#show heading.where(level: 1): it => [
  #pagebreak(weak: false)
  #set text(size: 20pt, font: "quicksand", weight: "extrabold")
  #text(fill: orange)[Capítulo #counter(heading).display()] 
  #it.body
]
#show heading.where(level: 2): it => [
  #set text(size: 18pt, font: "quicksand", weight: "bold")
  #it.body
  #v(0.2em)
]
#show heading.where(level: 3): it => [
  #set text(size: 16pt, font: "quicksand", weight: "bold")
  #it.body
  #v(0.2em)
]



#include "chapter-1.typ"
#include "chapter-2.typ"
#include "chapter-3.typ"
#include "chapter-4.typ"
#include "chapter-5.typ"
#include "chapter-6.typ"
#include "chapter-7.typ"
#include "chapter-8.typ"
#include "chapter-9.typ"
#include "chapter-10.typ"