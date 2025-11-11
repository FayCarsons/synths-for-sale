#set page(margin: 0.5in, height: auto)
#set text(font: "Berkeley Mono", size: 9pt)

#let listings = json(sys.inputs.jsonUri)

#table(
  columns: (1fr, 1fr, 0.25fr),
  stroke: (x, y) => (
    top: none,
    bottom: 0.5pt + gray,
    left: none,
    right: none,
  ),
  fill: (x, y) => if y == 0 { rgb("#1a1a1a") } else { white },
  align: left,
  text(white, weight: "bold", [*BRAND*]), text(white, weight: "bold", [*MODULE*]), text(white, weight: "bold", [*PRICE*]),
  ..listings.map(item => (
    text(rgb("333333"), [#item.brand]),
    text(rgb("333333"), [#item.name]),
    text(rgb("555555"), [\$ #item.price])
  )).flatten(),
)
