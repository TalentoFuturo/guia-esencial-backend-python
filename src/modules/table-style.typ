#import "@preview/tblr:0.3.1": *

// Definir colores aproximados (ajusta según sea necesario)
#let dark-teal = rgb("#208385")
#let light-teal = rgb("#C9EAEA")
#let white-gap = 2pt // Espacio entre celdas

#let styled-comparison-table(
  num-columns: 3,
  num-header-rows: 1,
  header: (),
  data: (),
  caption: none,
  breakable: false,
) = {
  block(breakable: breakable)[
    #tblr(
    columns: num-columns,
    header-rows: num-header-rows,
    align: center + horizon,
    inset: 8pt,
    stroke: none,
    gutter: white-gap,
    rows(within: "header", 0,
      fill: dark-teal,
      hooks: (text.with(fill: white), strong)
    ),
    rows(within: "body", auto,fill: light-teal),
    ..header,
    ..data
    )
    #if caption != none [
      #align(center)[
        #text(style: "italic", size: 0.9em)[*Tabla:* #caption]
      ]
      #v(0.5em)
    ]
  ]
}



