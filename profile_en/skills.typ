// Imports
#import "@preview/brilliant-cv:4.1.0": cv-section, cv-skill, h-bar


#cv-section("Skills")

#cv-skill(
  type-width: 27%,
  type: [Languages],
  info: [German (Mother tongue) #h-bar() English (Fluent, C1) #h-bar() French (Proficient, C1) #h-bar() Spanish (Basic, A2)],
)

#cv-skill(
  type-width: 27%,
  type: [Programming -- Advanced],
  info: [Git (GitLab, GitHub) #h-bar() LaTeX #h-bar() Power Query (M) \& DAX #h-bar() Python (pandas, NumPy) #h-bar() SQL (DB2, Impala, PostgreSQL) #h-bar() VBA],
)

#cv-skill(
  type-width: 27%,
  type: [Programming -- Intermediate],
  info: [Java/Scala (Spark) #h-bar() R #h-bar() SAS #h-bar() Stata],
)

#cv-skill(
  type-width: 27%,
  type: [ML / Analytics],
  info: [ML (scikit-learn, PyTorch) #h-bar() NLP (spaCy, NLTK) #h-bar() Econometrics (Synthetic DiD, IVs, matching)],
)

#cv-skill(
  type-width: 27%,
  type: [Cloud / Ops],
  info: [Apache Airflow #h-bar() Prefect #h-bar() Azure ML #h-bar() MLflow #h-bar() Docker],
)

#cv-skill(
  type-width: 27%,
  type: [Visualization],
  info: [Dash Plotly #h-bar() Power BI #h-bar() Tableau],
)

#cv-skill(
  type-width: 27%,
  type: [Productivity],
  info: [BPMN #h-bar() Excel #h-bar() KoboToolbox #h-bar() UNIX/Linux],
)

#cv-skill(
  type-width: 27%,
  type: [Open-Source],
  info: [#link("https://github.com/4Freye/panelsplit")[Panelsplit] -- Python, DataFrame agnosticism #h-bar() #link("https://github.com/Daniel-Pailanir/sdid")[sdid] -- Stata, bug fixes],
)
