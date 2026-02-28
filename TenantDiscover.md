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
- Renvoie **maximum 3 domaines**
- Clé API limitée en volume
- Idéal pour tester ou obtenir une première vue

## 💎 Version Premium
La version Premium renvoie **tous les domaines** du tenant, sans limite.  
👉 Pour y accéder : **contact LinkedIn**  
https://www.linkedin.com/in/charlesd75/

## 💡 Pourquoi c’est utile
Lorsqu’un tenant partenaire est compromis, vous ne connaissez souvent qu’un seul domaine. Cette API vous offre une **vision totale** pour évaluer le risque ou automatiser vos actions.

## ⚠️ Ce que l’API ne fait pas
- Aucun blocage  
- Aucun filtrage  
- Aucune action sur le tenant  

## 📦 Format de sortie  
- JSON structuré  
- Compatible SIEM, EDR, automatisation  

---

# 📚 API Reference

## **POST /api/tenant-domains-free**
Récupère les domaines associés à un tenant Microsoft à partir d’un domaine connu.

---

## 🔑 Authentication
```http
X-Api-Key: free_plan_key
Content-Type: application/json
```

## 📤 Request Body
```json
{
  "domain": "domain.fr"
}
```

---

## ▶️ Exemple d’appel (PowerShell)
```powershell
$uri  = 'https://tenantdiscover-gvakd7fhcae0a7b9.francecentral-01.azurewebsites.net/api/tenant-domains-free'
$hdrs = @{ 'X-Api-Key' = 'free_plan_key' }
$body = '{"domain":"domain.fr"}'

Invoke-RestMethod -Uri $uri -Headers $hdrs -Method Post -Body $body
```

## ▶️ Exemple d’appel (cURL)
```bash
curl -X POST https://tenantdiscover-gvakd7fhcae0a7b9.francecentral-01.azurewebsites.net/api/tenant-domains-free   -H "X-Api-Key: free_plan_key"   -H "Content-Type: application/json"   -d '{"domain":"domain.fr"}'
```

---

## 📥 Response (200 OK)
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

---

## ❌ Codes d’erreur
| Code | Description |
|------|-------------|
| **400** | Mauvais format ou domaine invalide |
| **401** | API Key manquante ou invalide |
| **429** | Limite d’appels atteinte |
| **500** | Erreur interne |
