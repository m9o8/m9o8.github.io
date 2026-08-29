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
  base-metadata + (
    personal: base-metadata.personal + (info: merged-info),
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

// The header contact-info row (location, GitHub, LinkedIn, and -- in the
// private variant -- email/phone) is left-aligned normally, but centered
// once it wraps past two lines, so a longer row (e.g. the private-variant
// build) doesn't end up ragged under the name. This rebuilds the row's
// content itself (rather than styling brilliant-cv's built-in row) because
// choosing an alignment requires measuring the rendered row first, and the
// package always builds+places that row internally. It only covers the
// plain `[personal.info]` keys this repo actually uses (location, github,
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

#let info-link(k, v) = if k == "email" {
  link("mailto:" + v)[#v]
} else if k == "linkedin" {
  link("https://www.linkedin.com/in/" + v)[#v]
} else if k == "github" {
  link("https://github.com/" + v)[#v]
} else if k == "gitlab" {
  link("https://gitlab.com/" + v)[#v]
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

// Estimates the row's wrapped line count from two self-consistent
// measurements of the SAME content (so icon glyphs are already accounted
// for): its unconstrained (one-line) height, and its height at the real
// container width. The per-line increment (line-height + paragraph
// leading) is calibrated separately from a plain two-line reference at the
// same font size, since a single unconstrained measurement can't reveal
// the leading Typst inserts only *between* wrapped lines.
#let count-lines(row, width, font-size) = {
  let wrapped-height = measure(row, width: width).height
  let one-line-height = measure(row, width: 1000cm).height
  let ref-one = measure(text(size: font-size)[Ag]).height
  let ref-two = measure(text(size: font-size)[Ag #linebreak() Ag]).height
  let increment = ref-two - ref-one
  calc.max(1, int(1 + calc.round((wrapped-height - one-line-height) / increment)))
}

#let smart-header-info = layout(container => context {
  let font-size = eval(metadata.layout.header.at("info_font_size", default: "10pt"))
  let row = text(size: font-size, info-row(metadata.personal.info))
  let lines = count-lines(row, container.width, font-size)
  align(if lines > 2 { center } else { left }, box(width: container.width, row))
})

#show: cv.with(
  metadata,
  profile-photo: none,
  header-info: smart-header-info,
)

// Add, remove, or reorder modules to customize CV content.
#import-modules((
  "education",
  "professional",
  "skills",
  "certificates",
  "volunteer",
))
