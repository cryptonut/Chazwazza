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

## 7. GitLab CI Configuration

Create `.gitlab-ci.yml` in your repository root:

```yaml
# GitLab CI/CD Pipeline
# Equivalent to GitHub Actions workflow

stages:
  - lint
  - test
  - build
  - deploy

variables:
  NODE_VERSION: "20"
  npm_config_cache: "$CI_PROJECT_DIR/.npm"

# Cache node_modules across jobs
cache:
  key: ${CI_COMMIT_REF_SLUG}
  paths:
    - .npm/
    - node_modules/

# ============================================
# LINT & TYPE CHECK
# ============================================
lint:
  stage: lint
  image: node:${NODE_VERSION}
  script:
    - npm ci
    - npm run lint
    - npx tsc --noEmit
  rules:
    - if: $CI_PIPELINE_SOURCE == "merge_request_event"
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH

# ============================================
# TEST
# ============================================
test:
  stage: test
  image: node:${NODE_VERSION}
  script:
    - npm ci
    - npm test -- --coverage
  coverage: '/All files[^|]*\|[^|]*\s+([\d\.]+)/'
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage/cobertura-coverage.xml
    paths:
      - coverage/
    expire_in: 1 week
  rules:
    - if: $CI_PIPELINE_SOURCE == "merge_request_event"
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH

# ============================================
# BUILD
# ============================================
build:
  stage: build
  image: node:${NODE_VERSION}
  script:
    - npm ci
    - npm run build
  artifacts:
    paths:
      - dist/
      - .next/
    expire_in: 1 day
  rules:
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH

# ============================================
# SECURITY AUDIT
# ============================================
security-audit:
  stage: lint
  image: node:${NODE_VERSION}
  script:
    - npm audit --audit-level=high
  allow_failure: true
  rules:
    - if: $CI_PIPELINE_SOURCE == "merge_request_event"
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH

# ============================================
# DEPLOY (Example: Vercel)
# ============================================
deploy-production:
  stage: deploy
  image: node:${NODE_VERSION}
  dependencies:
    - build
  before_script:
    - npm install -g vercel
  script:
    - vercel pull --yes --environment=production --token=$VERCEL_TOKEN
    - vercel build --prod --token=$VERCEL_TOKEN
    - vercel deploy --prebuilt --prod --token=$VERCEL_TOKEN
  environment:
    name: production
    url: https://{{PROJECT_URL}}
  rules:
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
      when: manual

# ============================================
# DEPLOY STAGING (Automatic on MR)
# ============================================
deploy-staging:
  stage: deploy
  image: node:${NODE_VERSION}
  dependencies:
    - build
  before_script:
    - npm install -g vercel
  script:
    - vercel deploy --token=$VERCEL_TOKEN
  environment:
    name: staging/$CI_COMMIT_REF_SLUG
    url: $STAGING_URL
    on_stop: stop-staging
  rules:
    - if: $CI_PIPELINE_SOURCE == "merge_request_event"

stop-staging:
  stage: deploy
  script:
    - echo "Stopping staging environment"
  environment:
    name: staging/$CI_COMMIT_REF_SLUG
    action: stop
  rules:
    - if: $CI_PIPELINE_SOURCE == "merge_request_event"
      when: manual
```

### GitLab CI Variables

Configure in Settings → CI/CD → Variables:

| Variable | Protected | Masked | Purpose |
|----------|-----------|--------|---------|
| `VERCEL_TOKEN` | Yes | Yes | Deployment token |
| `VERCEL_ORG_ID` | Yes | No | Organization ID |
| `VERCEL_PROJECT_ID` | Yes | No | Project ID |
| `SENTRY_DSN` | No | Yes | Error tracking |

---

## 8. Jenkins Pipeline

Create `Jenkinsfile` in your repository root:

```groovy
// Jenkins Declarative Pipeline
// Equivalent to GitHub Actions / GitLab CI

pipeline {
    agent any
    
    tools {
        nodejs 'NodeJS-20'  // Configure in Jenkins Global Tool Configuration
    }
    
    environment {
        CI = 'true'
        npm_config_cache = "${WORKSPACE}/.npm"
    }
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
    }
    
    stages {
        // ============================================
        // INSTALL DEPENDENCIES
        // ============================================
        stage('Install') {
            steps {
                sh 'npm ci'
            }
        }
        
        // ============================================
        // LINT & TYPE CHECK
        // ============================================
        stage('Lint') {
            parallel {
                stage('ESLint') {
                    steps {
                        sh 'npm run lint'
                    }
                }
                stage('TypeScript') {
                    steps {
                        sh 'npx tsc --noEmit'
                    }
                }
            }
        }
        
        // ============================================
        // TEST
        // ============================================
        stage('Test') {
            steps {
                sh 'npm test -- --coverage --watchAll=false'
            }
            post {
                always {
                    publishHTML(target: [
                        reportDir: 'coverage/lcov-report',
                        reportFiles: 'index.html',
                        reportName: 'Coverage Report'
                    ])
                }
            }
        }
        
        // ============================================
        // SECURITY AUDIT
        // ============================================
        stage('Security Audit') {
            steps {
                sh 'npm audit --audit-level=high || true'
            }
        }
        
        // ============================================
        // BUILD
        // ============================================
        stage('Build') {
            steps {
                sh 'npm run build'
            }
            post {
                success {
                    archiveArtifacts artifacts: 'dist/**/*', fingerprint: true
                }
            }
        }
        
        // ============================================
        // DEPLOY STAGING
        // ============================================
        stage('Deploy Staging') {
            when {
                branch 'develop'
            }
            steps {
                withCredentials([string(credentialsId: 'vercel-token', variable: 'VERCEL_TOKEN')]) {
                    sh '''
                        npm install -g vercel
                        vercel deploy --token=$VERCEL_TOKEN
                    '''
                }
            }
        }
        
        // ============================================
        // DEPLOY PRODUCTION
        // ============================================
        stage('Deploy Production') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Deploy to production?', ok: 'Deploy'
                withCredentials([string(credentialsId: 'vercel-token', variable: 'VERCEL_TOKEN')]) {
                    sh '''
                        npm install -g vercel
                        vercel pull --yes --environment=production --token=$VERCEL_TOKEN
                        vercel build --prod --token=$VERCEL_TOKEN
                        vercel deploy --prebuilt --prod --token=$VERCEL_TOKEN
                    '''
                }
            }
        }
    }
    
    post {
        success {
            slackSend(
                channel: '#deployments',
                color: 'good',
                message: "✅ Build Successful: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
            )
        }
        failure {
            slackSend(
                channel: '#deployments',
                color: 'danger',
                message: "❌ Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
            )
        }
        always {
            cleanWs()
        }
    }
}
```

### Jenkins Configuration

1. **Install Required Plugins:**
   - NodeJS Plugin
   - Pipeline
   - Slack Notification Plugin (optional)
   - HTML Publisher Plugin

2. **Configure Global Tools:**
   - Manage Jenkins → Tools → NodeJS installations
   - Add NodeJS 20.x

3. **Add Credentials:**
   - Manage Jenkins → Credentials → Global
   - Add `vercel-token` as Secret text

---

## 9. Platform Comparison

| Feature | GitHub Actions | GitLab CI | Jenkins |
|---------|----------------|-----------|---------|
| **Config File** | `.github/workflows/*.yml` | `.gitlab-ci.yml` | `Jenkinsfile` |
| **Syntax** | YAML | YAML | Groovy |
| **Runners** | Hosted / Self-hosted | Shared / Self-hosted | Self-hosted |
| **Secrets** | Repository Settings | CI/CD Variables | Credentials |
| **Caching** | `actions/cache@v4` | Built-in | Plugin required |
| **Matrix Builds** | Native | Native | Plugin required |
| **Cost** | Free (public), Minutes (private) | Free (400 mins), Paid | Free (self-hosted) |

---

## Template Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `{{PROJECT_NAME}}` | Project name | "SCAINET" |
| `{{PROJECT_URL}}` | Production URL | "scainet.io" |
| `{{TIMEZONE}}` | Timezone for schedules | "Australia/Adelaide" |
| `{{DOCUMENT_LAST_UPDATED}}` | Last update date | "January 2026" |
| `{{DOCUMENT_OWNER}}` | Document owner | "Simon Case" |

---

*This template is part of the Chazwazza framework v3.2*

