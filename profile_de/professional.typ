// Imports
#import "@preview/brilliant-cv:4.1.0": cv-entry, cv-section, h-bar

// Referenzzeilen (Name + Titel) sind private Daten. Sie existieren nur in
// der gitignorten private.toml und werden nur bei einem lokalen Build mit
// --input variant=private eingeblendet. Der öffentliche Build zeigt keine
// Referenzzeilen -- diese Datei enthält niemals Referenznamen im Klartext.
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
    [Referenz: #r.name -- #r.title]
  } else {
    none
  }
}
#let bullets(..items) = list(..items.pos().filter(b => b != none))


#cv-section("Berufserfahrung")

#cv-entry(
  title: [DG-SPL/ISO Analyst],
  society: [Europäische Zentralbank],
  date: [01/2026 -- laufend],
  location: [Frankfurt am Main, Deutschland],
  description: bullets(
    [Strategic Team, verantwortlich für sämtliche Daten der SSM-LSI-Landschaft (1.800 Institute)],
    [Entwicklung von Datenvisualisierungstools für Bankenstatistiken (u. a. Outlier Monitoring in Tableau und Financial-Deterioration-Dashboard in Power BI) für politische Handlungsempfehlungen],
    [Projekt(e): LSI Early Warning System für Fälle finanzieller Verschlechterung mittels Boosted Trees (Azure ML), LSI-Profitabilitäts-Deep-Dive, LSI-Liquidity-Funding-Plan-Bewertungen],
    ref-line("ecb_current"),
  ),
)

#cv-entry(
  title: [Data Scientist / Research Assistant],
  society: [EconAI],
  date: [08/2025 -- 12/2025],
  location: [Barcelona, Spanien],
  description: bullets(
    [Institutional-Disruption-Team, Entwicklung von ML-Modellen zur Vorhersage politischer Gewalt und Vertreibung mittels NLP-Pipelines für das Auswärtige Amt],
    [Refactoring und Neuentwicklung der ML-Infrastruktur, Implementierung von MLOps-Pipelines mit MLflow und Prefect für automatisiertes Modelltraining und -deployment, Sicherstellung von Reproduzierbarkeit und Versionskontrolle für die Forschung, Verbesserung der Laufzeiten von 2 Tagen auf 1 Stunde],
    [Barcelona School of Economics: Teaching Assistant für einen Master-Kurs in Volkswirtschaftslehre],
    ref-line("econai"),
  ),
)

#cv-entry(
  title: [Trainee, Analyst],
  society: [Europäische Zentralbank],
  date: [07/2023 -- 09/2024],
  location: [Frankfurt am Main, Deutschland],
  description: bullets(
    [DG-SPL/ISO-Traineeship (07/2023 -- 06/2024) \& Supervision Analyst (07/2024 -- 09/2024)],
    [Institutionelle und sektorale Aufsicht, Identifikation von Hochrisiko- und Hochimpact-Banken, Code-Migration (von SAS zu Python \& SQL) und Optimierung, Aufbau des GitLab der Abteilung],
    [Entwicklung \& Verbesserung von Datenextraktions-Pipelines aus Enterprise-Data-Lakes (Python, SQL, VBA, Excel-Datenmodell), Verbesserung der Berechnungszeiten um bis zu 300\%],
    [Projekt(e): Optimierung eines BERT-Modells zur Identifikation von Cyberrisiken (PyTorch, LangChain), Entwicklung der LSI-SREP-Dateninfrastruktur zur Konsolidierung von vier Quellsystemen über 3.000 SSM-Banken seit 2014 mittels Python, SQL \& Excel mit 20 Millionen Datenpunkten (quartalsweise wachsend)],
  ),
)

#cv-entry(
  title: [Studentische Hilfskraft],
  society: [HWR Berlin],
  date: [04/2022 -- 06/2023],
  location: [Berlin, Deutschland],
  description: bullets(
    [Wirkungsevaluation \& Monitoring des GIZ-Projekts OurVillage, Implementierung eines Blockchain-basierten Transaktionssystems in Kamerun, Vorbereitung von Konferenzen und Forschungsarbeiten],
    [Projekt(e): Recherche und Erstellung von Beiträgen für zwei veröffentlichte Working Papers],
  ),
)

#cv-entry(
  title: [ASA-Stipendium -- Projekt: OurVillage],
  society: [GIZ],
  date: [09/2022 -- 12/2022],
  location: [Bafoussam, Kamerun],
  description: bullets(
    [Projektmanagement, Design \& Durchführung von Umfragen im ländlichen Raum, Interviews, Transaktions- und sozioökonomische Datenanalyse und -visualisierung (Power BI, Python)],
  ),
)

#cv-entry(
  title: [Praktikant, Werkstudent -- Finance],
  society: [Solarisbank AG],
  date: [07/2020 -- 03/2022],
  location: [Berlin, Deutschland],
  description: bullets(
    [Finance-Praktikum (07/2020 -- 01/2021) \& Werkstudent Finance (01/2021 -- 03/2022)],
    [Core-Banking-Transformationsprogramm, Prozessautomatisierung \& -optimierung (VBA \& SQL)],
    [Finanzberichterstattung \& Forecasting (insb. Bilanz), Ad-hoc-Reporting \& Modellierung],
  ),
)

#cv-entry(
  title: [Werkstudent Finance \& Accounting],
  society: [mittemitte GmbH],
  date: [07/2018 -- 08/2019],
  location: [Berlin, Deutschland],
)
