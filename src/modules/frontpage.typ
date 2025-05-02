#let frontpage(
  title: [],
  subtitle: "",
  author: "",
  date: none,
  paper: "us-letter",
) = {
  set document(title: title, author: author)
  set text(font: "quicksand")
  set align(center)
  page(
    paper: paper,
    margin: (left: 0mm, right: 0mm, top: 0mm, bottom: 0mm),
    header: none,
    footer: none,
    numbering: none,
    number-align: center,
    [
      #place(top + left, image("./portada.svg", width: 100%, height: 100%))
      #place(top + left, 
        stack(
          spacing: 1em,
          align(center)[
            #text(8pt, weight: "semibold", fill: navy, "PROYECTO REALIZADO POR:")
          ],
          align(center)[
            #image("./talentofuturo.png", height: 15mm)
          ],
        ),
        dy: 40pt,
        dx: 40pt
      )
      #place(top + left, 
        box(
          stack(
            spacing: 1em,
            align(center)[
              #text(8pt, weight: "semibold", fill: navy, "APOYADO POR:")
            ],
            align(center)[
              #image("./corfo.png", height: 15mm)
            ]
          ),
        ),
        dy: 40pt,
        dx: 180pt,
      )
      #place(top + left, dy: 8cm, dx: 5%,
        box(
          width: 80%,
          align(center)[
            #stack(
              spacing: 1.5em,
              text(32pt, weight: "semibold", fill: navy, title),
              text(32pt, weight: "bold", fill: orange, subtitle)
            )
          ],
        ),
      )
    ],
  )
}