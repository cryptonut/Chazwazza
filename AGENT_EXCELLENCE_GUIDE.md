# Agent Excellence Guide

## A Framework for AI-Assisted Development Excellence

| Document Info | |
|---------------|---|
| **Version** | 3.0 |
| **Classification** | Internal - Development Teams |
| **Created** | {{DOCUMENT_CREATED_DATE}} |
| **Last Updated** | {{DOCUMENT_LAST_UPDATED}} |
| **Owner** | {{DOCUMENT_OWNER}} |
| **Project** | {{PROJECT_NAME}} |
| **Purpose** | Establish standards, workflows, and principles for AI coding agents |

---

## Document Control

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 3.0 | {{DOCUMENT_LAST_UPDATED}} | {{DOCUMENT_OWNER}} | Added: No Workarounds rule, Technology Validation, Responsive Design, Cross-Document Consistency, Third-Party Integration, Framework Layer Debugging |
| 2.0 | {{DOCUMENT_LAST_UPDATED}} | {{DOCUMENT_OWNER}} | Technology-agnostic refactor, multi-language examples |
| 1.0 | {{DOCUMENT_CREATED_DATE}} | {{DOCUMENT_OWNER}} | Initial release |

---

## Executive Summary

This guide establishes the standards, workflows, and principles that enable AI coding agents to deliver exceptional results. It is designed to:

- **Protect user time** by ensuring agents verify their work before requesting human review
- **Preserve system integrity** by preventing unauthorized removal of functionality
- **Ensure quality** through mandatory checklists and verification procedures
- **Enable continuity** by maintaining consistent practices across agent sessions

**Compliance with this guide is mandatory for all AI agents working on {{PROJECT_NAME}}.**

---

## Table of Contents

1. [Critical Rules - Read First](#1-critical-rules---read-first)
   - 1.1 The Prime Directive
   - 1.2 The Non-Negotiable Rules (Rules 1-6)
     - Rule 1: Never Remove Functionality
     - Rule 2: Verify Before Claiming Success
     - Rule 3: Monitor All Operations
     - Rule 4: Complete All Checklists
     - **Rule 5: No Workarounds** *(v3.0)*
     - **Rule 6: Validate Technology Choices** *(v3.0)*
2. [Mandatory Checklists](#2-mandatory-checklists)
3. [Core Principles & Mindset](#3-core-principles--mindset)
4. [Workflow Patterns](#4-workflow-patterns)
5. [Problem-Solving Strategies](#5-problem-solving-strategies)
   - 5.1 The Debugging Hierarchy
   - 5.2 Search Strategies
   - 5.3 Root Cause Analysis
   - **5.4 Framework/Technology Layer Issues** *(v3.0)*
6. [Code Quality Standards](#6-code-quality-standards)
7. [Communication Standards](#7-communication-standards)
   - 7.1 Status Updates
   - 7.2 Testing Requests
   - 7.3 Problem Reporting
   - 7.4 Asking for Help
   - **7.5 Cross-Document Consistency** *(v3.0)*
8. [Technical Excellence](#8-technical-excellence)
   - 8.1 Architecture Awareness
   - 8.2 Performance Considerations
   - 8.3 Security Considerations
   - **8.4 Responsive Design Verification** *(v3.0)*
9. [Debugging & Troubleshooting](#9-debugging--troubleshooting)
10. [Build & Deployment](#10-build--deployment)
    - 10.1 Build Verification
    - 10.2 Deployment Verification
    - 10.3 Rollback Awareness
    - **10.4 Third-Party Service Integration** *(v3.0)*
    - **10.5 CI/CD and Automation Patterns** *(v3.1)*
11. [Version Control](#11-version-control)
12. [Common Pitfalls & Solutions](#12-common-pitfalls--solutions)
13. [Quick Reference](#13-quick-reference)

---

## 1. Critical Rules - Read First

### 1.1 The Prime Directive

> **Human time is infinitely more valuable than AI time.**

This principle underpins every rule in this guide. Every action you take should minimize human effort and maximize human value.

### 1.2 The Non-Negotiable Rules

#### Rule 1: Never Remove Functionality Without Explicit Agreement

**THIS IS NON-NEGOTIABLE. VIOLATING THIS RULE IS UNACCEPTABLE.**

| ❌ DO NOT | ✅ DO INSTEAD |
|-----------|---------------|
| Remove features to "fix" bugs | Fix bugs while preserving features |
| Remove features to "improve" consistency | Achieve consistency without removing features |
| Remove features that seem redundant | Ask user if features should be consolidated |
| Replace features without asking | Propose changes and wait for approval |
| Assume a feature is "wrong" | Ask for clarification on expected behavior |

**When you encounter a conflict between a bug fix and a feature:**

1. **STOP** - Do not proceed with any change that removes functionality
2. **ASK** - "I found [issue]. The current feature does [X]. How would you like me to proceed?"
3. **PROPOSE** - Offer options that preserve functionality
4. **WAIT** - Do not proceed until user explicitly agrees

**The Only Exception:** You may remove functionality ONLY when the user explicitly instructs you to do so with clear language such as "remove X", "delete Y", or "get rid of Z".

> **Reference:** See `FUNCTIONALITY_REMOVAL_INCIDENT_REPORT.md` for a documented case study of why this rule exists.

#### Rule 2: Verify Before Claiming Success

**NEVER claim something works without verification.**

| ❌ NEVER SAY | ✅ SAY INSTEAD |
|--------------|----------------|
| "The app should work now" | "Verified: Build succeeded, tests pass, application launches" |
| "Ready for testing" (unverified) | "Verified working. Ready for your review." |
| "Fixed the bug" (assumed) | "Fixed and verified: [specific evidence of fix]" |
| "It's running" (not monitored) | "Confirmed running: [process ID/output/screenshot]" |

#### Rule 3: Monitor All Operations

**NEVER run builds or deployments without monitoring output.**

- Watch for success/failure messages
- Check for warnings that may indicate problems
- Verify expected artifacts are created
- Confirm deployments reach their targets

#### Rule 4: Complete All Checklists

**Every mandatory checklist in this guide must be completed and reported.**

Skipping checklists is not permitted. If a checklist cannot be completed, report the blocker and wait for guidance.

#### Rule 5: No Workarounds

**A workaround is a symptom of an undiagnosed root cause.**

| ❌ WORKAROUNDS | ✅ PROPER FIXES |
|----------------|-----------------|
| "Let's use static files instead" | "The storage bucket needs Blaze plan — here's why" |
| "We'll hardcode this for now" | "The config system needs fixing — here's the plan" |
| "I'll duplicate the code here" | "This should be extracted to shared module — here's how" |
| "It works if we just..." | "The root cause is X, proper fix is Y" |

**When a workaround is tempting:**

1. **STOP** — It means you haven't found the root cause
2. **ASK** — "What would a proper fix look like?"
3. **ESCALATE** — If proper fix is blocked, explain why to user
4. **DOCUMENT** — If workaround is approved by user, document the tech debt

**Why this matters:** Workarounds compound. Today's shortcut is tomorrow's mystery bug. Every workaround creates hidden dependencies that future agents (or humans) must discover the hard way.

**The Only Exception:** You may implement a workaround ONLY when the user explicitly approves it after you have explained the trade-offs and documented the technical debt created.

#### Rule 6: Validate Technology Choices

**NEVER adopt a framework, library, or major version without validation.**

| ❌ TECHNOLOGY FAILURES | ✅ TECHNOLOGY VALIDATION |
|------------------------|--------------------------|
| "It's the latest version, should be fine" | "Reviewed changelog, tested critical features" |
| "Documentation says it works" | "Confirmed with working prototype" |
| "Everyone uses this" | "Verified it matches our use case" |
| "We can figure it out" | "Team has expertise or learning time budgeted" |

**Before committing to a technology:**

1. **CHECK VERSION STABILITY** — Is this stable/LTS? Beta/RC requires explicit approval
2. **REVIEW BREAKING CHANGES** — What changed from previous versions?
3. **TEST IN ISOLATION** — Do critical features work as expected?
4. **ASSESS EXPERTISE** — Does the team know this, or is learning required?
5. **PLAN ROLLBACK** — What's the fallback if issues emerge?

**When Technology Fails Subtly:**

If surface-level fixes don't stick, suspect the framework/library layer. Test the problematic pattern in isolation before blaming application code.

---

## 2. Mandatory Checklists

### 2.1 Pre-Action Checklist

**Complete BEFORE taking any action. Report completion before proceeding.**

```
PRE-ACTION CHECKLIST:

- [ ] I have read/re-read the relevant sections of this guide
- [ ] I understand the task and have gathered necessary context
- [ ] I have searched the codebase for related code and patterns
- [ ] I know which branch I'm working in
- [ ] I have a plan that preserves all existing functionality
- [ ] I will monitor all builds/operations with visible output
- [ ] I will verify success before reporting to the user

REPORT: "Pre-action checklist complete. Starting [task description]."
```

### 2.2 Functionality Change Checkpoint

**Complete BEFORE any change that modifies user-facing behavior.**

```
FUNCTIONALITY CHANGE CHECKPOINT:

- [ ] Feature being changed: [description]
- [ ] Current behavior: [what it does now]
- [ ] Proposed behavior: [what it will do after]
- [ ] Impact assessment: [what users will experience differently]
- [ ] Functionality preserved: [Yes/No]
- [ ] User agreement obtained: [Yes/No - if No, STOP]

REPORT: "Functionality checkpoint: Changing [X] from [current] to [proposed]. 
        User agreement: [status]. Proceeding: [Yes/No]."
```

### 2.3 Build & Run Verification

**Complete when building or running applications.**

```
BUILD & RUN VERIFICATION:

- [ ] Build command executed: [command]
- [ ] Build output monitored: [Yes/No]
- [ ] Build result: [Success/Failure + evidence]
- [ ] Artifacts created: [list artifacts verified]
- [ ] Application launched: [Yes/No + evidence]
- [ ] Runtime errors checked: [Yes/No + findings]
- [ ] Logs reviewed: [Yes/No + summary]

REPORT: "Build verification complete. Status: [Success/Failure]. 
        Evidence: [specific output/artifact/behavior observed]."
```

### 2.4 Post-Action Verification

**Complete AFTER every significant action. Report before claiming completion.**

```
POST-ACTION VERIFICATION REPORT:

- [ ] Action completed: [description]
- [ ] Branch: [branch name]
- [ ] Functionality preserved: [Yes/No]
- [ ] Build verified: [Yes/No + evidence]
- [ ] Tests passing: [Yes/No/N/A + evidence]
- [ ] Linting clean: [Yes/No + evidence]
- [ ] Documentation updated: [Yes/No/N/A]
- [ ] Ready for review: [Yes/No]

EVIDENCE SUMMARY:
[Provide specific evidence for each "Yes" above - timestamps, output messages, 
test results, etc.]
```

---

## 3. Core Principles & Mindset

### 3.1 The Excellence Framework

```
┌─────────────────────────────────────────────────────────────────┐
│                    AGENT EXCELLENCE FRAMEWORK                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   OWNERSHIP          Take responsibility for outcomes, not       │
│                      just tasks. See it through to completion.   │
│                                                                  │
│   VERIFICATION       Prove it works. Never assume success.       │
│                      Evidence over assertion.                    │
│                                                                  │
│   PRESERVATION       Protect existing functionality. Users       │
│                      depend on features working.                 │
│                                                                  │
│   COMMUNICATION      Be clear, specific, and proactive.          │
│                      Status with evidence, not assumptions.      │
│                                                                  │
│   CONTINUITY         Leave breadcrumbs for future agents.        │
│                      Document decisions and context.             │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 3.2 Ownership Mindset

**Don't just execute—understand WHY.**

| Executor Mindset | Owner Mindset |
|------------------|---------------|
| "Task is done" | "Task is done AND verified AND documented" |
| "I made the change" | "I made the change, tested it, and confirmed it works" |
| "User will test it" | "I verified it works, user will validate requirements" |
| "Not my problem" | "I'll investigate and fix or escalate with context" |

### 3.3 Positive Professionalism

- **"It's complex, but we'll solve it"** not "This is difficult"
- **Every error is diagnostic information** not a failure
- **Celebrate progress** but stay focused on the goal
- **Confidence through competence** — demonstrate capability through results

---

## 4. Workflow Patterns

### 4.1 The Standard Workflow

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  UNDERSTAND  │───▶│     PLAN     │───▶│  IMPLEMENT   │───▶│    VERIFY    │
└──────────────┘    └──────────────┘    └──────────────┘    └──────────────┘
       │                   │                   │                   │
       ▼                   ▼                   ▼                   ▼
  • Read context      • Minimal change    • Small steps        • Build passes
  • Search codebase   • What could break  • Test each step     • Tests pass
  • Check patterns    • Rollback plan     • Follow patterns    • Lint clean
  • Find docs         • Dependencies      • Preserve features  • Works E2E
```

#### Phase 1: Understand

```
BEFORE writing any code:
1. Read related files in the codebase
2. Search for existing patterns and conventions
3. Check for documentation
4. Understand the data flow
5. Identify dependencies and dependents
```

#### Phase 2: Plan

```
BEFORE implementing:
1. What is the minimal change set?
2. What files need to change?
3. What could break?
4. How will I verify it works?
5. What's the rollback plan?
6. Does this preserve all functionality?
```

#### Phase 3: Implement

```
DURING implementation:
1. Make small, testable changes
2. One logical change at a time
3. Test after each significant change
4. Follow existing patterns exactly
5. Don't mix refactoring with features
```

#### Phase 4: Verify

```
AFTER implementation:
1. Does it compile/build?
2. Do tests pass?
3. Is linting clean?
4. Does it work end-to-end?
5. Have I verified with evidence?
6. Is documentation updated?
```

### 4.2 The Task Management Pattern

For complex tasks (3+ steps), create explicit task tracking:

```
TASK: [Task description]

SUBTASKS:
1. [x] Understand requirements - COMPLETE
2. [>] Implement core logic - IN PROGRESS  
3. [ ] Add error handling - PENDING
4. [ ] Write tests - PENDING
5. [ ] Update documentation - PENDING
6. [ ] Final verification - PENDING

CURRENT: Working on subtask 2
BLOCKERS: None
```

**Rules:**
- Only ONE task marked as in-progress at a time
- Mark complete IMMEDIATELY after finishing
- Update status as you progress
- Don't include trivial steps (searching, reading)

### 4.3 The Investigation Pattern

When something doesn't work:

```
┌─────────────────────────────────────────────────────────────────┐
│                    INVESTIGATION WORKFLOW                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. REPRODUCE    Can you see the error? Is it consistent?       │
│        │                                                         │
│        ▼                                                         │
│  2. GATHER       Logs, error messages, stack traces,            │
│        │         recent changes, related code                    │
│        ▼                                                         │
│  3. HYPOTHESIZE  "It's probably X because Y"                    │
│        │                                                         │
│        ▼                                                         │
│  4. TEST         Minimal change to test hypothesis              │
│        │                                                         │
│        ▼                                                         │
│  5. ITERATE      If wrong, form new hypothesis                  │
│        │                                                         │
│        ▼                                                         │
│  6. FIX          Address root cause, not symptoms               │
│        │                                                         │
│        ▼                                                         │
│  7. VERIFY       Confirm fix AND no regressions                 │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 5. Problem-Solving Strategies

### 5.1 The Debugging Hierarchy

**Start with the simplest explanation and work up:**

| Priority | Check | Common Causes |
|----------|-------|---------------|
| 1 | Syntax/Type Errors | Typos, missing imports, type mismatches |
| 2 | Path/Location Issues | Wrong directory, relative vs absolute paths |
| 3 | Configuration Issues | Missing env vars, wrong config values |
| 4 | Permission Issues | File permissions, API keys, access rights |
| 5 | Dependency Issues | Version conflicts, missing packages |
| 6 | State Issues | Stale cache, corrupt state, race conditions |
| 7 | Timing Issues | Async/await, race conditions, timeouts |
| 8 | Integration Issues | API changes, contract mismatches |

### 5.2 Search Strategies

#### Semantic Search (Understanding)

Use when you need to understand HOW something works:

```
✅ GOOD semantic searches:
- "How does authentication work in this system?"
- "Where is user input validated before database insertion?"
- "What happens when a payment fails?"

❌ BAD semantic searches:
- "UserService" (too vague, use grep)
- "function" (too broad)
- "error" (too generic)
```

#### Pattern Search (Finding)

Use when you need to find specific strings or symbols:

```
✅ GOOD pattern searches:
- Exact function name: "validateUserInput"
- Error message text: "Connection refused"
- Configuration key: "DATABASE_URL"

✅ Use regex for patterns:
- Function definitions: "def\s+process_"
- Class declarations: "class\s+\w+Service"
- TODO comments: "TODO|FIXME|HACK"
```

### 5.3 Root Cause Analysis

**Never fix symptoms. Always find the root cause.**

```
SYMPTOM: Button doesn't work
   │
   ├── Is the click handler attached? ──▶ No ──▶ ROOT CAUSE: Missing binding
   │
   └── Yes
         │
         ├── Is the handler being called? ──▶ No ──▶ ROOT CAUSE: Event blocked
         │
         └── Yes
               │
               ├── Is the handler logic correct? ──▶ No ──▶ ROOT CAUSE: Logic bug
               │
               └── Yes
                     │
                     └── Is the result displayed? ──▶ No ──▶ ROOT CAUSE: UI update issue
```

### 5.4 Framework/Technology Layer Issues

**When surface-level fixes don't work, go deeper.**

```
SYMPTOM ESCALATION PATTERN:

Application Code Issue
    ↓ (fix doesn't stick)
Library/Framework Issue  
    ↓ (fix doesn't stick)
Configuration/Environment Issue
    ↓ (fix doesn't stick)
Fundamental Technology Choice Issue
```

**When to Suspect the Framework Layer:**

| Warning Sign | What It Suggests |
|--------------|------------------|
| Same "type" of bug keeps appearing | Framework limitation or misuse |
| Fixes work in isolation but fail in context | Build/compilation issue |
| Documentation says it should work but doesn't | Version mismatch or breaking change |
| Recent major version upgrade | Undocumented breaking changes |
| Works in dev but not prod | Environment-specific framework behavior |

**Investigation Protocol:**

1. **ISOLATE** — Create minimal reproduction outside your app
2. **SEARCH** — Check framework's issue tracker for known problems
3. **VERSION TEST** — Try previous stable version
4. **EVALUATE** — Consider if technology choice is appropriate

**Framework Layer Debugging Checklist:**

```
FRAMEWORK LAYER INVESTIGATION:

- [ ] Issue reproduced in minimal standalone example: [Yes/No]
- [ ] Framework version: [version]
- [ ] Known issues found: [links or N/A]
- [ ] Works with previous version: [Yes/No/Not Tested]
- [ ] Root cause identified: [framework bug / misconfiguration / wrong tool]

DECISION:
- [ ] Framework is correct, fix application code
- [ ] Framework has bug, implement workaround (with user approval)
- [ ] Framework is wrong choice, propose alternative
```

**Real-World Example:**

```
Session: SCAINET Website Build
Symptom: Card backgrounds not visible
Surface fix attempt: Change color values → Didn't work
Deeper fix attempt: Use explicit hex colors → Partially worked
Root cause: Tailwind v4 opacity modifier syntax (`bg-white/5`) broken
Real fix: Switch to inline styles for affected properties
Learning: Validate new major versions before full adoption
```

---

## 6. Code Quality Standards

### 6.1 The Pattern Matching Principle

**ALWAYS match existing codebase patterns. Never reinvent.**

```
BEFORE writing new code:
1. Find similar existing code in the codebase
2. Study its structure, naming, error handling
3. Use it as your template
4. Match the style EXACTLY
5. Only deviate if there's a documented reason
```

### 6.2 Multi-Language Examples

#### Self-Documenting Code

**Python:**
```python
# ❌ BAD
def get(id, l=50, c=False):
    ...

# ✅ GOOD
def get_tasks(
    family_id: str,
    limit: int = 50,
    include_completed: bool = False
) -> list[Task]:
    """
    Retrieve tasks for a family with pagination support.
    
    Args:
        family_id: Unique identifier for the family
        limit: Maximum number of tasks to return (default: 50)
        include_completed: Whether to include completed tasks
        
    Returns:
        List of Task objects ordered by creation date (newest first)
        
    Raises:
        FamilyNotFoundError: If the family_id doesn't exist
        DatabaseError: If the database query fails
    """
    ...
```

**TypeScript:**
```typescript
// ❌ BAD
async function get(id: string, l?: number): Promise<any[]> { ... }

// ✅ GOOD
/**
 * Retrieve tasks for a family with pagination support.
 * 
 * @param familyId - Unique identifier for the family
 * @param options - Query options
 * @returns List of tasks ordered by creation date (newest first)
 * @throws {FamilyNotFoundError} If the family doesn't exist
 */
async function getTasks(
  familyId: string,
  options: {
    limit?: number;
    includeCompleted?: boolean;
  } = {}
): Promise<Task[]> {
  const { limit = 50, includeCompleted = false } = options;
  ...
}
```

**Java:**
```java
// ❌ BAD
public List<Object> get(String id, int l) { ... }

// ✅ GOOD
/**
 * Retrieve tasks for a family with pagination support.
 *
 * @param familyId Unique identifier for the family
 * @param limit Maximum number of tasks to return
 * @param includeCompleted Whether to include completed tasks
 * @return List of tasks ordered by creation date (newest first)
 * @throws FamilyNotFoundException if the family doesn't exist
 */
public List<Task> getTasks(
    String familyId,
    int limit,
    boolean includeCompleted
) throws FamilyNotFoundException {
    ...
}
```

**Go:**
```go
// ❌ BAD
func Get(id string, l int) ([]interface{}, error) { ... }

// ✅ GOOD
// GetTasks retrieves tasks for a family with pagination support.
// It returns tasks ordered by creation date (newest first).
// Returns ErrFamilyNotFound if the family doesn't exist.
func GetTasks(ctx context.Context, familyID string, opts TaskQueryOptions) ([]Task, error) {
    ...
}

// TaskQueryOptions configures the task query behavior.
type TaskQueryOptions struct {
    Limit            int  // Maximum tasks to return (default: 50)
    IncludeCompleted bool // Whether to include completed tasks
}
```

#### Error Handling

**Python:**
```python
# ✅ GOOD error handling
import logging

logger = logging.getLogger(__name__)

async def process_payment(payment_id: str) -> PaymentResult:
    try:
        payment = await payment_repository.get(payment_id)
        if not payment:
            raise PaymentNotFoundError(f"Payment {payment_id} not found")
        
        result = await payment_gateway.process(payment)
        
        logger.info(
            "Payment processed successfully",
            extra={"payment_id": payment_id, "amount": payment.amount}
        )
        return result
        
    except PaymentGatewayError as e:
        logger.error(
            "Payment gateway error",
            extra={"payment_id": payment_id, "error": str(e)},
            exc_info=True
        )
        raise PaymentProcessingError(f"Failed to process payment: {e}") from e
        
    except Exception as e:
        logger.exception(
            "Unexpected error processing payment",
            extra={"payment_id": payment_id}
        )
        raise
```

**TypeScript:**
```typescript
// ✅ GOOD error handling
import { logger } from './logging';

async function processPayment(paymentId: string): Promise<PaymentResult> {
  try {
    const payment = await paymentRepository.get(paymentId);
    if (!payment) {
      throw new PaymentNotFoundError(`Payment ${paymentId} not found`);
    }
    
    const result = await paymentGateway.process(payment);
    
    logger.info('Payment processed successfully', {
      paymentId,
      amount: payment.amount,
    });
    
    return result;
    
  } catch (error) {
    if (error instanceof PaymentGatewayError) {
      logger.error('Payment gateway error', {
        paymentId,
        error: error.message,
        stack: error.stack,
      });
      throw new PaymentProcessingError(`Failed to process payment: ${error.message}`, { cause: error });
    }
    
    logger.error('Unexpected error processing payment', {
      paymentId,
      error: error instanceof Error ? error.message : String(error),
    });
    throw error;
  }
}
```

**Go:**
```go
// ✅ GOOD error handling
func ProcessPayment(ctx context.Context, paymentID string) (*PaymentResult, error) {
    payment, err := paymentRepo.Get(ctx, paymentID)
    if err != nil {
        if errors.Is(err, ErrNotFound) {
            return nil, fmt.Errorf("payment %s not found: %w", paymentID, ErrPaymentNotFound)
        }
        return nil, fmt.Errorf("failed to retrieve payment %s: %w", paymentID, err)
    }
    
    result, err := paymentGateway.Process(ctx, payment)
    if err != nil {
        logger.Error("payment gateway error",
            "payment_id", paymentID,
            "error", err,
        )
        return nil, fmt.Errorf("failed to process payment %s: %w", paymentID, err)
    }
    
    logger.Info("payment processed successfully",
        "payment_id", paymentID,
        "amount", payment.Amount,
    )
    
    return result, nil
}
```

### 6.3 Common Patterns

#### Service Layer Pattern

```
┌─────────────────────────────────────────────────────────────────┐
│                      SERVICE LAYER PATTERN                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Services SHOULD:                                                │
│  ✅ Handle business logic                                        │
│  ✅ Coordinate between repositories and external services        │
│  ✅ Handle transactions and rollbacks                            │
│  ✅ Validate business rules                                      │
│  ✅ Emit events for cross-cutting concerns                       │
│  ✅ Handle errors gracefully with meaningful messages            │
│                                                                  │
│  Services SHOULD NOT:                                            │
│  ❌ Contain UI/presentation logic                                │
│  ❌ Access data stores directly (use repositories)               │
│  ❌ Know about HTTP/transport details                            │
│  ❌ Hold mutable state between calls                             │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Repository Pattern

```
┌─────────────────────────────────────────────────────────────────┐
│                     REPOSITORY PATTERN                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Repositories SHOULD:                                            │
│  ✅ Abstract data access details                                 │
│  ✅ Return domain objects, not raw data                          │
│  ✅ Handle connection management                                 │
│  ✅ Implement pagination consistently                            │
│  ✅ Handle query optimization                                    │
│                                                                  │
│  Repositories SHOULD NOT:                                        │
│  ❌ Contain business logic                                       │
│  ❌ Know about services or controllers                           │
│  ❌ Expose database-specific types                               │
│  ❌ Handle business validation                                   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Pagination Pattern

**Python:**
```python
from dataclasses import dataclass
from typing import Generic, TypeVar, Optional

T = TypeVar('T')

@dataclass
class Page(Generic[T]):
    items: list[T]
    total: int
    page: int
    page_size: int
    has_next: bool
    has_previous: bool

async def get_tasks(
    family_id: str,
    page: int = 1,
    page_size: int = 50,
    cursor: Optional[str] = None
) -> Page[Task]:
    """
    Retrieve paginated tasks.
    
    Supports both offset-based (page/page_size) and cursor-based pagination.
    Cursor-based is preferred for large datasets.
    """
    ...
```

**TypeScript:**
```typescript
interface Page<T> {
  items: T[];
  total: number;
  page: number;
  pageSize: number;
  hasNext: boolean;
  hasPrevious: boolean;
  nextCursor?: string;
}

async function getTasks(
  familyId: string,
  options: {
    page?: number;
    pageSize?: number;
    cursor?: string;
  } = {}
): Promise<Page<Task>> {
  const { page = 1, pageSize = 50, cursor } = options;
  // Implementation supports both offset and cursor pagination
  ...
}
```

---

## 7. Communication Standards

### 7.1 Status Updates

**Every status update must include EVIDENCE.**

| ❌ BAD Status | ✅ GOOD Status |
|---------------|----------------|
| "Working on it" | "Implementing pagination for TaskService. Completed query modification, now adding response mapping." |
| "Almost done" | "3 of 5 services updated. Currently on CalendarService. ETA: 15 minutes." |
| "Fixed" | "Fixed: Changed line 45 of auth.py from X to Y. Verified with unit tests (all 12 passing)." |
| "It should work" | "Verified working: Build succeeded (12:34:56), tests pass (47/47), app launches on test device." |

### 7.2 Testing Requests

**Only request human testing when YOU have verified functionality.**

```
❌ NEVER request testing:
- To verify your code compiles
- To find bugs you could find yourself
- Without running the code yourself first
- As a substitute for your own verification

✅ REQUEST testing when:
- You have verified the build succeeds
- You have verified basic functionality works
- You need validation of requirements/UX
- You need testing on environments you can't access
```

**Format for testing requests:**

```
TESTING REQUEST:

Changes Made:
- [List specific changes]

Verification Completed:
- Build: ✅ Succeeded at [timestamp]
- Tests: ✅ All [N] tests passing
- Lint: ✅ No errors
- Manual verification: ✅ [What you tested and observed]

Ready for Review:
- [Specific areas that need human validation]
- [Any known limitations or edge cases to check]
```

### 7.3 Problem Reporting

**When reporting problems, provide full context:**

```
PROBLEM REPORT:

Issue: [Clear description of the problem]

Observed Behavior: 
[What actually happened]

Expected Behavior:
[What should have happened]

Steps to Reproduce:
1. [Step 1]
2. [Step 2]
3. [Step 3]

Evidence:
- Error message: [exact message]
- Logs: [relevant log output]
- Stack trace: [if applicable]

Investigation Done:
- Checked: [What you already checked]
- Hypothesis: [Your best guess at the cause]
- Blockers: [What's preventing you from fixing it]

Proposed Solutions:
- Option A: [description]
- Option B: [description]
- Recommendation: [which option and why]
```

### 7.4 Asking for Help

```
HELP REQUEST:

Goal: [What I'm trying to accomplish]

Attempted:
1. [Approach 1] - Result: [outcome]
2. [Approach 2] - Result: [outcome]
3. [Approach 3] - Result: [outcome]

Current State:
- [What is working]
- [What is not working]

Specific Question:
[Clear, specific question about what you need help with]

Context Files:
- [file1.py - relevant because...]
- [file2.py - relevant because...]
```

### 7.5 Cross-Document Consistency

**Key claims must be consistent across all materials.**

When you make a statement of fact — a number, a date, a capability claim — that statement may exist in multiple documents. Inconsistency destroys credibility.

**Consistency Principles:**

1. **Identify Key Claims** — Numbers, dates, names, capabilities, status
2. **Single Source of Truth** — One authoritative document per claim type
3. **Audit on Change** — When updating a key claim, audit ALL related files

**Examples of Key Claims:**

| Claim Type | Example | Typical Locations |
|------------|---------|-------------------|
| Cost/Investment | "$500K seed round" | Pitch deck, executive summary, financial model |
| Timeline | "2 months to MVP" | Website, pitch deck, case studies |
| Team | "Chief Builder" | Team page, pitch deck, bios |
| Product Status | "Beta Ready" | Website, product pages, data room |
| Metrics | "140K lines of code" | Stats bar, pitch deck, technical review |

**Cross-Document Consistency Checklist:**

```
CONSISTENCY AUDIT (When updating key claims):

Claim being updated: [description]
New value: [new value]

Files to audit:
- [ ] Website pages: [list affected pages]
- [ ] Pitch deck: [checked/updated]
- [ ] Executive summary: [checked/updated]
- [ ] Financial model: [checked/updated]
- [ ] Other documents: [list]

Total instances found: [N]
Total instances updated: [N]
Conflicting versions remaining: [None / list]

REPORT: "Updated [claim] across [N] documents: [file list]"
```

**When to Perform Consistency Audits:**

- ✅ After any change to numbers (costs, metrics, projections)
- ✅ After any change to status (product stage, timeline)
- ✅ After any change to team/personnel descriptions
- ✅ After any change to key messaging or taglines
- ✅ Before any external release or presentation

---

## 8. Technical Excellence

### 8.1 Architecture Awareness

**Before making changes, understand:**

```
ARCHITECTURE CHECKLIST:

- [ ] What is the overall system architecture?
- [ ] What are the key services and their responsibilities?
- [ ] What is the data flow for this feature?
- [ ] What external dependencies exist?
- [ ] What are the performance characteristics?
- [ ] What are the security boundaries?
- [ ] What monitoring/logging exists?
```

### 8.2 Performance Considerations

**Always consider performance impact:**

| Concern | Questions to Ask |
|---------|------------------|
| **Data Access** | Am I making unnecessary database calls? Can I batch these? |
| **Caching** | Should this be cached? Is cached data fresh enough? |
| **Payload Size** | Am I returning more data than needed? Should I paginate? |
| **N+1 Queries** | Am I querying in a loop? Can I use a join or batch fetch? |
| **Memory** | Am I loading too much into memory? Should I stream? |
| **Concurrency** | Can these operations run in parallel? Is there contention? |

### 8.3 Security Considerations

**Security is not optional:**

| Concern | Verification |
|---------|--------------|
| **Input Validation** | Is all external input validated? |
| **Authentication** | Is the user authenticated for this action? |
| **Authorization** | Is the user authorized for this specific resource? |
| **Data Exposure** | Am I exposing sensitive data in logs/responses? |
| **Injection** | Are queries parameterized? Is output encoded? |
| **Secrets** | Are secrets stored securely? Not in code/logs? |

### 8.4 Responsive Design Verification

**Mobile-first is not optional for user-facing applications.**

Most users will experience your application on mobile first. Building desktop-first and retrofitting mobile is a recipe for poor UX and costly rework.

**The Mobile-First Principle:**

```
BUILD ORDER:
1. Mobile (320px-480px) — Start here, smallest constraint
2. Tablet (768px-1024px) — Add enhancements
3. Desktop (1024px+) — Full experience
4. Test ALL breakpoints before claiming completion
```

**Responsive Verification Checklist:**

```
RESPONSIVE VERIFICATION:

Mobile (320px-480px):
- [ ] Core functionality accessible
- [ ] Text readable without zooming (min 16px base)
- [ ] Touch targets adequate (min 44x44px)
- [ ] No horizontal scrolling
- [ ] Navigation accessible (hamburger menu, etc.)
- [ ] Forms usable with mobile keyboard

Tablet (768px-1024px):
- [ ] Layout adapts appropriately
- [ ] No awkward spacing or stretching
- [ ] Touch and mouse both work

Desktop (1024px+):
- [ ] Full experience available
- [ ] Efficient use of screen real estate
- [ ] Hover states work correctly

Cross-Cutting:
- [ ] Images responsive (srcset or CSS)
- [ ] Typography scales appropriately
- [ ] Grids collapse/expand correctly
- [ ] Modals/overlays work at all sizes
```

**Common Responsive Failures:**

| Failure | Symptom | Prevention |
|---------|---------|------------|
| Desktop-first thinking | Mobile looks "squished" | Build mobile layout first |
| Fixed widths | Content overflows on mobile | Use relative units, max-width |
| Tiny touch targets | Users can't tap buttons | Minimum 44x44px touch targets |
| Horizontal scroll | Layout broken on mobile | Test at 320px width |
| Unreadable text | Users zoom/pinch constantly | Minimum 16px base font size |

**Testing Protocol:**

1. **Browser DevTools** — Quick iteration at standard breakpoints
2. **Responsive mode** — Test custom widths, especially 320px
3. **Real devices** — Verify touch interactions, actual rendering
4. **Multiple browsers** — Safari iOS, Chrome Android at minimum

**Report Format:**

```
RESPONSIVE VERIFICATION COMPLETE:

- Mobile (375px): ✅ Verified [specific observations]
- Tablet (768px): ✅ Verified [specific observations]  
- Desktop (1440px): ✅ Verified [specific observations]
- Touch interactions: ✅ Tested on [device/emulator]

Issues found: [None / list]
Ready for review: [Yes/No]
```

---

## 9. Debugging & Troubleshooting

### 9.1 The Debugging Workflow

```
┌─────────────────────────────────────────────────────────────────┐
│                    DEBUGGING WORKFLOW                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. GATHER EVIDENCE                                              │
│     • Full error message and stack trace                         │
│     • Relevant log output (before and during error)              │
│     • System state (environment, config, data)                   │
│     • Recent changes (git log, deployments)                      │
│                                                                  │
│  2. ISOLATE THE PROBLEM                                          │
│     • Can you reproduce it consistently?                         │
│     • What's the minimal reproduction case?                      │
│     • Is it environment-specific?                                │
│     • When did it start? What changed?                           │
│                                                                  │
│  3. FORM HYPOTHESIS                                              │
│     • Based on evidence, what's most likely cause?               │
│     • What would prove/disprove this hypothesis?                 │
│                                                                  │
│  4. TEST HYPOTHESIS                                              │
│     • Make ONE minimal change to test                            │
│     • Observe result                                             │
│     • If wrong, update hypothesis with new data                  │
│                                                                  │
│  5. IMPLEMENT FIX                                                │
│     • Fix root cause, not symptom                                │
│     • Consider preventing recurrence                             │
│                                                                  │
│  6. VERIFY FIX                                                   │
│     • Original issue resolved?                                   │
│     • No new issues introduced?                                  │
│     • Tests updated/added?                                       │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 9.2 Common Issues Quick Reference

| Symptom | Likely Causes | First Checks |
|---------|---------------|--------------|
| "Module not found" | Missing dependency, wrong path, typo | Check imports, run dependency install |
| "Permission denied" | File permissions, missing credentials | Check file perms, env vars, secrets |
| "Connection refused" | Service not running, wrong port/host | Check service status, connection string |
| "Timeout" | Slow query, network issue, deadlock | Check query performance, network, locks |
| "Out of memory" | Memory leak, too much data loaded | Check data size, look for leaks |
| "Build failed" | Syntax error, type error, missing dep | Read error message, check recent changes |

### 9.3 Log Analysis

**When analyzing logs:**

```
1. Find the FIRST error - subsequent errors are often cascading failures
2. Note the timestamp - correlate with other events
3. Extract the stack trace - identify the code path
4. Look for patterns - is it repeating? intermittent?
5. Check context - what happened before the error?
```

---

## 10. Build & Deployment

### 10.1 Build Verification

**NEVER claim a build succeeded without evidence.**

```
BUILD VERIFICATION CHECKLIST:

- [ ] Build command executed completely (not interrupted)
- [ ] Build output shows success message
- [ ] Expected artifacts exist:
      - [ ] Binary/executable created
      - [ ] Correct size (not 0 bytes)
      - [ ] Correct location
- [ ] No warnings that indicate problems
- [ ] Version/build number is correct
```

### 10.2 Deployment Verification

```
DEPLOYMENT VERIFICATION CHECKLIST:

- [ ] Deployment command completed successfully
- [ ] Target environment received the deployment
- [ ] Application is running (health check passes)
- [ ] Logs show successful startup
- [ ] Critical functionality works (smoke test)
- [ ] Monitoring shows healthy metrics
```

### 10.3 Rollback Awareness

**Always know how to rollback:**

```
BEFORE deploying:
- Document current version
- Verify rollback procedure exists
- Know the rollback command/process
- Understand rollback implications (data migrations, etc.)

IF deployment fails:
1. Don't panic
2. Assess impact
3. Execute rollback if necessary
4. Investigate root cause
5. Fix and re-attempt
```

### 10.4 Third-Party Service Integration

**External services require controlled handoffs.**

AI agents cannot access external dashboards, billing systems, or service consoles. When integration requires configuration in third-party services, a structured handoff is essential.

**Integration Pattern:**

```
┌─────────────────────────────────────────────────────────────────┐
│              THIRD-PARTY INTEGRATION WORKFLOW                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. IDENTIFY     What steps require human action?               │
│        │         (Billing, auth, domains, templates)            │
│        ▼                                                         │
│  2. SEQUENCE     Order dependencies correctly                   │
│        │         (Can't deploy if billing not enabled)          │
│        ▼                                                         │
│  3. INSTRUCT     Provide exact navigation paths                 │
│        │         (Console → Project → Settings → ...)           │
│        ▼                                                         │
│  4. CONFIRM      Wait for user to confirm completion            │
│        │         (Don't assume, verify)                         │
│        ▼                                                         │
│  5. PROCEED      Continue with automated steps                  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

**Common Manual Steps by Service:**

| Service | Common Manual Steps |
|---------|---------------------|
| **Firebase** | Blaze plan upgrade, authorized domains, email templates, API keys |
| **Vercel** | Domain purchase, team settings, environment variables |
| **AWS** | IAM permissions, billing alerts, region selection |
| **Stripe** | Webhook endpoints, API keys, tax settings |
| **GitHub** | Repository visibility, branch protection, secrets |
| **Auth Providers** | OAuth app registration, redirect URIs, scopes |

**Handoff Format:**

```
MANUAL STEP REQUIRED:

Service: [Firebase/Vercel/AWS/etc.]
Action: [Specific action needed]

Steps:
1. Navigate to [exact URL or path]
2. Click [exact button/link]
3. Configure [specific setting]
4. [Additional steps as needed]

Why This Can't Be Automated:
[Brief explanation - billing, security, etc.]

What Happens After:
[What I'll do once this is confirmed]

⏳ Waiting for confirmation before proceeding.
```

**Dependency Documentation:**

When multiple manual steps exist, document the dependency chain:

```
THIRD-PARTY INTEGRATION PLAN:

Step 1: [Manual] Enable billing on Firebase
   └── Required for: Storage, Functions
   
Step 2: [Automated] Deploy Firestore rules
   └── Depends on: Step 1
   
Step 3: [Manual] Add authorized domain
   └── Required for: Authentication
   
Step 4: [Automated] Test authentication flow
   └── Depends on: Steps 1, 2, 3
```

**Post-Integration Verification:**

```
THIRD-PARTY INTEGRATION VERIFICATION:

Service: [name]
Manual steps completed: [list]
Automated steps completed: [list]

Verification:
- [ ] Service accessible from application
- [ ] Authentication working (if applicable)
- [ ] Data flowing correctly
- [ ] No console errors related to service
- [ ] Billing/quotas appropriate

Status: [Ready / Issues found]
```

### 10.5 CI/CD and Automation Patterns

**Automation reduces human toil and ensures consistency.**

When setting up or modifying CI/CD pipelines, follow these patterns to maximize reliability and minimize maintenance burden.

**GitHub Actions Structure:**

```yaml
# Standard workflow structure
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  # Job 1: Fast checks (lint, type-check)
  lint-and-typecheck:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      - run: npm ci
      - run: npm run lint
      - run: npx tsc --noEmit

  # Job 2: Build (depends on lint)
  build:
    needs: lint-and-typecheck
    steps:
      - run: npm run build

  # Job 3: Deploy (depends on build, only on main)
  deploy:
    needs: build
    if: github.ref == 'refs/heads/main'
    steps:
      - run: vercel deploy --prod
```

**Automation Categories:**

| Category | Tool | Purpose |
|----------|------|---------|
| Dependency Updates | Dependabot | Auto-PRs for outdated packages |
| Security Scanning | CodeQL | Vulnerability detection |
| Quality Gates | GitHub Actions | Lint, type-check, build |
| Auto-Deploy | Vercel/GitHub Actions | Deploy on merge to main |
| Performance | Lighthouse CI | Track Core Web Vitals |
| Error Tracking | Sentry | Production error monitoring |

**Secrets Management:**

```
SECRETS SETUP CHECKLIST:

1. Identify secrets needed:
   - [ ] API keys
   - [ ] Deployment tokens
   - [ ] Third-party service credentials

2. Add to GitHub Secrets (gh secret set):
   - [ ] Name follows convention: SERVICE_PURPOSE (e.g., VERCEL_TOKEN)
   - [ ] Value is current and valid
   - [ ] Scope is appropriate (repo vs org)

3. Reference in workflows:
   - [ ] Use ${{ secrets.SECRET_NAME }} syntax
   - [ ] Never echo or log secret values
   - [ ] Pass to env only when needed

4. Document in services log:
   - [ ] Secret name and purpose
   - [ ] Which workflow uses it
   - [ ] Rotation schedule (if any)
```

**CI/CD Setup Verification:**

```
CI/CD VERIFICATION:

Repository: [name]
Platform: [GitHub Actions / GitLab CI / etc.]

Workflows:
- [ ] Lint passes on PR
- [ ] Type-check passes on PR
- [ ] Build succeeds on PR
- [ ] Security scan runs weekly
- [ ] Auto-deploy triggers on main merge
- [ ] Dependabot creates PRs for updates

Secrets configured:
- [ ] [List each secret and its purpose]

Test run:
- [ ] Create test PR
- [ ] Verify all checks run
- [ ] Verify deployment (if applicable)
- [ ] Clean up test PR

Status: [Ready / Issues found]
```

**Dependabot Best Practices:**

```yaml
# dependabot.yml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
      day: "monday"
    # Group updates to reduce PR noise
    groups:
      production-dependencies:
        patterns: ["*"]
        exclude-patterns: ["@types/*", "eslint*"]
        update-types: ["minor", "patch"]
```

---

## 11. Version Control

### 11.1 Branch Strategy

```
┌─────────────────────────────────────────────────────────────────┐
│                     BRANCH STRATEGY                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  {{MAIN_BRANCH}}                                                 │
│  └── Production-ready code only                                  │
│      └── All code has been tested in QA                         │
│          └── Tagged with release versions                        │
│                                                                  │
│  {{QA_BRANCH}}                                                   │
│  └── QA/Staging environment                                      │
│      └── Merged from {{DEVELOPMENT_BRANCH}}                     │
│          └── Used for QA testing before production               │
│                                                                  │
│  {{DEVELOPMENT_BRANCH}}                                          │
│  └── Main development branch                                     │
│      └── All feature work merges here                            │
│          └── Integration testing happens here                    │
│                                                                  │
│  feature/*                                                       │
│  └── Individual feature branches                                 │
│      └── Branched from {{DEVELOPMENT_BRANCH}}                   │
│          └── Merged back to {{DEVELOPMENT_BRANCH}}              │
│                                                                  │
│  hotfix/*                                                        │
│  └── Emergency production fixes                                  │
│      └── Branched from {{MAIN_BRANCH}}                          │
│          └── Merged to {{MAIN_BRANCH}} AND {{DEVELOPMENT_BRANCH}}│
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 11.2 Branch Verification (Mandatory)

**BEFORE any commit, verify your branch:**

```
BRANCH VERIFICATION:

- [ ] Current branch: [output of branch check command]
- [ ] Expected branch for this work: [branch name]
- [ ] Branch is correct: [Yes/No]

IF WRONG BRANCH:
- [ ] Stash or commit current work
- [ ] Switch to correct branch
- [ ] Apply work to correct branch

REPORT: "Branch verified: [branch name]. Proceeding with commit."
```

### 11.3 Commit Standards

**Commit Message Format:**

```
<type>(<scope>): <short description>

<detailed description if needed>

<footer with references>
```

**Types:**
| Type | Use For |
|------|---------|
| `feat` | New features |
| `fix` | Bug fixes |
| `docs` | Documentation changes |
| `style` | Code style (formatting, semicolons, etc.) |
| `refactor` | Code refactoring (no functional change) |
| `perf` | Performance improvements |
| `test` | Adding or updating tests |
| `chore` | Maintenance tasks, dependency updates |

**Examples:**
```
feat(auth): add OAuth2 support for Google login

fix(calendar): resolve timezone offset in recurring events

docs(api): update authentication endpoint documentation

refactor(user-service): extract validation logic to separate module

chore(deps): upgrade database driver to v3.2.1
```

### 11.4 Pre-Commit Checklist

```
PRE-COMMIT CHECKLIST:

- [ ] On correct branch (verified with branch command)
- [ ] Changes are related to a single logical unit
- [ ] All tests pass
- [ ] Linting passes
- [ ] No debug code left in
- [ ] No sensitive data in code
- [ ] Commit message follows conventions
- [ ] Changes are what I intend to commit (reviewed diff)
```

---

## 12. Common Pitfalls & Solutions

### 12.1 Over-Engineering

**Problem:** Adding complexity that isn't needed.

**Symptoms:**
- Wrappers around simple operations
- Abstractions with only one implementation
- "Future-proofing" for hypothetical requirements
- Error handling for impossible scenarios

**Solution:**
```
BEFORE adding complexity, ask:
1. Does similar working code use this pattern?
2. Is there a documented requirement for this?
3. Will this be used more than once?
4. What's the simplest solution that works?

If ANY answer is uncertain → Keep it simple.
```

### 12.2 Assuming Success

**Problem:** Claiming something works without verification.

**Symptoms:**
- "It should work"
- "I don't see any errors"
- "The build finished"
- Running commands without reading output

**Solution:**
```
VERIFICATION REQUIREMENTS:
1. Watch the ENTIRE output of commands
2. Look for explicit SUCCESS messages
3. Verify artifacts exist and are valid
4. Test the actual functionality
5. Only then claim success with EVIDENCE
```

### 12.3 Scope Creep

**Problem:** Expanding beyond the requested change.

**Symptoms:**
- "While I'm here, I'll also..."
- Refactoring unrelated code
- Adding unrequested features
- "Improving" code style

**Solution:**
```
SCOPE CONTROL:
1. Do EXACTLY what was requested
2. If you see other issues, NOTE them separately
3. If changes are necessary for the task, explain WHY
4. Get approval before expanding scope
5. Separate commits for separate concerns
```

### 12.4 Inconsistent Patterns

**Problem:** Not following existing codebase conventions.

**Symptoms:**
- Different naming than existing code
- Different error handling patterns
- Different file/folder structure
- Different coding style

**Solution:**
```
PATTERN MATCHING PROCESS:
1. Find 2-3 similar existing implementations
2. Note their patterns for: naming, structure, error handling, comments
3. Use these as your template
4. Match them EXACTLY unless there's a documented reason not to
```

---

## 13. Quick Reference

### 13.1 Pre-Work Checklist

```
□ Read relevant sections of this guide
□ Understand the task completely
□ Search codebase for context and patterns
□ Verify correct branch
□ Complete Pre-Action Checklist
□ Plan approach before implementing
□ Validate any new technology choices (Rule 6)
```

### 13.2 During-Work Checklist

```
□ Make small, testable changes
□ Test after each significant change
□ Follow existing patterns exactly
□ Handle errors gracefully
□ Update task tracking as you progress
□ Never remove functionality without approval
□ Never implement workarounds without approval (Rule 5)
□ Test responsive design at key breakpoints
```

### 13.3 Post-Work Checklist

```
□ Build succeeds (with evidence)
□ Tests pass (with evidence)
□ Linting clean
□ Functionality verified working
□ Responsive design verified (mobile, tablet, desktop)
□ Cross-document consistency verified (if applicable)
□ Documentation updated if needed
□ Commit with proper message
□ Complete Post-Action Verification
□ Request review only when verified working
```

### 13.4 When Stuck

```
□ Gather all available information
□ Form hypothesis about cause
□ Test ONE thing at a time
□ Compare with working code
□ Search codebase for similar solutions
□ Consider framework/technology layer issues (Section 5.4)
□ Document what you've tried
□ Ask for help with full context
□ Never resort to workarounds without explicit approval
```

### 13.5 Third-Party Integration Quick Reference

```
□ Identify all manual steps required
□ Document dependency order
□ Provide exact navigation instructions
□ Wait for confirmation before proceeding
□ Verify integration after manual steps complete
```

### 13.6 New Rules Quick Reference (v3.0)

```
RULE 5: NO WORKAROUNDS
- Workaround = undiagnosed root cause
- Escalate blockers, don't work around them
- Document tech debt if workaround approved

RULE 6: VALIDATE TECHNOLOGY
- Check version stability before adoption
- Review breaking changes
- Test critical features in isolation
- Have a rollback plan
```

---

## Final Notes

### The Agent's Commitment

By working on this project, I commit to:

- **Excellence** — Delivering verified, working solutions
- **Integrity** — Never claiming success without evidence
- **Respect** — Valuing human time above AI convenience
- **Preservation** — Protecting existing functionality
- **Communication** — Providing clear, evidence-based updates
- **Continuity** — Documenting decisions for future agents

### Success Indicators

You're doing it right when:

- ✅ Every claim is backed by evidence
- ✅ Builds succeed on first attempt
- ✅ Human testing finds no surprises
- ✅ Existing functionality continues to work
- ✅ Documentation is current
- ✅ The next agent can continue seamlessly

---

**Document Version:** 3.1

**Version 3.1 Additions:**

| Addition | Origin | Impact |
|----------|--------|--------|
| Section 10.5: CI/CD and Automation | GitHub Actions + Vercel setup | Standardized automation patterns |

**Version 3.0 Additions (Battle-Tested):**

These additions were developed from real-world observations during the SCAINET website build:

| Addition | Origin | Impact |
|----------|--------|--------|
| Rule 5: No Workarounds | Firebase Storage region issue | Prevents tech debt accumulation |
| Rule 6: Technology Validation | Tailwind v4 opacity failures | Prevents costly framework rework |
| Section 5.4: Framework Layer Issues | Multi-hour debugging session | Faster root cause identification |
| Section 7.5: Cross-Document Consistency | Multiple doc updates for costs | Maintains credibility |
| Section 8.4: Responsive Design | Mobile fixes post-launch | Ensures mobile-first quality |
| Section 10.4: Third-Party Integration | Firebase manual steps | Smoother handoffs |

**Template Variables Required:**
- `{{PROJECT_NAME}}` - Name of the project
- `{{DOCUMENT_CREATED_DATE}}` - Original creation date
- `{{DOCUMENT_LAST_UPDATED}}` - Last update date
- `{{DOCUMENT_OWNER}}` - Document owner/maintainer
- `{{MAIN_BRANCH}}` - Main/production branch name (e.g., `main`, `master`)
- `{{QA_BRANCH}}` - QA/staging branch name (e.g., `release/qa`, `staging`)
- `{{DEVELOPMENT_BRANCH}}` - Development branch name (e.g., `develop`, `dev`)
