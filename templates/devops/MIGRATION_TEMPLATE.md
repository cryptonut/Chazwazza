# Migration Planning & Execution Guide

> **Comprehensive template for database migrations, repository migrations, and infrastructure migrations**

**Document Owner:** {{DOCUMENT_OWNER}}  
**Created:** {{DOCUMENT_CREATED_DATE}}  
**Last Updated:** {{DOCUMENT_LAST_UPDATED}}  
**Version:** 1.0

---

## Table of Contents

1. [Migration Types](#1-migration-types)
2. [Pre-Migration Checklist](#2-pre-migration-checklist)
3. [Database Migrations](#3-database-migrations)
4. [Git Repository Migrations](#4-git-repository-migrations)
5. [Infrastructure Migrations](#5-infrastructure-migrations)
6. [Rollback Planning](#6-rollback-planning)
7. [Post-Migration Verification](#7-post-migration-verification)
8. [Lessons Learned Template](#8-lessons-learned-template)

---

## 1. Migration Types

### Common Migration Scenarios

| Type | Examples | Risk Level |
|------|----------|------------|
| **Database Schema** | Add column, change type, new index | Medium |
| **Database Migration** | MySQL → PostgreSQL, self-hosted → cloud | High |
| **Git Repository** | GitHub org transfer, repo rename, monorepo split | Medium |
| **Cloud Provider** | AWS → GCP, Heroku → Vercel | Very High |
| **Authentication** | Auth0 → Firebase, custom → OAuth | High |

---

## 2. Pre-Migration Checklist

### Risk Assessment

| Question | Answer | Risk if "No" |
|----------|--------|--------------|
| Is there a complete backup? | ☐ Yes / ☐ No | 🔴 Critical |
| Has the migration been tested in staging? | ☐ Yes / ☐ No | 🔴 Critical |
| Is there a rollback plan? | ☐ Yes / ☐ No | 🔴 Critical |
| Is downtime scheduled and communicated? | ☐ Yes / ☐ No | 🟡 Medium |
| Are all stakeholders notified? | ☐ Yes / ☐ No | 🟡 Medium |
| Is monitoring in place? | ☐ Yes / ☐ No | 🟡 Medium |

### Stakeholder Communication

```
Subject: [PLANNED] Migration - {{MIGRATION_NAME}} - {{DATE}}

Team,

We will be performing a migration of {{WHAT}} on {{DATE}} at {{TIME}}.

Expected Impact:
- Downtime: {{DURATION}}
- Affected Services: {{SERVICES}}
- User Impact: {{IMPACT}}

Timeline:
- Start: {{START_TIME}}
- Expected Completion: {{END_TIME}}
- Rollback Decision Point: {{ROLLBACK_TIME}}

Contact during migration: {{CONTACT}}

Thank you for your patience.
```

---

## 3. Database Migrations

### Schema Migration Best Practices

#### Rule 1: Always Make Migrations Reversible

```sql
-- Good: Reversible migration
-- Up
ALTER TABLE users ADD COLUMN middle_name VARCHAR(100);

-- Down
ALTER TABLE users DROP COLUMN middle_name;
```

#### Rule 2: Never Delete Columns Immediately

```
Phase 1: Stop writing to old column
Phase 2: Deploy code that reads from new column
Phase 3: Migrate data from old to new
Phase 4: Remove old column (weeks later)
```

#### Rule 3: Use Online DDL When Possible

```sql
-- PostgreSQL: Online index creation
CREATE INDEX CONCURRENTLY idx_users_email ON users(email);

-- MySQL: Online ALTER
ALTER TABLE users ADD COLUMN status VARCHAR(20), ALGORITHM=INPLACE, LOCK=NONE;
```

### Database Migration Script Template

```sql
-- Migration: {{MIGRATION_NAME}}
-- Author: {{AUTHOR}}
-- Date: {{DATE}}
-- Description: {{DESCRIPTION}}
-- 
-- Pre-requisites:
-- - Backup completed: {{BACKUP_LOCATION}}
-- - Estimated duration: {{DURATION}}
-- - Rollback script: {{ROLLBACK_FILE}}

-- ============================================================
-- PRE-MIGRATION CHECKS
-- ============================================================

-- Check current state
SELECT version();
SELECT count(*) as user_count FROM users;

-- Verify no active transactions (PostgreSQL)
SELECT * FROM pg_stat_activity WHERE state = 'active';

-- ============================================================
-- MIGRATION UP
-- ============================================================

BEGIN;

-- Step 1: Add new column
ALTER TABLE users ADD COLUMN email_verified BOOLEAN DEFAULT false;

-- Step 2: Add index
CREATE INDEX idx_users_email_verified ON users(email_verified);

-- Step 3: Backfill data (if needed)
UPDATE users SET email_verified = true WHERE confirmed_at IS NOT NULL;

-- Verify migration
SELECT 
    count(*) as total,
    count(*) FILTER (WHERE email_verified = true) as verified
FROM users;

COMMIT;

-- ============================================================
-- MIGRATION DOWN (ROLLBACK)
-- ============================================================

-- Uncomment to rollback:
-- BEGIN;
-- DROP INDEX IF EXISTS idx_users_email_verified;
-- ALTER TABLE users DROP COLUMN IF EXISTS email_verified;
-- COMMIT;

-- ============================================================
-- POST-MIGRATION VERIFICATION
-- ============================================================

-- Verify column exists
\d users

-- Verify data integrity
SELECT count(*) FROM users WHERE email_verified IS NULL;
```

### Full Database Migration (e.g., MySQL → PostgreSQL)

#### Phase 1: Assessment
- [ ] Identify all schema differences
- [ ] Map data types (e.g., `DATETIME` → `TIMESTAMP`)
- [ ] Identify stored procedures/functions
- [ ] List all indexes and constraints
- [ ] Document sequence/auto-increment usage

#### Phase 2: Schema Conversion

```python
# Example data type mapping
TYPE_MAP = {
    'TINYINT(1)': 'BOOLEAN',
    'DATETIME': 'TIMESTAMP',
    'TEXT': 'TEXT',
    'MEDIUMTEXT': 'TEXT',
    'LONGTEXT': 'TEXT',
    'INT(11)': 'INTEGER',
    'BIGINT(20)': 'BIGINT',
    'DOUBLE': 'DOUBLE PRECISION',
    'ENUM': 'VARCHAR(50)',  # Or create custom TYPE
}
```

#### Phase 3: Data Migration

```bash
# Export from MySQL
mysqldump -u user -p --compatible=postgresql database > export.sql

# Or use pgloader (recommended)
pgloader mysql://user:pass@localhost/mydb \
         postgresql://user:pass@localhost/newdb
```

#### Phase 4: Verification

```sql
-- Compare row counts
SELECT 'users' as table_name, count(*) FROM users
UNION ALL
SELECT 'orders', count(*) FROM orders;

-- Compare checksums (sample)
SELECT md5(string_agg(email, ',' ORDER BY id)) FROM users;
```

---

## 4. Git Repository Migrations

### Repository Transfer Checklist

Based on real-world migration learnings:

#### Pre-Transfer

- [ ] **Backup everything first**
  ```bash
  git clone --mirror git@github.com:old-org/repo.git
  tar -czvf repo-backup-$(date +%Y%m%d).tar.gz repo.git
  ```

- [ ] **Document all integrations**
  - CI/CD pipelines (GitHub Actions, CircleCI, etc.)
  - Webhooks
  - Deploy keys
  - Branch protection rules
  - Required reviewers
  - Secrets and environment variables

- [ ] **Update references in other repos**
  ```bash
  # Find all references
  grep -r "old-org/repo" . --include="*.md" --include="*.json" --include="*.yaml"
  ```

- [ ] **Notify all contributors**

#### Transfer Execution

```bash
# Method 1: GitHub Organization Transfer (preserves history, stars, etc.)
# Use GitHub UI: Settings → Transfer ownership

# Method 2: Mirror to new location (fresh start)
git clone --mirror git@github.com:old-org/repo.git
cd repo.git
git remote set-url origin git@github.com:new-org/repo.git
git push --mirror

# Method 3: Keep history, new repo
git clone git@github.com:old-org/repo.git
cd repo
git remote remove origin
git remote add origin git@github.com:new-org/new-repo.git
git push -u origin --all
git push origin --tags
```

#### Post-Transfer

- [ ] **Update git remotes on all developer machines**
  ```bash
  git remote set-url origin git@github.com:new-org/repo.git
  ```

- [ ] **Re-configure CI/CD**
  - Update repository settings
  - Re-add secrets
  - Update deployment targets

- [ ] **Update documentation**
  - README badges
  - Installation instructions
  - Clone URLs

- [ ] **Set up redirects** (if possible)
  - GitHub shows redirect notice for transferred repos

- [ ] **Archive old repository** (if not transferred)
  ```bash
  # Add deprecation notice to README
  # Set repo to archived
  ```

### Monorepo → Multi-repo Migration

```bash
# Extract subdirectory with history
git filter-branch --subdirectory-filter packages/my-package -- --all

# Or use git-filter-repo (recommended)
pip install git-filter-repo
git filter-repo --path packages/my-package/ --path-rename packages/my-package/:
```

### Multi-repo → Monorepo Migration

```bash
# Add repo as subdirectory with history
git remote add -f repo-b git@github.com:org/repo-b.git
git merge -s ours --no-commit --allow-unrelated-histories repo-b/main
git read-tree --prefix=packages/repo-b/ -u repo-b/main
git commit -m "Merge repo-b into monorepo"
```

---

## 5. Infrastructure Migrations

### Cloud Provider Migration Framework

#### Phase 1: Discovery (Week 1-2)
- [ ] Inventory all services
- [ ] Document dependencies
- [ ] Identify cloud-specific features
- [ ] Estimate costs on new provider
- [ ] Security/compliance requirements

#### Phase 2: Architecture Design (Week 2-3)
- [ ] Map services to new provider equivalents
- [ ] Design networking (VPCs, subnets)
- [ ] Plan data migration strategy
- [ ] Define monitoring/alerting
- [ ] Document rollback plan

#### Phase 3: Infrastructure Setup (Week 3-4)
- [ ] Set up IaC (Terraform/Pulumi)
- [ ] Configure networking
- [ ] Set up CI/CD pipelines
- [ ] Configure secrets management
- [ ] Set up logging/monitoring

#### Phase 4: Data Migration (Week 4-5)
- [ ] Database replication/sync
- [ ] Object storage migration
- [ ] DNS preparation (low TTL)
- [ ] Test data integrity

#### Phase 5: Cutover (Day X)
- [ ] Final data sync
- [ ] DNS switch
- [ ] Monitor closely
- [ ] Keep old infra running (rollback)

#### Phase 6: Decommission (Week 6+)
- [ ] Verify everything works
- [ ] Update documentation
- [ ] Terminate old resources
- [ ] Archive backups

### Service Mapping Example

| AWS Service | GCP Equivalent | Azure Equivalent |
|-------------|----------------|------------------|
| EC2 | Compute Engine | Virtual Machines |
| S3 | Cloud Storage | Blob Storage |
| RDS | Cloud SQL | Azure SQL |
| Lambda | Cloud Functions | Azure Functions |
| EKS | GKE | AKS |
| CloudFront | Cloud CDN | Azure CDN |
| Route 53 | Cloud DNS | Azure DNS |
| SQS | Pub/Sub | Service Bus |

---

## 6. Rollback Planning

### Rollback Decision Matrix

| Metric | Threshold | Action |
|--------|-----------|--------|
| Error rate | > 1% | Consider rollback |
| Error rate | > 5% | Immediate rollback |
| Latency (p99) | > 2x baseline | Investigate |
| Latency (p99) | > 5x baseline | Rollback |
| Data corruption | Any | Immediate rollback |

### Rollback Procedure Template

```markdown
## Rollback Procedure: {{MIGRATION_NAME}}

### Triggers
- [ ] Error rate exceeds 5%
- [ ] Critical feature broken
- [ ] Data integrity issues
- [ ] Performance degradation > 200%

### Steps
1. **Announce rollback** in #engineering channel
2. **Stop migration** (if in progress)
3. **Restore from backup**
   ```bash
   # Command to restore
   {{RESTORE_COMMAND}}
   ```
4. **Verify restoration**
   ```bash
   # Verification command
   {{VERIFY_COMMAND}}
   ```
5. **Update DNS/Load Balancer** (if applicable)
6. **Notify stakeholders**
7. **Create incident report**

### Estimated Rollback Time: {{TIME}}

### Contacts
- Primary: {{PRIMARY_CONTACT}}
- Secondary: {{SECONDARY_CONTACT}}
```

---

## 7. Post-Migration Verification

### Verification Checklist

#### Functionality
- [ ] All API endpoints responding
- [ ] Authentication/authorization working
- [ ] Database queries returning correct data
- [ ] File uploads/downloads working
- [ ] Background jobs running
- [ ] Webhooks firing

#### Performance
- [ ] Response times within SLA
- [ ] Database query performance acceptable
- [ ] No memory leaks
- [ ] CPU usage normal

#### Data Integrity
- [ ] Row counts match
- [ ] Checksums match (sample)
- [ ] No null values where unexpected
- [ ] Foreign key relationships intact

#### Security
- [ ] SSL certificates valid
- [ ] Firewall rules correct
- [ ] Access controls working
- [ ] Audit logging enabled

### Smoke Test Script Template

```bash
#!/bin/bash
# Post-migration smoke tests

BASE_URL="${1:-https://api.example.com}"
FAILED=0

test_endpoint() {
    local name=$1
    local endpoint=$2
    local expected_status=${3:-200}
    
    status=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL$endpoint")
    
    if [ "$status" -eq "$expected_status" ]; then
        echo "✅ $name: PASS (HTTP $status)"
    else
        echo "❌ $name: FAIL (expected $expected_status, got $status)"
        ((FAILED++))
    fi
}

echo "Running smoke tests against $BASE_URL"
echo "========================================"

test_endpoint "Health Check" "/health"
test_endpoint "API Root" "/api/v1"
test_endpoint "Users List" "/api/v1/users"
test_endpoint "Auth Required" "/api/v1/protected" 401

echo ""
if [ $FAILED -eq 0 ]; then
    echo "✅ All tests passed!"
    exit 0
else
    echo "❌ $FAILED test(s) failed!"
    exit 1
fi
```

---

## 8. Lessons Learned Template

### Migration Retrospective

Complete this after every significant migration:

```markdown
## Migration Retrospective: {{MIGRATION_NAME}}

**Date:** {{DATE}}
**Duration:** {{PLANNED}} planned / {{ACTUAL}} actual
**Participants:** {{PARTICIPANTS}}

### What Went Well
- 
- 
- 

### What Could Be Improved
- 
- 
- 

### Unexpected Issues
| Issue | Impact | Resolution | Prevention |
|-------|--------|------------|------------|
| | | | |

### Metrics
| Metric | Before | After | Change |
|--------|--------|-------|--------|
| Response Time (p50) | | | |
| Response Time (p99) | | | |
| Error Rate | | | |
| Database Size | | | |

### Action Items
- [ ] {{ACTION_1}}
- [ ] {{ACTION_2}}
- [ ] {{ACTION_3}}

### Documentation Updates Needed
- [ ] Update runbook
- [ ] Update architecture diagram
- [ ] Update monitoring dashboards
```

---

## Quick Reference

### Migration Commands Cheat Sheet

```bash
# PostgreSQL backup
pg_dump -Fc database_name > backup.dump

# PostgreSQL restore
pg_restore -d database_name backup.dump

# MySQL backup
mysqldump -u user -p database > backup.sql

# Git mirror backup
git clone --mirror repo_url backup.git

# Git update remote
git remote set-url origin new_url

# Docker image migration
docker save image:tag | gzip > image.tar.gz
docker load < image.tar.gz
```

---

**Template Version:** 1.0  
**Last Updated:** {{DOCUMENT_LAST_UPDATED}}

