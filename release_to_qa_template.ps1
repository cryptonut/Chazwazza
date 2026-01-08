<#
.SYNOPSIS
    Automated QA Release Deployment Script - Template
    
.DESCRIPTION
    A comprehensive, enterprise-grade script for automating QA releases.
    This script handles the full release workflow:
    - Branch management (merge from development to QA branch)
    - Version incrementing
    - Building the application
    - Deploying to QA environment
    - Notifying stakeholders
    
.PARAMETER Notes
    Custom release notes to include with the deployment.
    If not provided, auto-generates notes from git commit history.
    
.PARAMETER SkipMerge
    Skip the branch merge step (use when QA branch is already up to date)
    
.PARAMETER SkipBuild
    Skip the build step (use when deploying a pre-built artifact)
    
.PARAMETER DryRun
    Show what would be done without actually executing commands
    
.PARAMETER Force
    Skip confirmation prompts
    
.EXAMPLE
    .\release_to_qa.ps1
    
.EXAMPLE
    .\release_to_qa.ps1 -Notes "Hotfix for login issue"
    
.EXAMPLE
    .\release_to_qa.ps1 -SkipMerge -DryRun
    
.NOTES
    Template Version: 2.0
    
    CUSTOMIZATION REQUIRED:
    Search for "{{CUSTOMIZE}}" to find sections that need project-specific configuration.
    
    This script follows the standard branch workflow:
    {{DEVELOPMENT_BRANCH}} → {{QA_BRANCH}} → {{MAIN_BRANCH}}
#>

[CmdletBinding()]
param(
    [Parameter()]
    [string]$Notes = "",
    
    [Parameter()]
    [switch]$SkipMerge,
    
    [Parameter()]
    [switch]$SkipBuild,
    
    [Parameter()]
    [switch]$DryRun,
    
    [Parameter()]
    [switch]$Force
)

#region Configuration
# ============================================================================
# CONFIGURATION - {{CUSTOMIZE}} these values for your project
# ============================================================================

$Config = @{
    # Project Information
    ProjectName = "{{PROJECT_NAME}}"
    
    # Branch Configuration
    DevelopmentBranch = "{{DEVELOPMENT_BRANCH}}"  # e.g., "develop", "dev", "main"
    QABranch = "{{QA_BRANCH}}"                    # e.g., "release/qa", "staging", "qa"
    MainBranch = "{{MAIN_BRANCH}}"                # e.g., "main", "master", "production"
    
    # Version Configuration
    VersionFile = "{{VERSION_FILE}}"              # e.g., "package.json", "pubspec.yaml", "VERSION"
    VersionPattern = "{{VERSION_PATTERN}}"        # Regex to match version, e.g., '"version":\s*"(\d+\.\d+\.\d+)"'
    VersionReplaceFormat = "{{VERSION_FORMAT}}"   # Format for replacement, e.g., '"version": "{0}"'
    
    # Build Configuration
    CleanCommand = "{{CLEAN_COMMAND}}"
    DependencyCommand = "{{DEPENDENCY_COMMAND}}"
    BuildCommand = "{{QA_BUILD_COMMAND}}"
    TestCommand = "{{TEST_COMMAND}}"
    
    # Artifact Configuration
    ArtifactPath = "{{QA_ARTIFACT_PATH}}"
    ArtifactPattern = "{{ARTIFACT_PATTERN}}"      # e.g., "*.apk", "*.zip", "dist/*"
    
    # Distribution Configuration
    DistributionEnabled = $true
    DistributionCommand = "{{DISTRIBUTION_COMMAND}}"
    DistributionTarget = "{{DISTRIBUTION_TARGET}}"
    TesterGroup = "{{TESTER_GROUP}}"              # e.g., "qa-testers", "beta-testers"
    
    # Notification Configuration
    NotificationEnabled = $false
    NotificationWebhook = "{{NOTIFICATION_WEBHOOK}}"
    
    # Retry Configuration
    MaxRetries = 2
    RetryDelaySeconds = 5
    
    # Cleanup Configuration
    KillProcesses = @()                           # e.g., @("java", "gradle", "node")
}

#endregion

#region Helper Functions
# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

function Write-Banner {
    param([string]$Title)
    $width = 64
    $padding = [math]::Floor(($width - $Title.Length - 2) / 2)
    $paddingStr = " " * $padding
    
    Write-Host "`n" -NoNewline
    Write-Host ("╔" + "═" * ($width - 2) + "╗") -ForegroundColor Cyan
    Write-Host ("║" + $paddingStr + $Title + $paddingStr + "║").PadRight($width - 1).Substring(0, $width - 1) + "║" -ForegroundColor Cyan
    Write-Host ("╚" + "═" * ($width - 2) + "╝") -ForegroundColor Cyan
}

function Write-Step {
    param(
        [string]$Number,
        [string]$Description
    )
    Write-Host "`n" -NoNewline
    Write-Host "[$Number] " -ForegroundColor Cyan -NoNewline
    Write-Host $Description -ForegroundColor White
    Write-Host ("-" * 50) -ForegroundColor DarkGray
}

function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Yellow
}

function Write-Success {
    param([string]$Message)
    Write-Host "[OK] $Message" -ForegroundColor Green
}

function Write-Failure {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARN] $Message" -ForegroundColor Yellow
}

function Write-Detail {
    param([string]$Message)
    Write-Host "   $Message" -ForegroundColor Gray
}

function Invoke-SafeCommand {
    param(
        [string]$Command,
        [string]$Description,
        [switch]$ContinueOnError
    )
    
    if ($DryRun) {
        Write-Info "DRY RUN: Would execute: $Command"
        return $true
    }
    
    Write-Info $Description
    Write-Detail "Command: $Command"
    
    try {
        Invoke-Expression $Command
        
        if ($LASTEXITCODE -ne 0) {
            if ($ContinueOnError) {
                Write-Warning "Command exited with code $LASTEXITCODE, continuing..."
                return $true
            }
            return $false
        }
        return $true
    }
    catch {
        if ($ContinueOnError) {
            Write-Warning "Command failed: $_, continuing..."
            return $true
        }
        Write-Failure "Command failed: $_"
        return $false
    }
}

function Get-CurrentVersion {
    # {{CUSTOMIZE}} - Implement version reading for your project
    
    $versionFile = $Config.VersionFile
    
    if (-not (Test-Path $versionFile) -or $versionFile -match "^\{\{.*\}\}$") {
        Write-Warning "Version file not configured or not found"
        return "0.0.0+0"
    }
    
    try {
        $content = Get-Content $versionFile -Raw
        
        # Try common patterns
        
        # package.json style: "version": "1.2.3"
        if ($content -match '"version"\s*:\s*"(\d+\.\d+\.\d+)"') {
            return $matches[1] + "+0"
        }
        
        # pubspec.yaml style: version: 1.2.3+4
        if ($content -match 'version:\s*(\d+\.\d+\.\d+)\+(\d+)') {
            return "$($matches[1])+$($matches[2])"
        }
        
        # Simple version file
        if ($content -match '^(\d+\.\d+\.\d+)') {
            return $matches[1] + "+0"
        }
        
        Write-Warning "Could not parse version from $versionFile"
        return "0.0.0+0"
    }
    catch {
        Write-Warning "Error reading version: $_"
        return "0.0.0+0"
    }
}

function Set-IncrementedVersion {
    # {{CUSTOMIZE}} - Implement version incrementing for your project
    
    $versionFile = $Config.VersionFile
    
    if (-not (Test-Path $versionFile) -or $versionFile -match "^\{\{.*\}\}$") {
        Write-Warning "Version file not configured, skipping version increment"
        return $null
    }
    
    if ($DryRun) {
        $currentVersion = Get-CurrentVersion
        Write-Info "DRY RUN: Would increment version from $currentVersion"
        return $currentVersion
    }
    
    try {
        $content = Get-Content $versionFile -Raw
        $newVersion = $null
        
        # pubspec.yaml style: version: 1.2.3+4 → 1.2.3+5
        if ($content -match 'version:\s*(\d+\.\d+\.\d+)\+(\d+)') {
            $versionName = $matches[1]
            $buildNumber = [int]$matches[2]
            $newBuildNumber = $buildNumber + 1
            $newVersion = "$versionName+$newBuildNumber"
            
            $content = $content -replace "version:\s*$versionName\+$buildNumber", "version: $newVersion"
            Set-Content -Path $versionFile -Value $content -NoNewline
            
            Write-Detail "Incremented: $versionName+$buildNumber → $newVersion"
            return $newVersion
        }
        
        # package.json style - increment patch version
        if ($content -match '"version"\s*:\s*"(\d+)\.(\d+)\.(\d+)"') {
            $major = [int]$matches[1]
            $minor = [int]$matches[2]
            $patch = [int]$matches[3] + 1
            $newVersion = "$major.$minor.$patch"
            
            $content = $content -replace '"version"\s*:\s*"\d+\.\d+\.\d+"', "`"version`": `"$newVersion`""
            Set-Content -Path $versionFile -Value $content -NoNewline
            
            Write-Detail "Incremented patch: $($matches[1]).$($matches[2]).$($matches[3]) → $newVersion"
            return $newVersion
        }
        
        Write-Warning "Could not find version pattern to increment"
        return $null
    }
    catch {
        Write-Warning "Error incrementing version: $_"
        return $null
    }
}

function Get-ReleaseNotes {
    param([string]$CustomNotes)
    
    if ($CustomNotes) {
        return $CustomNotes
    }
    
    # Auto-generate from git
    try {
        $commitHash = git rev-parse --short HEAD 2>$null
        $commitMessage = git log -1 --pretty=format:"%s" 2>$null
        $commitDate = git log -1 --pretty=format:"%ad" --date=short 2>$null
        $commitAuthor = git log -1 --pretty=format:"%an" 2>$null
        $branchName = git branch --show-current 2>$null
        
        # Get recent commits (last 5)
        $recentCommits = git log -5 --pretty=format:"• %s" --abbrev-commit 2>$null
        
        $version = Get-CurrentVersion
        
        $notes = @"
QA Release Build - Ready for Testing

═══════════════════════════════════════════

BUILD INFO:
  Version: $version
  Branch: $branchName
  Commit: $commitHash
  Built: $(Get-Date -Format 'yyyy-MM-dd HH:mm')

LATEST CHANGE:
  $commitMessage
  By: $commitAuthor ($commitDate)

RECENT UPDATES:
$recentCommits

═══════════════════════════════════════════

Please test thoroughly and report any issues.
"@
        
        return $notes
    }
    catch {
        return "QA Release - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    }
}

function Stop-BlockingProcesses {
    if ($Config.KillProcesses.Count -eq 0) {
        return
    }
    
    Write-Info "Checking for blocking processes..."
    
    foreach ($processName in $Config.KillProcesses) {
        $processes = Get-Process -Name $processName -ErrorAction SilentlyContinue
        if ($processes) {
            Write-Detail "Stopping $($processes.Count) $processName process(es)..."
            $processes | Stop-Process -Force -ErrorAction SilentlyContinue
        }
    }
    
    Start-Sleep -Seconds 2
}

function Send-Notification {
    param(
        [string]$Message,
        [string]$Status  # "success", "failure"
    )
    
    if (-not $Config.NotificationEnabled) {
        return
    }
    
    # {{CUSTOMIZE}} - Implement notification for your project
    # Example Slack webhook:
    <#
    $payload = @{
        text = "[$($Config.ProjectName)] QA Release: $Status"
        attachments = @(
            @{
                color = if ($Status -eq "success") { "good" } else { "danger" }
                text = $Message
            }
        )
    } | ConvertTo-Json
    
    Invoke-RestMethod -Uri $Config.NotificationWebhook -Method Post -Body $payload -ContentType "application/json"
    #>
    
    Write-Info "Notification sent: $Status"
}

#endregion

#region Main Script
# ============================================================================
# MAIN SCRIPT
# ============================================================================

$ErrorActionPreference = "Stop"
$startTime = Get-Date

# Display banner
Write-Banner "QA RELEASE AUTOMATION"
Write-Host ""
Write-Host "  Project:     $($Config.ProjectName)" -ForegroundColor Gray
Write-Host "  Source:      $($Config.DevelopmentBranch)" -ForegroundColor Gray
Write-Host "  Target:      $($Config.QABranch)" -ForegroundColor Gray
Write-Host "  Testers:     $($Config.TesterGroup)" -ForegroundColor Gray
if ($DryRun) {
    Write-Host "  Mode:        DRY RUN (no changes will be made)" -ForegroundColor Yellow
}
Write-Host ""

# Confirmation prompt
if (-not $Force -and -not $DryRun) {
    $confirm = Read-Host "Proceed with QA release? (Y/N)"
    if ($confirm -ne "Y" -and $confirm -ne "y") {
        Write-Info "Release cancelled by user"
        exit 0
    }
}

try {
    # Step 1: Pre-flight checks
    Write-Step "1/9" "Pre-flight Checks"
    
    # Check git
    $gitVersion = git --version 2>$null
    if (-not $gitVersion) {
        throw "Git is not installed or not in PATH"
    }
    Write-Success "Git: $gitVersion"
    
    # Check current branch
    $currentBranch = git branch --show-current 2>$null
    Write-Detail "Current branch: $currentBranch"
    
    # Check for uncommitted changes
    $gitStatus = git status --porcelain 2>$null
    if ($gitStatus) {
        Write-Warning "You have uncommitted changes:"
        $gitStatus | ForEach-Object { Write-Detail $_ }
        
        if (-not $Force) {
            $proceed = Read-Host "Continue anyway? (Y/N)"
            if ($proceed -ne "Y" -and $proceed -ne "y") {
                throw "Uncommitted changes present. Commit or stash before release."
            }
        }
    } else {
        Write-Success "Working directory is clean"
    }
    
    # Step 2: Checkout QA branch
    Write-Step "2/9" "Branch Management"
    
    if (-not $SkipMerge) {
        # Fetch latest
        Invoke-SafeCommand -Command "git fetch origin" -Description "Fetching latest from remote" -ContinueOnError | Out-Null
        
        # Checkout QA branch
        $qaBranch = $Config.QABranch
        if ($qaBranch -match "^\{\{.*\}\}$") {
            throw "QA branch not configured. Update Config.QABranch."
        }
        
        $branchExists = git branch --list $qaBranch 2>$null
        if ($branchExists) {
            Invoke-SafeCommand -Command "git checkout $qaBranch" -Description "Checking out $qaBranch" | Out-Null
        } else {
            Invoke-SafeCommand -Command "git checkout -b $qaBranch origin/$qaBranch" -Description "Creating local $qaBranch from origin" | Out-Null
        }
        
        if (-not $DryRun) {
            Invoke-SafeCommand -Command "git pull origin $qaBranch" -Description "Pulling latest $qaBranch" -ContinueOnError | Out-Null
        }
        
        Write-Success "On branch: $qaBranch"
    } else {
        Write-Info "Skipping merge (--SkipMerge specified)"
    }
    
    # Step 3: Merge development branch
    Write-Step "3/9" "Merging Development Branch"
    
    if (-not $SkipMerge) {
        $devBranch = $Config.DevelopmentBranch
        if ($devBranch -match "^\{\{.*\}\}$") {
            throw "Development branch not configured. Update Config.DevelopmentBranch."
        }
        
        # Fetch development branch
        Invoke-SafeCommand -Command "git fetch origin $devBranch" -Description "Fetching $devBranch" -ContinueOnError | Out-Null
        
        # Merge
        $mergeResult = Invoke-SafeCommand -Command "git merge origin/$devBranch --no-edit --no-ff -m `"chore: Merge $devBranch into $($Config.QABranch) for QA release`"" -Description "Merging $devBranch"
        
        if (-not $mergeResult -and -not $DryRun) {
            Write-Failure "Merge failed! Resolve conflicts manually:"
            Write-Detail "1. Run: git status"
            Write-Detail "2. Resolve conflicts in listed files"
            Write-Detail "3. Run: git add . && git commit"
            Write-Detail "4. Re-run this script with -SkipMerge"
            throw "Merge conflict detected"
        }
        
        Write-Success "Merge completed"
    }
    
    # Step 4: Increment version
    Write-Step "4/9" "Version Management"
    
    $previousVersion = Get-CurrentVersion
    Write-Detail "Current version: $previousVersion"
    
    $newVersion = Set-IncrementedVersion
    if ($newVersion) {
        Write-Success "Version incremented to: $newVersion"
        
        # Commit version change
        if (-not $DryRun) {
            $versionFile = $Config.VersionFile
            if ($versionFile -and -not ($versionFile -match "^\{\{.*\}\}$")) {
                git add $versionFile 2>$null
                git commit -m "chore: Bump version to $newVersion for QA release" --no-verify 2>$null
            }
        }
    } else {
        Write-Warning "Version not incremented (not configured)"
        $newVersion = $previousVersion
    }
    
    # Step 5: Push changes
    Write-Step "5/9" "Pushing Changes"
    
    if (-not $SkipMerge -and -not $DryRun) {
        $pushResult = Invoke-SafeCommand -Command "git push origin $($Config.QABranch)" -Description "Pushing to origin" -ContinueOnError
        if ($pushResult) {
            Write-Success "Changes pushed to remote"
        }
    } else {
        Write-Info "Skipping push (merge skipped or dry run)"
    }
    
    # Step 6: Clean and prepare build
    Write-Step "6/9" "Preparing Build Environment"
    
    if (-not $SkipBuild) {
        # Kill blocking processes
        Stop-BlockingProcesses
        
        # Clean
        if ($Config.CleanCommand -and -not ($Config.CleanCommand -match "^\{\{.*\}\}$")) {
            Invoke-SafeCommand -Command $Config.CleanCommand -Description "Cleaning previous build" -ContinueOnError | Out-Null
            Start-Sleep -Seconds 2
        }
        
        # Install dependencies
        if ($Config.DependencyCommand -and -not ($Config.DependencyCommand -match "^\{\{.*\}\}$")) {
            $depResult = Invoke-SafeCommand -Command $Config.DependencyCommand -Description "Installing dependencies"
            if (-not $depResult -and -not $DryRun) {
                throw "Failed to install dependencies"
            }
        }
        
        Write-Success "Build environment ready"
    } else {
        Write-Info "Skipping build preparation (--SkipBuild specified)"
    }
    
    # Step 7: Build
    Write-Step "7/9" "Building Application"
    
    if (-not $SkipBuild) {
        if ($Config.BuildCommand -and -not ($Config.BuildCommand -match "^\{\{.*\}\}$")) {
            
            # Run tests first (if configured)
            if ($Config.TestCommand -and -not ($Config.TestCommand -match "^\{\{.*\}\}$")) {
                $testResult = Invoke-SafeCommand -Command $Config.TestCommand -Description "Running tests" -ContinueOnError
                if (-not $testResult) {
                    Write-Warning "Tests had issues, but continuing with build..."
                }
            }
            
            # Build with retry
            $buildSuccess = $false
            $attempt = 0
            
            while ($attempt -lt $Config.MaxRetries -and -not $buildSuccess) {
                $attempt++
                
                if ($attempt -gt 1) {
                    Write-Warning "Build attempt $attempt of $($Config.MaxRetries)..."
                    Stop-BlockingProcesses
                    Start-Sleep -Seconds $Config.RetryDelaySeconds
                }
                
                $buildResult = Invoke-SafeCommand -Command $Config.BuildCommand -Description "Building (attempt $attempt)"
                
                if ($buildResult -or $DryRun) {
                    $buildSuccess = $true
                }
            }
            
            if (-not $buildSuccess -and -not $DryRun) {
                throw "Build failed after $($Config.MaxRetries) attempts"
            }
            
            Write-Success "Build completed"
        } else {
            Write-Warning "Build command not configured"
        }
    } else {
        Write-Info "Skipping build (--SkipBuild specified)"
    }
    
    # Step 8: Verify artifacts
    Write-Step "8/9" "Verifying Artifacts"
    
    $artifactPath = $Config.ArtifactPath
    
    if ($artifactPath -and -not ($artifactPath -match "^\{\{.*\}\}$") -and -not $DryRun) {
        if (Test-Path $artifactPath) {
            $artifacts = Get-ChildItem $artifactPath -File -ErrorAction SilentlyContinue | Select-Object -First 3
            
            if ($artifacts) {
                Write-Success "Artifacts found:"
                foreach ($artifact in $artifacts) {
                    $sizeMB = [math]::Round($artifact.Length / 1MB, 2)
                    Write-Detail "$($artifact.Name) ($sizeMB MB)"
                }
            } else {
                Write-Warning "No artifacts found at: $artifactPath"
            }
        } else {
            Write-Warning "Artifact path does not exist: $artifactPath"
        }
    } else {
        Write-Info "Artifact verification skipped"
    }
    
    # Step 9: Distribute
    Write-Step "9/9" "Distributing to QA Testers"
    
    if ($Config.DistributionEnabled -and $Config.DistributionCommand -and -not ($Config.DistributionCommand -match "^\{\{.*\}\}$")) {
        
        # Generate release notes
        $releaseNotes = Get-ReleaseNotes -CustomNotes $Notes
        Write-Detail "Release notes generated"
        
        # Distribute
        # {{CUSTOMIZE}} - You may need to pass release notes differently based on your distribution system
        $distCommand = $Config.DistributionCommand
        
        # Replace common placeholders if present
        $distCommand = $distCommand -replace "\{\{ARTIFACT_PATH\}\}", $Config.ArtifactPath
        $distCommand = $distCommand -replace "\{\{TESTER_GROUP\}\}", $Config.TesterGroup
        $distCommand = $distCommand -replace "\{\{VERSION\}\}", $newVersion
        
        $distResult = Invoke-SafeCommand -Command $distCommand -Description "Distributing to $($Config.TesterGroup)"
        
        if ($distResult -or $DryRun) {
            Write-Success "Distribution completed!"
            Write-Detail "Testers will be notified"
        } else {
            Write-Warning "Distribution may have had issues. Check manually."
        }
    } else {
        Write-Info "Distribution not configured or disabled"
        Write-Detail "Artifacts are ready for manual distribution at: $($Config.ArtifactPath)"
    }
    
    # Summary
    $endTime = Get-Date
    $duration = $endTime - $startTime
    
    Write-Host ""
    Write-Banner "RELEASE SUCCESSFUL"
    Write-Host ""
    Write-Host "  Summary:" -ForegroundColor White
    Write-Host "  ────────────────────────────────" -ForegroundColor DarkGray
    Write-Host "  Project:      $($Config.ProjectName)" -ForegroundColor Gray
    Write-Host "  Version:      $newVersion" -ForegroundColor Gray
    Write-Host "  Branch:       $($Config.QABranch)" -ForegroundColor Gray
    Write-Host "  Testers:      $($Config.TesterGroup)" -ForegroundColor Gray
    Write-Host "  Duration:     $($duration.Minutes)m $($duration.Seconds)s" -ForegroundColor Gray
    Write-Host "  Artifacts:    $($Config.ArtifactPath)" -ForegroundColor Gray
    Write-Host ""
    
    # Send notification
    Send-Notification -Message "QA Release $newVersion deployed successfully" -Status "success"
    
    exit 0
}
catch {
    $endTime = Get-Date
    $duration = $endTime - $startTime
    
    Write-Host ""
    Write-Banner "RELEASE FAILED"
    Write-Host ""
    Write-Failure "Error: $_"
    Write-Host ""
    Write-Host "  Duration: $($duration.Minutes)m $($duration.Seconds)s" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  Troubleshooting:" -ForegroundColor Yellow
    Write-Host "  1. Check the error message above" -ForegroundColor White
    Write-Host "  2. Verify branch state: git status" -ForegroundColor White
    Write-Host "  3. Check for merge conflicts" -ForegroundColor White
    Write-Host "  4. Try with -DryRun to see what would happen" -ForegroundColor White
    Write-Host ""
    
    # Send notification
    Send-Notification -Message "QA Release failed: $_" -Status "failure"
    
    exit 1
}

#endregion

<#
================================================================================
CUSTOMIZATION GUIDE
================================================================================

This template provides a complete QA release automation workflow. Follow these
steps to customize it for your project:

## Step 1: Branch Configuration

Update these in $Config:
- DevelopmentBranch: Your main development branch (e.g., "develop", "main")
- QABranch: Your QA/staging branch (e.g., "release/qa", "staging")
- MainBranch: Your production branch (e.g., "main", "master")

## Step 2: Version Management

Update these in $Config:
- VersionFile: Path to your version file (e.g., "package.json", "pubspec.yaml")
- Modify Get-CurrentVersion and Set-IncrementedVersion for your version format

## Step 3: Build Commands

Update these in $Config:
- CleanCommand: Command to clean previous builds
- DependencyCommand: Command to install dependencies
- BuildCommand: Command to build for QA
- TestCommand: Command to run tests

## Step 4: Artifact Configuration

Update these in $Config:
- ArtifactPath: Where your build outputs are located
- ArtifactPattern: Pattern to match artifact files

## Step 5: Distribution

Update these in $Config:
- DistributionEnabled: Set to $true to enable
- DistributionCommand: Your distribution command
- DistributionTarget: Target URL/server
- TesterGroup: Name of your tester group

## Step 6: Notifications (Optional)

Update these in $Config:
- NotificationEnabled: Set to $true to enable
- NotificationWebhook: Your webhook URL
- Implement Send-Notification function for your notification system

## Common Platform Examples

### Firebase App Distribution
DistributionCommand = "firebase appdistribution:distribute {{ARTIFACT_PATH}} --app YOUR_APP_ID --groups {{TESTER_GROUP}}"

### TestFlight (via fastlane)
DistributionCommand = "fastlane pilot upload --ipa {{ARTIFACT_PATH}}"

### AWS S3
DistributionCommand = "aws s3 cp {{ARTIFACT_PATH}} s3://your-bucket/releases/"

### Azure DevOps
DistributionCommand = "az pipelines run --name 'Deploy to QA'"

### Custom Webhook
DistributionCommand = "curl -X POST -F 'file=@{{ARTIFACT_PATH}}' https://your-server/upload"

================================================================================
WORKFLOW OVERVIEW
================================================================================

1. Pre-flight Checks
   - Verify git is available
   - Check for uncommitted changes
   
2. Branch Management
   - Checkout QA branch
   - Pull latest changes
   
3. Merge Development
   - Merge development branch into QA
   - Handle conflicts (manual if needed)
   
4. Version Increment
   - Automatically increment version/build number
   - Commit version change
   
5. Push Changes
   - Push merged changes to remote
   
6. Build Preparation
   - Clean previous artifacts
   - Install dependencies
   
7. Build
   - Run tests (if configured)
   - Build application (with retry logic)
   
8. Verify Artifacts
   - Confirm build outputs exist
   - Display artifact info
   
9. Distribute
   - Generate release notes
   - Deploy to QA testers

================================================================================
#>

