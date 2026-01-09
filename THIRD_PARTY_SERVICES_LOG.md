# Third-Party Services Log

> **Template for tracking external services and integrations**

**Document Owner:** {{DOCUMENT_OWNER}}  
**Created:** {{DOCUMENT_CREATED_DATE}}  
**Last Updated:** {{DOCUMENT_LAST_UPDATED}}  
**Project:** {{PROJECT_NAME}}

---

## Purpose

This document tracks all third-party services used by the project, including their status, credentials location, and configuration requirements. Essential for onboarding, debugging, and disaster recovery.

---

## 📋 Services Overview

### Production Services

| Service | Purpose | Status | Tier | Monthly Cost |
|---------|---------|--------|------|--------------|
| {{SERVICE_1}} | {{PURPOSE}} | ✅ Active | {{TIER}} | ${{COST}} |
| {{SERVICE_2}} | {{PURPOSE}} | ✅ Active | {{TIER}} | ${{COST}} |
| {{SERVICE_3}} | {{PURPOSE}} | ⚠️ Trial | {{TIER}} | ${{COST}} |

### Development Services

| Service | Purpose | Status | Notes |
|---------|---------|--------|-------|
| {{DEV_SERVICE_1}} | {{PURPOSE}} | ✅ Active | Development only |
| {{DEV_SERVICE_2}} | {{PURPOSE}} | ✅ Active | Shared instance |

---

## 🔑 Credentials Reference

**⚠️ DO NOT store actual credentials in this document. Only reference where they are stored.**

### Credentials Locations

| Service | Credentials Location | Access Level |
|---------|---------------------|--------------|
| {{SERVICE_1}} | {{SECRET_MANAGER_PATH}} | Admin only |
| {{SERVICE_2}} | {{SECRET_MANAGER_PATH}} | Team |
| {{SERVICE_3}} | {{SECRET_MANAGER_PATH}} | Admin only |

### Environment Variable Mapping

| Service | Environment Variable | Used In |
|---------|---------------------|---------|
| {{SERVICE_1}} | `{{ENV_VAR_NAME}}` | Backend |
| {{SERVICE_2}} | `{{ENV_VAR_NAME}}` | Frontend |
| {{SERVICE_3}} | `{{ENV_VAR_NAME}}` | Both |

---

## 📊 Service Details

### {{SERVICE_NAME}} (e.g., Firebase)

| Property | Value |
|----------|-------|
| **Category** | Authentication / Database / Hosting |
| **Dashboard** | [Link to dashboard] |
| **Documentation** | [Link to docs] |
| **Support** | [Support contact] |
| **Status Page** | [Link to status page] |

**Configuration:**
```
Project ID: {{PROJECT_ID}}
Region: {{REGION}}
Environment: Production
```

**Required Setup Steps:**
1. [ ] Create project
2. [ ] Enable required services
3. [ ] Configure security rules
4. [ ] Set up authentication methods
5. [ ] Add authorized domains
6. [ ] Deploy initial configuration

**Environment Variables:**
```
{{SERVICE}}_API_KEY=xxx
{{SERVICE}}_PROJECT_ID=xxx
{{SERVICE}}_AUTH_DOMAIN=xxx
```

**Billing:**
| Item | Limit | Current Usage |
|------|-------|---------------|
| Requests | 50K/day | 10K/day |
| Storage | 5GB | 1GB |
| Bandwidth | 10GB/mo | 2GB/mo |

**Dependencies:**
- Required by: {{LIST_FEATURES}}
- Requires: {{LIST_PREREQUISITES}}

---

### Template for Each Service

Copy this template for each new service:

```markdown
### [Service Name]

| Property | Value |
|----------|-------|
| **Category** | [Auth/DB/Hosting/Analytics/Email/Payment/etc.] |
| **Dashboard** | [URL] |
| **Documentation** | [URL] |
| **Support** | [Contact method] |
| **Status Page** | [URL] |
| **Account Owner** | [Email] |
| **Billing Contact** | [Email] |

**Tier:** [Free/Pro/Enterprise]  
**Monthly Cost:** $[amount]  
**Renewal Date:** [date]

**Configuration:**
[Environment-specific details]

**Required Setup Steps:**
1. [ ] Step 1
2. [ ] Step 2
3. [ ] Step 3

**Environment Variables:**
[List of env vars needed]

**Billing Limits:**
| Item | Limit | Alert Threshold |
|------|-------|-----------------|
| [Resource] | [Limit] | [80%] |

**Dependencies:**
- Required by: [features]
- Requires: [other services]

**Notes:**
[Any special considerations]
```

---

## 🚨 Critical Services

Services that will cause immediate outage if unavailable:

| Service | Impact | Failover | RTO |
|---------|--------|----------|-----|
| {{CRITICAL_1}} | Site down | {{FAILOVER}} | {{TIME}} |
| {{CRITICAL_2}} | Auth broken | {{FAILOVER}} | {{TIME}} |
| {{CRITICAL_3}} | Data loss | {{FAILOVER}} | {{TIME}} |

### Incident Response

If critical service is down:

1. **Check status page** — Is it a known outage?
2. **Check credentials** — Have they expired?
3. **Check quotas** — Have we hit limits?
4. **Enable failover** — If available
5. **Communicate** — Update users if needed
6. **Monitor** — Watch for recovery

---

## 🔄 Integration Status

### API Integrations

| Integration | Endpoint | Auth Method | Rate Limit | Status |
|-------------|----------|-------------|------------|--------|
| {{API_1}} | {{ENDPOINT}} | API Key | {{LIMIT}} | ✅ |
| {{API_2}} | {{ENDPOINT}} | OAuth | {{LIMIT}} | ✅ |
| {{API_3}} | {{ENDPOINT}} | JWT | {{LIMIT}} | ⚠️ |

### Webhook Configurations

| Source | Event | Endpoint | Secret Location |
|--------|-------|----------|-----------------|
| {{SERVICE}} | {{EVENT}} | {{URL}} | {{SECRET_PATH}} |

---

## 🛡️ Security Configuration

### OAuth Applications

| Provider | Client ID Location | Redirect URIs |
|----------|-------------------|---------------|
| {{PROVIDER}} | {{SECRET_PATH}} | {{URIS}} |

**Authorized Domains (must be manually configured):**
- `{{DOMAIN_1}}`
- `{{DOMAIN_2}}`
- `localhost` (development only)

### API Key Rotation Schedule

| Service | Last Rotated | Next Rotation | Owner |
|---------|--------------|---------------|-------|
| {{SERVICE}} | {{DATE}} | {{DATE}} | {{OWNER}} |

---

## 💰 Cost Tracking

### Monthly Costs

| Service | Budget | Actual | Status |
|---------|--------|--------|--------|
| {{SERVICE_1}} | ${{BUDGET}} | ${{ACTUAL}} | ✅ Under |
| {{SERVICE_2}} | ${{BUDGET}} | ${{ACTUAL}} | ⚠️ Near |
| {{SERVICE_3}} | ${{BUDGET}} | ${{ACTUAL}} | ✅ Under |
| **Total** | **${{TOTAL}}** | **${{TOTAL}}** | |

### Cost Alerts

| Service | Alert Threshold | Notify |
|---------|-----------------|--------|
| {{SERVICE}} | ${{THRESHOLD}} | {{EMAIL}} |

---

## 📅 Renewal Calendar

| Service | Renewal Date | Action Required | Owner |
|---------|--------------|-----------------|-------|
| {{SERVICE}} | {{DATE}} | Renew subscription | {{OWNER}} |
| {{DOMAIN}} | {{DATE}} | Renew domain | {{OWNER}} |
| {{CERT}} | {{DATE}} | Auto-renews | Automated |

---

## 🔧 Manual Configuration Required

Services that require manual steps (cannot be fully automated):

### {{SERVICE_NAME}}

**Manual Steps Required:**
1. Log into {{SERVICE}} dashboard
2. Navigate to Settings → Configuration
3. [Specific steps]
4. Save changes

**When Required:**
- Initial setup
- Adding new domains
- Updating billing
- Changing plans

**Who Can Do This:**
- {{ADMIN_EMAIL}} (Owner)
- {{ADMIN_EMAIL}} (Admin)

---

## 📝 Change Log

| Date | Service | Change | By |
|------|---------|--------|-----|
| {{DATE}} | {{SERVICE}} | Added new service | {{WHO}} |
| {{DATE}} | {{SERVICE}} | Upgraded tier | {{WHO}} |
| {{DATE}} | {{SERVICE}} | Rotated API key | {{WHO}} |

---

## ✅ New Service Checklist

When adding a new third-party service:

- [ ] Document in this file
- [ ] Add credentials to secret manager
- [ ] Set up environment variables
- [ ] Configure for all environments (dev/staging/prod)
- [ ] Set up billing alerts
- [ ] Add to cost tracking
- [ ] Add renewal to calendar
- [ ] Document manual configuration steps
- [ ] Test failover (if applicable)
- [ ] Update relevant team members

---

## AI Agent Instructions

When working with third-party services:

1. **Never hardcode credentials** — Use environment variables
2. **Document all services** — Add to this log immediately
3. **Use handoff protocol** — For manual configuration steps
4. **Check status pages** — Before debugging integration issues
5. **Monitor costs** — Alert if approaching limits
6. **Rotate credentials** — Follow security schedule

---

*Template from [Chazwazza](https://github.com/cryptonut/Chazwazza) - Enterprise Project Starter Kit*

