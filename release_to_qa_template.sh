#!/usr/bin/env bash
#
# Automated QA Release Deployment Script - Template
#
# DESCRIPTION:
#   A comprehensive, enterprise-grade script for automating QA releases.
#   This script handles the full release workflow:
#   - Branch management (merge from development to QA branch)
#   - Version incrementing
#   - Building the application
#   - Deploying to QA environment
#   - Notifying stakeholders
#
# USAGE:
#   ./release_to_qa.sh [OPTIONS]
#
# OPTIONS:
#   -n, --notes         Custom release notes (auto-generates from git if not provided)
#   --skip-merge        Skip the branch merge step
#   --skip-build        Skip the build step
#   --dry-run           Show what would be done without executing
#   -f, --force         Skip confirmation prompts
#   -h, --help          Show this help message
#
# EXAMPLES:
#   ./release_to_qa.sh
#   ./release_to_qa.sh -n "Hotfix for login issue"
#   ./release_to_qa.sh --skip-merge --dry-run
#
# CUSTOMIZATION:
#   Search for "{{CUSTOMIZE}}" to find sections needing project-specific configuration.
#
# Template Version: 2.0

set -euo pipefail

# ============================================================================
# CONFIGURATION - {{CUSTOMIZE}} these values for your project
# ============================================================================

# Project Information
PROJECT_NAME="{{PROJECT_NAME}}"

# Branch Configuration
DEVELOPMENT_BRANCH="{{DEVELOPMENT_BRANCH}}"  # e.g., "develop", "dev", "main"
QA_BRANCH="{{QA_BRANCH}}"                    # e.g., "release/qa", "staging", "qa"
MAIN_BRANCH="{{MAIN_BRANCH}}"                # e.g., "main", "master", "production"

# Version Configuration
VERSION_FILE="{{VERSION_FILE}}"              # e.g., "package.json", "pubspec.yaml", "VERSION"

# Build Configuration
CLEAN_COMMAND="{{CLEAN_COMMAND}}"
DEPENDENCY_COMMAND="{{DEPENDENCY_COMMAND}}"
BUILD_COMMAND="{{QA_BUILD_COMMAND}}"
TEST_COMMAND="{{TEST_COMMAND}}"

# Artifact Configuration
ARTIFACT_PATH="{{QA_ARTIFACT_PATH}}"

# Distribution Configuration
DISTRIBUTION_ENABLED=true
DISTRIBUTION_COMMAND="{{DISTRIBUTION_COMMAND}}"
DISTRIBUTION_TARGET="{{DISTRIBUTION_TARGET}}"
TESTER_GROUP="{{TESTER_GROUP}}"              # e.g., "qa-testers", "beta-testers"

# Notification Configuration
NOTIFICATION_ENABLED=false
NOTIFICATION_WEBHOOK="{{NOTIFICATION_WEBHOOK}}"

# Retry Configuration
MAX_RETRIES=2
RETRY_DELAY_SECONDS=5

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

print_banner() {
    local title="$1"
    local width=64
    local padding=$(( (width - ${#title} - 2) / 2 ))
    local padding_str=$(printf '%*s' "$padding" '')
    
    echo ""
    echo -e "${CYAN}╔$(printf '═%.0s' $(seq 1 $((width-2))))╗${NC}"
    printf "${CYAN}║%s%s%s║${NC}\n" "$padding_str" "$title" "$padding_str"
    echo -e "${CYAN}╚$(printf '═%.0s' $(seq 1 $((width-2))))╝${NC}"
}

print_step() {
    local number="$1"
    local description="$2"
    echo ""
    echo -e "${CYAN}[$number]${NC} $description"
    echo -e "${GRAY}$(printf '─%.0s' $(seq 1 50))${NC}"
}

print_info() {
    echo -e "${YELLOW}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_detail() {
    echo -e "${GRAY}   $1${NC}"
}

show_help() {
    head -35 "$0" | grep -E "^#" | sed 's/^# //' | sed 's/^#//'
    exit 0
}

# Safe command execution
invoke_safe_command() {
    local command="$1"
    local description="$2"
    local continue_on_error="${3:-false}"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        print_info "DRY RUN: Would execute: $command"
        return 0
    fi
    
    print_info "$description"
    print_detail "Command: $command"
    
    if eval "$command"; then
        return 0
    else
        if [[ "$continue_on_error" == "true" ]]; then
            print_warning "Command failed, continuing..."
            return 0
        fi
        print_error "Command failed"
        return 1
    fi
}

# Get current version
get_current_version() {
    # {{CUSTOMIZE}} - Implement version reading for your project
    
    if [[ -z "$VERSION_FILE" ]] || [[ "$VERSION_FILE" =~ ^\{\{.*\}\}$ ]] || [[ ! -f "$VERSION_FILE" ]]; then
        print_warning "Version file not configured or not found"
        echo "0.0.0+0"
        return
    fi
    
    local content
    content=$(cat "$VERSION_FILE")
    
    # package.json style: "version": "1.2.3"
    if echo "$content" | grep -qE '"version"[[:space:]]*:[[:space:]]*"[0-9]+\.[0-9]+\.[0-9]+"'; then
        echo "$content" | grep -oE '"version"[[:space:]]*:[[:space:]]*"[0-9]+\.[0-9]+\.[0-9]+"' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+'
        return
    fi
    
    # pubspec.yaml style: version: 1.2.3+4
    if echo "$content" | grep -qE '^version:[[:space:]]*[0-9]+\.[0-9]+\.[0-9]+\+[0-9]+'; then
        echo "$content" | grep -oE '^version:[[:space:]]*[0-9]+\.[0-9]+\.[0-9]+\+[0-9]+' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\+[0-9]+'
        return
    fi
    
    # Simple version file
    if echo "$content" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+'; then
        echo "$content" | head -1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+'
        return
    fi
    
    echo "0.0.0+0"
}

# Increment version
increment_version() {
    # {{CUSTOMIZE}} - Implement version incrementing for your project
    
    if [[ -z "$VERSION_FILE" ]] || [[ "$VERSION_FILE" =~ ^\{\{.*\}\}$ ]] || [[ ! -f "$VERSION_FILE" ]]; then
        print_warning "Version file not configured, skipping version increment"
        return
    fi
    
    if [[ "$DRY_RUN" == "true" ]]; then
        local current_version
        current_version=$(get_current_version)
        print_info "DRY RUN: Would increment version from $current_version"
        echo "$current_version"
        return
    fi
    
    local content
    content=$(cat "$VERSION_FILE")
    local new_version=""
    
    # pubspec.yaml style: version: 1.2.3+4 → 1.2.3+5
    if echo "$content" | grep -qE '^version:[[:space:]]*[0-9]+\.[0-9]+\.[0-9]+\+[0-9]+'; then
        local version_name build_number new_build_number
        version_name=$(echo "$content" | grep -oE '^version:[[:space:]]*[0-9]+\.[0-9]+\.[0-9]+' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
        build_number=$(echo "$content" | grep -oE '\+[0-9]+' | grep -oE '[0-9]+')
        new_build_number=$((build_number + 1))
        new_version="${version_name}+${new_build_number}"
        
        sed -i.bak "s/version:[[:space:]]*${version_name}+${build_number}/version: ${new_version}/" "$VERSION_FILE"
        rm -f "${VERSION_FILE}.bak"
        
        print_detail "Incremented: ${version_name}+${build_number} → $new_version"
        echo "$new_version"
        return
    fi
    
    # package.json style - increment patch version
    if echo "$content" | grep -qE '"version"[[:space:]]*:[[:space:]]*"[0-9]+\.[0-9]+\.[0-9]+"'; then
        local major minor patch
        local current_version
        current_version=$(echo "$content" | grep -oE '"version"[[:space:]]*:[[:space:]]*"[0-9]+\.[0-9]+\.[0-9]+"' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
        major=$(echo "$current_version" | cut -d. -f1)
        minor=$(echo "$current_version" | cut -d. -f2)
        patch=$(echo "$current_version" | cut -d. -f3)
        patch=$((patch + 1))
        new_version="${major}.${minor}.${patch}"
        
        sed -i.bak "s/\"version\"[[:space:]]*:[[:space:]]*\"${current_version}\"/\"version\": \"${new_version}\"/" "$VERSION_FILE"
        rm -f "${VERSION_FILE}.bak"
        
        print_detail "Incremented patch: ${current_version} → $new_version"
        echo "$new_version"
        return
    fi
    
    print_warning "Could not find version pattern to increment"
}

# Generate release notes
get_release_notes() {
    local custom_notes="$1"
    
    if [[ -n "$custom_notes" ]]; then
        echo "$custom_notes"
        return
    fi
    
    # Auto-generate from git
    local commit_hash commit_message commit_date commit_author branch_name recent_commits version
    commit_hash=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
    commit_message=$(git log -1 --pretty=format:"%s" 2>/dev/null || echo "unknown")
    commit_date=$(git log -1 --pretty=format:"%ad" --date=short 2>/dev/null || echo "unknown")
    commit_author=$(git log -1 --pretty=format:"%an" 2>/dev/null || echo "unknown")
    branch_name=$(git branch --show-current 2>/dev/null || echo "unknown")
    recent_commits=$(git log -5 --pretty=format:"• %s" --abbrev-commit 2>/dev/null || echo "")
    version=$(get_current_version)
    
    cat << EOF
QA Release Build - Ready for Testing

═══════════════════════════════════════════

BUILD INFO:
  Version: $version
  Branch: $branch_name
  Commit: $commit_hash
  Built: $(date '+%Y-%m-%d %H:%M')

LATEST CHANGE:
  $commit_message
  By: $commit_author ($commit_date)

RECENT UPDATES:
$recent_commits

═══════════════════════════════════════════

Please test thoroughly and report any issues.
EOF
}

# Send notification
send_notification() {
    local message="$1"
    local status="$2"  # "success", "failure"
    
    if [[ "$NOTIFICATION_ENABLED" != "true" ]]; then
        return
    fi
    
    # {{CUSTOMIZE}} - Implement notification for your project
    # Example Slack webhook:
    # curl -X POST -H 'Content-type: application/json' \
    #   --data "{\"text\":\"[$PROJECT_NAME] QA Release: $status\n$message\"}" \
    #   "$NOTIFICATION_WEBHOOK"
    
    print_info "Notification sent: $status"
}

# ============================================================================
# PARSE ARGUMENTS
# ============================================================================

NOTES=""
SKIP_MERGE=false
SKIP_BUILD=false
DRY_RUN=false
FORCE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--notes)
            NOTES="$2"
            shift 2
            ;;
        --skip-merge)
            SKIP_MERGE=true
            shift
            ;;
        --skip-build)
            SKIP_BUILD=true
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        -f|--force)
            FORCE=true
            shift
            ;;
        -h|--help)
            show_help
            ;;
        *)
            print_error "Unknown option: $1"
            exit 1
            ;;
    esac
done

# ============================================================================
# MAIN SCRIPT
# ============================================================================

START_TIME=$(date +%s)

# Display banner
print_banner "QA RELEASE AUTOMATION"
echo ""
echo "  Project:     $PROJECT_NAME"
echo "  Source:      $DEVELOPMENT_BRANCH"
echo "  Target:      $QA_BRANCH"
echo "  Testers:     $TESTER_GROUP"
if [[ "$DRY_RUN" == "true" ]]; then
    echo -e "  Mode:        ${YELLOW}DRY RUN (no changes will be made)${NC}"
fi
echo ""

# Confirmation prompt
if [[ "$FORCE" != "true" ]] && [[ "$DRY_RUN" != "true" ]]; then
    read -p "Proceed with QA release? (Y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Release cancelled by user"
        exit 0
    fi
fi

# Trap for cleanup on error
cleanup() {
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        END_TIME=$(date +%s)
        DURATION=$((END_TIME - START_TIME))
        MINUTES=$((DURATION / 60))
        SECONDS=$((DURATION % 60))
        
        echo ""
        print_banner "RELEASE FAILED"
        echo ""
        print_error "Error occurred during release"
        echo ""
        echo "  Duration: ${MINUTES}m ${SECONDS}s"
        echo ""
        echo "  Troubleshooting:"
        echo "  1. Check the error message above"
        echo "  2. Verify branch state: git status"
        echo "  3. Check for merge conflicts"
        echo "  4. Try with --dry-run to see what would happen"
        echo ""
        
        send_notification "QA Release failed" "failure"
    fi
}
trap cleanup EXIT

# Step 1: Pre-flight checks
print_step "1/9" "Pre-flight Checks"

# Check git
GIT_VERSION=$(git --version 2>/dev/null || true)
if [[ -z "$GIT_VERSION" ]]; then
    print_error "Git is not installed or not in PATH"
    exit 1
fi
print_success "Git: $GIT_VERSION"

# Check current branch
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "")
print_detail "Current branch: $CURRENT_BRANCH"

# Check for uncommitted changes
GIT_STATUS=$(git status --porcelain 2>/dev/null || echo "")
if [[ -n "$GIT_STATUS" ]]; then
    print_warning "You have uncommitted changes:"
    echo "$GIT_STATUS" | while read -r line; do
        print_detail "$line"
    done
    
    if [[ "$FORCE" != "true" ]]; then
        read -p "Continue anyway? (Y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_error "Uncommitted changes present. Commit or stash before release."
            exit 1
        fi
    fi
else
    print_success "Working directory is clean"
fi

# Step 2: Checkout QA branch
print_step "2/9" "Branch Management"

if [[ "$SKIP_MERGE" != "true" ]]; then
    # Fetch latest
    invoke_safe_command "git fetch origin" "Fetching latest from remote" "true"
    
    # Checkout QA branch
    if [[ "$QA_BRANCH" =~ ^\{\{.*\}\}$ ]]; then
        print_error "QA branch not configured. Update QA_BRANCH variable."
        exit 1
    fi
    
    if git branch --list "$QA_BRANCH" | grep -q "$QA_BRANCH"; then
        invoke_safe_command "git checkout $QA_BRANCH" "Checking out $QA_BRANCH"
    else
        invoke_safe_command "git checkout -b $QA_BRANCH origin/$QA_BRANCH" "Creating local $QA_BRANCH from origin"
    fi
    
    if [[ "$DRY_RUN" != "true" ]]; then
        invoke_safe_command "git pull origin $QA_BRANCH" "Pulling latest $QA_BRANCH" "true"
    fi
    
    print_success "On branch: $QA_BRANCH"
else
    print_info "Skipping merge (--skip-merge specified)"
fi

# Step 3: Merge development branch
print_step "3/9" "Merging Development Branch"

if [[ "$SKIP_MERGE" != "true" ]]; then
    if [[ "$DEVELOPMENT_BRANCH" =~ ^\{\{.*\}\}$ ]]; then
        print_error "Development branch not configured. Update DEVELOPMENT_BRANCH variable."
        exit 1
    fi
    
    # Fetch development branch
    invoke_safe_command "git fetch origin $DEVELOPMENT_BRANCH" "Fetching $DEVELOPMENT_BRANCH" "true"
    
    # Merge
    if ! invoke_safe_command "git merge origin/$DEVELOPMENT_BRANCH --no-edit --no-ff -m \"chore: Merge $DEVELOPMENT_BRANCH into $QA_BRANCH for QA release\"" "Merging $DEVELOPMENT_BRANCH"; then
        if [[ "$DRY_RUN" != "true" ]]; then
            print_error "Merge failed! Resolve conflicts manually:"
            print_detail "1. Run: git status"
            print_detail "2. Resolve conflicts in listed files"
            print_detail "3. Run: git add . && git commit"
            print_detail "4. Re-run this script with --skip-merge"
            exit 1
        fi
    fi
    
    print_success "Merge completed"
fi

# Step 4: Increment version
print_step "4/9" "Version Management"

PREVIOUS_VERSION=$(get_current_version)
print_detail "Current version: $PREVIOUS_VERSION"

NEW_VERSION=$(increment_version)
if [[ -n "$NEW_VERSION" ]]; then
    print_success "Version incremented to: $NEW_VERSION"
    
    # Commit version change
    if [[ "$DRY_RUN" != "true" ]] && [[ -n "$VERSION_FILE" ]] && [[ ! "$VERSION_FILE" =~ ^\{\{.*\}\}$ ]]; then
        git add "$VERSION_FILE" 2>/dev/null || true
        git commit -m "chore: Bump version to $NEW_VERSION for QA release" --no-verify 2>/dev/null || true
    fi
else
    print_warning "Version not incremented (not configured)"
    NEW_VERSION="$PREVIOUS_VERSION"
fi

# Step 5: Push changes
print_step "5/9" "Pushing Changes"

if [[ "$SKIP_MERGE" != "true" ]] && [[ "$DRY_RUN" != "true" ]]; then
    if invoke_safe_command "git push origin $QA_BRANCH" "Pushing to origin" "true"; then
        print_success "Changes pushed to remote"
    fi
else
    print_info "Skipping push (merge skipped or dry run)"
fi

# Step 6: Clean and prepare build
print_step "6/9" "Preparing Build Environment"

if [[ "$SKIP_BUILD" != "true" ]]; then
    # Clean
    if [[ -n "$CLEAN_COMMAND" ]] && [[ ! "$CLEAN_COMMAND" =~ ^\{\{.*\}\}$ ]]; then
        invoke_safe_command "$CLEAN_COMMAND" "Cleaning previous build" "true"
        sleep 2
    fi
    
    # Install dependencies
    if [[ -n "$DEPENDENCY_COMMAND" ]] && [[ ! "$DEPENDENCY_COMMAND" =~ ^\{\{.*\}\}$ ]]; then
        if ! invoke_safe_command "$DEPENDENCY_COMMAND" "Installing dependencies"; then
            print_error "Failed to install dependencies"
            exit 1
        fi
    fi
    
    print_success "Build environment ready"
else
    print_info "Skipping build preparation (--skip-build specified)"
fi

# Step 7: Build
print_step "7/9" "Building Application"

if [[ "$SKIP_BUILD" != "true" ]]; then
    if [[ -n "$BUILD_COMMAND" ]] && [[ ! "$BUILD_COMMAND" =~ ^\{\{.*\}\}$ ]]; then
        
        # Run tests first (if configured)
        if [[ -n "$TEST_COMMAND" ]] && [[ ! "$TEST_COMMAND" =~ ^\{\{.*\}\}$ ]]; then
            invoke_safe_command "$TEST_COMMAND" "Running tests" "true" || print_warning "Tests had issues, but continuing..."
        fi
        
        # Build with retry
        local attempt=0
        local build_success=false
        
        while [[ $attempt -lt $MAX_RETRIES ]] && [[ "$build_success" == "false" ]]; do
            ((attempt++)) || true
            
            if [[ $attempt -gt 1 ]]; then
                print_warning "Build attempt $attempt of $MAX_RETRIES..."
                sleep "$RETRY_DELAY_SECONDS"
            fi
            
            if invoke_safe_command "$BUILD_COMMAND" "Building (attempt $attempt)"; then
                build_success=true
            fi
        done
        
        if [[ "$build_success" != "true" ]] && [[ "$DRY_RUN" != "true" ]]; then
            print_error "Build failed after $MAX_RETRIES attempts"
            exit 1
        fi
        
        print_success "Build completed"
    else
        print_warning "Build command not configured"
    fi
else
    print_info "Skipping build (--skip-build specified)"
fi

# Step 8: Verify artifacts
print_step "8/9" "Verifying Artifacts"

if [[ -n "$ARTIFACT_PATH" ]] && [[ ! "$ARTIFACT_PATH" =~ ^\{\{.*\}\}$ ]] && [[ "$DRY_RUN" != "true" ]]; then
    if [[ -d "$ARTIFACT_PATH" ]]; then
        print_success "Artifacts found:"
        find "$ARTIFACT_PATH" -type f | head -3 | while read -r artifact; do
            size=$(du -h "$artifact" 2>/dev/null | cut -f1 || echo "?")
            print_detail "$(basename "$artifact") ($size)"
        done
    else
        print_warning "Artifact path does not exist: $ARTIFACT_PATH"
    fi
else
    print_info "Artifact verification skipped"
fi

# Step 9: Distribute
print_step "9/9" "Distributing to QA Testers"

if [[ "$DISTRIBUTION_ENABLED" == "true" ]] && [[ -n "$DISTRIBUTION_COMMAND" ]] && [[ ! "$DISTRIBUTION_COMMAND" =~ ^\{\{.*\}\}$ ]]; then
    
    # Generate release notes
    RELEASE_NOTES=$(get_release_notes "$NOTES")
    print_detail "Release notes generated"
    
    # Replace common placeholders
    DIST_CMD="$DISTRIBUTION_COMMAND"
    DIST_CMD="${DIST_CMD//\{\{ARTIFACT_PATH\}\}/$ARTIFACT_PATH}"
    DIST_CMD="${DIST_CMD//\{\{TESTER_GROUP\}\}/$TESTER_GROUP}"
    DIST_CMD="${DIST_CMD//\{\{VERSION\}\}/$NEW_VERSION}"
    
    if invoke_safe_command "$DIST_CMD" "Distributing to $TESTER_GROUP"; then
        print_success "Distribution completed!"
        print_detail "Testers will be notified"
    else
        print_warning "Distribution may have had issues. Check manually."
    fi
else
    print_info "Distribution not configured or disabled"
    print_detail "Artifacts are ready for manual distribution at: $ARTIFACT_PATH"
fi

# Summary
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))
MINUTES=$((DURATION / 60))
SECONDS=$((DURATION % 60))

echo ""
print_banner "RELEASE SUCCESSFUL"
echo ""
echo "  Summary:"
echo "  ────────────────────────────────"
echo "  Project:      $PROJECT_NAME"
echo "  Version:      $NEW_VERSION"
echo "  Branch:       $QA_BRANCH"
echo "  Testers:      $TESTER_GROUP"
echo "  Duration:     ${MINUTES}m ${SECONDS}s"
echo "  Artifacts:    $ARTIFACT_PATH"
echo ""

# Send notification
send_notification "QA Release $NEW_VERSION deployed successfully" "success"

# Clear the trap since we succeeded
trap - EXIT

exit 0

