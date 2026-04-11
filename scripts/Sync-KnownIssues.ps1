[CmdletBinding()]
param(
    [string]$Owner,
    [string]$Repo,
    [string]$OutputPath = "docs/known-issues.md",
    [int]$ReleasedLimit = 10
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-GitHubRepository {
    param(
        [string]$Owner,
        [string]$Repo
    )

    if ($Owner -and $Repo) {
        return @{
            Owner = $Owner
            Repo = $Repo
        }
    }

    $remoteUrl = (& git remote get-url origin 2>$null)
    if (-not $remoteUrl) {
        throw "Could not resolve GitHub repository from origin. Pass -Owner and -Repo explicitly."
    }

    $match = [regex]::Match($remoteUrl.Trim(), 'github\.com[:/](?<owner>[^/]+)/(?<repo>[^/.]+?)(?:\.git)?$')
    if (-not $match.Success) {
        throw "Origin does not look like a GitHub repository URL: $remoteUrl"
    }

    return @{
        Owner = $match.Groups["owner"].Value
        Repo = $match.Groups["repo"].Value
    }
}

function Get-GitHubHeaders {
    $headers = @{
        "Accept" = "application/vnd.github+json"
        "User-Agent" = "PlumAntics-KnownIssues-Sync"
    }

    $token = $env:GITHUB_TOKEN
    if (-not $token) {
        $token = $env:GH_TOKEN
    }

    if ($token) {
        $headers["Authorization"] = "Bearer $token"
    }

    return $headers
}

function Get-AllGitHubIssues {
    param(
        [string]$Owner,
        [string]$Repo
    )

    $headers = Get-GitHubHeaders
    $issues = @()
    $page = 1

    while ($true) {
        $uri = "https://api.github.com/repos/$Owner/$Repo/issues?state=all&per_page=100&page=$page"
        $batch = Invoke-RestMethod -Headers $headers -Uri $uri
        if ($null -eq $batch) {
            break
        }

        $batchItems = @($batch)
        if ($batchItems.Count -eq 0) {
            break
        }

        $issues += $batchItems | Where-Object { -not $_.pull_request }

        if ($batchItems.Count -lt 100) {
            break
        }

        $page += 1
    }

    return $issues
}

function Get-LabelNames {
    param($Issue)

    return @($Issue.labels | ForEach-Object { $_.name })
}

function Test-HasLabel {
    param(
        [string[]]$Labels,
        [string]$Label
    )

    return $Labels -contains $Label
}

function Get-PrimaryStatus {
    param([string[]]$Labels)

    $statusOrder = @(
        "status:released",
        "status:fixed-next-patch",
        "status:in-progress",
        "status:confirmed",
        "status:needs-info",
        "status:needs-triage"
    )

    foreach ($status in $statusOrder) {
        if ($Labels -contains $status) {
            return $status
        }
    }

    return "status:unlabeled"
}

function Get-ModDisplay {
    param([string[]]$Labels)

    $modMap = [ordered]@{
        "mod:big3" = "Big 3 Mod"
        "mod:careers" = "Simstrology Career Mod"
        "mod:degrees" = "Simstrology Degree Mod"
        "mod:skills" = "Simstrology Skill Mod"
        "mod:childhood" = "Simstrology Childhood Mod"
    }

    $mods = foreach ($entry in $modMap.GetEnumerator()) {
        if ($Labels -contains $entry.Key) {
            $entry.Value
        }
    }

    if (-not $mods) {
        return "Unlabeled"
    }

    return ($mods -join ", ")
}

function Format-IssueBullet {
    param($Issue)

    $labels = Get-LabelNames -Issue $Issue
    $modDisplay = Get-ModDisplay -Labels $labels
    $status = Get-PrimaryStatus -Labels $labels
    $safeTitle = ($Issue.title -replace '\r?\n', ' ').Trim()

    return "- [#$($Issue.number) $safeTitle](../../issues/$($Issue.number)) - $modDisplay - ``$status``"
}

function Add-Section {
    param(
        [System.Collections.Generic.List[string]]$Lines,
        [string]$Heading,
        [object[]]$Items,
        [string]$EmptyText
    )

    $Lines.Add("## $Heading")
    $Lines.Add("")

    if (@($Items).Count -eq 0) {
        $Lines.Add($EmptyText)
    }
    else {
        foreach ($item in $Items) {
            $Lines.Add((Format-IssueBullet -Issue $item))
        }
    }

    $Lines.Add("")
    $Lines.Add("---")
    $Lines.Add("")
}

$repoInfo = Resolve-GitHubRepository -Owner $Owner -Repo $Repo
$allIssues = @(Get-AllGitHubIssues -Owner $repoInfo.Owner -Repo $repoInfo.Repo)

$normalized = foreach ($issue in $allIssues) {
    $labels = Get-LabelNames -Issue $issue
    [PSCustomObject]@{
        Number      = $issue.number
        Title       = $issue.title
        State       = $issue.state
        HtmlUrl     = $issue.html_url
        UpdatedAt   = $issue.updated_at
        ClosedAt    = $issue.closed_at
        Labels      = $labels
        Status      = Get-PrimaryStatus -Labels $labels
        TypeBug     = Test-HasLabel -Labels $labels -Label "type:bug"
        TypeCompat  = Test-HasLabel -Labels $labels -Label "type:compatibility"
        SeverityCrit = Test-HasLabel -Labels $labels -Label "severity:critical"
    }
}

$openIssues = @($normalized | Where-Object { $_.State -eq "open" })
$triageIssues = @($openIssues | Where-Object { $_.Status -in @("status:needs-triage", "status:needs-info") })
$confirmedStatuses = @("status:confirmed", "status:in-progress", "status:fixed-next-patch")

$criticalIssues = @(
    $openIssues |
    Where-Object { $_.TypeBug -and $_.SeverityCrit -and $_.Status -in $confirmedStatuses } |
    Sort-Object Number
)

$openBugs = @(
    $openIssues |
    Where-Object { $_.TypeBug -and $_.Status -in $confirmedStatuses } |
    Sort-Object Number
)

$compatibilityIssues = @(
    $openIssues |
    Where-Object { $_.TypeCompat -and $_.Status -in $confirmedStatuses } |
    Sort-Object Number
)

$releasedIssues = @(
    $normalized |
    Where-Object { $_.Labels -contains "status:released" } |
    Sort-Object @{ Expression = { if ($_.ClosedAt) { [datetime]$_.ClosedAt } else { [datetime]$_.UpdatedAt } }; Descending = $true } |
    Select-Object -First $ReleasedLimit
)

$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add("# Known Issues")
$lines.Add("")
$lines.Add('> This file is generated by `scripts/Sync-KnownIssues.ps1` from live GitHub issues.')
$lines.Add("")
$lines.Add("Check here before reporting. If something is already confirmed, you may find it on this page before opening a new issue.")
$lines.Add("")
$lines.Add('Only confirmed issues and released fixes are listed below. New reports with `status:needs-triage` or `status:needs-info` may still be visible in [open issues](../../issues) before they appear here.')
$lines.Add("")
$lines.Add("---")
$lines.Add("")
$lines.Add("## Current Status")
$lines.Add("")
$lines.Add("- Confirmed critical issues: $($criticalIssues.Count)")
$lines.Add("- Confirmed open bugs: $($openBugs.Count)")
$lines.Add("- Confirmed compatibility issues: $($compatibilityIssues.Count)")
$lines.Add("- Released fixes listed below: $($releasedIssues.Count)")
$lines.Add("- Open reports still under review: $($triageIssues.Count)")
$lines.Add("")
$lines.Add("---")
$lines.Add("")

Add-Section -Lines $lines -Heading "Critical Issues" -Items $criticalIssues -EmptyText "None currently."
Add-Section -Lines $lines -Heading "Open Bugs We're Working On" -Items $openBugs -EmptyText "No confirmed bugs are listed here yet."
Add-Section -Lines $lines -Heading "Known Mod Conflicts" -Items $compatibilityIssues -EmptyText "No confirmed mod conflicts are listed here yet."
Add-Section -Lines $lines -Heading "Fixed Recently" -Items $releasedIssues -EmptyText "No released fixes are listed yet."

$lines.Add("## Before You Report")
$lines.Add("")
$lines.Add("1. Search this page for your mod name or symptom")
$lines.Add("2. If you do not find it here, check [open issues](../../issues)")
$lines.Add("3. If it is still not listed, [report it here](../../issues/new?template=bug_report.yml)")
$lines.Add("")
$lines.Add("---")
$lines.Add("")
$lines.Add("## Sync Notes")
$lines.Add("")
$lines.Add('- Labels drive this page, especially `status:*`, `type:*`, `severity:*`, and `mod:*`')
$lines.Add('- Critical issues require `type:bug` and `severity:critical`')
$lines.Add('- Open bug and compatibility sections list confirmed issues only')
$lines.Add('- Released fixes require the `status:released` label')
$lines.Add("")
$lines.Add("---")
$lines.Add("")
$lines.Add(('**Last synced:** {0} from `https://github.com/{1}/{2}`' -f (Get-Date -Format 'MMMM d, yyyy'), $repoInfo.Owner, $repoInfo.Repo))

$outputFile = Join-Path -Path (Get-Location) -ChildPath $OutputPath
$outputDir = Split-Path -Path $outputFile -Parent
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

$content = $lines -join "`r`n"
Set-Content -Path $outputFile -Value $content -Encoding utf8

Write-Host "Synced known issues to $outputFile"
Write-Host "Fetched $($allIssues.Count) issue(s) from $($repoInfo.Owner)/$($repoInfo.Repo)"
