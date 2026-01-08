# Technical Debt Backlog

> **Template for tracking and managing technical debt in AI-assisted projects**

**Document Owner:** {{DOCUMENT_OWNER}}  
**Created:** {{DOCUMENT_CREATED_DATE}}  
**Last Updated:** {{DOCUMENT_LAST_UPDATED}}  
**Total Active Items:** X

---

## Purpose

This document tracks genuine technical debt - code or architecture decisions that need future attention. It provides:
- Visibility into known issues
- Prioritization guidance
- Resolution tracking
- Audit trail for decisions

---

## 🔴 High Priority (Pre-Production)

Items that must be resolved before production release.

| ID | File/Location | Description | Effort | Status | Owner |
|----|---------------|-------------|--------|--------|-------|
| TD-001 | `example.ts:42` | Example: Security vulnerability | High | **In Progress** | @dev |
| TD-002 | `api/auth.ts` | Example: Missing rate limiting | Medium | **Planned: Q1** | @team |

### Criteria for High Priority
- Security vulnerabilities
- Data integrity risks
- Performance blockers
- Compliance requirements

---

## 🟡 Medium Priority (Post-MVP)

Items that should be addressed after initial release.

| ID | File/Location | Description | Effort | Status | Owner |
|----|---------------|-------------|--------|--------|-------|
| TD-010 | `utils/cache.ts` | Example: Cache invalidation | Medium | **Roadmap: Q2** | - |
| TD-011 | `services/*.ts` | Example: Inconsistent error handling | Low | **Roadmap: Q2** | - |

### Criteria for Medium Priority
- Code quality improvements
- Performance optimizations
- Developer experience enhancements
- Non-critical feature gaps

---

## 🟢 Low Priority (Nice to Have)

Items that would improve the codebase but aren't blocking.

| ID | File/Location | Description | Effort | Status | Owner |
|----|---------------|-------------|--------|--------|-------|
| TD-020 | `components/` | Example: Component refactoring | Low | **Backlog** | - |

---

## ✅ Resolved

Track resolved items for audit trail and learning.

| ID | Description | Resolution | Resolved Date |
|----|-------------|------------|---------------|
| TD-R01 | Example resolved item | Implemented in PR #123 | 2026-01-08 |

---

## 📋 Deferred (Intentional - Not Tech Debt)

Items intentionally deferred to post-MVP that are NOT technical debt.

- **Feature X**: Planned for Phase 2, not a quality issue
- **Integration Y**: Awaiting third-party API availability

---

## Roadmap Integration

### {{CURRENT_QUARTER}} (Current)
- List items planned for this quarter

### {{NEXT_QUARTER}}
- List items planned for next quarter

### Future
- Items without specific timeline

---

## Process

### Adding New Items
1. Assign unique ID (TD-XXX for active, TD-RXXX for resolved)
2. Document file/location precisely
3. Describe the issue clearly
4. Estimate effort (Low/Medium/High)
5. Set initial status

### Status Values
- **New**: Just identified
- **In Progress**: Being worked on
- **Planned: QX**: Scheduled for specific quarter
- **Roadmap: QX**: Tentatively scheduled
- **Backlog**: No specific timeline
- **Blocked**: Waiting on external dependency

### Resolution Process
1. Move item to Resolved section
2. Document resolution method
3. Add resolved date
4. Update total active count

---

## Metrics

Track these metrics over time:

| Metric | Value |
|--------|-------|
| Total Active | X |
| High Priority | X |
| Resolved This Month | X |
| Average Age (days) | X |

---

## AI Agent Instructions

When working with this document:

1. **Never remove items** without explicit approval
2. **Update status** as work progresses
3. **Add new items** when discovered during development
4. **Move to Resolved** with proper documentation
5. **Keep counts accurate** in header

---

*Template from [Chazwazza](https://github.com/cryptonut/Chazwazza) - Enterprise Project Starter Kit*

