# Third-Party Services Log — EXAMPLE (SCAINET)

> **This is an EXAMPLE of a completed THIRD_PARTY_SERVICES_LOG.md showing real-world usage**

**Document Owner:** Platform Team  
**Created:** December 1, 2025  
**Last Updated:** January 14, 2026  
**Version:** 2.3

---

## Quick Reference

| Service | Purpose | Status | Owner |
|---------|---------|--------|-------|
| **Vercel** | Hosting & deployment | 🟢 Active | Simon |
| **Firebase** | Auth, DB, Functions | 🟢 Active | Simon |
| **Sentry** | Error tracking | 🟢 Active | Simon |
| **Resend** | Transactional email | 🟢 Active | Simon |
| **Stripe** | Payments | 🟡 Not yet configured | — |
| **ElevenLabs** | TTS API | 🟢 Active | Simon |

---

## Service Details

### 1. Vercel

| Field | Value |
|-------|-------|
| **Purpose** | Hosting, serverless functions, edge deployment |
| **Account** | simon@scainet.io |
| **Projects** | `scainet-website`, `familyhub-website`, `pro-talk` |
| **Plan** | Pro ($20/month) |
| **Domains** | scainet.io, familyhub.app, protalk.studio |

**Key Configuration:**
- Git integration: GitHub `scainet-enterprise/SCAINET`
- Auto-deploy on push to `main`
- Preview deploys for PRs
- Edge functions enabled

**Environment Variables:**
```
NEXT_PUBLIC_FIREBASE_API_KEY=***
NEXT_PUBLIC_FIREBASE_PROJECT_ID=scainet-portal
SENTRY_DSN=***
```

**Access:**
- Dashboard: https://vercel.com/scainet
- API Token stored in: 1Password → SCAINET Vault

---

### 2. Firebase

| Field | Value |
|-------|-------|
| **Purpose** | Authentication, Firestore DB, Cloud Functions, Storage |
| **Project ID** | `scainet-portal` |
| **Region** | australia-southeast1 |
| **Plan** | Blaze (pay-as-you-go) |

**Services Used:**
- ✅ Authentication (Email link, Google OAuth)
- ✅ Firestore (investors, employees, documentViews)
- ✅ Cloud Functions (sendCustomMagicLink, sendContactForm)
- ✅ Storage (data-room documents)
- ❌ Realtime Database (not used)
- ❌ ML Kit (not used)

**Key Collections:**
```
/investors/{uid}
  - email, ndaAccepted, ndaAcceptedAt, createdAt

/employees/{uid}
  - email, employeeNumber, role, codeAccessNdaSigned

/documentViews/{docId}
  - investorId, documentName, viewedAt

/ndaSignings/{docId}
  - type, employeeId, signature, signedAt
```

**Access:**
- Console: https://console.firebase.google.com/project/scainet-portal
- Service Account Key: 1Password → Firebase Service Account

---

### 3. Sentry

| Field | Value |
|-------|-------|
| **Purpose** | Error tracking, performance monitoring |
| **Organization** | scainet |
| **Projects** | `scainet-website`, `pro-talk-backend` |
| **Plan** | Developer (free) |

**Configuration:**
- Source maps uploaded on deploy
- Release tracking enabled
- User feedback widget: disabled
- Performance sampling: 10%

**Alert Rules:**
- New issue → Slack #engineering
- High frequency error → Email simon@scainet.io

**Access:**
- Dashboard: https://sentry.io/organizations/scainet
- DSN stored in: Vercel env vars

---

### 4. Resend

| Field | Value |
|-------|-------|
| **Purpose** | Transactional emails (magic links, notifications) |
| **Account** | simon@scainet.io |
| **Domain** | scainet.io |
| **Plan** | Free (100 emails/day) |

**Email Templates:**
- Magic link (investor portal)
- Magic link (team portal)
- Contact form notification

**DNS Records Required:**
```
Type    Name                    Value
TXT     resend._domainkey      [provided by Resend]
TXT     @                      v=spf1 include:_spf.resend.com ~all
```

**Access:**
- Dashboard: https://resend.com/overview
- API Key: Vercel env `RESEND_API_KEY`

---

### 5. ElevenLabs (Pro Talk)

| Field | Value |
|-------|-------|
| **Purpose** | Text-to-speech for AI commentary |
| **Account** | simon@scainet.io |
| **Plan** | Creator ($22/month) |
| **Characters/month** | 100,000 |

**Voices Used:**
| Persona | Voice ID | Voice Name |
|---------|----------|------------|
| Alex (PxP) | `pNInz6obpgDQGcFmaJgB` | Adam |
| Jordan (Analyst) | `21m00Tcm4TlvDq8ikWAM` | Rachel |
| Sam (Hype) | `EXAVITQu4vr4xnSDxMaL` | Bella |

**Access:**
- Dashboard: https://elevenlabs.io/app
- API Key: Pro Talk backend env `ELEVENLABS_API_KEY`

---

## Credential Rotation Schedule

| Service | Last Rotated | Next Rotation | Owner |
|---------|--------------|---------------|-------|
| Firebase Service Account | 2025-12-01 | 2026-03-01 | Simon |
| Vercel API Token | 2026-01-01 | 2026-04-01 | Simon |
| Resend API Key | 2025-12-15 | 2026-03-15 | Simon |
| ElevenLabs API Key | 2026-01-10 | 2026-04-10 | Simon |

---

## Cost Summary (Monthly)

| Service | Cost | Billing Date |
|---------|------|--------------|
| Vercel Pro | $20 | 1st |
| Firebase | ~$5-15 | 1st |
| ElevenLabs | $22 | 15th |
| Domains (annual/12) | ~$10 | Various |
| **Total** | **~$57-67** | |

---

## Emergency Contacts

| Service | Support URL | Response Time |
|---------|-------------|---------------|
| Vercel | https://vercel.com/support | 24h (Pro) |
| Firebase | https://firebase.google.com/support | 24h (Blaze) |
| Sentry | https://sentry.io/support | Community |

---

**This example demonstrates how to fill out the THIRD_PARTY_SERVICES_LOG template with real service configurations, credentials management, and cost tracking.**

