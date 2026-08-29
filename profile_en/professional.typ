// Imports
#import "@preview/brilliant-cv:4.1.0": cv-entry, cv-section, h-bar

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
#let ref-line(key) = {
  let matches = references.filter(r => r.key == key)
  if matches.len() > 0 {
    let r = matches.first()
    let name = if r.at("email", default: "") != "" {
      link("mailto:" + r.email)[#r.name]
    } else {
      r.name
    }
    [Reference: #name -- #r.title]
  } else {
    none
  }
}
#let bullets(..items) = list(..items.pos().filter(b => b != none))


#cv-section("Professional Experience")

#cv-entry(
  title: [DG-SPL/ISO Analyst],
  society: [European Central Bank],
  date: [01/2026 -- ongoing],
  location: [Frankfurt am Main, Germany],
  description: bullets(
    [Strategic Team, responsible for all data across the SSM LSI landscape (1,800 institutions)],
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

#cv-entry(
  title: [Trainee, Analyst],
  society: [European Central Bank],
  date: [07/2023 -- 09/2024],
  location: [Frankfurt am Main, Germany],
  description: bullets(
    [DG-SPL/ISO Traineeship (07/2023 -- 06/2024) \& Supervision Analyst (07/2024 -- 09/2024)],
    [Institutional and sectoral oversight, identification of high-risk and high-impact banks, code migration (from SAS to Python \& SQL) and optimization, established the division's GitLab],
    [Developed \& improved data extraction pipelines from enterprise data lakes (Python, SQL, VBA, Excel data model), improving calculation times by up to 300%],
    [Project(s): optimized a BERT model to identify cyber risks (PyTorch, LangChain), developed the LSI SREP data infrastructure consolidating four source systems across 3,000 SSM banks since 2014 via Python, SQL \& Excel with 20 million datapoints growing quarterly],
  ),
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

#cv-entry(
  title: [Intern, Working Student -- Finance],
  society: [Solarisbank AG],
  date: [07/2020 -- 03/2022],
  location: [Berlin, Germany],
  description: bullets(
    [Finance Intern (07/2020 -- 01/2021) \& Finance Working Student (01/2021 -- 03/2022)],
    [Core banking transformation program, process automation \& optimization (VBA \& SQL)],
    [Financial reporting \& forecasting (esp. balance sheet), ad-hoc reporting \& modeling],
  ),
)

#cv-entry(
  title: [Finance \& Accounting Working Student],
  society: [mittemitte GmbH],
  date: [07/2018 -- 08/2019],
  location: [Berlin, Germany],
)
