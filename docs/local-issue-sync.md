# Local Issue Sync

This repo can rebuild [known-issues.md](known-issues.md) from live GitHub issues.

## Command

Run this from the repository root:

```powershell
.\scripts\Sync-KnownIssues.ps1
```

The script:
- reads the GitHub repo from your `origin` remote
- fetches issues through the GitHub API
- groups them by the labels already used in this tracker
- rewrites `docs/known-issues.md`

## Optional GitHub Token

Public repos work without a token, but GitHub rate limits anonymous API calls more aggressively.

If you want higher limits, set a token first:

```powershell
$env:GITHUB_TOKEN = "your_token_here"
.\scripts\Sync-KnownIssues.ps1
```

The script also accepts `GH_TOKEN`.

## Labels That Matter

The generated page depends on these labels:
- `status:needs-triage`
- `status:needs-info`
- `status:confirmed`
- `status:in-progress`
- `status:fixed-next-patch`
- `status:released`
- `type:bug`
- `type:compatibility`
- `severity:critical`
- `mod:aspirations`
- `mod:Simstrology`
- `mod:careers`
- `mod:degrees`
- `mod:skills`
- `mod:childhood`

If an open issue has a `mod:*` label but no explicit `type:*` label yet, the sync treats it as a bug by default so it can still appear in `known-issues.md` while you triage it.

## Useful Pattern

When you want a fresh local snapshot:

```powershell
git pull
.\scripts\Sync-KnownIssues.ps1
git diff -- docs/known-issues.md
```
