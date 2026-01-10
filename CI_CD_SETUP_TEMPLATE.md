# CI/CD Setup Template
## {{PROJECT_NAME}} Continuous Integration & Deployment

**Last Updated:** {{DOCUMENT_LAST_UPDATED}}  
**Owner:** {{DOCUMENT_OWNER}}

---

## Overview

This template provides a complete CI/CD setup including GitHub Actions workflows, Dependabot configuration, security scanning, and automated deployment.

---

## 1. GitHub Actions Workflow

Create `.github/workflows/ci.yml`:

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  lint-and-build:
    name: Lint, Type-check, and Build
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: "20"
          cache: "npm"
          # Adjust if your package.json is in a subdirectory
          # cache-dependency-path: ./app/package-lock.json

      - name: Install dependencies
        run: npm ci

      - name: Run ESLint
        run: npm run lint

      - name: Type check
        run: npx tsc --noEmit

      - name: Build
        run: npm run build
        env:
          # Add any build-time environment variables
          NEXT_PUBLIC_SENTRY_DSN: ${{ secrets.SENTRY_DSN }}

  security-scan:
    name: Security Audit
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: "20"

      - name: Install dependencies
        run: npm ci

      - name: Run security audit
        run: npm audit --audit-level=high
        continue-on-error: true

  deploy:
    name: Deploy to Production
    runs-on: ubuntu-latest
    needs: lint-and-build
    if: github.ref == 'refs/heads/main'

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Install Vercel CLI
        run: npm install --global vercel@latest

      - name: Pull Vercel Environment
        run: vercel pull --yes --environment=production --token=${{ secrets.VERCEL_TOKEN }}

      - name: Build Artifacts
        run: vercel build --prod --token=${{ secrets.VERCEL_TOKEN }}

      - name: Deploy to Vercel
        run: vercel deploy --prebuilt --prod --token=${{ secrets.VERCEL_TOKEN }}
        env:
          VERCEL_ORG_ID: ${{ secrets.VERCEL_ORG_ID }}
          VERCEL_PROJECT_ID: ${{ secrets.VERCEL_PROJECT_ID }}
```

---

## 2. Security Scanning (CodeQL)

Create `.github/workflows/codeql.yml`:

```yaml
name: CodeQL Security Analysis

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  schedule:
    # Weekly scan (adjust timezone as needed)
    - cron: "0 9 * * 1"

jobs:
  analyze:
    name: Analyze
    runs-on: ubuntu-latest
    permissions:
      actions: read
      contents: read
      security-events: write

    strategy:
      fail-fast: false
      matrix:
        language: ["javascript-typescript"]

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Initialize CodeQL
        uses: github/codeql-action/init@v3
        with:
          languages: ${{ matrix.language }}
          queries: security-and-quality

      - name: Autobuild
        uses: github/codeql-action/autobuild@v3

      - name: Perform CodeQL Analysis
        uses: github/codeql-action/analyze@v3
        with:
          category: "/language:${{ matrix.language }}"
```

---

## 3. Dependabot Configuration

Create `.github/dependabot.yml`:

```yaml
version: 2
updates:
  # NPM dependencies
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
      day: "monday"
      time: "09:00"
      timezone: "{{TIMEZONE}}"
    open-pull-requests-limit: 5
    commit-message:
      prefix: "deps"
    labels:
      - "dependencies"
      - "automated"
    groups:
      production-dependencies:
        patterns:
          - "*"
        exclude-patterns:
          - "@types/*"
          - "eslint*"
          - "typescript"
        update-types:
          - "minor"
          - "patch"
      dev-dependencies:
        patterns:
          - "@types/*"
          - "eslint*"
          - "typescript"
        update-types:
          - "minor"
          - "patch"

  # GitHub Actions
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
      day: "monday"
    commit-message:
      prefix: "ci"
    labels:
      - "ci"
      - "automated"
```

---

## 4. Required GitHub Secrets

Configure these secrets in your repository settings:

| Secret | Purpose | How to Obtain |
|--------|---------|---------------|
| `VERCEL_TOKEN` | Automated deployments | vercel.com/account/tokens |
| `VERCEL_ORG_ID` | Identify Vercel org | `vercel project ls` or dashboard |
| `VERCEL_PROJECT_ID` | Identify Vercel project | `vercel project ls` or dashboard |
| `SENTRY_DSN` | Error tracking | sentry.io project settings |
| `CODECOV_TOKEN` | Coverage reports | codecov.io settings (optional) |

**CLI Commands:**

```bash
# Add secret via GitHub CLI
gh secret set SECRET_NAME --body "secret_value" --repo owner/repo

# List existing secrets
gh secret list --repo owner/repo

# Get Vercel project info
vercel project ls
```

---

## 5. Setup Checklist

```
CI/CD SETUP CHECKLIST:

Repository: {{PROJECT_NAME}}

Workflows Created:
- [ ] .github/workflows/ci.yml
- [ ] .github/workflows/codeql.yml
- [ ] .github/dependabot.yml

GitHub Secrets Configured:
- [ ] VERCEL_TOKEN
- [ ] VERCEL_ORG_ID
- [ ] VERCEL_PROJECT_ID
- [ ] SENTRY_DSN (if using Sentry)

Verification:
- [ ] Push to main triggers CI
- [ ] PR triggers lint + build
- [ ] Security tab shows CodeQL results
- [ ] Dependabot creates PRs on Monday
- [ ] Auto-deploy works on merge to main

Documentation:
- [ ] Updated THIRD_PARTY_SERVICES_LOG.md
- [ ] Added secrets to team knowledge base
```

---

## 6. Troubleshooting

### Build Fails in CI but Works Locally

1. Check Node.js version matches
2. Verify all environment variables are set
3. Clear npm cache: `npm ci` vs `npm install`
4. Check for OS-specific issues (path separators, etc.)

### Deployment Fails

1. Verify VERCEL_TOKEN is valid and not expired
2. Check VERCEL_ORG_ID and VERCEL_PROJECT_ID are correct
3. Ensure Vercel project is linked to repository
4. Check Vercel dashboard for detailed error logs

### Dependabot PRs Failing

1. Review the PR for breaking changes
2. Check if dependencies have peer dependency conflicts
3. Consider grouping conflicting updates manually
4. Add to `ignore` list if intentionally pinned

---

## Template Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `{{PROJECT_NAME}}` | Project name | "SCAINET" |
| `{{TIMEZONE}}` | Timezone for schedules | "Australia/Adelaide" |
| `{{DOCUMENT_LAST_UPDATED}}` | Last update date | "January 2026" |
| `{{DOCUMENT_OWNER}}` | Document owner | "Simon Case" |

---

*This template is part of the Chazwazza framework.*

