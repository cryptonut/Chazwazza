<#
.SYNOPSIS
    Build and Distribute Application - Template Script
    
.DESCRIPTION
    A generic, enterprise-grade build and distribution script template.
    Customize this script for your specific project's build and deployment needs.
    
.PARAMETER Environment
    Target environment: dev, qa, staging, prod
    
.PARAMETER Method
    Distribution method: auto, manual, local
    
.PARAMETER SkipTests
    Skip running tests during build (not recommended for production)
    
.PARAMETER Clean
    Perform a clean build (remove all previous artifacts)
    
.PARAMETER Verbose
    Enable verbose output for debugging
    
.EXAMPLE
    .\build_and_distribute.ps1 -Environment qa -Method auto
    
.EXAMPLE
    .\build_and_distribute.ps1 -Environment prod -Clean -Verbose
    
.NOTES
    Template Version: 2.0
    
    CUSTOMIZATION REQUIRED:
    Search for "{{CUSTOMIZE}}" comments to find sections that need project-specific configuration.
    
    Template Variables Used:
    - {{PROJECT_NAME}} - Name of your project
    - {{BUILD_COMMAND}} - Your project's build command
    - {{TEST_COMMAND}} - Your project's test command
    - {{ARTIFACT_PATH}} - Path to build artifacts
    - {{DISTRIBUTION_COMMAND}} - Command to distribute builds
#>

[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [ValidateSet("dev", "qa", "staging", "prod")]
    [string]$Environment = "dev",
    
    [Parameter(Position = 1)]
    [ValidateSet("auto", "manual", "local")]
    [string]$Method = "auto",
    
    [Parameter()]
    [switch]$SkipTests,
    
    [Parameter()]
    [switch]$Clean,
    
    [Parameter()]
    [switch]$VerboseOutput
)

#region Configuration
# ============================================================================
# CONFIGURATION - {{CUSTOMIZE}} these values for your project
# ============================================================================

$Config = @{
    # Project Information
    ProjectName = "{{PROJECT_NAME}}"
    
    # Build Configuration
    BuildCommands = @{
        dev     = "{{DEV_BUILD_COMMAND}}"      # e.g., "npm run build:dev"
        qa      = "{{QA_BUILD_COMMAND}}"       # e.g., "npm run build:qa"
        staging = "{{STAGING_BUILD_COMMAND}}"  # e.g., "npm run build:staging"
        prod    = "{{PROD_BUILD_COMMAND}}"     # e.g., "npm run build:prod"
    }
    
    # Artifact Paths
    ArtifactPaths = @{
        dev     = "{{DEV_ARTIFACT_PATH}}"      # e.g., "dist/dev"
        qa      = "{{QA_ARTIFACT_PATH}}"       # e.g., "dist/qa"
        staging = "{{STAGING_ARTIFACT_PATH}}"  # e.g., "dist/staging"
        prod    = "{{PROD_ARTIFACT_PATH}}"     # e.g., "dist/prod"
    }
    
    # Clean Commands
    CleanCommand = "{{CLEAN_COMMAND}}"          # e.g., "npm run clean" or "rm -rf dist"
    
    # Dependency Commands
    DependencyCommand = "{{DEPENDENCY_COMMAND}}" # e.g., "npm ci" or "pip install -r requirements.txt"
    
    # Test Commands
    TestCommand = "{{TEST_COMMAND}}"            # e.g., "npm test" or "pytest"
    
    # Lint Commands
    LintCommand = "{{LINT_COMMAND}}"            # e.g., "npm run lint" or "flake8"
    
    # Distribution Configuration
    DistributionCommands = @{
        dev     = "{{DEV_DISTRIBUTION_COMMAND}}"
        qa      = "{{QA_DISTRIBUTION_COMMAND}}"
        staging = "{{STAGING_DISTRIBUTION_COMMAND}}"
        prod    = "{{PROD_DISTRIBUTION_COMMAND}}"
    }
    
    # Distribution Targets (URLs, servers, etc.)
    DistributionTargets = @{
        dev     = "{{DEV_DISTRIBUTION_TARGET}}"
        qa      = "{{QA_DISTRIBUTION_TARGET}}"
        staging = "{{STAGING_DISTRIBUTION_TARGET}}"
        prod    = "{{PROD_DISTRIBUTION_TARGET}}"
    }
    
    # Notification Configuration
    NotificationEnabled = $false                 # Set to $true to enable notifications
    NotificationCommand = "{{NOTIFICATION_COMMAND}}"
    
    # Retry Configuration
    MaxRetries = 2
    RetryDelaySeconds = 5
}

#endregion

#region Helper Functions
# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

function Write-StepHeader {
    param([string]$Message)
    Write-Host "`n" -NoNewline
    Write-Host "=" * 60 -ForegroundColor Cyan
    Write-Host " $Message" -ForegroundColor Cyan
    Write-Host "=" * 60 -ForegroundColor Cyan
}

function Write-StepInfo {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Yellow
}

function Write-StepSuccess {
    param([string]$Message)
    Write-Host "[OK] $Message" -ForegroundColor Green
}

function Write-StepError {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Write-StepWarning {
    param([string]$Message)
    Write-Host "[WARN] $Message" -ForegroundColor Yellow
}

function Invoke-CommandWithRetry {
    param(
        [string]$Command,
        [string]$Description,
        [int]$MaxRetries = $Config.MaxRetries,
        [int]$RetryDelay = $Config.RetryDelaySeconds
    )
    
    $attempt = 0
    $success = $false
    
    while ($attempt -lt $MaxRetries -and -not $success) {
        $attempt++
        
        if ($attempt -gt 1) {
            Write-StepWarning "Retry attempt $attempt of $MaxRetries for: $Description"
            Start-Sleep -Seconds $RetryDelay
        }
        
        Write-StepInfo "Executing: $Description"
        if ($VerboseOutput) {
            Write-Host "   Command: $Command" -ForegroundColor Gray
        }
        
        try {
            Invoke-Expression $Command
            
            if ($LASTEXITCODE -eq 0) {
                $success = $true
            } else {
                Write-StepWarning "Command exited with code: $LASTEXITCODE"
            }
        }
        catch {
            Write-StepWarning "Command threw exception: $_"
        }
    }
    
    return $success
}

function Get-VersionInfo {
    # {{CUSTOMIZE}} - Implement version retrieval for your project
    # Examples:
    # - Read from package.json: (Get-Content package.json | ConvertFrom-Json).version
    # - Read from version file: Get-Content VERSION
    # - Read from setup.py: Select-String -Path setup.py -Pattern "version="
    
    try {
        # Example: Read version from a JSON file
        if (Test-Path "package.json") {
            $packageJson = Get-Content "package.json" | ConvertFrom-Json
            return $packageJson.version
        }
        
        # Example: Read version from VERSION file
        if (Test-Path "VERSION") {
            return (Get-Content "VERSION" -First 1).Trim()
        }
        
        # Fallback
        return "0.0.0-unknown"
    }
    catch {
        return "0.0.0-unknown"
    }
}

function Test-Prerequisites {
    Write-StepHeader "Checking Prerequisites"
    
    $allPassed = $true
    
    # {{CUSTOMIZE}} - Add your project's prerequisites
    # Examples: node, npm, python, pip, java, gradle, docker, etc.
    
    $prerequisites = @(
        # @{ Name = "node"; Command = "node --version"; Required = $true }
        # @{ Name = "npm"; Command = "npm --version"; Required = $true }
        # @{ Name = "python"; Command = "python --version"; Required = $true }
        # @{ Name = "docker"; Command = "docker --version"; Required = $false }
    )
    
    foreach ($prereq in $prerequisites) {
        try {
            $result = Invoke-Expression $prereq.Command 2>&1
            Write-StepSuccess "$($prereq.Name): $result"
        }
        catch {
            if ($prereq.Required) {
                Write-StepError "$($prereq.Name) is required but not found!"
                $allPassed = $false
            } else {
                Write-StepWarning "$($prereq.Name) not found (optional)"
            }
        }
    }
    
    return $allPassed
}

function Send-Notification {
    param(
        [string]$Message,
        [string]$Status  # "success", "failure", "warning"
    )
    
    if (-not $Config.NotificationEnabled) {
        return
    }
    
    # {{CUSTOMIZE}} - Implement notification for your project
    # Examples:
    # - Slack webhook: Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $payload
    # - Email: Send-MailMessage -To $recipients -Subject $subject -Body $Message
    # - Teams webhook: Similar to Slack
    
    Write-StepInfo "Sending notification: $Status"
    
    try {
        # Invoke-Expression ($Config.NotificationCommand -replace "{{MESSAGE}}", $Message -replace "{{STATUS}}", $Status)
        Write-StepSuccess "Notification sent"
    }
    catch {
        Write-StepWarning "Failed to send notification: $_"
    }
}

#endregion

#region Main Script
# ============================================================================
# MAIN SCRIPT
# ============================================================================

$ErrorActionPreference = "Stop"
$startTime = Get-Date

# Display banner
Write-Host "`n" -NoNewline
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║           BUILD AND DISTRIBUTE AUTOMATION                  ║" -ForegroundColor Cyan
Write-Host "║                                                            ║" -ForegroundColor Cyan
Write-Host "║  Project: $($Config.ProjectName.PadRight(46))║" -ForegroundColor Cyan
Write-Host "║  Environment: $($Environment.ToUpper().PadRight(42))║" -ForegroundColor Cyan
Write-Host "║  Method: $($Method.PadRight(47))║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

try {
    # Step 1: Check Prerequisites
    if (-not (Test-Prerequisites)) {
        throw "Prerequisites check failed. Please install required tools."
    }
    
    # Step 2: Clean (if requested)
    if ($Clean) {
        Write-StepHeader "Cleaning Previous Build Artifacts"
        
        if ($Config.CleanCommand -and $Config.CleanCommand -ne "{{CLEAN_COMMAND}}") {
            $cleanSuccess = Invoke-CommandWithRetry -Command $Config.CleanCommand -Description "Clean build"
            if ($cleanSuccess) {
                Write-StepSuccess "Clean completed"
            } else {
                Write-StepWarning "Clean had issues, continuing anyway..."
            }
        } else {
            Write-StepWarning "No clean command configured, skipping..."
        }
    }
    
    # Step 3: Install Dependencies
    Write-StepHeader "Installing Dependencies"
    
    if ($Config.DependencyCommand -and $Config.DependencyCommand -ne "{{DEPENDENCY_COMMAND}}") {
        $depSuccess = Invoke-CommandWithRetry -Command $Config.DependencyCommand -Description "Install dependencies"
        if ($depSuccess) {
            Write-StepSuccess "Dependencies installed"
        } else {
            throw "Failed to install dependencies"
        }
    } else {
        Write-StepWarning "No dependency command configured, skipping..."
    }
    
    # Step 4: Lint Check
    Write-StepHeader "Running Lint Checks"
    
    if ($Config.LintCommand -and $Config.LintCommand -ne "{{LINT_COMMAND}}") {
        $lintSuccess = Invoke-CommandWithRetry -Command $Config.LintCommand -Description "Lint check"
        if ($lintSuccess) {
            Write-StepSuccess "Lint check passed"
        } else {
            Write-StepWarning "Lint check had issues"
        }
    } else {
        Write-StepWarning "No lint command configured, skipping..."
    }
    
    # Step 5: Run Tests (unless skipped)
    if (-not $SkipTests) {
        Write-StepHeader "Running Tests"
        
        if ($Config.TestCommand -and $Config.TestCommand -ne "{{TEST_COMMAND}}") {
            $testSuccess = Invoke-CommandWithRetry -Command $Config.TestCommand -Description "Run tests"
            if ($testSuccess) {
                Write-StepSuccess "All tests passed"
            } else {
                if ($Environment -eq "prod") {
                    throw "Tests failed! Cannot proceed with production build."
                } else {
                    Write-StepWarning "Tests failed, but continuing for $Environment environment..."
                }
            }
        } else {
            Write-StepWarning "No test command configured, skipping..."
        }
    } else {
        Write-StepWarning "Tests skipped by user request"
        if ($Environment -eq "prod") {
            Write-StepWarning "WARNING: Skipping tests for production build is not recommended!"
        }
    }
    
    # Step 6: Build
    Write-StepHeader "Building Application"
    
    $buildCommand = $Config.BuildCommands[$Environment]
    
    if ($buildCommand -and $buildCommand -notmatch "^\{\{.*\}\}$") {
        $buildSuccess = Invoke-CommandWithRetry -Command $buildCommand -Description "Build for $Environment"
        if ($buildSuccess) {
            Write-StepSuccess "Build completed successfully"
        } else {
            throw "Build failed after $($Config.MaxRetries) attempts"
        }
    } else {
        throw "No build command configured for environment: $Environment"
    }
    
    # Step 7: Verify Artifacts
    Write-StepHeader "Verifying Build Artifacts"
    
    $artifactPath = $Config.ArtifactPaths[$Environment]
    
    if ($artifactPath -and $artifactPath -notmatch "^\{\{.*\}\}$") {
        if (Test-Path $artifactPath) {
            $artifacts = Get-ChildItem $artifactPath -Recurse -File | Select-Object -First 5
            Write-StepSuccess "Artifacts found at: $artifactPath"
            
            foreach ($artifact in $artifacts) {
                $size = [math]::Round($artifact.Length / 1KB, 2)
                Write-Host "   - $($artifact.Name) ($size KB)" -ForegroundColor Gray
            }
        } else {
            throw "Artifact path does not exist: $artifactPath"
        }
    } else {
        Write-StepWarning "No artifact path configured, skipping verification..."
    }
    
    # Step 8: Distribute (based on method)
    Write-StepHeader "Distributing Build"
    
    switch ($Method) {
        "auto" {
            Write-StepInfo "Using automated distribution..."
            
            $distCommand = $Config.DistributionCommands[$Environment]
            
            if ($distCommand -and $distCommand -notmatch "^\{\{.*\}\}$") {
                $distSuccess = Invoke-CommandWithRetry -Command $distCommand -Description "Distribute to $Environment"
                if ($distSuccess) {
                    Write-StepSuccess "Distribution completed"
                    
                    $target = $Config.DistributionTargets[$Environment]
                    if ($target -and $target -notmatch "^\{\{.*\}\}$") {
                        Write-Host "`n   Target: $target" -ForegroundColor Gray
                    }
                } else {
                    throw "Distribution failed after $($Config.MaxRetries) attempts"
                }
            } else {
                Write-StepWarning "No distribution command configured for $Environment"
                Write-StepInfo "Falling back to manual method..."
                $Method = "manual"
            }
        }
        
        "manual" {
            Write-StepInfo "Manual distribution mode"
            Write-Host "`n   Build artifacts are ready at: $artifactPath" -ForegroundColor White
            Write-Host "`n   Manual distribution steps:" -ForegroundColor Yellow
            Write-Host "   1. Navigate to your distribution platform" -ForegroundColor White
            Write-Host "   2. Upload the build artifacts" -ForegroundColor White
            Write-Host "   3. Configure release settings" -ForegroundColor White
            Write-Host "   4. Publish/Deploy" -ForegroundColor White
            
            $target = $Config.DistributionTargets[$Environment]
            if ($target -and $target -notmatch "^\{\{.*\}\}$") {
                Write-Host "`n   Distribution target: $target" -ForegroundColor Gray
            }
            
            # Open artifact location
            if ($artifactPath -and (Test-Path $artifactPath)) {
                $openFolder = Read-Host "`n   Open artifact folder? (Y/N)"
                if ($openFolder -eq "Y" -or $openFolder -eq "y") {
                    explorer.exe $artifactPath
                }
            }
        }
        
        "local" {
            Write-StepInfo "Local deployment mode"
            Write-StepSuccess "Build is ready for local testing at: $artifactPath"
        }
    }
    
    # Step 9: Summary
    $endTime = Get-Date
    $duration = $endTime - $startTime
    
    Write-Host "`n" -NoNewline
    Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║                    BUILD SUCCESSFUL                        ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host "`n   Summary:" -ForegroundColor White
    Write-Host "   - Environment: $Environment" -ForegroundColor Gray
    Write-Host "   - Method: $Method" -ForegroundColor Gray
    Write-Host "   - Version: $(Get-VersionInfo)" -ForegroundColor Gray
    Write-Host "   - Duration: $($duration.Minutes)m $($duration.Seconds)s" -ForegroundColor Gray
    Write-Host "   - Artifacts: $artifactPath" -ForegroundColor Gray
    Write-Host ""
    
    # Send success notification
    Send-Notification -Message "Build for $Environment completed successfully" -Status "success"
    
    exit 0
}
catch {
    $endTime = Get-Date
    $duration = $endTime - $startTime
    
    Write-Host "`n" -NoNewline
    Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Red
    Write-Host "║                     BUILD FAILED                           ║" -ForegroundColor Red
    Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Red
    Write-Host "`n   Error: $_" -ForegroundColor Red
    Write-Host "   Duration: $($duration.Minutes)m $($duration.Seconds)s" -ForegroundColor Gray
    Write-Host "`n   Troubleshooting:" -ForegroundColor Yellow
    Write-Host "   1. Check the error message above" -ForegroundColor White
    Write-Host "   2. Verify all prerequisites are installed" -ForegroundColor White
    Write-Host "   3. Run with -VerboseOutput for more details" -ForegroundColor White
    Write-Host "   4. Check project-specific build documentation" -ForegroundColor White
    Write-Host ""
    
    # Send failure notification
    Send-Notification -Message "Build for $Environment failed: $_" -Status "failure"
    
    exit 1
}

#endregion

<#
================================================================================
CUSTOMIZATION GUIDE
================================================================================

This template script provides a flexible foundation for build and distribution
automation. Follow these steps to customize it for your project:

## Step 1: Project Configuration

Update the $Config hashtable at the top of the script:

1. Set ProjectName to your project's name
2. Configure BuildCommands for each environment
3. Set ArtifactPaths to where your builds output files
4. Configure CleanCommand for your build system
5. Set DependencyCommand for your package manager
6. Configure TestCommand for your test runner
7. Set LintCommand for your linter

## Step 2: Prerequisites

Update the Test-Prerequisites function:

1. Add entries to $prerequisites array for tools your project needs
2. Set Required = $true for mandatory tools
3. Update the Command property to the version check command

## Step 3: Version Info

Update the Get-VersionInfo function:

1. Implement logic to read your project's version
2. Common sources: package.json, VERSION file, setup.py, pom.xml

## Step 4: Distribution

Update distribution configuration:

1. Set DistributionCommands for each environment
2. Set DistributionTargets (URLs, servers, etc.)
3. Implement any custom distribution logic needed

## Step 5: Notifications (Optional)

If you want build notifications:

1. Set NotificationEnabled = $true
2. Implement Send-Notification function for your notification system

## Common Build Systems

### Node.js/npm
- Clean: "npm run clean" or "rm -rf node_modules dist"
- Dependencies: "npm ci"
- Build: "npm run build"
- Test: "npm test"
- Lint: "npm run lint"

### Python
- Clean: "rm -rf dist build *.egg-info"
- Dependencies: "pip install -r requirements.txt"
- Build: "python -m build" or "python setup.py build"
- Test: "pytest"
- Lint: "flake8" or "pylint"

### Java/Gradle
- Clean: "./gradlew clean"
- Dependencies: (handled by Gradle)
- Build: "./gradlew build"
- Test: "./gradlew test"
- Lint: "./gradlew check"

### .NET
- Clean: "dotnet clean"
- Dependencies: "dotnet restore"
- Build: "dotnet build"
- Test: "dotnet test"
- Lint: (varies)

### Flutter
- Clean: "flutter clean"
- Dependencies: "flutter pub get"
- Build: "flutter build apk --release"
- Test: "flutter test"
- Lint: "flutter analyze"

================================================================================
#>

