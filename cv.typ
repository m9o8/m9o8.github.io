// Imports
#import "@preview/brilliant-cv:4.1.0": cv, h-bar
#import "@preview/fontawesome:0.6.0": (
  fa-envelope, fa-gitlab, fa-linkedin, fa-location-dot, fa-orcid, fa-pager,
  fa-phone, fa-researchgate, fa-square-github,
)

// Two independent switches, both set via --input at compile time:
//   profile: "en" (default) | "de"          -- which language to render
//   variant: "public" (default) | "private" -- whether to overlay real
//     contact info + referee names from the gitignored private.toml
//
// CI never passes `variant`, so it always builds the public/redacted PDF —
// the private branch below is only ever exercised on a local machine that
// has created profile_<lang>/private.toml (see private.example.toml).
#let profile = sys.inputs.at("profile", default: "en")
#let variant = sys.inputs.at("variant", default: "public")
#let profile-dir = "profile_" + profile + "/"

#let base-metadata = toml(profile-dir + "metadata.toml")

#let metadata = if variant == "private" {
  let private-data = toml(profile-dir + "private.toml")
  let merged-info = base-metadata.personal.info + private-data.info
  (
    base-metadata
      + (
        personal: base-metadata.personal + (info: merged-info),
      )
  )
} else {
  base-metadata
}

#let import-modules(modules) = {
  for module in modules {
    include profile-dir + module + ".typ"
  }
}

// Subtle affordance so hyperlinks (header contact info, referee emails,
// inline citation links) read as clickable without shouting -- tinted with
// the profile's own accent color rather than a fixed one.
#show link: it => text(fill: rgb(metadata.layout.awesome_color), it)

// Justify body text so wrapped lines in entry descriptions stretch to the
// full column width instead of ending ragged-right wherever the last word
// happens to land -- entries read as consistently "full-width" even though
// the underlying content lengths vary.
#set par(justify: true)

// The header contact-info row (location, email, phone, GitHub, LinkedIn)
// is centered under the name. This rebuilds the row's content itself
// (rather than styling brilliant-cv's built-in row) because the package
// always builds+places that row internally. It only covers the plain
// `[personal.info]` keys this repo actually uses (location, github,
// linkedin, email, phone) -- not the package's `custom-*` icon or manual
// `linebreak` keys, since neither profile uses those.
#let info-icons = (
  location: fa-location-dot(),
  github: fa-square-github(),
  linkedin: fa-linkedin(),
  homepage: fa-pager(),
  gitlab: fa-gitlab(),
  orcid: fa-orcid(),
  researchgate: fa-researchgate(),
  email: fa-envelope(),
  phone: fa-phone(),
)

// Displays full "host.tld/handle" text (not just the bare handle) so the
// link survives an ATS stripping images -- the header's little
// GitHub/LinkedIn icons are otherwise the only thing disambiguating an
// opaque handle like "m9o8" from plain text.
#let info-link(k, v) = if k == "email" {
  link("mailto:" + v)[#v]
} else if k == "linkedin" {
  link("https://www.linkedin.com/in/" + v)[linkedin.com/in/#v]
} else if k == "github" {
  link("https://github.com/" + v)[github.com/#v]
} else if k == "gitlab" {
  link("https://gitlab.com/" + v)[gitlab.com/#v]
} else if k == "homepage" {
  link("https://" + v)[#v]
} else if k == "orcid" {
  link("https://orcid.org/" + v)[#v]
} else if k == "researchgate" {
  link("https://www.researchgate.net/profile/" + v)[#v]
} else if k == "phone" {
  link("tel:" + v.replace(" ", ""))[#v]
} else {
  v
}

#let info-row(personal-info) = {
  let visible = personal-info.pairs().filter(((k, v)) => v != none and v != "")
  for (i, (k, v)) in visible.enumerate() {
    if i > 0 { h-bar() }
    box({
      info-icons.at(k)
      h(5pt)
      info-link(k, v)
    })
  }
}

#let centered-header-info = context {
  let font-size = eval(metadata.layout.header.at(
    "info_font_size",
    default: "10pt",
  ))
  align(center, text(size: font-size, info-row(metadata.personal.info)))
}

// brilliant-cv 4.1.0 stacks the header's name / contact-info / header-quote
// rows in a table with a fixed 6mm row-gutter and no metadata override --
// shrink that specific gap to close up the whitespace above "Education".
// `row-gutter` isn't a field `.where()` can match on (it silently never
// matches, even on an exact value/type copy of what `.fields()` reports),
// so match on `columns: (1fr,)` instead -- a single 1fr column is unique to
// this header table (every other table in the package/content uses a
// multi-column layout) -- and rebuild it with a tighter gutter. Swapping
// the rebuilt column spec from `1fr` to `100%` avoids the rebuilt table
// re-matching its own selector (both fill the same single-column width, so
// this doesn't change layout). Must run before `cv.with` below, since the
// header itself is rendered inside that call.
#show table.where(columns: (1fr,)): it => {
  let f = it.fields()
  table(
    columns: (100%,),
    inset: f.inset,
    stroke: f.stroke,
    align: f.align,
    fill: f.fill,
    column-gutter: f.column-gutter,
    row-gutter: 3mm,
    ..f.children,
  )
}

// brilliant-cv 4.1.0's entry-header tables (`columns: (1fr, date-width)`,
// shared by cv-entry/-start/-continued since logos are off here) are
// breakable by default -- a plain cv-entry nests its society/location and
// title/date rows as a 2-row sub-table inside a single cell, which can
// split across a page break (e.g. "mittemitte GmbH" stranded at a page
// bottom with its role/date line starting the next page). Force every
// match non-breakable so a header always moves to the next page as a
// whole instead of splitting; the description/bullets below it are
// unaffected and can still flow across a page break as normal.
#let date-width = eval(metadata.layout.at("date_width", default: "3.6cm"))
#show table.where(columns: (1fr, date-width)): it => block(breakable: false, it)

#show: cv.with(
  metadata,
  profile-photo: none,
  header-info: centered-header-info,
)

// brilliant-cv 4.1.0 hardcodes cv-section's title at 16pt bold with no
// metadata override, so shrink it by pattern-matching the exact text()
// call it emits internally.
#show text.where(size: 16pt, weight: "bold"): set text(size: 11pt)

// Add, remove, or reorder modules to customize CV content.
#[
  // Entry society/title lines use brilliant-cv's "a1" style, also a
  // hardcoded 10pt bold with no override -- match it down to the body
  // font size so firm names read on par with the entries' own text.
  // Scoped to a block rather than applied document-wide because
  // cv-skill's type labels (Skills section) use the same 10pt/bold
  // combination and should keep their current size.
  #show text.where(size: 10pt, weight: "bold"): set text(
    size: eval(metadata.layout.at("font_size", default: "9pt")),
  )
  #import-modules(("education", "professional", "volunteer"))
]
#import-modules(("skills", "certificates"))
