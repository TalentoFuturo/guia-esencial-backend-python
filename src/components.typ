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