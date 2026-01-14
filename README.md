# Chazwazza 🚀

## The Standard for AI-Assisted Development

**Chazwazza** is a comprehensive, enterprise-grade documentation framework designed specifically for AI-assisted software development. It provides 25+ battle-tested templates covering AI agent governance, DevOps, testing, startup operations, and release management.

[![Version](https://img.shields.io/badge/version-3.2-blue.svg)](CHANGELOG.md)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

---

## 📑 Table of Contents

- [Why Chazwazza?](#-why-chazwazza)
- [What's Included](#-whats-included)
- [Quick Start](#-quick-start)
- [Template Reference](#-template-reference)
  - [AI Agent Standards](#ai-agent-standards)
  - [DevOps & CI/CD](#devops--cicd)
  - [Testing](#testing)
  - [Startup & Business](#startup--business)
  - [Operations](#operations)
  - [Build Scripts](#build-scripts)
- [Examples](#-examples)
- [Customization Guide](#-customization-guide)
- [Template Variables](#-template-variables)
- [Tech Stack Examples](#-tech-stack-examples)
- [Repository Structure](#-repository-structure)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎯 Why Chazwazza?

### The Problem
AI coding assistants (GitHub Copilot, Cursor, Claude) are powerful but can:
- Remove functionality without understanding context
- Introduce workarounds instead of proper fixes
- Lose context across long sessions
- Create inconsistent documentation

### The Solution
Chazwazza provides **battle-tested governance rules** that prevent common AI mistakes:

> **"Never Remove Functionality"** — AI agents must preserve all existing features unless explicitly requested.

> **"No Workarounds"** — Forces root cause analysis instead of band-aid fixes.

> **"Validate Technology Choices"** — Prevents AI from inventing non-existent libraries.

These rules emerged from **real incidents** documented in our incident reports.

---

## 📦 What's Included

| Category | Templates | New in v3.2 |
|----------|-----------|-------------|
| **AI Agent Standards** | 3 | — |
| **DevOps & CI/CD** | 8 | Testing, API Docs, Migration |
| **Startup & Business** | 3 | — |
| **Operations** | 4 | Postmortem |
| **Build Scripts** | 4 | Bash equivalents |
| **Examples** | 1+ | Filled templates |

---

## 🚀 Quick Start

### Option 1: GitHub Template

1. Click **"Use this template"** on GitHub
2. Create your new repository
3. Clone and customize

### Option 2: Manual Clone

```bash
# Clone the repository
git clone https://github.com/YOUR_ORG/Chazwazza.git my-project
cd my-project

# Remove Chazwazza history (start fresh)
rm -rf .git
git init

# Start customizing!
```

### Option 3: Copy Specific Templates

```bash
# Copy just what you need
curl -O https://raw.githubusercontent.com/ORG/Chazwazza/main/AGENT_EXCELLENCE_GUIDE.md
```

---

## 📋 Template Reference

### AI Agent Standards

| Template | Purpose | Lines |
|----------|---------|-------|
| [**AGENT_EXCELLENCE_GUIDE.md**](AGENT_EXCELLENCE_GUIDE.md) | Comprehensive AI agent governance rules (v3.1) | 1,800+ |
| [**CONTEXT_MANAGEMENT_ADDENDUM.md**](CONTEXT_MANAGEMENT_ADDENDUM.md) | Long session management, handover protocols | 200+ |
| [**FUNCTIONALITY_REMOVAL_INCIDENT_REPORT.md**](FUNCTIONALITY_REMOVAL_INCIDENT_REPORT.md) | Real incident case study + reusable template | 300+ |

**Key Rules:**
- ✅ Never remove functionality without explicit request
- ✅ No workarounds — fix root causes
- ✅ Validate all technology choices
- ✅ Preserve human time (verify before testing)

---

### DevOps & CI/CD

| Template | Purpose |
|----------|---------|
| [**CI_CD_SETUP_TEMPLATE.md**](CI_CD_SETUP_TEMPLATE.md) | GitHub Actions, GitLab CI, Jenkins, Dependabot |
| [**DEPLOYMENT_CHECKLIST.md**](DEPLOYMENT_CHECKLIST.md) | Production deployment with domain, SSL, monitoring |
| [**MONITORING_SETUP_TEMPLATE.md**](MONITORING_SETUP_TEMPLATE.md) | Sentry, Vercel Analytics, uptime monitoring |
| [**GITHUB_REPO_SETUP.md**](GITHUB_REPO_SETUP.md) | Issue templates, PR templates, community files |
| [**TECHNICAL_DEBT_TEMPLATE.md**](TECHNICAL_DEBT_TEMPLATE.md) | Track and prioritize technical debt |
| [**SECURITY_TEMPLATE.md**](SECURITY_TEMPLATE.md) | Security policies and vulnerability disclosure |

**New in v3.2:**

| Template | Purpose |
|----------|---------|
| [**templates/devops/TESTING_TEMPLATE.md**](templates/devops/TESTING_TEMPLATE.md) | Jest, Pytest, Go testing setups |
| [**templates/devops/API_DOCUMENTATION_TEMPLATE.md**](templates/devops/API_DOCUMENTATION_TEMPLATE.md) | OpenAPI/Swagger documentation |
| [**templates/devops/MIGRATION_TEMPLATE.md**](templates/devops/MIGRATION_TEMPLATE.md) | Database, Git, infrastructure migrations |

---

### Testing

| Framework | Coverage |
|-----------|----------|
| **Jest** (JavaScript/TypeScript) | Unit tests, API tests, mocking |
| **Pytest** (Python) | Unit tests, fixtures, async testing |
| **Go Testing** | Table-driven tests, benchmarks |

See [templates/devops/TESTING_TEMPLATE.md](templates/devops/TESTING_TEMPLATE.md) for complete setup guides.

---

### Startup & Business

| Template | Purpose |
|----------|---------|
| [**INVESTOR_MATERIALS_GUIDE.md**](INVESTOR_MATERIALS_GUIDE.md) | Pitch deck, data room, due diligence |
| [**BRAND_ASSETS_TEMPLATE.md**](BRAND_ASSETS_TEMPLATE.md) | Colors, typography, logos, voice |
| [**LANDING_PAGE_CHECKLIST.md**](LANDING_PAGE_CHECKLIST.md) | High-converting landing page structure |

---

### Operations

| Template | Purpose |
|----------|---------|
| [**RELEASE_INSTRUCTIONS_FOR_AGENTS.md**](RELEASE_INSTRUCTIONS_FOR_AGENTS.md) | Platform-agnostic deployment procedures |
| [**THIRD_PARTY_SERVICES_LOG.md**](THIRD_PARTY_SERVICES_LOG.md) | Track external services and credentials |
| [**CROSS_DOCUMENT_CONSISTENCY.md**](CROSS_DOCUMENT_CONSISTENCY.md) | Maintain consistency across documentation |
| [**templates/operations/INCIDENT_POSTMORTEM_TEMPLATE.md**](templates/operations/INCIDENT_POSTMORTEM_TEMPLATE.md) | Blameless postmortem with 5 Whys |

---

### Build Scripts

| Script | Platform | Purpose |
|--------|----------|---------|
| [**build_and_distribute_template.ps1**](build_and_distribute_template.ps1) | Windows | Build automation with retry logic |
| [**build_and_distribute_template.sh**](build_and_distribute_template.sh) | Linux/Mac | Build automation (bash equivalent) |
| [**release_to_qa_template.ps1**](release_to_qa_template.ps1) | Windows | QA release automation |
| [**release_to_qa_template.sh**](release_to_qa_template.sh) | Linux/Mac | QA release automation (bash) |

---

## 📖 Examples

Real-world examples of filled templates:

| Example | Based On |
|---------|----------|
| [**THIRD_PARTY_SERVICES_LOG_EXAMPLE.md**](examples/THIRD_PARTY_SERVICES_LOG_EXAMPLE.md) | SCAINET's actual service configuration |

*Examples show how to populate templates with real data.*

---

## 🔧 Customization Guide

### Step 1: Global Find & Replace

Search and replace these variables across all files:

| Variable | Replace With | Example |
|----------|--------------|---------|
| `{{PROJECT_NAME}}` | Your project name | "MyAwesomeApp" |
| `{{DOCUMENT_OWNER}}` | Your name or team | "Platform Team" |
| `{{DOCUMENT_CREATED_DATE}}` | Today's date | "January 14, 2026" |
| `{{MAIN_BRANCH}}` | Production branch | "main" |
| `{{QA_BRANCH}}` | QA/staging branch | "release/qa" |
| `{{REPO_URL}}` | Repository URL | "https://github.com/org/repo" |

### Step 2: Configure Build Scripts

Edit the configuration section in build scripts:

```bash
# In build_and_distribute_template.sh
PROJECT_NAME="MyProject"
BUILD_COMMANDS["prod"]="npm run build"
TEST_COMMAND="npm test"
```

### Step 3: Remove Unused Templates

Keep only what you need. The framework is modular.

---

## 📝 Template Variables

### Document Metadata
```
{{PROJECT_NAME}}         - Project name
{{DOCUMENT_OWNER}}       - Document maintainer  
{{DOCUMENT_CREATED_DATE}} - Creation date
{{DOCUMENT_LAST_UPDATED}} - Last modification date
```

### Version Control
```
{{MAIN_BRANCH}}          - Production branch (main/master)
{{QA_BRANCH}}            - QA/staging branch
{{DEVELOPMENT_BRANCH}}   - Development branch
{{REPO_URL}}             - Repository URL
```

### Build & Deploy
```
{{BUILD_COMMAND}}        - Build command
{{TEST_COMMAND}}         - Test command
{{DEPENDENCY_COMMAND}}   - Dependency install command
{{ARTIFACT_PATH}}        - Build output path
```

---

## 🛠️ Tech Stack Examples

### Node.js / TypeScript
```
BUILD_COMMAND = "npm run build"
TEST_COMMAND = "npm test"
LINT_COMMAND = "npm run lint"
DEPENDENCY_COMMAND = "npm ci"
```

### Python
```
BUILD_COMMAND = "python -m build"
TEST_COMMAND = "pytest"
LINT_COMMAND = "flake8 && mypy ."
DEPENDENCY_COMMAND = "pip install -r requirements.txt"
```

### Go
```
BUILD_COMMAND = "go build ./..."
TEST_COMMAND = "go test ./..."
LINT_COMMAND = "golangci-lint run"
DEPENDENCY_COMMAND = "go mod download"
```

### Flutter / Dart
```
BUILD_COMMAND = "flutter build apk --release"
TEST_COMMAND = "flutter test"
LINT_COMMAND = "flutter analyze"
DEPENDENCY_COMMAND = "flutter pub get"
```

---

## 📁 Repository Structure

```
Chazwazza/
├── README.md                              # This file
├── LICENSE                                # MIT License
├── CHANGELOG.md                           # Version history
├── CONTRIBUTING.md                        # Contribution guidelines
│
├── # Core AI Agent Framework
├── AGENT_EXCELLENCE_GUIDE.md              # AI governance rules (v3.1)
├── CONTEXT_MANAGEMENT_ADDENDUM.md         # Session management
├── FUNCTIONALITY_REMOVAL_INCIDENT_REPORT.md
│
├── # DevOps & CI/CD
├── CI_CD_SETUP_TEMPLATE.md
├── DEPLOYMENT_CHECKLIST.md
├── MONITORING_SETUP_TEMPLATE.md
├── GITHUB_REPO_SETUP.md
├── TECHNICAL_DEBT_TEMPLATE.md
├── SECURITY_TEMPLATE.md
│
├── # Release Management
├── RELEASE_INSTRUCTIONS_FOR_AGENTS.md
├── RELEASE_NOTES_TEMPLATE.md
│
├── # Startup & Business
├── INVESTOR_MATERIALS_GUIDE.md
├── BRAND_ASSETS_TEMPLATE.md
├── LANDING_PAGE_CHECKLIST.md
│
├── # Operations
├── THIRD_PARTY_SERVICES_LOG.md
├── CROSS_DOCUMENT_CONSISTENCY.md
│
├── # Build Scripts
├── build_and_distribute_template.ps1      # Windows
├── build_and_distribute_template.sh       # Linux/Mac
├── release_to_qa_template.ps1             # Windows
├── release_to_qa_template.sh              # Linux/Mac
│
├── # New Templates (v3.2)
├── templates/
│   ├── ai-agent/                          # AI-specific templates
│   ├── devops/
│   │   ├── TESTING_TEMPLATE.md            # Jest, Pytest, Go
│   │   ├── API_DOCUMENTATION_TEMPLATE.md  # OpenAPI/Swagger
│   │   └── MIGRATION_TEMPLATE.md          # DB/Git/Infra migrations
│   ├── business/
│   └── operations/
│       └── INCIDENT_POSTMORTEM_TEMPLATE.md
│
└── examples/
    └── THIRD_PARTY_SERVICES_LOG_EXAMPLE.md
```

---

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Suggesting new templates
- Improving existing templates
- Reporting issues
- Submitting pull requests

---

## 📄 License

MIT License — See [LICENSE](LICENSE) for details.

---

## 🙏 Acknowledgments

Created for teams who want to:
- ✅ Work effectively with AI coding assistants
- ✅ Maintain high documentation standards
- ✅ Ensure consistent release processes
- ✅ Protect users from unexpected changes

---

**Happy Building! 🚀**

*Chazwazza — The Standard for AI-Assisted Development*

---

### Version History

| Version | Date | Highlights |
|---------|------|------------|
| **3.2** | Jan 2026 | Testing templates, API docs, migrations, bash scripts, postmortems |
| **3.1** | Jan 2026 | CI/CD, monitoring, GitHub repo setup |
| **3.0** | Dec 2025 | Business templates, operations guides |
| **2.0** | Nov 2025 | Build scripts, deployment checklists |
| **1.0** | Oct 2025 | Initial AI agent framework |
