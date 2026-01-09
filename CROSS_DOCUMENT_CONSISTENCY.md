# Cross-Document Consistency Log

> **Template for maintaining consistency across project documentation and materials**

**Document Owner:** {{DOCUMENT_OWNER}}  
**Created:** {{DOCUMENT_CREATED_DATE}}  
**Last Updated:** {{DOCUMENT_LAST_UPDATED}}  
**Project:** {{PROJECT_NAME}}

---

## Purpose

When the same information appears in multiple documents (website, pitch deck, investor materials, README), inconsistencies destroy credibility. This log tracks key claims to ensure single-source-of-truth consistency.

---

## 🎯 Key Claims Registry

### Company/Project Claims

| Claim Type | Current Value | Source of Truth | Last Verified |
|------------|---------------|-----------------|---------------|
| Company Name | {{COMPANY_NAME}} | Legal docs | {{DATE}} |
| Tagline | "{{TAGLINE}}" | Brand Assets | {{DATE}} |
| Founded | {{YEAR}} | Legal docs | {{DATE}} |
| Headquarters | {{LOCATION}} | Legal docs | {{DATE}} |
| Website | {{URL}} | DNS | {{DATE}} |

### Product Claims

| Claim Type | Current Value | Source of Truth | Last Verified |
|------------|---------------|-----------------|---------------|
| Product Name | {{PRODUCT}} | Product roadmap | {{DATE}} |
| Version | {{VERSION}} | package.json | {{DATE}} |
| Status | {{STATUS}} | Product status | {{DATE}} |
| Launch Date | {{DATE}} | Project plan | {{DATE}} |

### Metrics Claims

| Claim Type | Current Value | Source of Truth | Last Verified |
|------------|---------------|-----------------|---------------|
| Users | {{NUMBER}} | Analytics | {{DATE}} |
| Revenue | ${{AMOUNT}} | Financials | {{DATE}} |
| Growth Rate | {{PERCENT}}% | Financials | {{DATE}} |
| Lines of Code | {{NUMBER}} | CI/CD | {{DATE}} |

### Fundraising Claims

| Claim Type | Current Value | Source of Truth | Last Verified |
|------------|---------------|-----------------|---------------|
| Raise Amount | ${{AMOUNT}} | Fundraising plan | {{DATE}} |
| Valuation | ${{AMOUNT}} | Term sheet | {{DATE}} |
| Use of Funds | See breakdown | Financial model | {{DATE}} |
| Runway | {{MONTHS}} months | Financial model | {{DATE}} |

### Team Claims

| Claim Type | Current Value | Source of Truth | Last Verified |
|------------|---------------|-----------------|---------------|
| Founder Name | {{NAME}} | Legal docs | {{DATE}} |
| Founder Title | {{TITLE}} | Team page | {{DATE}} |
| Team Size | {{NUMBER}} | HR/Org chart | {{DATE}} |
| Advisors | {{LIST}} | Advisory agreements | {{DATE}} |

---

## 📁 Document Inventory

### Documents Containing Key Claims

| Document | Location | Claims Included | Auto-Updated |
|----------|----------|-----------------|--------------|
| Website - Home | `/src/app/page.tsx` | Tagline, Stats, Team | No |
| Website - Products | `/src/app/products/` | Product info, Status | No |
| Website - Team | `/src/app/team/` | Founder bio, Team | No |
| Pitch Deck | `/investor-materials/pitch-deck.html` | All claims | No |
| Executive Summary | `/investor-materials/exec-summary.md` | Key claims | No |
| Financial Model | `/investor-materials/financial-model.xlsx` | Financial claims | No |
| README | `/README.md` | Product info | No |
| Data Room | `/data-room/` | All claims | No |

---

## 🔄 Update Protocol

### When a Key Claim Changes

1. **Update Source of Truth First**
   - Make the change in the authoritative source
   - Document the change with date and reason

2. **Audit All Documents**
   - Use this log to identify all affected documents
   - Check each document in the inventory

3. **Update Each Instance**
   - Make identical changes across all documents
   - Verify formatting matches context

4. **Verify Consistency**
   - Search codebase for old value
   - Confirm no orphaned references

5. **Log the Update**
   - Record in Change Log below
   - Update "Last Verified" dates

### Search Commands

```bash
# Search for specific value across all files
grep -r "{{OLD_VALUE}}" --include="*.md" --include="*.tsx" --include="*.html"

# Case-insensitive search
grep -ri "{{SEARCH_TERM}}" .

# Search and list files only
grep -rl "{{SEARCH_TERM}}" .
```

---

## 📊 Use of Funds Breakdown

*This is a commonly inconsistent section — track all instances here.*

### Current Allocation

| Category | Percentage | Amount | Source |
|----------|------------|--------|--------|
| {{CATEGORY_1}} | {{PERCENT}}% | ${{AMOUNT}} | Financial Model |
| {{CATEGORY_2}} | {{PERCENT}}% | ${{AMOUNT}} | Financial Model |
| {{CATEGORY_3}} | {{PERCENT}}% | ${{AMOUNT}} | Financial Model |
| {{CATEGORY_4}} | {{PERCENT}}% | ${{AMOUNT}} | Financial Model |
| {{CATEGORY_5}} | {{PERCENT}}% | ${{AMOUNT}} | Financial Model |
| **Total** | **100%** | **${{TOTAL}}** | |

### Documents with Use of Funds

| Document | Section | Format | Status |
|----------|---------|--------|--------|
| Pitch Deck | Slide 11 | Visual bars | ☐ Verify |
| Executive Summary | Funding section | Table | ☐ Verify |
| Financial Model | Assumptions | Detailed | Source ✅ |
| Website (if shown) | Investors page | Visual | ☐ Verify |

---

## 👤 Founder Bio Versions

*Track all versions of founder descriptions.*

### Current Bio Versions

| Length | Content | Used In |
|--------|---------|---------|
| **One-liner** | "{{BIO_ONELINER}}" | Email signatures, social |
| **Short (2-3 sentences)** | "{{BIO_SHORT}}" | Pitch deck, press kit |
| **Medium (paragraph)** | "{{BIO_MEDIUM}}" | Executive summary, website |
| **Full (3+ paragraphs)** | See FOUNDER_BIO.md | Data room, detailed |

### Bio Document Locations

- [ ] Website team page
- [ ] Pitch deck team slide
- [ ] Executive summary
- [ ] LinkedIn profile
- [ ] Twitter/X bio
- [ ] Press kit
- [ ] Data room

---

## 📈 Metrics Consistency

### Active Metrics

| Metric | Value | As Of | Update Frequency |
|--------|-------|-------|------------------|
| Total Users | {{NUMBER}} | {{DATE}} | Weekly |
| Active Users | {{NUMBER}} | {{DATE}} | Weekly |
| Revenue (MRR) | ${{AMOUNT}} | {{DATE}} | Monthly |
| Growth Rate | {{PERCENT}}% | {{DATE}} | Monthly |
| Retention | {{PERCENT}}% | {{DATE}} | Monthly |

### Metric Locations

| Metric | Website | Pitch Deck | Exec Summary | Other |
|--------|---------|------------|--------------|-------|
| Total Users | Stats bar | Traction slide | Key metrics | |
| Revenue | Stats bar | Financials slide | Summary | |
| Growth | Not shown | Traction slide | Highlights | |

---

## ✅ Consistency Audit Checklist

### Weekly Quick Check

- [ ] Website stats match current data
- [ ] No obvious outdated information on homepage
- [ ] Contact information current

### Monthly Full Audit

- [ ] All metrics updated from source data
- [ ] Pitch deck reflects current state
- [ ] Executive summary is current
- [ ] Financial model assumptions valid
- [ ] Team information current
- [ ] All links working
- [ ] No conflicting claims found

### Before Major Presentations

- [ ] Full audit completed
- [ ] All numbers verified against source
- [ ] Screenshots/demos current
- [ ] Bio versions consistent
- [ ] Use of funds matches latest plan
- [ ] No outdated dates mentioned

---

## 📝 Change Log

| Date | Claim | Old Value | New Value | Updated By | Documents Updated |
|------|-------|-----------|-----------|------------|-------------------|
| {{DATE}} | {{CLAIM}} | {{OLD}} | {{NEW}} | {{WHO}} | {{LIST}} |

### Example Entries

```markdown
| 2026-01-09 | Use of Funds - CTO | 30% | 20% + equity | Agent | Pitch Deck, Exec Summary, Financial Model |
| 2026-01-09 | Founder Title | Not a developer | Chief Builder | Agent | Website, Pitch Deck, Exec Summary |
| 2026-01-08 | Product Status | Planned | Beta Ready | Agent | Website, Products page |
```

---

## 🚨 Common Inconsistency Patterns

### Watch For These

| Pattern | Example | Prevention |
|---------|---------|------------|
| **Old dates** | "Founded 2024" vs "Since 2025" | Use source of truth |
| **Rounded vs exact** | "10K users" vs "10,847 users" | Decide on policy |
| **Stale metrics** | Different numbers in slides | Update all at once |
| **Title variations** | "CEO" vs "Founder" vs "Chief Builder" | Standardize |
| **Product names** | Inconsistent capitalization | Style guide |
| **Dollar amounts** | $5K vs $5,000 vs 5000 | Formatting standard |

### Prevention Strategies

1. **Update in batches** — When changing one doc, update all
2. **Search after changes** — Verify no orphaned old values
3. **Regular audits** — Schedule monthly reviews
4. **Single source** — Always start from authoritative source
5. **Document changes** — Log every update

---

## AI Agent Instructions

When handling content that appears in multiple documents:

1. **Check this log first** — Identify all locations of the claim
2. **Update source of truth** — Start with authoritative document
3. **Update all instances** — Don't leave partial updates
4. **Search for stragglers** — Grep for old values
5. **Log the change** — Add to Change Log
6. **Report completeness** — "Updated X across N documents: [list]"

### Claim Update Report Format

```
CONSISTENCY UPDATE COMPLETE:

Claim: [description]
Old Value: [old]
New Value: [new]

Documents Updated:
- [file1] - [section]
- [file2] - [section]
- [file3] - [section]

Search Verification:
- Searched for "[old value]" — 0 remaining instances
- Searched for "[new value]" — N instances (all intended)

Status: All documents consistent
```

---

*Template from [Chazwazza](https://github.com/cryptonut/Chazwazza) - Enterprise Project Starter Kit*

