# mo.github.io

Source for my CV, built with [Typst](https://typst.app) and the
[brilliant-cv](https://typst.app/universe/package/brilliant-cv/) template.
Every push to `main` compiles it to English and German PDFs and publishes
them via GitHub Pages.

## Layout

- `cv.typ` — entry point. Selects language (`profile=en`/`de`) and
  public/full variant (`variant=public`/`private`) via `--input`.
- `profile_en/`, `profile_de/` — one self-contained profile per language:
  `metadata.toml` (public-safe personal data + layout config), `private.toml`
  (gitignored — real contact info + referee names), `private.example.toml`
  (template for the above), and the content modules (`education.typ`,
  `professional.typ`, `skills.typ`, `certificates.typ`, `volunteer.typ`).
- `assets/fonts/` — bundled Roboto, Source Sans 3, and Font Awesome 7 Free
  desktop fonts (all OFL-licensed), so `--font-path assets/fonts` is
  self-contained and CI needs no separate font install step.
- `index.html` — thin landing page linking the two published PDFs.

## Public vs. full PDF

`profile_*/private.toml` never leaves this machine (gitignored) and holds
real email/phone/address plus referee name+title pairs. `cv.typ` only
overlays it when `variant=private` is explicitly requested — CI never passes
that flag, so the published site is always built from the redacted default.

Build the public PDF (what gets published):

```sh
typst compile cv.typ output/cv-en.pdf --font-path assets/fonts --input profile=en
typst compile cv.typ output/cv-de.pdf --font-path assets/fonts --input profile=de
```

Build the full PDF (for actual applications — first copy
`profile_en/private.example.toml` / `profile_de/private.example.toml` to
`private.toml` in the same folder and fill in real values, once):

```sh
typst compile cv.typ output/cv-en-full.pdf --font-path assets/fonts --input profile=en --input variant=private
typst compile cv.typ output/cv-de-full.pdf --font-path assets/fonts --input profile=de --input variant=private
```

## Published site

Once this repo is renamed to `m9o8.github.io`, made public, and Pages is
enabled (Settings → Pages → Source: GitHub Actions): `https://m9o8.github.io/`.
