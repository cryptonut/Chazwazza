#!/usr/bin/env bash
#
# Build and Distribute Application - Template Script
#
# DESCRIPTION:
#   A generic, enterprise-grade build and distribution script template.
#   Customize this script for your specific project's build and deployment needs.
#
# USAGE:
#   ./build_and_distribute.sh [OPTIONS]
#
# OPTIONS:
#   -e, --environment   Target environment: dev, qa, staging, prod (default: dev)
#   -m, --method        Distribution method: auto, manual, local (default: auto)
#   -s, --skip-tests    Skip running tests during build
#   -c, --clean         Perform a clean build
#   -v, --verbose       Enable verbose output
#   -h, --help          Show this help message
#
# EXAMPLES:
#   ./build_and_distribute.sh -e qa -m auto
#   ./build_and_distribute.sh -e prod -c -v
#
# CUSTOMIZATION:
#   Search for "{{CUSTOMIZE}}" comments to find sections needing project-specific configuration.
#
# Template Version: 2.0

set -euo pipefail

# ============================================================================
# CONFIGURATION - {{CUSTOMIZE}} these values for your project
# ============================================================================

# Project Information
PROJECT_NAME="{{PROJECT_NAME}}"

# Build Commands (per environment)
declare -A BUILD_COMMANDS=(
    ["dev"]="{{DEV_BUILD_COMMAND}}"        # e.g., "npm run build:dev"
    ["qa"]="{{QA_BUILD_COMMAND}}"          # e.g., "npm run build:qa"
    ["staging"]="{{STAGING_BUILD_COMMAND}}" # e.g., "npm run build:staging"
    ["prod"]="{{PROD_BUILD_COMMAND}}"      # e.g., "npm run build:prod"
)

# Artifact Paths (per environment)
declare -A ARTIFACT_PATHS=(
    ["dev"]="{{DEV_ARTIFACT_PATH}}"        # e.g., "dist/dev"
    ["qa"]="{{QA_ARTIFACT_PATH}}"          # e.g., "dist/qa"
    ["staging"]="{{STAGING_ARTIFACT_PATH}}" # e.g., "dist/staging"
    ["prod"]="{{PROD_ARTIFACT_PATH}}"      # e.g., "dist/prod"
)

# Distribution Commands (per environment)
declare -A DISTRIBUTION_COMMANDS=(
    ["dev"]="{{DEV_DISTRIBUTION_COMMAND}}"
    ["qa"]="{{QA_DISTRIBUTION_COMMAND}}"
    ["staging"]="{{STAGING_DISTRIBUTION_COMMAND}}"
    ["prod"]="{{PROD_DISTRIBUTION_COMMAND}}"
)

# Distribution Targets (URLs, servers, etc.)
declare -A DISTRIBUTION_TARGETS=(
    ["dev"]="{{DEV_DISTRIBUTION_TARGET}}"
    ["qa"]="{{QA_DISTRIBUTION_TARGET}}"
    ["staging"]="{{STAGING_DISTRIBUTION_TARGET}}"
    ["prod"]="{{PROD_DISTRIBUTION_TARGET}}"
)

# Other Commands
CLEAN_COMMAND="{{CLEAN_COMMAND}}"           # e.g., "npm run clean" or "rm -rf dist"
DEPENDENCY_COMMAND="{{DEPENDENCY_COMMAND}}" # e.g., "npm ci" or "pip install -r requirements.txt"
TEST_COMMAND="{{TEST_COMMAND}}"             # e.g., "npm test" or "pytest"
LINT_COMMAND="{{LINT_COMMAND}}"             # e.g., "npm run lint" or "flake8"

# Retry Configuration
MAX_RETRIES=2
RETRY_DELAY_SECONDS=5

# Notification Configuration
NOTIFICATION_ENABLED=false
NOTIFICATION_COMMAND="{{NOTIFICATION_COMMAND}}"

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

print_header() {
    echo ""
    echo -e "${CYAN}============================================================${NC}"
    echo -e "${CYAN} $1${NC}"
    echo -e "${CYAN}============================================================${NC}"
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
    head -30 "$0" | grep -E "^#" | sed 's/^# //' | sed 's/^#//'
    exit 0
}

# Execute command with retry logic
invoke_with_retry() {
    local command="$1"
    local description="$2"
    local max_retries="${3:-$MAX_RETRIES}"
    local retry_delay="${4:-$RETRY_DELAY_SECONDS}"
    
    local attempt=0
    local success=false
    
    while [[ $attempt -lt $max_retries ]] && [[ "$success" == "false" ]]; do
        ((attempt++)) || true
        
        if [[ $attempt -gt 1 ]]; then
            print_warning "Retry attempt $attempt of $max_retries for: $description"
            sleep "$retry_delay"
        fi
        
        print_info "Executing: $description"
        if [[ "$VERBOSE" == "true" ]]; then
            print_detail "Command: $command"
        fi
        
        if eval "$command"; then
            success=true
        else
            print_warning "Command exited with non-zero status"
        fi
    done
    
    [[ "$success" == "true" ]]
}

# Get version from common version files
get_version() {
    # {{CUSTOMIZE}} - Implement version retrieval for your project
    
    # Try package.json
    if [[ -f "package.json" ]]; then
        grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' package.json | grep -o '"[^"]*"$' | tr -d '"'
        return
    fi
    
    # Try VERSION file
    if [[ -f "VERSION" ]]; then
        head -1 VERSION | tr -d '[:space:]'
        return
    fi
    
    # Try setup.py
    if [[ -f "setup.py" ]]; then
        grep -o "version[[:space:]]*=[[:space:]]*['\"][^'\"]*['\"]" setup.py | grep -o "['\"][^'\"]*['\"]$" | tr -d "'\""
        return
    fi
    
    echo "0.0.0-unknown"
}

# Check prerequisites
check_prerequisites() {
    print_header "Checking Prerequisites"
    
    local all_passed=true
    
    # {{CUSTOMIZE}} - Add your project's prerequisites
    # Examples: node, npm, python, pip, java, gradle, docker, etc.
    
    local prerequisites=(
        # "node:node --version:true"
        # "npm:npm --version:true"
        # "python:python --version:true"
        # "docker:docker --version:false"
    )
    
    for prereq in "${prerequisites[@]}"; do
        IFS=':' read -r name command required <<< "$prereq"
        
        if output=$(eval "$command" 2>&1); then
            print_success "$name: $output"
        else
            if [[ "$required" == "true" ]]; then
                print_error "$name is required but not found!"
                all_passed=false
            else
                print_warning "$name not found (optional)"
            fi
        fi
    done
    
    [[ "$all_passed" == "true" ]]
}

# Send notification
send_notification() {
    local message="$1"
    local status="$2"  # "success", "failure", "warning"
    
    if [[ "$NOTIFICATION_ENABLED" != "true" ]]; then
        return
    fi
    
    # {{CUSTOMIZE}} - Implement notification for your project
    # Examples:
    # - Slack webhook: curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" "$WEBHOOK_URL"
    # - Email: mail -s "Build $status" recipients@example.com <<< "$message"
    
    print_info "Sending notification: $status"
}

# ============================================================================
# PARSE ARGUMENTS
# ============================================================================

ENVIRONMENT="dev"
METHOD="auto"
SKIP_TESTS=false
CLEAN=false
VERBOSE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--environment)
            ENVIRONMENT="$2"
            shift 2
            ;;
        -m|--method)
            METHOD="$2"
            shift 2
            ;;
        -s|--skip-tests)
            SKIP_TESTS=true
            shift
            ;;
        -c|--clean)
            CLEAN=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
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

# Validate environment
if [[ ! "$ENVIRONMENT" =~ ^(dev|qa|staging|prod)$ ]]; then
    print_error "Invalid environment: $ENVIRONMENT. Must be: dev, qa, staging, or prod"
    exit 1
fi

# Validate method
if [[ ! "$METHOD" =~ ^(auto|manual|local)$ ]]; then
    print_error "Invalid method: $METHOD. Must be: auto, manual, or local"
    exit 1
fi

# ============================================================================
# MAIN SCRIPT
# ============================================================================

START_TIME=$(date +%s)

# Display banner
echo ""
echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║           BUILD AND DISTRIBUTE AUTOMATION                  ║${NC}"
echo -e "${CYAN}║                                                            ║${NC}"
printf "${CYAN}║  Project: %-46s  ║${NC}\n" "$PROJECT_NAME"
printf "${CYAN}║  Environment: %-42s  ║${NC}\n" "$(echo "$ENVIRONMENT" | tr '[:lower:]' '[:upper:]')"
printf "${CYAN}║  Method: %-47s  ║${NC}\n" "$METHOD"
echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"

# Step 1: Check Prerequisites
if ! check_prerequisites; then
    print_error "Prerequisites check failed. Please install required tools."
    exit 1
fi

# Step 2: Clean (if requested)
if [[ "$CLEAN" == "true" ]]; then
    print_header "Cleaning Previous Build Artifacts"
    
    if [[ -n "$CLEAN_COMMAND" ]] && [[ "$CLEAN_COMMAND" != "{{CLEAN_COMMAND}}" ]]; then
        if invoke_with_retry "$CLEAN_COMMAND" "Clean build"; then
            print_success "Clean completed"
        else
            print_warning "Clean had issues, continuing anyway..."
        fi
    else
        print_warning "No clean command configured, skipping..."
    fi
fi

# Step 3: Install Dependencies
print_header "Installing Dependencies"

if [[ -n "$DEPENDENCY_COMMAND" ]] && [[ "$DEPENDENCY_COMMAND" != "{{DEPENDENCY_COMMAND}}" ]]; then
    if invoke_with_retry "$DEPENDENCY_COMMAND" "Install dependencies"; then
        print_success "Dependencies installed"
    else
        print_error "Failed to install dependencies"
        exit 1
    fi
else
    print_warning "No dependency command configured, skipping..."
fi

# Step 4: Lint Check
print_header "Running Lint Checks"

if [[ -n "$LINT_COMMAND" ]] && [[ "$LINT_COMMAND" != "{{LINT_COMMAND}}" ]]; then
    if invoke_with_retry "$LINT_COMMAND" "Lint check"; then
        print_success "Lint check passed"
    else
        print_warning "Lint check had issues"
    fi
else
    print_warning "No lint command configured, skipping..."
fi

# Step 5: Run Tests (unless skipped)
if [[ "$SKIP_TESTS" == "false" ]]; then
    print_header "Running Tests"
    
    if [[ -n "$TEST_COMMAND" ]] && [[ "$TEST_COMMAND" != "{{TEST_COMMAND}}" ]]; then
        if invoke_with_retry "$TEST_COMMAND" "Run tests"; then
            print_success "All tests passed"
        else
            if [[ "$ENVIRONMENT" == "prod" ]]; then
                print_error "Tests failed! Cannot proceed with production build."
                exit 1
            else
                print_warning "Tests failed, but continuing for $ENVIRONMENT environment..."
            fi
        fi
    else
        print_warning "No test command configured, skipping..."
    fi
else
    print_warning "Tests skipped by user request"
    if [[ "$ENVIRONMENT" == "prod" ]]; then
        print_warning "WARNING: Skipping tests for production build is not recommended!"
    fi
fi

# Step 6: Build
print_header "Building Application"

BUILD_COMMAND="${BUILD_COMMANDS[$ENVIRONMENT]:-}"

if [[ -n "$BUILD_COMMAND" ]] && [[ ! "$BUILD_COMMAND" =~ ^\{\{.*\}\}$ ]]; then
    if invoke_with_retry "$BUILD_COMMAND" "Build for $ENVIRONMENT"; then
        print_success "Build completed successfully"
    else
        print_error "Build failed after $MAX_RETRIES attempts"
        exit 1
    fi
else
    print_error "No build command configured for environment: $ENVIRONMENT"
    exit 1
fi

# Step 7: Verify Artifacts
print_header "Verifying Build Artifacts"

ARTIFACT_PATH="${ARTIFACT_PATHS[$ENVIRONMENT]:-}"

if [[ -n "$ARTIFACT_PATH" ]] && [[ ! "$ARTIFACT_PATH" =~ ^\{\{.*\}\}$ ]]; then
    if [[ -d "$ARTIFACT_PATH" ]]; then
        print_success "Artifacts found at: $ARTIFACT_PATH"
        
        # List first 5 artifacts
        find "$ARTIFACT_PATH" -type f | head -5 | while read -r artifact; do
            size=$(du -h "$artifact" | cut -f1)
            print_detail "$(basename "$artifact") ($size)"
        done
    else
        print_error "Artifact path does not exist: $ARTIFACT_PATH"
        exit 1
    fi
else
    print_warning "No artifact path configured, skipping verification..."
fi

# Step 8: Distribute (based on method)
print_header "Distributing Build"

case "$METHOD" in
    auto)
        print_info "Using automated distribution..."
        
        DIST_COMMAND="${DISTRIBUTION_COMMANDS[$ENVIRONMENT]:-}"
        
        if [[ -n "$DIST_COMMAND" ]] && [[ ! "$DIST_COMMAND" =~ ^\{\{.*\}\}$ ]]; then
            if invoke_with_retry "$DIST_COMMAND" "Distribute to $ENVIRONMENT"; then
                print_success "Distribution completed"
                
                TARGET="${DISTRIBUTION_TARGETS[$ENVIRONMENT]:-}"
                if [[ -n "$TARGET" ]] && [[ ! "$TARGET" =~ ^\{\{.*\}\}$ ]]; then
                    print_detail "Target: $TARGET"
                fi
            else
                print_error "Distribution failed after $MAX_RETRIES attempts"
                exit 1
            fi
        else
            print_warning "No distribution command configured for $ENVIRONMENT"
            print_info "Falling back to manual method..."
            METHOD="manual"
        fi
        ;;
        
    manual)
        print_info "Manual distribution mode"
        echo ""
        echo "   Build artifacts are ready at: $ARTIFACT_PATH"
        echo ""
        echo "   Manual distribution steps:"
        echo "   1. Navigate to your distribution platform"
        echo "   2. Upload the build artifacts"
        echo "   3. Configure release settings"
        echo "   4. Publish/Deploy"
        
        TARGET="${DISTRIBUTION_TARGETS[$ENVIRONMENT]:-}"
        if [[ -n "$TARGET" ]] && [[ ! "$TARGET" =~ ^\{\{.*\}\}$ ]]; then
            echo ""
            print_detail "Distribution target: $TARGET"
        fi
        ;;
        
    local)
        print_info "Local deployment mode"
        print_success "Build is ready for local testing at: $ARTIFACT_PATH"
        ;;
esac

# Step 9: Summary
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))
MINUTES=$((DURATION / 60))
SECONDS=$((DURATION % 60))

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                    BUILD SUCCESSFUL                        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "   Summary:"
echo "   - Environment: $ENVIRONMENT"
echo "   - Method: $METHOD"
echo "   - Version: $(get_version)"
echo "   - Duration: ${MINUTES}m ${SECONDS}s"
echo "   - Artifacts: $ARTIFACT_PATH"
echo ""

# Send success notification
send_notification "Build for $ENVIRONMENT completed successfully" "success"

exit 0

