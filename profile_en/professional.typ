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
  title: [Supervision Analyst (DG-SPL/ISO)],
  society: [European Central Bank],
  date: [01/2026 -- ongoing],
  location: [Frankfurt am Main, Germany],
  description: bullets(
    [Strategic Team: own data quality, analytics, and reporting across 1,800 SSM Less Significant Institutions, incl. drafting the "Structure of the LSI sector" chapter of the SSM supervision report & quarterly public LSI statistics],
    [Migrated dashboards and data infrastructure from Excel to SQL/Python (Power BI, Tableau, Pandas to Polars)],
    [Project(s): *RWA/CET1 capital impact* simulation tool for proposed risk-weighting simplifications #h-bar() *USD devaluation exposure* on LSI USD positions #h-bar() *LSI profitability deep-dive* #h-bar() LSI IT risk monitoring],
    ref-line("ecb_current"),
  ),
)

#cv-entry(
  title: [Data Scientist / Research Assistant],
  society: [EconAI],
  date: [08/2025 -- 12/2025],
  location: [Barcelona, Spain],
  description: bullets(
    [Built ML/econometric forecasting models for electoral violence & human rights violations, for the German Federal Foreign Office (Auswärtiges Amt), supervising a team of 2 working students on taxonomy design \& data labeling],
    [Processed millions of newspaper articles via LDA topic modeling and headline-embedding/few-shot pipelines to generate national and subnational (ADM2) conflict forecasts from UCDP/ACLED data],
    [Optimized runtimes across the stack: *MLOps pipelines* (Prefect) cut model training from 2 days to 1 hour #h-bar() *PostGIS geospatial joins* cut query time from 25 hours to 30 minutes],
    [Infrastructure: built a Python/PostgreSQL library (Jinja templates, DuckDB) implementing SCD2 versioning for ingested articles #h-bar() open-sourced a Narwhals dataframe-interoperability layer for the panelsplit library],
    ref-line("econai"),
  ),
)

#cv-entry(
  title: [Teaching Assistant -- Economics for Decision Making],
  society: [Universitat Pompeu Fabra / Barcelona School of Economics],
  date: [09/2025 -- 12/2025],
  location: [Barcelona, Spain],
  description: bullets(
    [Weekly TA sessions on Microeconomics \& Game Theory for the Data Science for Decision Making Master's (24 students)],
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
    [Institutional and sectoral oversight: identified high-risk and high-impact Less Significant Institutions through targeted risk models; managed NCA communication via a Central Notification Point & curated the divion's internal konwledge-sharing],
    [Developed \& improved data-extraction pipelines (Python, SQL, VBA, Excel), cutting calculation time by up to 300%],
    [Project(s): *BERT-based cyber-risk detection* POC (PyTorch, LangChain, Azure ML) #h-bar() *LSI SREP data infrastructure* consolidating 3 source systems across 3,000 SSM banks since 2014 (20M+ rows) #h-bar() *SAS to Python/SQL migration* \& GitLab maintenance],
  ),
)
#cv-entry-continued(
  title: [DG-SPL/ISO Trainee],
  date: [07/2023 -- 06/2024],
)

#cv-entry-start(
  society: [HWR Berlin / Gesellschaft für Internationale Zusammenarbeit (GIZ)],
  location: [Berlin, Germany / Bafoussam, Cameroon],
)
#v(3.5pt)
#cv-entry-continued(
  title: [HWR: Student Research Assistant],
  date: [04/2022 -- 06/2023],
  description: bullets(
    [Academic monitoring \& impact evaluation for the GIZ "OurVillage" project, implementing a blockchain-based transaction system in rural Cameroon, researched and drafted input for a working paper (#link("https://www.ipe-berlin.org/fileadmin/institut-ipe/Dokumente/Working_Papers/ipe_working_paper_209.pdf")[1])  \& conference (#link("https://ramics-sofia-2022.unwe.bg/Uploads/Conference/_RAMICS%20-Bulgaria-2022.pdf")[2])],
  ),
)
#cv-entry-continued(
  title: [GIZ: ASA Scholarship -- Project: OurVillage],
  date: [09/2022 -- 12/2022],
  description: bullets(
    [Designed and conducted a field study (approx. 500 interviews, French \& English) evaluating blockchain-voucher adoption],
    [Built a transaction-network visualization tool (Python: NetworkX, Plotly Dash), modeled voucher impact for stakeholder reporting],
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
    [Built VBA/SQL integration frameworks for the core-banking transformation, incl. a proprietary HGB-compliant securities posting tool],
    [Automated monthly FINREP reporting (balance sheet \& P\&L) and reconciliation using AWS, Power Query (M), VBA \& SQL],
  ),
)
#cv-entry-continued(
  title: [Finance Intern],
  date: [07/2020 -- 01/2021],
  description: bullets(
    [Financial reporting, reconciliation \& forecasting; mapped all Finance processes in BPMN diagrams for the core-banking migration],
  ),
)

#cv-entry(
  title: [Finance \& Accounting Working Student],
  society: [mittemitte GmbH],
  date: [07/2018 -- 08/2019],
  location: [Berlin, Germany],
  description: bullets(
    [Sole responsibility for Accounting \& Finance (later joined by a CFO): built the company's first budget model, led the digital migration to Datev, and managed EU (Horizon 2020) \& Investment Bank Berlin funding applications],
  ),
)
