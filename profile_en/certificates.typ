// Imports
#import "@preview/brilliant-cv:4.1.0": cv-section

// Rendered as a two-column card grid rather than brilliant-cv's cv-honor
// list: cv-honor reserves fixed date/location columns, which for entries
// with neither leaves most of the row as empty space.
//
// `date` is optional per entry (left `none` where the year isn't known/
// worth listing) and renders right-aligned next to the title when set.
#let accent-color = rgb(toml("metadata.toml").layout.awesome_color)

#let certs = (
  (
    title: [Innovation \& AI],
    issuer: [European Central Bank / INSEAD],
    date: [05/2024],
  ),
  (
    title: [AI Programming with Python],
    issuer: [Bertelsmann Tech Scholarship],
    date: [05/2024],
  ),
  (
    title: [Predictive Analytics for Business],
    issuer: [Bertelsmann Tech Scholarship],
    date: [11/2021],
  ),
  (
    title: [Distributed Computing with Spark],
    issuer: [UC Davis],
    date: [02/2021],
  ),
  (title: [Digitalization \& Sustainability], issuer: [FSEGT], date: [03/2022]),
  (
    title: [Introduction to Portfolio Construction and Analysis with Python],
    issuer: [EDHEC],
    date: [08/2020],
  ),
)

#let cert-card(cert) = [
  #grid(
    columns: (1fr, auto),
    column-gutter: 6pt,
    align: horizon,
    text(weight: "bold", size: 9pt, cert.title),
    if cert.date != none {
      text(fill: accent-color, size: 8pt, style: "oblique", cert.date)
    },
  )
  #text(fill: accent-color, size: 8pt, style: "italic", cert.issuer)
]


#cv-section("Certificates")

#grid(
  columns: (1fr, 1fr),
  column-gutter: 20pt,
  row-gutter: 12pt,
  ..certs.map(cert-card),
)
