# Release Notes Template

## {{PROJECT_NAME}} — Release {{VERSION}}

| Release Info | |
|--------------|---|
| **Version** | {{VERSION}} |
| **Release Date** | {{RELEASE_DATE}} |
| **Release Type** | {{RELEASE_TYPE}} |
| **Branch** | {{RELEASE_BRANCH}} |
| **Build Number** | {{BUILD_NUMBER}} |
| **Commit** | {{COMMIT_HASH}} |

---

## 🎉 Release Highlights

*Provide a brief executive summary of this release — what are the most important changes users should know about?*

{{RELEASE_HIGHLIGHTS}}

---

## ✨ New Features

### {{FEATURE_1_TITLE}}

**{{FEATURE_1_SHORT_DESCRIPTION}}**

{{FEATURE_1_DETAILED_DESCRIPTION}}

**Key Capabilities:**
- ✅ {{CAPABILITY_1}}
- ✅ {{CAPABILITY_2}}
- ✅ {{CAPABILITY_3}}

**How to Use:**
{{FEATURE_1_USAGE_INSTRUCTIONS}}

**Technical Notes:**
- {{TECHNICAL_NOTE_1}}
- {{TECHNICAL_NOTE_2}}

---

### {{FEATURE_2_TITLE}}

**{{FEATURE_2_SHORT_DESCRIPTION}}**

{{FEATURE_2_DETAILED_DESCRIPTION}}

---

## 🔧 Improvements

| Area | Improvement | Impact |
|------|-------------|--------|
| {{IMPROVEMENT_AREA_1}} | {{IMPROVEMENT_1}} | {{IMPACT_1}} |
| {{IMPROVEMENT_AREA_2}} | {{IMPROVEMENT_2}} | {{IMPACT_2}} |
| {{IMPROVEMENT_AREA_3}} | {{IMPROVEMENT_3}} | {{IMPACT_3}} |

---

## 🐛 Bug Fixes

| ID | Description | Severity | Affected Versions |
|----|-------------|----------|-------------------|
| {{BUG_ID_1}} | {{BUG_DESCRIPTION_1}} | {{SEVERITY_1}} | {{AFFECTED_1}} |
| {{BUG_ID_2}} | {{BUG_DESCRIPTION_2}} | {{SEVERITY_2}} | {{AFFECTED_2}} |
| {{BUG_ID_3}} | {{BUG_DESCRIPTION_3}} | {{SEVERITY_3}} | {{AFFECTED_3}} |

---

## 🔐 Security Updates

| CVE/ID | Description | Severity | Resolution |
|--------|-------------|----------|------------|
| {{CVE_1}} | {{SECURITY_DESC_1}} | {{SEC_SEVERITY_1}} | {{RESOLUTION_1}} |

---

## ⚠️ Breaking Changes

### {{BREAKING_CHANGE_1_TITLE}}

**What Changed:**
{{BREAKING_CHANGE_1_DESCRIPTION}}

**Why:**
{{BREAKING_CHANGE_1_REASON}}

**Migration Steps:**
1. {{MIGRATION_STEP_1}}
2. {{MIGRATION_STEP_2}}
3. {{MIGRATION_STEP_3}}

**Code Example:**
```{{LANGUAGE}}
// Before ({{PREVIOUS_VERSION}})
{{CODE_BEFORE}}

// After ({{VERSION}})
{{CODE_AFTER}}
```

---

## 📦 Dependencies

### Updated Dependencies

| Package | Previous | New | Notes |
|---------|----------|-----|-------|
| {{PACKAGE_1}} | {{OLD_VERSION_1}} | {{NEW_VERSION_1}} | {{NOTES_1}} |
| {{PACKAGE_2}} | {{OLD_VERSION_2}} | {{NEW_VERSION_2}} | {{NOTES_2}} |

### New Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| {{NEW_PACKAGE_1}} | {{NPV_1}} | {{PURPOSE_1}} |

### Removed Dependencies

| Package | Reason |
|---------|--------|
| {{REMOVED_PACKAGE_1}} | {{REMOVAL_REASON_1}} |

---

## 🗄️ Database/Schema Changes

### Migrations Required

| Migration | Description | Reversible |
|-----------|-------------|------------|
| {{MIGRATION_1}} | {{MIGRATION_DESC_1}} | {{REVERSIBLE_1}} |

### Schema Changes

```sql
-- {{SCHEMA_CHANGE_DESCRIPTION}}
{{SCHEMA_CHANGE_SQL}}
```

**Migration Instructions:**
1. {{DB_MIGRATION_STEP_1}}
2. {{DB_MIGRATION_STEP_2}}

---

## 📋 Testing Checklist

Use this checklist to verify the release:

### Core Functionality

- [ ] {{TEST_CORE_1}}
- [ ] {{TEST_CORE_2}}
- [ ] {{TEST_CORE_3}}

### New Features

- [ ] {{TEST_FEATURE_1}}
- [ ] {{TEST_FEATURE_2}}

### Bug Fixes Verification

- [ ] {{TEST_FIX_1}} — Verify {{BUG_ID_1}} is resolved
- [ ] {{TEST_FIX_2}} — Verify {{BUG_ID_2}} is resolved

### Regression Testing

- [ ] {{TEST_REGRESSION_1}}
- [ ] {{TEST_REGRESSION_2}}

### Platform-Specific Testing

| Platform | Test Status |
|----------|-------------|
| {{PLATFORM_1}} | ⬜ Not Started |
| {{PLATFORM_2}} | ⬜ Not Started |
| {{PLATFORM_3}} | ⬜ Not Started |

---

## 📥 Installation & Upgrade

### Fresh Installation

```bash
{{FRESH_INSTALL_COMMANDS}}
```

### Upgrade from Previous Version

```bash
{{UPGRADE_COMMANDS}}
```

### Configuration Changes

If upgrading from a previous version, update your configuration:

```{{CONFIG_FORMAT}}
# New in {{VERSION}}
{{NEW_CONFIG_OPTIONS}}
```

---

## ⚡ Performance Notes

| Metric | Before | After | Change |
|--------|--------|-------|--------|
| {{METRIC_1}} | {{BEFORE_1}} | {{AFTER_1}} | {{CHANGE_1}} |
| {{METRIC_2}} | {{BEFORE_2}} | {{AFTER_2}} | {{CHANGE_2}} |

---

## 📝 Known Issues

| ID | Description | Workaround | Target Fix |
|----|-------------|------------|------------|
| {{KNOWN_ISSUE_ID_1}} | {{KNOWN_ISSUE_DESC_1}} | {{WORKAROUND_1}} | {{TARGET_FIX_1}} |

---

## 🔮 Coming Soon

Features planned for upcoming releases:

- {{UPCOMING_1}}
- {{UPCOMING_2}}
- {{UPCOMING_3}}

---

## 📚 Documentation

| Resource | Link |
|----------|------|
| Full Documentation | {{DOCS_URL}} |
| API Reference | {{API_DOCS_URL}} |
| Migration Guide | {{MIGRATION_GUIDE_URL}} |
| FAQ | {{FAQ_URL}} |

---

## 🙏 Acknowledgments

Thanks to everyone who contributed to this release:

- {{CONTRIBUTOR_1}}
- {{CONTRIBUTOR_2}}
- Community members who reported issues and provided feedback

---

## 📞 Support

| Channel | Link/Contact |
|---------|--------------|
| Issue Tracker | {{ISSUE_TRACKER_URL}} |
| Documentation | {{DOCS_URL}} |
| Community | {{COMMUNITY_URL}} |
| Email Support | {{SUPPORT_EMAIL}} |

---

## 📄 Release Artifacts

| Artifact | Location | Checksum (SHA256) |
|----------|----------|-------------------|
| {{ARTIFACT_1}} | {{LOCATION_1}} | {{CHECKSUM_1}} |
| {{ARTIFACT_2}} | {{LOCATION_2}} | {{CHECKSUM_2}} |

---

**Previous Release:** [{{PREVIOUS_VERSION}}]({{PREVIOUS_RELEASE_URL}})  
**Full Changelog:** [{{PREVIOUS_VERSION}}...{{VERSION}}]({{CHANGELOG_COMPARE_URL}})

---

<!--
================================================================================
RELEASE NOTES GUIDELINES
================================================================================

## Purpose

Release notes communicate changes to users, testers, and stakeholders. They 
should be clear, comprehensive, and actionable.

## Audience

Consider that your audience includes:
- End users who need to know about new features and changes
- QA testers who need to know what to test
- Operations teams who need to plan deployments
- Support teams who need to handle user questions
- Developers who need to understand technical changes

## Writing Style

1. Be specific and concrete — avoid vague language
2. Lead with the most important changes
3. Use consistent formatting throughout
4. Include actionable information (how to use, how to migrate)
5. Link to detailed documentation where appropriate

## Release Type Definitions

- **Major Release (X.0.0)**: Significant new features, breaking changes
- **Minor Release (0.X.0)**: New features, backward compatible
- **Patch Release (0.0.X)**: Bug fixes, security patches
- **Pre-release (X.Y.Z-alpha/beta/rc)**: Testing releases
- **Hotfix**: Emergency production fix

## Section Usage

Not all sections are required for every release:

| Section | Major | Minor | Patch | Hotfix |
|---------|-------|-------|-------|--------|
| Highlights | ✅ | ✅ | ⬜ | ⬜ |
| New Features | ✅ | ✅ | ⬜ | ⬜ |
| Improvements | ✅ | ✅ | ✅ | ⬜ |
| Bug Fixes | ✅ | ✅ | ✅ | ✅ |
| Security | ✅ | ✅ | ✅ | ✅ |
| Breaking Changes | ✅ | ⬜ | ⬜ | ⬜ |
| Dependencies | ✅ | ✅ | ⬜ | ⬜ |
| Database Changes | ✅ | ✅ | ⬜ | ⬜ |
| Testing Checklist | ✅ | ✅ | ✅ | ✅ |

================================================================================
-->

