# Security Policy

> **Template for security policies in AI-assisted development projects**

**Document Owner:** {{DOCUMENT_OWNER}}  
**Created:** {{DOCUMENT_CREATED_DATE}}  
**Last Updated:** {{DOCUMENT_LAST_UPDATED}}

---

## Supported Versions

| Version | Supported |
|---------|-----------|
| {{LATEST_VERSION}} | ✅ Active support |
| {{PREVIOUS_VERSION}} | ⚠️ Security fixes only |
| < {{PREVIOUS_VERSION}} | ❌ No longer supported |

---

## Reporting a Vulnerability

### How to Report

**DO NOT** create public GitHub issues for security vulnerabilities.

Instead, please report security issues via:
- Email: {{SECURITY_EMAIL}}
- Or: [GitHub Security Advisories]({{REPO_URL}}/security/advisories/new)

### What to Include

1. Description of the vulnerability
2. Steps to reproduce
3. Potential impact assessment
4. Any suggested fixes (optional)

### Response Timeline

| Stage | Timeline |
|-------|----------|
| Acknowledgment | Within 48 hours |
| Initial Assessment | Within 7 days |
| Resolution Target | Within 30 days (critical) / 90 days (other) |
| Public Disclosure | After fix is released |

---

## Security Practices for AI Agents

### 🚫 NEVER Commit These

```
❌ API keys or secrets
❌ Personal access tokens (PAT)
❌ Private keys or certificates
❌ Database connection strings with passwords
❌ AWS/GCP/Azure credentials
❌ OAuth client secrets
❌ Encryption keys
❌ User passwords or PII
```

### ✅ ALWAYS Do This

```
✅ Use environment variables for secrets
✅ Create .example files for sensitive configs
✅ Verify .gitignore before committing
✅ Use secret scanning tools
✅ Review diffs before pushing
✅ Use secure storage services (KeyVault, KMS, etc.)
```

### Example: Safe Configuration Pattern

**❌ WRONG - Never do this:**
```javascript
const apiKey = "sk-1234567890abcdef"; // EXPOSED!
```

**✅ CORRECT - Do this instead:**
```javascript
const apiKey = process.env.API_KEY;
```

With `.env.example`:
```
API_KEY=your-api-key-here
```

And `.gitignore`:
```
.env
.env.local
*.pem
*.key
```

---

## Pre-Commit Security Checklist

Before every commit, verify:

- [ ] No hardcoded secrets in code
- [ ] No credentials in configuration files
- [ ] `.gitignore` includes all sensitive files
- [ ] No PII in logs or comments
- [ ] Dependencies are from trusted sources
- [ ] No known vulnerable dependencies

---

## Secrets Management

### Required Secret Types

| Secret Type | Storage Location | Rotation Frequency |
|-------------|------------------|-------------------|
| API Keys | {{SECRET_STORE}} | 90 days |
| Database Credentials | {{SECRET_STORE}} | 90 days |
| Encryption Keys | {{SECRET_STORE}} | Annual |
| Service Accounts | {{SECRET_STORE}} | 90 days |

### Environment-Specific Secrets

```
Development:  .env.development (local only, gitignored)
QA/Staging:   CI/CD secrets + {{SECRET_STORE}}
Production:   {{SECRET_STORE}} only (no local copies)
```

---

## Dependency Security

### Automated Scanning

Enable these in CI/CD:
- Dependabot / Renovate for dependency updates
- npm audit / pip-audit / cargo-audit
- SAST tools (CodeQL, Semgrep, etc.)
- Container scanning if using Docker

### Manual Review Required For

- New dependencies with < 1000 weekly downloads
- Dependencies with no recent commits (> 1 year)
- Dependencies with known CVEs
- Dependencies requiring elevated permissions

---

## Authentication & Authorization

### Required Standards

| Feature | Minimum Standard |
|---------|-----------------|
| Password Hashing | bcrypt/Argon2 (cost factor ≥ 10) |
| Session Tokens | 256-bit random, HTTPOnly, Secure |
| API Authentication | OAuth 2.0 or API keys with rotation |
| MFA | TOTP or WebAuthn for admin access |

### Authorization Principles

1. **Principle of Least Privilege** - Grant minimum required access
2. **Defense in Depth** - Multiple layers of security
3. **Fail Secure** - Deny access on errors
4. **Audit Everything** - Log security-relevant events

---

## Data Protection

### Classification

| Level | Examples | Handling |
|-------|----------|----------|
| **Public** | Marketing content | No restrictions |
| **Internal** | Business documents | Access control |
| **Confidential** | User data, PII | Encryption required |
| **Restricted** | Credentials, keys | Hardware security |

### Encryption Standards

| Data State | Minimum Standard |
|------------|-----------------|
| At Rest | AES-256 |
| In Transit | TLS 1.3 |
| End-to-End | AES-256-GCM with ECDH |

---

## Incident Response

### Severity Levels

| Level | Description | Response Time |
|-------|-------------|---------------|
| **Critical** | Active exploitation, data breach | Immediate |
| **High** | Exploitable vulnerability | 24 hours |
| **Medium** | Potential vulnerability | 7 days |
| **Low** | Minor security improvement | 30 days |

### Response Steps

1. **Contain** - Stop ongoing damage
2. **Assess** - Determine scope and impact
3. **Remediate** - Fix the vulnerability
4. **Communicate** - Notify affected parties
5. **Review** - Post-incident analysis

---

## Compliance

### Relevant Standards

- [ ] OWASP Top 10
- [ ] {{COMPLIANCE_STANDARD_1}} (e.g., GDPR, HIPAA, SOC2)
- [ ] {{COMPLIANCE_STANDARD_2}}

### Regular Activities

| Activity | Frequency |
|----------|-----------|
| Dependency audit | Weekly (automated) |
| Access review | Monthly |
| Penetration testing | Annual |
| Security training | Annual |

---

## AI Agent Security Instructions

When working on security-related code:

1. **Never bypass** security controls for convenience
2. **Always validate** input at trust boundaries
3. **Use parameterized queries** - never string concatenation for SQL
4. **Sanitize output** - prevent XSS in all user-facing content
5. **Log security events** - but never log sensitive data
6. **Ask when uncertain** - security decisions need human approval

---

*Template from [Chazwazza](https://github.com/cryptonut/Chazwazza) - Enterprise Project Starter Kit*

