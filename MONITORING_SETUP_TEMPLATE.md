# Monitoring & Analytics Setup Template
## {{PROJECT_NAME}} Observability Configuration

**Last Updated:** {{DOCUMENT_LAST_UPDATED}}  
**Owner:** {{DOCUMENT_OWNER}}

---

## Overview

This template provides setup guides for error tracking (Sentry), analytics (Vercel Analytics, Google Analytics), and performance monitoring to ensure production visibility.

---

## 1. Error Tracking (Sentry)

### Setup Steps

1. **Create Sentry Account & Project**
   - Go to [sentry.io](https://sentry.io)
   - Create organization (use project name)
   - Create project → Select "Next.js" (or your framework)
   - Copy the DSN

2. **Install SDK**

```bash
# Next.js
npm install @sentry/nextjs

# React
npm install @sentry/react

# Node.js
npm install @sentry/node
```

3. **Configuration Files**

`sentry.client.config.ts`:
```typescript
import * as Sentry from "@sentry/nextjs";

Sentry.init({
  dsn: process.env.NEXT_PUBLIC_SENTRY_DSN,
  
  // Performance monitoring
  tracesSampleRate: 1.0,
  
  // Session replay (optional)
  replaysSessionSampleRate: 0.1,
  replaysOnErrorSampleRate: 1.0,
  
  // Only enable in production
  enabled: process.env.NODE_ENV === "production",
});
```

`sentry.server.config.ts`:
```typescript
import * as Sentry from "@sentry/nextjs";

Sentry.init({
  dsn: process.env.NEXT_PUBLIC_SENTRY_DSN,
  tracesSampleRate: 1.0,
  enabled: process.env.NODE_ENV === "production",
});
```

`sentry.edge.config.ts`:
```typescript
import * as Sentry from "@sentry/nextjs";

Sentry.init({
  dsn: process.env.NEXT_PUBLIC_SENTRY_DSN,
  tracesSampleRate: 1.0,
  enabled: process.env.NODE_ENV === "production",
});
```

4. **Environment Variables**

Add to Vercel (or hosting platform):
```
NEXT_PUBLIC_SENTRY_DSN=https://xxx@xxx.ingest.sentry.io/xxx
SENTRY_ORG=your-org
SENTRY_PROJECT=your-project
```

Add to GitHub Secrets:
```bash
gh secret set SENTRY_DSN --body "https://xxx@xxx.ingest.sentry.io/xxx"
gh secret set NEXT_PUBLIC_SENTRY_DSN --body "https://xxx@xxx.ingest.sentry.io/xxx"
```

---

## 2. Analytics (Vercel)

### Setup Steps

1. **Install Packages**

```bash
npm install @vercel/analytics @vercel/speed-insights
```

2. **Add to Layout**

```tsx
// app/layout.tsx
import { Analytics } from '@vercel/analytics/react';
import { SpeedInsights } from '@vercel/speed-insights/next';

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        {children}
        <Analytics />
        <SpeedInsights />
      </body>
    </html>
  );
}
```

3. **View Data**
   - Go to Vercel Dashboard → Your Project → Analytics
   - Speed Insights shows Core Web Vitals

---

## 3. Analytics (Google Analytics 4)

### Setup Steps

1. **Create GA4 Property**
   - Go to [analytics.google.com](https://analytics.google.com)
   - Admin → Create Property
   - Create Web Data Stream
   - Copy Measurement ID (G-XXXXXXXXXX)

2. **Install Package**

```bash
npm install @next/third-parties
```

3. **Add to Layout**

```tsx
// app/layout.tsx
import { GoogleAnalytics } from '@next/third-parties/google';

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        {children}
        <GoogleAnalytics gaId="G-XXXXXXXXXX" />
      </body>
    </html>
  );
}
```

4. **Track Custom Events**

```tsx
'use client';

import { sendGAEvent } from '@next/third-parties/google';

export function Button() {
  return (
    <button onClick={() => sendGAEvent('event', 'button_click', { value: 'xyz' })}>
      Click me
    </button>
  );
}
```

---

## 4. Performance Monitoring

### Lighthouse CI

Add to `.github/workflows/ci.yml`:

```yaml
lighthouse:
  name: Lighthouse Audit
  runs-on: ubuntu-latest
  needs: deploy

  steps:
    - uses: actions/checkout@v4
    
    - name: Run Lighthouse
      uses: treosh/lighthouse-ci-action@v11
      with:
        urls: |
          https://your-site.com
          https://your-site.com/products
        uploadArtifacts: true
        temporaryPublicStorage: true
```

Create `lighthouserc.json`:

```json
{
  "ci": {
    "collect": {
      "numberOfRuns": 3
    },
    "assert": {
      "assertions": {
        "categories:performance": ["warn", { "minScore": 0.8 }],
        "categories:accessibility": ["error", { "minScore": 0.9 }],
        "categories:best-practices": ["warn", { "minScore": 0.9 }],
        "categories:seo": ["warn", { "minScore": 0.9 }]
      }
    }
  }
}
```

---

## 5. Uptime Monitoring (Optional)

### Options

| Service | Free Tier | Features |
|---------|-----------|----------|
| UptimeRobot | 50 monitors | 5-min checks, alerts |
| Better Uptime | 10 monitors | 3-min checks, status pages |
| Pingdom | Trial only | Advanced features |
| Vercel | Included | Basic uptime data |

### UptimeRobot Setup

1. Create account at [uptimerobot.com](https://uptimerobot.com)
2. Add Monitor → HTTP(s)
3. Enter URL and friendly name
4. Set check interval (5 min on free)
5. Add alert contacts (email, Slack, etc.)

---

## 6. Setup Checklist

```
MONITORING SETUP CHECKLIST:

Project: {{PROJECT_NAME}}

Error Tracking (Sentry):
- [ ] Sentry account created
- [ ] Project created (correct framework)
- [ ] DSN copied and saved
- [ ] sentry.client.config.ts created
- [ ] sentry.server.config.ts created
- [ ] sentry.edge.config.ts created (if using edge)
- [ ] NEXT_PUBLIC_SENTRY_DSN in Vercel env vars
- [ ] SENTRY_DSN in GitHub Secrets
- [ ] Test error captured in Sentry dashboard

Analytics:
- [ ] Vercel Analytics installed
- [ ] Vercel Speed Insights installed
- [ ] Google Analytics created (optional)
- [ ] GA Measurement ID configured
- [ ] Custom events tracked (optional)

Performance:
- [ ] Lighthouse CI in GitHub Actions
- [ ] lighthouserc.json configured
- [ ] Baseline scores established

Uptime (optional):
- [ ] Uptime service selected
- [ ] Monitors created for critical pages
- [ ] Alert contacts configured

Documentation:
- [ ] Updated THIRD_PARTY_SERVICES_LOG.md
- [ ] Added DSN/IDs to team knowledge base
```

---

## 7. Verification

### Test Sentry Integration

Add a test button to verify errors are captured:

```tsx
'use client';

export function TestSentry() {
  return (
    <button
      onClick={() => {
        throw new Error("Test Sentry Error");
      }}
    >
      Test Sentry
    </button>
  );
}
```

After clicking:
1. Check Sentry dashboard
2. Error should appear within 1-2 minutes
3. Remove test button after verification

### Verify Analytics

1. Open site in incognito window
2. Navigate between pages
3. Check Vercel Analytics → should show pageviews
4. Check Google Analytics → Realtime report

---

## Template Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `{{PROJECT_NAME}}` | Project name | "SCAINET" |
| `{{DOCUMENT_LAST_UPDATED}}` | Last update date | "January 2026" |
| `{{DOCUMENT_OWNER}}` | Document owner | "Simon Case" |

---

*This template is part of the Chazwazza framework.*

