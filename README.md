# 🌍 Business Clustering Analysis – BUSINFO 703

In an increasingly globalised market, companies looking to expand internationally need more than just instinct — they need data-backed insights. This project explores how countries compare on key economic factors like GDP per capita, availability of skilled labour, and corporate tax rates. By clustering countries into similar groups, we help businesses identify which regions share strategic traits — whether you're hunting for growth opportunities, benchmarking policies, or just curious where Singapore fits on the global map

## 📦 What's Inside

- Data cleaning & standardisation
- K-means clustering with silhouette score evaluation
- Optimal cluster selection (spoiler: we liked 5)
- Visual analysis of cluster profiles:
  - 💰 GDP per Capita
  - 👷 Skilled Labour
  - 💼 Corporate Taxes

## 🔍 Methodology Highlights

- Standardised numeric features (removed strings, scaled variables)
- Ran K-means with 3 to 10 clusters
- Used silhouette scores to identify the optimal K
- Assigned clusters to countries and extracted Singapore's cluster for closer inspection

## 📊 Key Visualisations

- Boxplots showing how each cluster compares in:
  - GDP per capita
  - Skilled labour levels
  - Corporate tax rates  
  *(Plus we made it pretty with dark themes for the PowerBI fans in the room)*

## 🧠 Insights

- Clusters revealed meaningful groupings — some tax-heavy, some talent-rich.
- Singapore sat among countries with high-skilled labor and moderate GDP/tax levels.
- Cluster-based segmentation supports expansion strategies for multinationals.

## 🛠️ Tech Stack

- **R** for clustering and visualisation
- **ggplot2**, **cluster**, **arules**, **dplyr**
- **Power BI** for dashboarding

## ⚠️ Disclaimer

This was a university group project and should be treated as an academic exploration, not investment advice. Countries may shift over time, but clustering them was fun anyway.

---

> “When in doubt, cluster it out. And yes, silhouette scores were our guiding light.”  

