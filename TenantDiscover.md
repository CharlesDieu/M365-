# Tenant Discover

## API de Récupération des Domaines d’un Tenant

Cette API permet de récupérer automatiquement **l’ensemble des domaines** associés à un tenant partenaire. Elle ne réalise **aucune action**, aucun blocage et aucune modification : elle se limite à fournir une **liste exhaustive et fiable**.

## 🎯 Objectif
Vous aider à :
- identifier tous les domaines liés à un tenant (connus ou inconnus)
- améliorer votre visibilité et vos décisions de sécurité.

## 🔍 Fonctionnement
1. Vous interrogez l’API avec un domaine connu.
2. L’API collecte et agrège l’ensemble des domaines associés.
3. Vous récupérez une liste complète, exploitable selon vos outils (SIEM, firewall, EDR, etc.).

## 🆓 Version Free
- La version **Free** renvoie **maximum 3 domaines**.
- La **clé Free** est **limitée en nombre d'usages par jour**.
- Parfait pour un premier niveau de visibilité ou un test rapide.

## 💎 Version Premium
La version **Premium** renvoie **tous les domaines** du tenant, sans limite. 
👉 Pour y accéder, **envoyez‑moi simplement un message privé sur LinkedIn**. [Charles DIEU](https://www.linkedin.com/in/charlesd75/)

## 💡 Pourquoi c’est utile
Lorsqu’un tenant partenaire est compromis, vous ne connaissez généralement qu’une petite partie de ses domaines. L’API vous permet d’obtenir **une vision complète**, indispensable pour analyser le risque ou appliquer vos propres actions.

## ⚠️ Ce que l’API ne fait pas
- Aucun blocage automatique
- Aucun filtrage
- Aucune action sur le tenant

## 📦 Format de sortie
- JSON structuré
- Compatibilité avec vos outils d’analyse et d’automatisation

## 📘 Exemple d'entrée
```json
$uri  = 'https://tenantdiscover-gvakd7fhcae0a7b9.francecentral-01.azurewebsites.net/api/tenant-domains-free'
$hdrs = @{ 'X-Api-Key' = 'free_plan_key' }
$body = '{"domain":"domain.fr"}'
```

## 📘 Exemple de réponse
```json
{
  "tenantId": "xxxx-xxxx",
  "domains": [
    "example.com",
    "mail.example.com",
    "sub.example.org"
  ]
}
```
