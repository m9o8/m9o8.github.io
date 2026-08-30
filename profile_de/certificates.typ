// Imports
#import "@preview/brilliant-cv:4.1.0": cv-section

// Als zweispaltiges Karten-Grid statt brilliant-cvs cv-honor-Liste
// dargestellt: cv-honor reserviert feste Datums-/Ortsspalten, die bei
// Einträgen ohne beides den Großteil der Zeile leer lassen.
//
// `date` ist pro Eintrag optional (`none`, wenn das Jahr nicht bekannt/
// relevant ist) und erscheint rechtsbündig neben dem Titel, wenn gesetzt.
#let accent-color = rgb(toml("metadata.toml").layout.awesome_color)

#let certs = (
  (
    title: [Innovation \& AI],
    issuer: [Europäische Zentralbank / INSEAD],
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


#cv-section("Zertifikate")

#grid(
  columns: (1fr, 1fr),
  column-gutter: 20pt,
  row-gutter: 12pt,
  ..certs.map(cert-card),
)
