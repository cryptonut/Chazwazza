# Deployment Checklist

> **Template for deploying web applications to production**

**Document Owner:** {{DOCUMENT_OWNER}}  
**Created:** {{DOCUMENT_CREATED_DATE}}  
**Last Updated:** {{DOCUMENT_LAST_UPDATED}}

---

## Purpose

This checklist ensures consistent, reliable deployments with no missed steps. It covers hosting setup, domain configuration, SSL, environment variables, and post-deployment verification.

---

## 🎯 Pre-Deployment

### Code Readiness

- [ ] All features complete and tested
- [ ] Build succeeds locally
- [ ] All tests passing
- [ ] No linting errors
- [ ] No console.log / debug statements
- [ ] Environment variables documented
- [ ] README updated

### Infrastructure Readiness

- [ ] Hosting platform selected ({{HOSTING_PLATFORM}})
- [ ] Domain purchased or identified
- [ ] SSL certificate planned
- [ ] Database/backend services ready
- [ ] Third-party services configured
- [ ] Budget confirmed for hosting costs

---

## 🌐 Domain Configuration

### Domain Purchase

| Step | Action | Status |
|------|--------|--------|
| 1 | Choose domain name | ☐ |
| 2 | Check availability | ☐ |
| 3 | Purchase domain | ☐ |
| 4 | Access DNS settings | ☐ |

**Domain Details:**
```
Domain: {{DOMAIN_NAME}}
Registrar: {{REGISTRAR}}
Purchase Date: {{PURCHASE_DATE}}
Renewal Date: {{RENEWAL_DATE}}
Admin Email: {{ADMIN_EMAIL}}
```

### DNS Configuration

| Record Type | Name | Value | TTL | Purpose |
|-------------|------|-------|-----|---------|
| A | @ | {{IP_ADDRESS}} | 300 | Root domain |
| CNAME | www | {{CNAME_TARGET}} | 300 | www subdomain |
| TXT | @ | {{VERIFICATION_TXT}} | 300 | Domain verification |
| MX | @ | {{MAIL_SERVER}} | 300 | Email (if needed) |

**DNS Configuration Steps:**

1. Log into domain registrar
2. Navigate to DNS settings
3. Add/modify records as above
4. Save changes
5. Wait for propagation (up to 48 hours, usually 15-30 minutes)

### DNS Verification

```bash
# Check A record
nslookup {{DOMAIN_NAME}}

# Check CNAME
nslookup www.{{DOMAIN_NAME}}

# Check propagation status
# Visit: https://dnschecker.org/#A/{{DOMAIN_NAME}}
```

---

## 🔒 SSL Certificate

### SSL Setup

| Method | Provider | Auto-Renewal | Cost |
|--------|----------|--------------|------|
| **Platform SSL** | Vercel/Netlify/etc. | ✅ | Free |
| **Let's Encrypt** | Let's Encrypt | ✅ | Free |
| **Commercial** | {{SSL_PROVIDER}} | Manual | Paid |

**SSL Configuration:**

For most modern platforms (Vercel, Netlify, Cloudflare):
1. Add domain to platform
2. SSL is automatically provisioned
3. Wait 5-30 minutes for certificate

**Verification:**
- [ ] HTTPS works on root domain
- [ ] HTTPS works on www subdomain
- [ ] HTTP redirects to HTTPS
- [ ] No mixed content warnings
- [ ] Certificate shows correct domain

---

## ⚙️ Environment Variables

### Production Environment Variables

| Variable | Value | Source | Required |
|----------|-------|--------|----------|
| `NODE_ENV` | `production` | Hardcoded | ✅ |
| `{{ENV_VAR_1}}` | `***` | {{SECRET_SOURCE}} | ✅ |
| `{{ENV_VAR_2}}` | `***` | {{SECRET_SOURCE}} | ✅ |
| `{{ENV_VAR_3}}` | `***` | {{SECRET_SOURCE}} | ☐ |

### Setting Environment Variables

**Vercel:**
```bash
vercel env add {{ENV_VAR_NAME}} production
```

**Netlify:**
```bash
netlify env:set {{ENV_VAR_NAME}} "value"
```

**Manual (Platform Dashboard):**
1. Navigate to project settings
2. Find Environment Variables section
3. Add each variable
4. Save and redeploy

### Environment Variable Checklist

- [ ] All required variables set
- [ ] No development values in production
- [ ] Secrets not exposed in client-side code
- [ ] Backup of all values documented securely
- [ ] Team access configured appropriately

---

## 🚀 Platform-Specific Deployment

### Vercel

```bash
# Install CLI
npm install -g vercel

# Login
vercel login

# Deploy to preview
vercel

# Deploy to production
vercel --prod

# Add custom domain
vercel domains add {{DOMAIN_NAME}}
```

**Vercel Configuration (`vercel.json`):**
```json
{
  "buildCommand": "{{BUILD_COMMAND}}",
  "outputDirectory": "{{OUTPUT_DIR}}",
  "framework": "{{FRAMEWORK}}",
  "regions": ["{{REGION}}"]
}
```

### Netlify

```bash
# Install CLI
npm install -g netlify-cli

# Login
netlify login

# Initialize
netlify init

# Deploy
netlify deploy --prod
```

**Netlify Configuration (`netlify.toml`):**
```toml
[build]
  command = "{{BUILD_COMMAND}}"
  publish = "{{OUTPUT_DIR}}"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

### AWS Amplify

```bash
# Install CLI
npm install -g @aws-amplify/cli

# Configure
amplify configure

# Initialize
amplify init

# Deploy
amplify publish
```

### Firebase Hosting

```bash
# Install CLI
npm install -g firebase-tools

# Login
firebase login

# Initialize
firebase init hosting

# Deploy
firebase deploy --only hosting
```

---

## 🔧 Third-Party Services

### Required Service Configuration

| Service | Purpose | Production Config Needed |
|---------|---------|-------------------------|
| {{SERVICE_1}} | {{PURPOSE}} | ☐ |
| {{SERVICE_2}} | {{PURPOSE}} | ☐ |
| {{SERVICE_3}} | {{PURPOSE}} | ☐ |

### Common Service Checklist

**Authentication Provider:**
- [ ] Production OAuth credentials created
- [ ] Redirect URIs updated for production domain
- [ ] Rate limits appropriate for production
- [ ] Authorized domains list updated

**Database:**
- [ ] Production instance created
- [ ] Connection string updated
- [ ] Indexes created
- [ ] Backup schedule configured
- [ ] Security rules deployed

**Analytics:**
- [ ] Production tracking ID
- [ ] Filters for internal traffic
- [ ] Goals/conversions configured

**Email Service:**
- [ ] Domain verified
- [ ] SPF/DKIM records added
- [ ] Production API key
- [ ] Templates created

---

## ✅ Post-Deployment Verification

### Functional Testing

| Test | URL | Expected | Status |
|------|-----|----------|--------|
| Homepage loads | {{DOMAIN_NAME}} | 200 OK | ☐ |
| HTTPS redirect | http://{{DOMAIN_NAME}} | 301 → https | ☐ |
| www redirect | www.{{DOMAIN_NAME}} | 301 → root | ☐ |
| 404 page | {{DOMAIN_NAME}}/nonexistent | Custom 404 | ☐ |
| Core feature 1 | {{FEATURE_URL_1}} | Works | ☐ |
| Core feature 2 | {{FEATURE_URL_2}} | Works | ☐ |

### Performance Testing

```bash
# Lighthouse audit
npx lighthouse {{DOMAIN_NAME}} --output html --output-path ./lighthouse.html

# PageSpeed Insights
# Visit: https://pagespeed.web.dev/report?url={{DOMAIN_NAME}}
```

**Performance Targets:**

| Metric | Target | Actual |
|--------|--------|--------|
| First Contentful Paint | < 1.8s | |
| Largest Contentful Paint | < 2.5s | |
| Time to Interactive | < 3.8s | |
| Cumulative Layout Shift | < 0.1 | |
| Performance Score | > 90 | |

### Security Verification

- [ ] SSL certificate valid
- [ ] Security headers present (CSP, HSTS, X-Frame-Options)
- [ ] No sensitive data in client-side code
- [ ] API keys not exposed
- [ ] CORS configured correctly

### SEO Verification

- [ ] Title tags present on all pages
- [ ] Meta descriptions present
- [ ] Open Graph tags configured
- [ ] Sitemap generated and accessible
- [ ] robots.txt configured
- [ ] Canonical URLs set

---

## 📊 Monitoring Setup

### Essential Monitoring

| Type | Tool | Status |
|------|------|--------|
| Uptime | {{UPTIME_TOOL}} | ☐ |
| Error tracking | {{ERROR_TOOL}} | ☐ |
| Analytics | {{ANALYTICS_TOOL}} | ☐ |
| Performance | {{PERF_TOOL}} | ☐ |

### Alert Configuration

| Alert | Threshold | Notify |
|-------|-----------|--------|
| Site down | 1 minute | {{ALERT_EMAIL}} |
| Error spike | > 10/min | {{ALERT_EMAIL}} |
| Slow response | > 3s | {{ALERT_EMAIL}} |

---

## 🔄 Rollback Plan

### If Deployment Fails

1. **Identify the issue** from build logs
2. **Revert to last working deployment**
   ```bash
   # Vercel
   vercel rollback
   
   # Netlify
   netlify deploy --prod --alias previous
   
   # Git
   git revert HEAD
   git push origin main
   ```
3. **Investigate** root cause
4. **Fix and redeploy**

### Rollback Checklist

- [ ] Know how to rollback on {{HOSTING_PLATFORM}}
- [ ] Previous deployment preserved
- [ ] Database migration rollback plan (if applicable)
- [ ] Communication plan for users (if needed)

---

## 📝 Post-Launch

### Immediate (First 24 Hours)

- [ ] Monitor error logs
- [ ] Monitor performance metrics
- [ ] Check analytics tracking
- [ ] Test all critical paths
- [ ] Monitor social mentions

### First Week

- [ ] Review user feedback
- [ ] Check for SEO indexing
- [ ] Verify email deliverability
- [ ] Review performance trends
- [ ] Document any issues

### Ongoing

- [ ] Weekly performance review
- [ ] Monthly security audit
- [ ] Regular dependency updates
- [ ] Backup verification

---

## 📋 Final Checklist

```
DEPLOYMENT VERIFICATION COMPLETE:

□ Domain: {{DOMAIN_NAME}}
□ SSL: Active and valid
□ Environment: All variables configured
□ Third-party: All services connected
□ Testing: All critical paths verified
□ Performance: Meets targets
□ Monitoring: Alerts configured
□ Rollback: Plan documented

Status: [READY / NOT READY]
Deployed by: {{DEPLOYER}}
Date: {{DEPLOY_DATE}}
```

---

## AI Agent Instructions

When deploying:

1. **Follow this checklist** sequentially
2. **Document all credentials** securely (never in code)
3. **Verify each step** before proceeding
4. **Use third-party integration handoff** for manual steps
5. **Never skip security** or monitoring setup
6. **Test thoroughly** before announcing launch

---

*Template from [Chazwazza](https://github.com/cryptonut/Chazwazza) - Enterprise Project Starter Kit*

