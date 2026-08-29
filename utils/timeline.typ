// Thin convenience wrapper around brilliant-cv's own
// cv-entry-start/cv-entry-continued: groups multiple roles held at the same
// company (career progression) into a single call with a `roles` array,
// instead of one cv-entry-start + N manual cv-entry-continued calls at each
// call site.
#import "@preview/brilliant-cv:4.1.0": cv-entry-continued, cv-entry-start

#let cv-entry-timeline(
  society: "Society",
  location: "Location",
  logo: "",
  roles: (),
  color: none,
  metadata: none,
) = {
  cv-entry-start(
    society: society,
    location: location,
    logo: logo,
    color: color,
    metadata: metadata,
  )

  for role in roles {
    cv-entry-continued(
      title: role.at("title", default: ""),
      date: role.at("date", default: ""),
      description: role.at("description", default: ""),
      tags: role.at("tags", default: ()),
      color: color,
      metadata: metadata,
    )
  }
}
