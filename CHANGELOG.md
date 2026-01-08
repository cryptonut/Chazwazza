# Changelog

All notable changes to **{{PROJECT_NAME}}** are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Added
- *New features that have been added*

### Changed
- *Changes to existing functionality*

### Deprecated
- *Features that will be removed in upcoming releases*

### Removed
- *Features that have been removed*

### Fixed
- *Bug fixes*

### Security
- *Security-related changes*

---

## [{{VERSION}}] - {{RELEASE_DATE}}

### Added
- {{FEATURE_1}}
- {{FEATURE_2}}

### Changed
- {{CHANGE_1}}

### Fixed
- {{FIX_1}}
- {{FIX_2}}

### Security
- {{SECURITY_1}}

---

<!--
================================================================================
CHANGELOG GUIDELINES
================================================================================

## What is a Changelog?

A changelog is a file which contains a curated, chronologically ordered list 
of notable changes for each version of a project.

## Why Keep a Changelog?

- Makes it easier for users and contributors to see what notable changes have 
  been made between each release
- Essential for proper version communication
- Required for enterprise-level release management

## Who Needs a Changelog?

Everyone. Whether you're a consumer or developer, a changelog helps understand
what's new, what's fixed, and what might affect your usage.

## How to Write Good Changelog Entries

### Guiding Principles

1. Changelogs are for HUMANS, not machines
2. There should be an entry for every single version
3. The same types of changes should be grouped
4. Versions and sections should be linkable
5. The latest version comes first
6. The release date of each version is displayed

### Types of Changes

- `Added` for new features
- `Changed` for changes in existing functionality
- `Deprecated` for soon-to-be removed features
- `Removed` for now removed features
- `Fixed` for any bug fixes
- `Security` in case of vulnerabilities

### Writing Good Entries

✅ GOOD entries:
- "Add user authentication with OAuth2 support"
- "Fix crash when submitting form with empty email field"
- "Change default pagination limit from 100 to 50 for performance"
- "Remove deprecated `getUser()` method (use `getUserById()` instead)"
- "Security: Upgrade dependency X to patch CVE-YYYY-NNNN"

❌ BAD entries:
- "Bug fixes" (too vague)
- "Updates" (meaningless)
- "Fixed stuff" (unhelpful)
- "Changed some code" (not informative)

### Entry Format

Each entry should:
1. Start with a verb (Add, Fix, Change, Remove, Deprecate, Security)
2. Be in the present tense ("Add" not "Added")
3. Describe WHAT changed, not HOW
4. Include context if the change is breaking
5. Reference issue/PR numbers when applicable

### Examples

#### Added
- Add dark mode support with automatic system preference detection
- Add export functionality for user data (CSV, JSON formats)
- Add rate limiting to API endpoints (100 requests/minute)

#### Changed
- Change minimum password length from 6 to 8 characters
- Improve search performance with database indexing
- Update UI components to Material Design 3

#### Deprecated
- Deprecate `POST /api/v1/users` endpoint (use `POST /api/v2/users`)
- Deprecate `Config.legacyMode` option (will be removed in v3.0)

#### Removed
- Remove support for Node.js 14 (EOL)
- Remove `experimental.newFeature` flag (now always enabled)

#### Fixed
- Fix memory leak in WebSocket connection handler
- Fix incorrect date formatting in non-English locales
- Fix race condition when updating concurrent user sessions

#### Security
- Security: Update `lodash` to 4.17.21 to fix prototype pollution (CVE-2021-23337)
- Security: Add CSRF protection to all state-changing endpoints
- Security: Implement request signing for webhook deliveries

================================================================================
SEMANTIC VERSIONING REFERENCE
================================================================================

Given a version number MAJOR.MINOR.PATCH, increment the:

- MAJOR version when you make incompatible API changes
- MINOR version when you add functionality in a backward compatible manner
- PATCH version when you make backward compatible bug fixes

Additional labels for pre-release and build metadata are available as extensions
to the MAJOR.MINOR.PATCH format.

Examples:
- 1.0.0 → 1.0.1 (bug fix)
- 1.0.0 → 1.1.0 (new feature, backward compatible)
- 1.0.0 → 2.0.0 (breaking change)
- 1.0.0-alpha.1 (pre-release)
- 1.0.0+build.123 (build metadata)

================================================================================
-->

---

## Version History Links

[Unreleased]: {{REPO_URL}}/compare/v{{LATEST_VERSION}}...HEAD
[{{VERSION}}]: {{REPO_URL}}/compare/v{{PREVIOUS_VERSION}}...v{{VERSION}}

---

**Project:** {{PROJECT_NAME}}  
**Repository:** {{REPO_URL}}  
**Maintained by:** {{MAINTAINER}}
