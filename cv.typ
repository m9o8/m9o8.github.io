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

#let centered-header-info = context {
  let font-size = eval(metadata.layout.header.at(
    "info_font_size",
    default: "10pt",
  ))
  align(center, text(size: font-size, info-row(metadata.personal.info)))
}

#show: cv.with(
  metadata,
  profile-photo: none,
  header-info: centered-header-info,
)

// Add, remove, or reorder modules to customize CV content.
#import-modules((
  "education",
  "professional",
  "volunteer",
  "skills",
  "certificates",
))
