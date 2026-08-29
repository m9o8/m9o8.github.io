// Imports
#import "@preview/brilliant-cv:4.1.0": cv

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

#show: cv.with(
  metadata,
  profile-photo: none,
)

// Add, remove, or reorder modules to customize CV content.
#import-modules((
  "education",
  "professional",
  "skills",
  "certificates",
  "volunteer",
))
