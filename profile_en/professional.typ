// Imports
#import "@preview/brilliant-cv:4.1.0": (
  cv-entry, cv-entry-continued, cv-entry-start, cv-section, h-bar,
)

// Reference lines (referee name + title) are private data. They only exist
// in the gitignored private.toml and are only pulled in for a local build
// run with --input variant=private. The public build renders no reference
// lines at all, and this file never contains referee names in plain text.
#let variant = sys.inputs.at("variant", default: "public")
#let references = if variant == "private" {
  toml("private.toml").at("references", default: ())
} else {
  ()
}
// Styled in the accent color (as brilliant-cv's own cv-honor location text
// is) and slanted, so a reference reads as a distinct, slightly emphasized
// aside rather than another plain bullet. The slant is faked with skew()
// rather than text(style: "italic"): the bundled Source Sans 3 file has no
// italic face, and Typst drops an unmatched style silently instead of
// synthesizing one, so a real italic face would need a whole new font asset.
#let accent-color = rgb(toml("metadata.toml").layout.awesome_color)
#let ref-line(key) = {
  let matches = references.filter(r => r.key == key)
  if matches.len() > 0 {
    let r = matches.first()
    let name = if r.at("email", default: "") != "" {
      link("mailto:" + r.email)[#r.name]
    } else {
      r.name
    }
    skew(
      ax: -10deg,
      reflow: true,
      text(
        weight: "medium",
        fill: accent-color,
        [Reference: #name -- #r.title],
      ),
    )
  } else {
    none
  }
}
#let bullets(..items) = list(..items.pos().filter(b => b != none))


#cv-section("Professional Experience")

#cv-entry(
  title: [Supervision Analyst],
  society: [European Central Bank],
  date: [01/2026 -- ongoing],
  location: [Frankfurt am Main, Germany],
  description: bullets(
    [DG-SPL/ISO Strategic Team, responsible for all data across the SSM LSI landscape (1,800 institutions)],
    [Development of data visualization tools for banking statistics (e.g. Outlier Monitoring in Tableau and Financial Deterioration dashboard in Power BI) for policy recommendations],
    [Project(s): LSI Early Warning System for Financial Deterioration cases using boosted trees (Azure ML), LSI Profitability deep dive, LSI Liquidity Funding Plan assessments],
    ref-line("ecb_current"),
  ),
)

#cv-entry(
  title: [Data Scientist / Research Assistant],
  society: [EconAI],
  date: [08/2025 -- 12/2025],
  location: [Barcelona, Spain],
  description: bullets(
    [Institutional disruption team, building ML models predicting political violence and displacement using NLP pipelines for the German Federal Foreign Office],
    [Refactoring and rewriting of ML infrastructure, implementing MLOps pipelines using MLFlow and Prefect for automated model training and deployment, ensuring reproducibility and version control for research, improving runtimes from 2 days to 1 hour],
    [Barcelona School of Economics: Teaching Assistant for a Master's-level Economics course],
    ref-line("econai"),
  ),
)

#cv-entry-start(
  society: [European Central Bank],
  location: [Frankfurt am Main, Germany],
)
// cv-entry-start/-continued space the company header from the first role's
// title using `before_entry_skip` (tuned tight, -2pt, to keep gaps between
// separate entries compact), whereas a plain cv-entry uses a fixed 6pt
// row-gutter for that same company/title gap. Nudge it back to match.
#v(3.5pt)
#cv-entry-continued(
  title: [Supervision Analyst],
  date: [07/2024 -- 09/2024],
  description: bullets(
    [Institutional and sectoral oversight, identification of high-risk and high-impact banks, code migration (from SAS to Python \& SQL) and optimization, established the division's GitLab],
    [Developed \& improved data extraction pipelines from enterprise data lakes (Python, SQL, VBA, Excel data model), improving calculation times by up to 300%],
    [Project(s): optimized a BERT model to identify cyber risks (PyTorch, LangChain), developed the LSI SREP data infrastructure consolidating four source systems across 3,000 SSM banks since 2014 via Python, SQL \& Excel with 20 million datapoints growing quarterly],
  ),
)
#cv-entry-continued(
  title: [DG-SPL/ISO Trainee],
  date: [07/2023 -- 06/2024],
)


#cv-entry(
  title: [Student Research Assistant],
  society: [HWR Berlin],
  date: [04/2022 -- 06/2023],
  location: [Berlin, Germany],
  description: bullets(
    [Impact evaluation \& monitoring of the GIZ project OurVillage, implementing a blockchain-based transaction system in Cameroon, preparation of conferences and research papers],
    [Project(s): researched and drafted input for two published working papers (#link("https://www.ipe-berlin.org/fileadmin/institut-ipe/Dokumente/Working_Papers/ipe_working_paper_209.pdf")[1] \& #link("https://ramics-sofia-2022.unwe.bg/Uploads/Conference/_RAMICS%20-Bulgaria-2022.pdf")[2])],
  ),
)

#cv-entry(
  title: [ASA Scholarship -- Project: OurVillage],
  society: [GIZ],
  date: [09/2022 -- 12/2022],
  location: [Bafoussam, Cameroon],
  description: bullets(
    [Project management, survey design \& implementation in rural environments, interviews, transaction \& socio-economic data analysis and visualization (Power BI, Python)],
  ),
)

#cv-entry-start(
  society: [Solarisbank AG],
  location: [Berlin, Germany],
)
#v(3.5pt)
#cv-entry-continued(
  title: [Finance Working Student],
  date: [01/2021 -- 03/2022],
  description: bullets(
    [Core banking transformation program, process automation \& optimization (VBA \& SQL)],
    [Financial reporting \& forecasting (esp. balance sheet), ad-hoc reporting \& modeling],
  ),
)
#cv-entry-continued(
  title: [Finance Intern],
  date: [07/2020 -- 01/2021],
)

#cv-entry(
  title: [Finance \& Accounting Working Student],
  society: [mittemitte GmbH],
  date: [07/2018 -- 08/2019],
  location: [Berlin, Germany],
)
