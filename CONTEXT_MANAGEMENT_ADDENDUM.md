# Context Window Management Addendum

> **Addition to AGENT_EXCELLENCE_GUIDE.md**
> 
> Add this section to help AI agents manage long sessions effectively.

---

## Context Window Management

### Understanding Context Limits

AI agents have limited context windows. As conversations grow, older information may be lost. Proactive management ensures continuity.

### Warning Signs

Watch for these indicators that context limits are approaching:

- 🟡 Session has been running for extended period
- 🟡 Many files have been read/modified
- 🟡 Complex multi-step tasks in progress
- 🔴 Agent seems to "forget" earlier decisions
- 🔴 Repeating questions already answered

### Proactive Strategies

#### 1. Summarize Regularly

After completing significant milestones:

```markdown
## Progress Summary

### Completed
- [x] Task 1: Brief description
- [x] Task 2: Brief description

### In Progress
- [ ] Task 3: Current status

### Pending
- [ ] Task 4: Not started

### Key Decisions Made
- Decision 1: Rationale
- Decision 2: Rationale
```

#### 2. Document State Clearly

When working on complex tasks, maintain state:

```markdown
## Current State

**Working On:** Feature X implementation
**Branch:** feature/x-implementation
**Last Commit:** abc1234 "feat: Add X component"

**Modified Files:**
- src/components/X.tsx (new)
- src/services/x-service.ts (new)
- src/App.tsx (modified - added route)

**Known Issues:**
- Issue 1: Description and status
```

#### 3. Create Handover Documents

When context limits approach or session ends:

```markdown
# Session Handover

**Date:** YYYY-MM-DD
**Agent Session:** [identifier if available]

## Summary
Brief overview of what was accomplished.

## Completed Work
- Item 1 with details
- Item 2 with details

## Current State
- What's working
- What's partially complete
- What's not started

## Next Steps
1. Priority 1 item
2. Priority 2 item

## Important Context
- Key decisions and rationale
- Gotchas or warnings
- Dependencies to be aware of

## Files Modified This Session
| File | Change Type | Notes |
|------|-------------|-------|
| path/to/file | Created | Purpose |
| path/to/file | Modified | What changed |

## Commands to Resume
```bash
# Commands needed to continue work
git checkout branch-name
npm install  # if dependencies changed
```
```

### Recovery Strategies

#### When Starting Fresh Session

1. **Read key documents first:**
   - AGENT_EXCELLENCE_GUIDE.md
   - TECHNICAL_DEBT.md (if exists)
   - Recent CHANGELOG entries
   - Any HANDOVER.md from previous session

2. **Verify current state:**
   ```bash
   git status
   git log --oneline -10
   ```

3. **Run project to confirm working state:**
   ```bash
   {{TEST_COMMAND}}
   {{BUILD_COMMAND}}
   ```

#### When Context Seems Lost

1. **Stop and assess** - Don't continue blindly
2. **Re-read relevant files** - Refresh understanding
3. **Summarize understanding** - Verify with user
4. **Proceed carefully** - Smaller steps

### Communication Protocols

#### Informing User of Context Status

```
"I want to note that we've covered a lot of ground in this session. 
To ensure continuity, I'm documenting our progress:
[summary]
Would you like me to create a formal handover document?"
```

#### Requesting Context Refresh

```
"I want to make sure I have the complete picture. Could you confirm:
1. Current goal: [your understanding]
2. Completed items: [list]
3. Next priority: [your understanding]"
```

### Best Practices

| Do | Don't |
|----|-------|
| Summarize after major milestones | Wait until context is lost |
| Document decisions as they're made | Rely on memory alone |
| Create handover docs proactively | Leave state undocumented |
| Ask for confirmation on understanding | Assume and proceed |
| Work in smaller, complete chunks | Take on massive tasks at once |

---

## Quality Gates Checklist

> **Addition to AGENT_EXCELLENCE_GUIDE.md**
>
> Pre-commit verification checklist for AI agents.

### Before Every Commit

```markdown
## Pre-Commit Checklist

### Code Quality
- [ ] All linter errors resolved (`{{LINT_COMMAND}}`)
- [ ] Code follows project conventions
- [ ] No debug code left in (console.log, print, etc.)
- [ ] Comments are helpful and accurate

### Testing
- [ ] Tests pass locally (`{{TEST_COMMAND}}`)
- [ ] New tests added for new functionality
- [ ] Existing tests still pass
- [ ] Manual testing completed (if UI changes)

### Security
- [ ] No hardcoded secrets or credentials
- [ ] No sensitive data in logs
- [ ] Input validation where needed
- [ ] .gitignore includes sensitive files

### Documentation
- [ ] README updated (if needed)
- [ ] API docs updated (if needed)
- [ ] Code comments for complex logic
- [ ] CHANGELOG entry added (if user-facing)

### Verification
- [ ] Changes verified on device/browser
- [ ] No functionality removed without approval
- [ ] Commit message follows conventions
- [ ] Branch is correct

### Final Check
- [ ] `git diff` reviewed - changes are intentional
- [ ] No unrelated changes included
- [ ] Ready for human review
```

### Before Requesting Human Testing

```markdown
## Pre-Testing Verification

- [ ] Application builds without errors
- [ ] Application runs without crashes
- [ ] Core functionality works as expected
- [ ] Changes are visible/testable
- [ ] Test instructions provided (if needed)
- [ ] Known limitations documented
```

---

*Addendum for [Chazwazza](https://github.com/cryptonut/Chazwazza) - Enterprise Project Starter Kit*

