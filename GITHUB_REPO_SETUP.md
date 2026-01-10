# GitHub Repository Setup Template
## {{PROJECT_NAME}} Professional Repository Configuration

**Last Updated:** {{DOCUMENT_LAST_UPDATED}}  
**Owner:** {{DOCUMENT_OWNER}}

---

## Overview

This template provides a complete GitHub repository setup including issue templates, PR templates, and community files for professional open-source or enterprise projects.

---

## 1. Issue Templates

Create `.github/ISSUE_TEMPLATE/` directory with the following files:

### Bug Report Template

`.github/ISSUE_TEMPLATE/bug_report.md`:

```markdown
---
name: Bug Report
about: Report a bug or unexpected behavior
title: "[BUG] "
labels: bug, triage
assignees: {{GITHUB_USERNAME}}
---

## Description
A clear and concise description of the bug.

## Steps to Reproduce
1. Go to '...'
2. Click on '...'
3. Scroll down to '...'
4. See error

## Expected Behavior
What you expected to happen.

## Actual Behavior
What actually happened.

## Screenshots
If applicable, add screenshots to help explain the problem.

## Environment
- **Browser:** [e.g., Chrome 120, Safari 17]
- **Device:** [e.g., Desktop, iPhone 15]
- **OS:** [e.g., Windows 11, macOS Sonoma]

## Additional Context
Any other context about the problem.
```

### Feature Request Template

`.github/ISSUE_TEMPLATE/feature_request.md`:

```markdown
---
name: Feature Request
about: Suggest a new feature or enhancement
title: "[FEATURE] "
labels: enhancement, triage
assignees: {{GITHUB_USERNAME}}
---

## Problem Statement
A clear description of the problem you're trying to solve.

## Proposed Solution
Describe the solution you'd like to see.

## Alternatives Considered
Any alternative solutions or features you've considered.

## Additional Context
Any other context, mockups, or examples that would help.

## Priority
- [ ] Critical - Blocking other work
- [ ] High - Needed soon
- [ ] Medium - Would be nice
- [ ] Low - Future consideration
```

### Config File

`.github/ISSUE_TEMPLATE/config.yml`:

```yaml
blank_issues_enabled: false
contact_links:
  - name: 📧 Email Support
    url: mailto:{{CONTACT_EMAIL}}
    about: For direct inquiries
  - name: 📖 Documentation
    url: {{DOCS_URL}}
    about: Check our documentation first
  - name: 💬 Discussions
    url: https://github.com/{{GITHUB_ORG}}/{{REPO_NAME}}/discussions
    about: Ask questions in Discussions
```

---

## 2. Pull Request Template

`.github/PULL_REQUEST_TEMPLATE.md`:

```markdown
## Description
Brief description of changes.

## Type of Change
- [ ] 🐛 Bug fix
- [ ] ✨ New feature
- [ ] 📝 Documentation
- [ ] 🎨 Style/UI
- [ ] ♻️ Refactor
- [ ] ⚡ Performance
- [ ] 🔒 Security
- [ ] 🔧 Configuration

## Changes Made
- 
- 
- 

## Testing
- [ ] Tested locally
- [ ] Build passes
- [ ] No new linting errors

## Screenshots (if UI changes)


## Notes for Reviewer

```

---

## 3. Community Files

### Contributing Guide

`CONTRIBUTING.md`:

```markdown
# Contributing to {{PROJECT_NAME}}

Thank you for your interest in contributing!

## Getting Started

1. Fork the repository
2. Clone your fork
3. Create a new branch: `git checkout -b feature/your-feature`
4. Make your changes
5. Run tests: `npm test`
6. Commit with a clear message
7. Push and create a Pull Request

## Code Standards

- Follow existing code style
- Write meaningful commit messages
- Add tests for new features
- Update documentation as needed

## Pull Request Process

1. Update the README.md if needed
2. Update the CHANGELOG.md
3. The PR will be merged once approved

## Questions?

Open a Discussion or reach out to {{CONTACT_EMAIL}}.
```

### Security Policy

`SECURITY.md`:

```markdown
# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

If you discover a security vulnerability, please:

1. **Do NOT** open a public issue
2. Email {{SECURITY_EMAIL}} with details
3. Include steps to reproduce
4. Allow 48 hours for initial response

We take security seriously and will respond promptly.
```

### Code of Conduct

`CODE_OF_CONDUCT.md`:

```markdown
# Code of Conduct

## Our Pledge

We pledge to make participation in our project a harassment-free experience for everyone.

## Our Standards

**Positive behaviors:**
- Using welcoming and inclusive language
- Being respectful of differing viewpoints
- Gracefully accepting constructive criticism
- Focusing on what is best for the community

**Unacceptable behaviors:**
- Harassment, trolling, or personal attacks
- Publishing others' private information
- Other conduct which could reasonably be considered inappropriate

## Enforcement

Violations may be reported to {{CONTACT_EMAIL}}. All complaints will be reviewed and investigated.

## Attribution

This Code of Conduct is adapted from the Contributor Covenant.
```

---

## 4. Setup Checklist

```
GITHUB REPO SETUP CHECKLIST:

Repository: {{PROJECT_NAME}}

Issue Templates:
- [ ] .github/ISSUE_TEMPLATE/bug_report.md
- [ ] .github/ISSUE_TEMPLATE/feature_request.md
- [ ] .github/ISSUE_TEMPLATE/config.yml

PR Template:
- [ ] .github/PULL_REQUEST_TEMPLATE.md

Community Files:
- [ ] CONTRIBUTING.md
- [ ] SECURITY.md
- [ ] CODE_OF_CONDUCT.md
- [ ] LICENSE

Repository Settings:
- [ ] Description set
- [ ] Topics/tags added
- [ ] Website URL (if applicable)
- [ ] Discussions enabled (if desired)
- [ ] Wiki disabled (if not using)
- [ ] Sponsorship enabled (if applicable)

Branch Protection (requires GitHub Pro for private repos):
- [ ] Require pull request reviews
- [ ] Require status checks to pass
- [ ] Require conversation resolution
- [ ] Restrict who can push to main
```

---

## 5. Template Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `{{PROJECT_NAME}}` | Project name | "SCAINET" |
| `{{GITHUB_USERNAME}}` | Your GitHub username | "cryptonut" |
| `{{GITHUB_ORG}}` | GitHub organization | "cryptonut" |
| `{{REPO_NAME}}` | Repository name | "SCAINET" |
| `{{CONTACT_EMAIL}}` | Contact email | "support@example.com" |
| `{{SECURITY_EMAIL}}` | Security contact | "security@example.com" |
| `{{DOCS_URL}}` | Documentation URL | "https://docs.example.com" |
| `{{DOCUMENT_LAST_UPDATED}}` | Last update date | "January 2026" |
| `{{DOCUMENT_OWNER}}` | Document owner | "Simon Case" |

---

*This template is part of the Chazwazza framework.*

