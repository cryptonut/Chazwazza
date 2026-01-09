# Chazwazza 🚀

## Enterprise Project Starter Kit

**Chazwazza** is a comprehensive, enterprise-grade project starter kit that provides foundational documentation templates for AI-assisted software development projects.

---

## 🎯 What's Included

### Core Framework (AI Agent Standards)

| Template | Purpose |
|----------|---------|
| **AGENT_EXCELLENCE_GUIDE.md** | Comprehensive standards and workflows for AI coding agents (v3.0) |
| **FUNCTIONALITY_REMOVAL_INCIDENT_REPORT.md** | Incident documentation with example and reusable template |
| **CONTEXT_MANAGEMENT_ADDENDUM.md** | Long session management and handover protocols |

### Development & Release

| Template | Purpose |
|----------|---------|
| **RELEASE_INSTRUCTIONS_FOR_AGENTS.md** | Platform-agnostic deployment procedures |
| **CHANGELOG.md** | Keep a Changelog format template with guidelines |
| **RELEASE_NOTES_TEMPLATE.md** | Comprehensive release notes template |
| **build_and_distribute_template.ps1** | Generic build/distribution automation script |
| **release_to_qa_template.ps1** | QA release automation script |
| **TECHNICAL_DEBT_TEMPLATE.md** | Track and manage technical debt |
| **SECURITY_TEMPLATE.md** | Security policies and practices |

### Startup & Business (NEW in v3.0)

| Template | Purpose |
|----------|---------|
| **INVESTOR_MATERIALS_GUIDE.md** | Complete guide to creating investor/fundraising materials |
| **BRAND_ASSETS_TEMPLATE.md** | Document brand colors, typography, logos, voice |
| **LANDING_PAGE_CHECKLIST.md** | High-converting startup landing page structure |

### Operations & Consistency (NEW in v3.0)

| Template | Purpose |
|----------|---------|
| **DEPLOYMENT_CHECKLIST.md** | Production deployment with domain, SSL, monitoring |
| **THIRD_PARTY_SERVICES_LOG.md** | Track external services, credentials, integrations |
| **CROSS_DOCUMENT_CONSISTENCY.md** | Maintain consistency across all documentation |

---

## 🚀 Quick Start

### Option 1: Use as GitHub Template

1. Click "Use this template" on GitHub
2. Create your new repository
3. Clone and customize

### Option 2: Manual Setup

```bash
# Clone the repository
git clone https://github.com/{{YOUR_ORG}}/Chazwazza.git my-new-project

# Navigate to the project
cd my-new-project

# Remove the Chazwazza git history (start fresh)
rm -rf .git
git init

# Start customizing!
```

---

## 📝 Customization Guide

### Step 1: Global Find & Replace

Replace these template variables across all files:

| Variable | Replace With | Example |
|----------|--------------|---------|
| `{{PROJECT_NAME}}` | Your project name | "MyAwesomeApp" |
| `{{DOCUMENT_OWNER}}` | Your name or team | "Platform Team" |
| `{{DOCUMENT_CREATED_DATE}}` | Today's date | "January 8, 2026" |
| `{{DOCUMENT_LAST_UPDATED}}` | Today's date | "January 8, 2026" |
| `{{MAIN_BRANCH}}` | Production branch | "main" |
| `{{QA_BRANCH}}` | QA/staging branch | "release/qa" |
| `{{DEVELOPMENT_BRANCH}}` | Development branch | "develop" |
| `{{REPO_URL}}` | Your repository URL | "https://github.com/org/repo" |

### Step 2: Configure Build Scripts

Edit the PowerShell scripts and update the `$Config` section:

```powershell
$Config = @{
    ProjectName = "MyProject"
    BuildCommand = "npm run build"
    TestCommand = "npm test"
    # ... etc
}
```

### Step 3: Customize for Your Tech Stack

The templates include multi-language examples. Keep the ones relevant to your project and remove the rest.

### Step 4: Update Incident Report

The `FUNCTIONALITY_REMOVAL_INCIDENT_REPORT.md` contains an example incident. You can:
- Keep it as a reference example
- Replace it with your own incident history
- Remove Part 1 and keep only the template

---

## 📋 Template Variable Reference

### Document Metadata
```
{{PROJECT_NAME}}              - Project name
{{DOCUMENT_OWNER}}            - Document maintainer
{{DOCUMENT_CREATED_DATE}}     - Creation date
{{DOCUMENT_LAST_UPDATED}}     - Last modification date
{{MAINTAINER}}                - Project maintainer
```

### Version Control
```
{{MAIN_BRANCH}}               - Production branch (main/master)
{{QA_BRANCH}}                 - QA/staging branch (release/qa/staging)
{{DEVELOPMENT_BRANCH}}        - Development branch (develop/dev)
{{REPO_URL}}                  - Repository URL
```

### Versioning
```
{{VERSION}}                   - Current version number
{{PREVIOUS_VERSION}}          - Previous version number
{{LATEST_VERSION}}            - Latest release version
{{BUILD_NUMBER}}              - Build/revision number
{{RELEASE_DATE}}              - Release date
```

### Build & Deploy
```
{{BUILD_COMMAND}}             - Build command for your project
{{TEST_COMMAND}}              - Test command
{{LINT_COMMAND}}              - Linting command
{{CLEAN_COMMAND}}             - Clean/reset command
{{DEPENDENCY_COMMAND}}        - Dependency install command
{{DEV_BUILD_COMMAND}}         - Development build command
{{QA_BUILD_COMMAND}}          - QA/staging build command
{{PROD_BUILD_COMMAND}}        - Production build command
```

### Distribution
```
{{DISTRIBUTION_COMMAND}}      - Distribution/deploy command
{{DISTRIBUTION_TARGET}}       - Deploy target URL/server
{{TESTER_GROUP}}              - QA tester group name
```

### Artifacts
```
{{ARTIFACT_PATH}}             - Build output path
{{DEV_ARTIFACT_PATH}}         - Development build output
{{QA_ARTIFACT_PATH}}          - QA build output
{{PROD_ARTIFACT_PATH}}        - Production build output
```

### Configuration
```
{{VERSION_FILE}}              - File containing version (package.json, etc.)
{{DEV_CONFIG_PATH}}           - Development config file path
{{QA_CONFIG_PATH}}            - QA config file path
{{PROD_CONFIG_PATH}}          - Production config file path
```

---

## 🏗️ Tech Stack Examples

The templates are technology-agnostic. Here are common configurations:

### Node.js / TypeScript
```
BUILD_COMMAND = "npm run build"
TEST_COMMAND = "npm test"
LINT_COMMAND = "npm run lint"
DEPENDENCY_COMMAND = "npm ci"
VERSION_FILE = "package.json"
```

### Python
```
BUILD_COMMAND = "python -m build"
TEST_COMMAND = "pytest"
LINT_COMMAND = "flake8 && mypy ."
DEPENDENCY_COMMAND = "pip install -r requirements.txt"
VERSION_FILE = "setup.py" or "pyproject.toml"
```

### Flutter / Dart
```
BUILD_COMMAND = "flutter build apk --release"
TEST_COMMAND = "flutter test"
LINT_COMMAND = "flutter analyze"
DEPENDENCY_COMMAND = "flutter pub get"
VERSION_FILE = "pubspec.yaml"
```

### .NET / C#
```
BUILD_COMMAND = "dotnet build --configuration Release"
TEST_COMMAND = "dotnet test"
LINT_COMMAND = "dotnet format --verify-no-changes"
DEPENDENCY_COMMAND = "dotnet restore"
VERSION_FILE = "*.csproj"
```

### Go
```
BUILD_COMMAND = "go build ./..."
TEST_COMMAND = "go test ./..."
LINT_COMMAND = "golangci-lint run"
DEPENDENCY_COMMAND = "go mod download"
VERSION_FILE = "version.go"
```

### Java / Gradle
```
BUILD_COMMAND = "./gradlew build"
TEST_COMMAND = "./gradlew test"
LINT_COMMAND = "./gradlew check"
DEPENDENCY_COMMAND = "./gradlew dependencies"
VERSION_FILE = "build.gradle"
```

---

## 📁 Repository Structure

```
Chazwazza/
├── README.md                              # This file
│
├── # Core Framework
├── AGENT_EXCELLENCE_GUIDE.md              # AI agent standards (v3.0)
├── CONTEXT_MANAGEMENT_ADDENDUM.md         # Session management
├── FUNCTIONALITY_REMOVAL_INCIDENT_REPORT.md # Incident template
│
├── # Development & Release
├── RELEASE_INSTRUCTIONS_FOR_AGENTS.md     # Deployment procedures
├── CHANGELOG.md                           # Changelog template
├── RELEASE_NOTES_TEMPLATE.md              # Release notes template
├── TECHNICAL_DEBT_TEMPLATE.md             # Tech debt tracking
├── SECURITY_TEMPLATE.md                   # Security policies
├── build_and_distribute_template.ps1      # Build script template
├── release_to_qa_template.ps1             # QA release script template
│
├── # Startup & Business (v3.0)
├── INVESTOR_MATERIALS_GUIDE.md            # Fundraising materials guide
├── BRAND_ASSETS_TEMPLATE.md               # Brand documentation
├── LANDING_PAGE_CHECKLIST.md              # Landing page structure
│
├── # Operations & Consistency (v3.0)
├── DEPLOYMENT_CHECKLIST.md                # Production deployment
├── THIRD_PARTY_SERVICES_LOG.md            # External services tracking
├── CROSS_DOCUMENT_CONSISTENCY.md          # Document consistency
│
├── # Meta
├── .gitignore                             # Git ignore rules
├── LICENSE                                # License file
└── CONTRIBUTING.md                        # Contribution guidelines
```

---

## 🎨 Design Philosophy

### Enterprise-Grade Quality
- Document control with versioning and ownership
- Comprehensive cross-references
- Audit trail support
- Compliance-ready formatting

### Technology-Agnostic
- Platform-neutral workflows
- Multi-language code examples
- Configurable for any tech stack
- No vendor lock-in

### AI-Optimized
- Clear instructions for AI coding agents
- Mandatory checklists to ensure quality
- Verification requirements at every step
- Protection against common AI mistakes

### Human-Centered
- Respects human time as infinitely valuable
- Requires verification before human testing
- Prevents functionality removal without consent
- Clear communication standards

---

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Suggesting new templates
- Improving existing templates
- Reporting issues
- Submitting pull requests

---

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.

---

## 🙏 Acknowledgments

Created with care for teams who want to:
- Maintain high documentation standards
- Work effectively with AI coding assistants
- Ensure consistent release processes
- Protect their users from unexpected changes

---

**Happy Building! 🚀**

*Chazwazza — Because great projects start with great foundations.*

