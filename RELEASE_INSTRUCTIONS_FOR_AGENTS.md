# Release Instructions for Agents

## Standardized Release and Deployment Procedures

| Document Info | |
|---------------|---|
| **Version** | 2.0 |
| **Classification** | Internal - Development Teams |
| **Created** | {{DOCUMENT_CREATED_DATE}} |
| **Last Updated** | {{DOCUMENT_LAST_UPDATED}} |
| **Owner** | {{DOCUMENT_OWNER}} |
| **Project** | {{PROJECT_NAME}} |

---

## Table of Contents

1. [Overview](#1-overview)
2. [Environment Configuration](#2-environment-configuration)
3. [Pre-Release Checklist](#3-pre-release-checklist)
4. [Build Procedures](#4-build-procedures)
5. [Deployment Procedures](#5-deployment-procedures)
6. [Verification Procedures](#6-verification-procedures)
7. [Rollback Procedures](#7-rollback-procedures)
8. [Platform-Specific Guides](#8-platform-specific-guides)
9. [Troubleshooting](#9-troubleshooting)

---

## 1. Overview

### 1.1 Release Philosophy

```
┌─────────────────────────────────────────────────────────────────┐
│                    RELEASE PRINCIPLES                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. VERIFY BEFORE RELEASE                                        │
│     Every release must be verified working before distribution   │
│                                                                  │
│  2. AUTOMATE WHERE POSSIBLE                                      │
│     Use scripts to reduce human error and ensure consistency     │
│                                                                  │
│  3. DOCUMENT EVERYTHING                                          │
│     Every release should have notes, changelogs, and artifacts   │
│                                                                  │
│  4. ENABLE ROLLBACK                                              │
│     Always know how to revert to the previous working state      │
│                                                                  │
│  5. NOTIFY STAKEHOLDERS                                          │
│     Testers, users, and team members should know about releases  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 1.2 Release Types

| Type | Purpose | Target | Approval Required |
|------|---------|--------|-------------------|
| **Development** | Internal testing, rapid iteration | Development environment | None |
| **QA/Staging** | Quality assurance testing | QA testers | Development lead |
| **Production** | End user release | All users | Product owner + QA sign-off |
| **Hotfix** | Emergency production fix | Production | Expedited approval |

### 1.3 Branch-to-Environment Mapping

```
┌─────────────────────────────────────────────────────────────────┐
│                 BRANCH → ENVIRONMENT MAPPING                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  {{DEVELOPMENT_BRANCH}}  ───────────────▶  Development Env       │
│         │                                                        │
│         │ (merge when ready for QA)                              │
│         ▼                                                        │
│  {{QA_BRANCH}}  ────────────────────────▶  QA/Staging Env        │
│         │                                                        │
│         │ (merge after QA approval)                              │
│         ▼                                                        │
│  {{MAIN_BRANCH}}  ──────────────────────▶  Production Env        │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 2. Environment Configuration

### 2.1 Environment Variables

Each environment requires specific configuration. Document your environment variables:

| Variable | Development | QA/Staging | Production |
|----------|-------------|------------|------------|
| `{{ENV_VAR_1}}` | `{{DEV_VALUE_1}}` | `{{QA_VALUE_1}}` | `{{PROD_VALUE_1}}` |
| `{{ENV_VAR_2}}` | `{{DEV_VALUE_2}}` | `{{QA_VALUE_2}}` | `{{PROD_VALUE_2}}` |
| `{{ENV_VAR_3}}` | `{{DEV_VALUE_3}}` | `{{QA_VALUE_3}}` | `{{PROD_VALUE_3}}` |

### 2.2 Configuration Files

| Environment | Config File Location | Notes |
|-------------|---------------------|-------|
| Development | `{{DEV_CONFIG_PATH}}` | Local development settings |
| QA/Staging | `{{QA_CONFIG_PATH}}` | QA environment settings |
| Production | `{{PROD_CONFIG_PATH}}` | Production settings (secured) |

### 2.3 Secrets Management

```
🔒 SECURITY REQUIREMENTS:

- NEVER commit secrets to version control
- NEVER log secrets in build output
- NEVER include secrets in release notes
- Use environment variables or secret management services
- Rotate secrets according to security policy
```

| Secret Type | Storage Location | Access Method |
|-------------|------------------|---------------|
| API Keys | {{SECRET_STORE}} | {{ACCESS_METHOD}} |
| Database Credentials | {{SECRET_STORE}} | {{ACCESS_METHOD}} |
| Signing Keys | {{SECRET_STORE}} | {{ACCESS_METHOD}} |

---

## 3. Pre-Release Checklist

### 3.1 Code Readiness

```
PRE-RELEASE CODE CHECKLIST:

- [ ] All planned features are complete
- [ ] All tests pass (unit, integration, e2e)
- [ ] Linting passes with no errors
- [ ] No TODO/FIXME items blocking release
- [ ] No debug code in production paths
- [ ] No hardcoded secrets or sensitive data
- [ ] Dependencies are up to date (security patches)
- [ ] Breaking changes are documented
```

### 3.2 Documentation Readiness

```
PRE-RELEASE DOCUMENTATION CHECKLIST:

- [ ] CHANGELOG.md is updated
- [ ] Release notes are written
- [ ] API documentation is current
- [ ] Migration guides (if applicable) are complete
- [ ] Known issues are documented
- [ ] User-facing documentation is updated
```

### 3.3 Infrastructure Readiness

```
PRE-RELEASE INFRASTRUCTURE CHECKLIST:

- [ ] Target environment is available
- [ ] Database migrations are ready (if applicable)
- [ ] Configuration changes are prepared
- [ ] Monitoring and alerting is configured
- [ ] Rollback procedure is documented and tested
- [ ] Stakeholders are notified of release window
```

---

## 4. Build Procedures

### 4.1 Standard Build Process

```
┌─────────────────────────────────────────────────────────────────┐
│                    BUILD WORKFLOW                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. CLEAN                                                        │
│     Remove previous build artifacts                              │
│     └── Ensures no stale files affect build                     │
│                                                                  │
│  2. DEPENDENCIES                                                 │
│     Install/update project dependencies                          │
│     └── Ensures correct versions are used                        │
│                                                                  │
│  3. VALIDATE                                                     │
│     Run linting and static analysis                              │
│     └── Catches issues before build                              │
│                                                                  │
│  4. TEST                                                         │
│     Run automated test suite                                     │
│     └── Verifies code correctness                                │
│                                                                  │
│  5. BUILD                                                        │
│     Compile/bundle for target environment                        │
│     └── Creates deployable artifacts                             │
│                                                                  │
│  6. VERIFY                                                       │
│     Check artifacts exist and are valid                          │
│     └── Confirms build succeeded                                 │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 4.2 Build Commands by Environment

#### Development Build

```bash
# Clean previous builds
{{CLEAN_COMMAND}}

# Install dependencies
{{DEPENDENCY_INSTALL_COMMAND}}

# Run tests
{{TEST_COMMAND}}

# Build for development
{{DEV_BUILD_COMMAND}}
```

#### QA/Staging Build

```bash
# Clean previous builds
{{CLEAN_COMMAND}}

# Install dependencies
{{DEPENDENCY_INSTALL_COMMAND}}

# Run full test suite
{{FULL_TEST_COMMAND}}

# Build for QA
{{QA_BUILD_COMMAND}}

# Verify build artifacts
{{VERIFY_ARTIFACTS_COMMAND}}
```

#### Production Build

```bash
# Clean previous builds
{{CLEAN_COMMAND}}

# Install dependencies (production only)
{{PROD_DEPENDENCY_COMMAND}}

# Run full test suite
{{FULL_TEST_COMMAND}}

# Build for production
{{PROD_BUILD_COMMAND}}

# Verify build artifacts
{{VERIFY_ARTIFACTS_COMMAND}}

# Generate checksums
{{CHECKSUM_COMMAND}}
```

### 4.3 Build Verification

After every build, verify:

```
BUILD VERIFICATION CHECKLIST:

- [ ] Build command completed without errors
- [ ] Build output shows success message
- [ ] Expected artifacts exist:
      - [ ] Primary artifact: {{PRIMARY_ARTIFACT_PATH}}
      - [ ] Size is reasonable (not 0, not unexpectedly large)
      - [ ] Timestamp is current
- [ ] Version number is correct
- [ ] No warnings that indicate problems
```

---

## 5. Deployment Procedures

### 5.1 Deployment Methods

| Method | Use Case | Automation Level |
|--------|----------|------------------|
| **CLI Deployment** | Standard automated deployment | High |
| **Manual Upload** | Fallback when CLI fails | Low |
| **CI/CD Pipeline** | Continuous deployment | Highest |
| **Direct Transfer** | Air-gapped environments | None |

### 5.2 Automated Deployment (Recommended)

```bash
# Use the automated release script
{{RELEASE_SCRIPT_PATH}}

# Or with custom options
{{RELEASE_SCRIPT_PATH}} --environment {{ENVIRONMENT}} --notes "{{RELEASE_NOTES}}"
```

**Script Behavior:**
1. Validates current branch is correct for target environment
2. Runs pre-deployment checks
3. Builds the application
4. Deploys to target environment
5. Runs post-deployment verification
6. Notifies stakeholders

### 5.3 Manual Deployment (Fallback)

Use when automated deployment fails or is unavailable:

```
MANUAL DEPLOYMENT STEPS:

1. VERIFY BRANCH
   - Confirm you are on the correct branch for the target environment
   - Command: {{BRANCH_CHECK_COMMAND}}

2. BUILD
   - Execute build command for target environment
   - Command: {{BUILD_COMMAND}}
   - Verify: {{VERIFY_BUILD_COMMAND}}

3. UPLOAD/DEPLOY
   - Transfer artifacts to target environment
   - Method: {{DEPLOYMENT_METHOD}}
   - Verify: {{VERIFY_DEPLOYMENT_COMMAND}}

4. ACTIVATE
   - Activate the new release
   - Command: {{ACTIVATE_COMMAND}}
   - Verify: {{VERIFY_ACTIVATION_COMMAND}}

5. NOTIFY
   - Inform stakeholders of completed deployment
   - Method: {{NOTIFICATION_METHOD}}
```

### 5.4 Deployment Verification

```
DEPLOYMENT VERIFICATION CHECKLIST:

- [ ] Deployment command completed successfully
- [ ] Target environment shows new version
- [ ] Health checks pass
- [ ] Application starts successfully
- [ ] Critical paths work (smoke test)
- [ ] Logs show no errors
- [ ] Monitoring shows healthy metrics
- [ ] Stakeholders notified
```

---

## 6. Verification Procedures

### 6.1 Smoke Test Checklist

Perform immediately after deployment:

```
SMOKE TEST CHECKLIST:

- [ ] Application loads/starts
- [ ] Authentication works
- [ ] Primary user flow completes:
      - [ ] {{PRIMARY_FLOW_STEP_1}}
      - [ ] {{PRIMARY_FLOW_STEP_2}}
      - [ ] {{PRIMARY_FLOW_STEP_3}}
- [ ] Critical integrations respond:
      - [ ] {{INTEGRATION_1}}
      - [ ] {{INTEGRATION_2}}
- [ ] No errors in logs
```

### 6.2 QA Verification

For QA releases, ensure:

```
QA RELEASE VERIFICATION:

- [ ] Build distributed to QA testers
- [ ] QA testers received notification
- [ ] Test plan is available
- [ ] Known issues documented
- [ ] QA environment matches expected configuration
- [ ] Test data is available
```

### 6.3 Production Verification

For production releases, ensure:

```
PRODUCTION RELEASE VERIFICATION:

- [ ] All QA tests passed
- [ ] Product owner sign-off obtained
- [ ] Release notes published
- [ ] User documentation updated
- [ ] Monitoring alerts configured
- [ ] Rollback procedure ready
- [ ] Support team notified
```

---

## 7. Rollback Procedures

### 7.1 When to Rollback

**Immediately rollback if:**
- Critical functionality is broken
- Security vulnerability is introduced
- Data corruption is occurring
- System is unstable/crashing

**Consider rollback if:**
- Significant bugs affect user experience
- Performance degradation is severe
- External integrations are failing

### 7.2 Rollback Process

```
ROLLBACK PROCEDURE:

1. DECISION
   - Confirm rollback is necessary
   - Get approval if required: {{ROLLBACK_APPROVAL}}
   - Notify stakeholders of impending rollback

2. EXECUTE
   - Method A: Redeploy previous version
     {{REDEPLOY_COMMAND}}
   
   - Method B: Revert and deploy
     {{REVERT_COMMAND}}
     {{DEPLOY_COMMAND}}

3. VERIFY
   - Confirm previous version is running
   - Run smoke tests
   - Check logs for errors

4. COMMUNICATE
   - Notify stakeholders of completed rollback
   - Document the rollback decision and outcome

5. INVESTIGATE
   - Do NOT proceed with new release until root cause is found
   - Document findings
   - Plan fix
```

### 7.3 Rollback Verification

```
ROLLBACK VERIFICATION CHECKLIST:

- [ ] Previous version is now running
- [ ] All previously working functionality works
- [ ] No lingering effects from failed release
- [ ] Logs show normal operation
- [ ] Stakeholders are informed
- [ ] Incident documented
```

---

## 8. Platform-Specific Guides

### 8.1 Web Application Deployment

```
WEB APPLICATION DEPLOYMENT:

Build:
  {{WEB_BUILD_COMMAND}}

Deploy:
  {{WEB_DEPLOY_COMMAND}}

Verify:
  - [ ] Site loads at {{WEB_URL}}
  - [ ] SSL certificate is valid
  - [ ] All routes respond correctly
  - [ ] Assets load properly
  - [ ] API endpoints respond
```

### 8.2 Mobile Application Deployment

```
MOBILE APPLICATION DEPLOYMENT:

Build:
  {{MOBILE_BUILD_COMMAND}}

Distribute:
  - Development: {{DEV_DISTRIBUTION_METHOD}}
  - QA Testing: {{QA_DISTRIBUTION_METHOD}}
  - Production: {{PROD_DISTRIBUTION_METHOD}}

Verify:
  - [ ] App installs successfully
  - [ ] App launches without crash
  - [ ] Core functionality works
  - [ ] Version number is correct
```

### 8.3 Backend/API Deployment

```
BACKEND DEPLOYMENT:

Build:
  {{BACKEND_BUILD_COMMAND}}

Deploy:
  {{BACKEND_DEPLOY_COMMAND}}

Database Migration (if applicable):
  {{MIGRATION_COMMAND}}

Verify:
  - [ ] Health endpoint responds: {{HEALTH_ENDPOINT}}
  - [ ] API endpoints respond correctly
  - [ ] Database connections work
  - [ ] External service integrations work
```

### 8.4 Infrastructure/Configuration Deployment

```
INFRASTRUCTURE DEPLOYMENT:

Preview Changes:
  {{INFRA_PREVIEW_COMMAND}}

Apply Changes:
  {{INFRA_APPLY_COMMAND}}

Verify:
  - [ ] Resources created/updated as expected
  - [ ] No unexpected changes
  - [ ] Dependent services still work
  - [ ] Costs are as expected
```

---

## 9. Troubleshooting

### 9.1 Common Build Issues

| Issue | Likely Cause | Solution |
|-------|--------------|----------|
| Build fails with dependency error | Missing/outdated dependencies | Run `{{DEPENDENCY_INSTALL_COMMAND}}` |
| Build fails with type/syntax error | Code issue | Check linter, fix errors |
| Build hangs | Resource/process issue | Kill processes, clean, retry |
| Artifact not created | Build didn't complete | Check logs, verify command |

### 9.2 Common Deployment Issues

| Issue | Likely Cause | Solution |
|-------|--------------|----------|
| Deployment command fails | Auth/permission issue | Re-authenticate, check permissions |
| Upload times out | Network/size issue | Check connection, retry |
| Deployment succeeds but app fails | Config/env issue | Check environment config |
| Version not updating | Cache issue | Clear caches, force refresh |

### 9.3 Common Verification Issues

| Issue | Likely Cause | Solution |
|-------|--------------|----------|
| App won't start | Missing config/dependency | Check logs, verify config |
| Tests fail after deployment | Environment difference | Compare environments |
| Integrations fail | Config/credential issue | Verify integration config |
| Performance degraded | Resource/optimization issue | Check metrics, investigate |

### 9.4 Escalation Procedure

```
ESCALATION PATH:

Level 1: Self-Investigation (15 minutes)
  - Check logs and error messages
  - Review recent changes
  - Search documentation

Level 2: Team Consultation (30 minutes)
  - Discuss with team members
  - Review together
  - Check for known issues

Level 3: Lead/Senior Escalation
  - Escalate to: {{ESCALATION_CONTACT}}
  - Provide: Error details, steps tried, impact assessment

Level 4: External Support
  - Platform support: {{PLATFORM_SUPPORT}}
  - Vendor support: {{VENDOR_SUPPORT}}
```

---

## Appendix A: Command Reference

### Build Commands

| Environment | Command |
|-------------|---------|
| Development | `{{DEV_BUILD_COMMAND}}` |
| QA/Staging | `{{QA_BUILD_COMMAND}}` |
| Production | `{{PROD_BUILD_COMMAND}}` |

### Deployment Commands

| Environment | Command |
|-------------|---------|
| Development | `{{DEV_DEPLOY_COMMAND}}` |
| QA/Staging | `{{QA_DEPLOY_COMMAND}}` |
| Production | `{{PROD_DEPLOY_COMMAND}}` |

### Utility Commands

| Purpose | Command |
|---------|---------|
| Check version | `{{VERSION_CHECK_COMMAND}}` |
| Check status | `{{STATUS_CHECK_COMMAND}}` |
| View logs | `{{LOG_VIEW_COMMAND}}` |
| Rollback | `{{ROLLBACK_COMMAND}}` |

---

## Appendix B: Template Variables

This document uses the following template variables that should be replaced with project-specific values:

| Variable | Description |
|----------|-------------|
| `{{PROJECT_NAME}}` | Name of the project |
| `{{MAIN_BRANCH}}` | Production branch name |
| `{{QA_BRANCH}}` | QA/staging branch name |
| `{{DEVELOPMENT_BRANCH}}` | Development branch name |
| `{{RELEASE_SCRIPT_PATH}}` | Path to automated release script |
| `{{DEV_BUILD_COMMAND}}` | Development build command |
| `{{QA_BUILD_COMMAND}}` | QA build command |
| `{{PROD_BUILD_COMMAND}}` | Production build command |
| `{{DEV_DEPLOY_COMMAND}}` | Development deploy command |
| `{{QA_DEPLOY_COMMAND}}` | QA deploy command |
| `{{PROD_DEPLOY_COMMAND}}` | Production deploy command |

*See full variable list in project configuration.*

---

**Document Version:** 2.0  
**Last Updated:** {{DOCUMENT_LAST_UPDATED}}
