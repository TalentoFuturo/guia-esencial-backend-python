#import "@preview/colorful-boxes:1.4.2": *

#let protip(content) = {
  block(breakable: false)[
    #slanted-colorbox(
      title: "🚀 ProTip",
      color: "blue",
      radius: 0pt,
      width: auto
    )[
      #content
    ]
  ]
}

#let note(
  title: "Nota",
  content: content
) = {
  block(breakable: false)[
    #slanted-colorbox(
      title: title,
      color: "purple",
      radius: 0pt,
      width: auto
    )[
      #content
    ]
  ]
}