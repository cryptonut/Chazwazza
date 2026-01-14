# Incident Postmortem Template

> **Blameless postmortem template for documenting and learning from incidents**

---

## Incident Summary

| Field | Value |
|-------|-------|
| **Incident ID** | INC-{{INCIDENT_NUMBER}} |
| **Title** | {{INCIDENT_TITLE}} |
| **Severity** | P1 / P2 / P3 / P4 |
| **Status** | Resolved / Monitoring |
| **Date** | {{INCIDENT_DATE}} |
| **Duration** | {{DURATION}} |
| **Author** | {{AUTHOR}} |
| **Review Date** | {{REVIEW_DATE}} |

---

## Executive Summary

*Write a 2-3 sentence summary for non-technical stakeholders:*

On {{DATE}}, {{BRIEF_DESCRIPTION}}. The incident lasted {{DURATION}} and affected {{IMPACT}}. The root cause was {{ROOT_CAUSE_SUMMARY}}.

---

## Impact Assessment

### User Impact

| Metric | Value |
|--------|-------|
| Users Affected | {{NUMBER}} |
| Requests Failed | {{NUMBER}} |
| Error Rate | {{PERCENTAGE}}% |
| Revenue Impact | ${{AMOUNT}} (estimated) |

### Service Impact

| Service | Status | Duration |
|---------|--------|----------|
| {{SERVICE_1}} | Degraded / Down | {{TIME}} |
| {{SERVICE_2}} | Degraded / Down | {{TIME}} |

### Severity Criteria

| Level | Definition | This Incident |
|-------|------------|---------------|
| **P1** | Complete outage, >50% users affected | ☐ |
| **P2** | Major degradation, 10-50% users affected | ☐ |
| **P3** | Minor degradation, <10% users affected | ☐ |
| **P4** | Minimal impact, internal only | ☐ |

---

## Timeline

*All times in {{TIMEZONE}}*

| Time | Event |
|------|-------|
| {{TIME}} | 🔴 **Incident begins** - First error detected |
| {{TIME}} | 📟 Alert triggered - {{ALERT_NAME}} |
| {{TIME}} | 👤 On-call engineer {{NAME}} paged |
| {{TIME}} | 🔍 Investigation begins |
| {{TIME}} | 💡 Root cause identified |
| {{TIME}} | 🔧 Fix deployed |
| {{TIME}} | 🟢 **Incident resolved** - Service restored |
| {{TIME}} | ✅ Post-incident verification complete |

### Detection Timeline

| Metric | Time |
|--------|------|
| **Time to Detect (TTD)** | {{MINUTES}} minutes |
| **Time to Acknowledge (TTA)** | {{MINUTES}} minutes |
| **Time to Mitigate (TTM)** | {{MINUTES}} minutes |
| **Time to Resolve (TTR)** | {{MINUTES}} minutes |

---

## Root Cause Analysis

### The 5 Whys

1. **Why did the incident occur?**
   - {{ANSWER_1}}

2. **Why did {{ANSWER_1}} happen?**
   - {{ANSWER_2}}

3. **Why did {{ANSWER_2}} happen?**
   - {{ANSWER_3}}

4. **Why did {{ANSWER_3}} happen?**
   - {{ANSWER_4}}

5. **Why did {{ANSWER_4}} happen?**
   - {{ANSWER_5}} ← **Root Cause**

### Root Cause Summary

*Describe the fundamental cause in technical detail:*

{{DETAILED_ROOT_CAUSE}}

### Contributing Factors

| Factor | Description | Contribution |
|--------|-------------|--------------|
| {{FACTOR_1}} | {{DESCRIPTION}} | High / Medium / Low |
| {{FACTOR_2}} | {{DESCRIPTION}} | High / Medium / Low |

---

## Resolution

### Immediate Actions Taken

1. {{ACTION_1}}
2. {{ACTION_2}}
3. {{ACTION_3}}

### What Fixed It

*Describe the specific change that resolved the incident:*

```
{{CODE_OR_CONFIG_CHANGE}}
```

### Verification

- [ ] Service health restored
- [ ] Error rates returned to normal
- [ ] User-facing functionality verified
- [ ] Monitoring shows stable state

---

## Lessons Learned

### What Went Well

| Item | Details |
|------|---------|
| ✅ | {{POSITIVE_1}} |
| ✅ | {{POSITIVE_2}} |
| ✅ | {{POSITIVE_3}} |

### What Went Poorly

| Item | Details |
|------|---------|
| ❌ | {{NEGATIVE_1}} |
| ❌ | {{NEGATIVE_2}} |
| ❌ | {{NEGATIVE_3}} |

### Where We Got Lucky

| Item | Details |
|------|---------|
| 🍀 | {{LUCKY_1}} |
| 🍀 | {{LUCKY_2}} |

---

## Action Items

### Immediate (This Week)

| ID | Action | Owner | Due Date | Status |
|----|--------|-------|----------|--------|
| 1 | {{ACTION}} | {{OWNER}} | {{DATE}} | ☐ Open |
| 2 | {{ACTION}} | {{OWNER}} | {{DATE}} | ☐ Open |

### Short-term (This Sprint/Month)

| ID | Action | Owner | Due Date | Status |
|----|--------|-------|----------|--------|
| 3 | {{ACTION}} | {{OWNER}} | {{DATE}} | ☐ Open |
| 4 | {{ACTION}} | {{OWNER}} | {{DATE}} | ☐ Open |

### Long-term (This Quarter)

| ID | Action | Owner | Due Date | Status |
|----|--------|-------|----------|--------|
| 5 | {{ACTION}} | {{OWNER}} | {{DATE}} | ☐ Open |
| 6 | {{ACTION}} | {{OWNER}} | {{DATE}} | ☐ Open |

### Action Item Categories

- 🔧 **Fix** - Direct fix for the root cause
- 🛡️ **Prevent** - Prevent similar incidents
- 🔍 **Detect** - Improve detection/alerting
- 📖 **Document** - Update runbooks/docs
- 🎓 **Train** - Knowledge sharing

---

## Prevention Measures

### How Could This Have Been Prevented?

| Prevention | Feasibility | Priority |
|------------|-------------|----------|
| {{PREVENTION_1}} | High / Medium / Low | P1 / P2 / P3 |
| {{PREVENTION_2}} | High / Medium / Low | P1 / P2 / P3 |

### Monitoring Improvements

| Alert | Condition | Action |
|-------|-----------|--------|
| {{NEW_ALERT_1}} | {{CONDITION}} | Page on-call |
| {{NEW_ALERT_2}} | {{CONDITION}} | Slack notification |

### Runbook Updates

- [ ] Update {{RUNBOOK_NAME}} with {{CHANGES}}
- [ ] Add troubleshooting steps for {{SCENARIO}}
- [ ] Document {{PROCEDURE}}

---

## Communication

### Internal Communication

| Audience | Channel | Message |
|----------|---------|---------|
| Engineering | #engineering | Incident started/resolved |
| Leadership | Email | Impact summary |
| Support | #support | Customer-facing talking points |

### External Communication (if applicable)

| Time | Channel | Message |
|------|---------|---------|
| {{TIME}} | Status Page | Investigating issues with {{SERVICE}} |
| {{TIME}} | Status Page | Issue identified, fix in progress |
| {{TIME}} | Status Page | Issue resolved |

### Customer Communication Template

```
Subject: Service Disruption - {{DATE}}

Dear Customer,

On {{DATE}}, we experienced a service disruption affecting {{SERVICE}}.

Impact: {{IMPACT_DESCRIPTION}}
Duration: {{START_TIME}} - {{END_TIME}} ({{DURATION}})

What happened: {{BRIEF_EXPLANATION}}

What we're doing: {{PREVENTIVE_MEASURES}}

We sincerely apologize for any inconvenience this may have caused.

Best regards,
{{YOUR_NAME}}
{{COMPANY}}
```

---

## Appendix

### Related Incidents

| Incident | Date | Similarity |
|----------|------|------------|
| INC-{{NUMBER}} | {{DATE}} | {{DESCRIPTION}} |

### References

- [Link to monitoring dashboard]({{URL}})
- [Link to relevant code]({{URL}})
- [Link to Slack thread]({{URL}})
- [Link to ticket]({{URL}})

### Metrics & Graphs

*Attach relevant screenshots or links to dashboards showing:*

1. Error rate during incident
2. Latency during incident
3. Traffic patterns
4. Resource utilization

---

## Review & Approval

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Author | {{NAME}} | {{DATE}} | ☐ |
| Technical Reviewer | {{NAME}} | {{DATE}} | ☐ |
| Manager | {{NAME}} | {{DATE}} | ☐ |

---

## Blameless Culture Reminder

> **This postmortem focuses on systems and processes, not individuals.**
> 
> Our goal is to understand what happened and improve our systems to prevent recurrence. 
> Human error is always a symptom of a systemic issue, not a root cause.
>
> Questions to ask:
> - What made it easy for this to happen?
> - What would have prevented this?
> - How can we make our systems more resilient?

---

**Template Version:** 1.0  
**Last Updated:** {{DOCUMENT_LAST_UPDATED}}

