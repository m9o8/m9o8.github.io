// Imports
#import "@preview/brilliant-cv:4.1.0": cv-section, cv-skill, h-bar


#cv-section("Kenntnisse")

#cv-skill(
  type-width: 32%,
  type: [Sprachen],
  info: [Deutsch (Muttersprache) #h-bar() Englisch (Fließend, C1) #h-bar() Französisch (Sehr gut, C1) #h-bar() Spanisch (Grundkenntnisse, A2)],
)

#cv-skill(
  type-width: 32%,
  type: [Programmierung -- Fortgeschritten],
  info: [Git (GitLab, GitHub) #h-bar() LaTeX #h-bar() Power Query (M) \& DAX #h-bar() Python (pandas, NumPy) #h-bar() SQL (DB2, Impala, PostgreSQL) #h-bar() VBA],
)

#cv-skill(
  type-width: 32%,
  type: [Programmierung -- Mittel],
  info: [Java/Scala (Spark) #h-bar() R #h-bar() SAS #h-bar() Stata],
)

#cv-skill(
  type-width: 32%,
  type: [ML / Analytics],
  info: [ML (scikit-learn, PyTorch) #h-bar() NLP (spaCy, NLTK) #h-bar() Ökonometrie (Synthetic DiD, IVs, Matching)],
)

#cv-skill(
  type-width: 32%,
  type: [Cloud / Ops],
  info: [Apache Airflow #h-bar() Prefect #h-bar() Azure ML #h-bar() MLflow #h-bar() Docker],
)

#cv-skill(
  type-width: 32%,
  type: [Visualisierung],
  info: [Dash Plotly #h-bar() Power BI #h-bar() Tableau],
)

#cv-skill(
  type-width: 32%,
  type: [Produktivität],
  info: [BPMN #h-bar() Excel #h-bar() KoboToolbox #h-bar() UNIX/Linux],
)

#cv-skill(
  type-width: 32%,
  type: [Open Source],
  info: [#link("https://github.com/4Freye/panelsplit")[Panelsplit] -- Python, DataFrame-Agnostizismus #h-bar() #link("https://github.com/Daniel-Pailanir/sdid")[sdid] -- Stata, Bugfixes],
)
