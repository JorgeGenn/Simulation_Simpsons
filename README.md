# 🧬 Applied Biostatistical Analysis of Gene Expression in *The Simpsons* Population

![R](https://img.shields.io/badge/Language-R%20%3E%3D%204.0-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Status](https://img.shields.io/badge/Analysis-Completed-brightgreen)
![Topic](https://img.shields.io/badge/Topic-Bioinformatics%20%26%20Biostatistics-orange)

An end-to-end bioinformatics and biostatistical pipeline implemented in **R Markdown**. This study evaluates non-parametric gene expression profiles, dimensionality reduction via Principal Component Analysis (PCA), spatial clustering, Spearman correlation heatmaps, and multivariate logistic regression modeling to predict overweight/obesity risk ($N = 59$, 37 target genes).

---

## 📌 Executive Summary

This project analyzes simulated genomic and clinical data from *The Simpsons* universe to uncover latent biological pathways driving metabolic phenotypes. Due to non-normal transcriptional distributions, non-parametric methods were implemented throughout. 

Key insights include:
* **Transcriptional Dysregulation:** A distinct multigenic cluster (*POMC*, *LEPR*, *ANO4*) correlates strongly with obesity phenotypes and spatial divergence in PCA space.
* **Dimensionality Reduction:** The first two principal components (PC1 & PC2) explain 21.04% of total biological variance (PC1: 12.48%, PC2: 8.56%), reflecting multi-pathway complexity.
* **Clinical Prediction:** Multivariate logistic regression demonstrates that the top tertile of Component 2 (*CADM2*-dominated) exhibits a statistically significant protective effect against overweight status ($\text{OR} = 0.0$, $95\%\text{ CI: } 0.0\text{--}0.7$, $p = 0.047$).

---

## 🔬 Analytical Pipeline & Methodology

```
┌───────────────────────────┐
│     Data Ingestion &      │  • Automated NA filtering (ADCY3:UHMK1)
│        Preprocessing      │  • Quality check & feature selection
└─────────────┬─────────────┘
              │
┌─────────────▼─────────────┐
│    Normality Testing      │  • Shapiro-Wilk Test (p < 0.05 -> Non-parametric)
│   (Shapiro-Wilk Model)    │  • Reporting Medians & IQRs (P25 - P75)
└─────────────┬─────────────┘
              │
┌─────────────▼─────────────┐
│  Dimensionality Reduction │  • Centered & scaled PCA (`prcomp`)
│          (PCA)            │  • Eigenvalue extraction (scree plot & loadings)
└─────────────┬─────────────┘
              │
┌─────────────▼─────────────┐
│  Clustering & Heatmaps    │  • K-means clustering (k = 3 for genes/samples)
│   (Spatial & Correlation) │  • Spearman correlation & scaled expression heatmaps
└─────────────┬─────────────┘
              │
┌─────────────▼─────────────┐
│ Stratified Analysis       │  • Sample discretization into PC tertiles (T1, T2, T3)
│   (Kruskal-Wallis)        │  • Non-parametric Kruskal-Wallis tests via `gtsummary`
└─────────────┬─────────────┘
              │
┌─────────────▼─────────────┐
│ Multivariate Logistic Reg.│  • Response: Overweight (BMI >= 25 kg/m²)
│   (Forest Plot & AIC)     │  • Predictors: PC Tertiles + 14 clinical covariates
└───────────────────────────┘
```

---

## 🛠️ Required R Packages

Ensure you have R (>= 4.0.0) installed. The script automatically verifies and installs missing dependencies upon execution:

```r
mis_paquetes <- c(
  "tidyverse", "gtsummary", "gt", "rmarkdown", "knitr", 
  "stats", "readr", "dplyr", "tidyr", "factoextra", 
  "reshape", "ggplot2", "car", "pROC", "broom", "kableExtra"
)
```

---

## 📊 Key Results & Visualizations

| Figure / Table | Description | Main Findings |
| :--- | :--- | :--- |
| **Model Table 1** | Shapiro-Wilk Normality Evaluation | Rejects $H_0$ ($p < 0.05$) for expression variables; justifies non-parametric statistics. |
| **Figure 1–4** | PCA Scree Plot, Variables & Biplot | Identifies key drivers (*POMC*, *ANO4*, *LEPR* vs. *MC4R*, *SIM1*). |
| **Figures 6 & 9** | K-means Clustering ($k=3$) | Isolates outlier subjects (Patient 1 & Patient 2) exhibiting extreme overexpression. |
| **Figures 10 & 11** | Spearman & Raw Heatmaps | Validates directional vector correlations and raw expression intensity blocks. |
| **Descriptive Table** | Tertile Stratification (`gtsummary`) | Significant median shifts across strata (e.g., *CADM2* $p = 7.39\text{e-}05$). |
| **Figure 12** | Multivariate Logistic Regression Forest Plot | Component 2 Tertile 3 protects against overweight risk; Model $\text{AIC} = 90.30$, Residual Deviance $= 48.30$. |

---

## 🚀 How to Run & Reproduce

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/simpsons-gene-expression-r.git
   cd simpsons-gene-expression-r
   ```

2. **Open in RStudio:**
   Open `Simulation_Simpsons.Rmd` (or the primary R Markdown file) inside RStudio.

3. **Knit the Document:**
   Click the **Knit** button or run the following command in your R console to build the standalone HTML report:
   ```r
   rmarkdown::render("Simulation_Simpsons.Rmd", output_format = "html_document")
   ```

---

## 📁 Repository Structure

```text
.
├── Simulation_Simpsons.Rmd  # Primary R Markdown analysis script
├── estilos.css              # Custom styling for HTML output
├── README.md                # Project documentation
├── campana_gauss_95.png     # Methodology figure for Gaussian distribution
└── output/
    └── Simulation_Simpsons.html # Standalone compiled HTML report
```

---

## ✒️ Author

* **Jorge Hurtado Soriano**
---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
