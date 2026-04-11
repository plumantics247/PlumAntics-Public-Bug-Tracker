# Audit Report & Setup Checklist

## ✅ Audit Completed

### Redundancy Removed
- **CONTRIBUTING.md** — Condensed "For Players" section; removed duplicate "best practices" that were in README
- **SUPPORT.md** — Removed duplicate "For Maintainers" heading
- **README.md** — Status labels table now uses consistent prefix notation

### Terminology Standardized
- **All labels now use full names** with colons (e.g., `status:confirmed`, not `confirmed`)
- **Consistent across all files:** README, SUPPORT, triage-workflow, label-taxonomy
- **Status label descriptions unified** between README and SUPPORT

### File Paths Verified
- **bug_report.yml** — Fixed relative path to `../../docs/known-issues.md` (was `../docs/known-issues.md`)
- **All other forms** — Paths verified as correct
- **All docs** — Internal links use consistent relative paths

### Labels Validation
All labels referenced in forms and docs exist in `docs/label-taxonomy.md`:
- ✅ `status:needs-triage`
- ✅ `status:needs-info`
- ✅ `status:confirmed`
- ✅ `status:in-progress`
- ✅ `status:fixed-next-patch`
- ✅ `status:released`
- ✅ `type:bug`
- ✅ `type:compatibility`
- ✅ `type:balance`
- ✅ `type:support`
- ✅ `severity:critical`
- ✅ `severity:major`
- ✅ `severity:minor`
- ✅ `mod:big3`, `mod:careers`, `mod:degrees`, `mod:skills`, `mod:childhood`

### Copy Tightened
- **README** — Removed duplicate status explanations, streamlined FAQ
- **CONTRIBUTING** — Removed verbose "best practices" section; now points to README
- **SUPPORT** — Clearer section divisions for solo creator workflow
- **triage-workflow** — Consistent label formatting in all decision trees

### Consistency Checks
- **Label naming:** All labels use `category:value` format consistently ✅
- **File references:** All links use correct relative paths ✅
- **Terminology:** "issue," "bug," "form" used consistently ✅
- **Tone:** Friendly, non-technical throughout ✅

---

## 📋 Manual GitHub UI Setup Tasks

Complete these steps in your GitHub repository settings.

### 1. Create Labels (Issues → Labels → New Label)

Create these 16 labels with suggested colors:

**Status Labels** (Blue: `#0366d6`)
- `status:needs-triage`
- `status:needs-info`
- `status:confirmed`
- `status:in-progress`
- `status:fixed-next-patch`
- `status:released`

**Type Labels** (Green: `#28a745`)
- `type:bug`
- `type:compatibility`
- `type:balance`
- `type:support`

**Severity Labels** (Vary)
- `severity:critical` (Red: `#d73a49`)
- `severity:major` (Orange: `#fd7e14`)
- `severity:minor` (Yellow: `#ffc107`)

**Mod Labels** (Purple: `#6f42c1`)
- `mod:big3`
- `mod:careers`
- `mod:degrees`
- `mod:skills`
- `mod:childhood`

### 2. Create GitHub Project Views (Projects → New Project)

Create a new project called "Bug Tracker" with these filtered views:

#### View 1: "Open Bugs"
- Filter: `is:open type:bug status:confirmed -status:fixed-next-patch`
- Shows: Bugs being worked on
- Audience: Public (players can see what's broken)

#### View 2: "Fixed in Next Patch"
- Filter: `is:open status:fixed-next-patch`
- Shows: Fixes coming soon
- Audience: Public

#### View 3: "Compatibility Issues" (Optional)
- Filter: `is:open type:compatibility`
- Shows: Known mod conflicts
- Audience: Public

#### View 4: "Needs Your Input" (Maintainer Only)
- Filter: `is:open status:needs-info`
- Shows: Issues awaiting player response
- Audience: Private (for you)

### 3. Enable Issue Forms

No action needed — GitHub automatically detects `.github/ISSUE_TEMPLATE/*.yml` files.

**Test:** Go to Issues → New Issue. You should see 4 form options:
1. Bug Report
2. Compatibility Issue
3. Balance Feedback
4. Question or Help

### 4. Configure Issue Form Permissions (Optional)

**Settings → Code and automation → Discussions** — Consider enabling Discussions if you want structured Q&A (optional).

### 5. Add to Platform Links

Add to your Patreon, itch.io, and CurseForge profiles:

```
☐ Bug reports & support: [GitHub Issue Link]
```

Example text to use anywhere:
```
Found a bug? Report it directly on GitHub: https://github.com/yourname/PlumAntics-Public-Bug-Tracker/issues/new/choose
```

### 6. Verify Everything Works

- [ ] Test all 4 issue forms
- [ ] Verify labels auto-apply (forms pre-label issues)
- [ ] Check that form links work from README.md
- [ ] Create a test issue in each form type
- [ ] Confirm labels appear correctly

### 7. Link Repo (Optional)

**Settings → About → Description & Website:**
```
Public bug tracker and support system for PlumAntics Sims 4 mods
```

---

## 📊 File Structure Checklist

```
✅ PlumAntics-Public-Bug-Tracker/
   ✅ README.md (Home page)
   ✅ SUPPORT.md (Workflow & triage guide)
   ✅ CONTRIBUTING.md (Community guidelines)
   ✅ AGENTS.md (Automation notes)
   ✅ AUDIT_REPORT.md (This file)
   ✅ .github/
      ✅ PULL_REQUEST_TEMPLATE.md
      ✅ ISSUE_TEMPLATE/
         ✅ config.yml (Contact links)
         ✅ bug_report.yml
         ✅ compatibility_report.yml
         ✅ balance_feedback.yml
         ✅ question_or_help.yml
   ✅ docs/
      ✅ known-issues.md
      ✅ label-taxonomy.md
      ✅ triage-workflow.md
```

---

## 🚀 Next Steps

1. **Commit & push** all files to GitHub
2. **Create the 16 labels** in GitHub UI (5 min)
3. **Create project views** in GitHub UI (10 min)
4. **Test each form** to verify they work (5 min)
5. **Add links** to Patreon, itch.io, CurseForge (2 min)
6. **Pin the README** or create a Welcome Discussion (optional)

**Time to setup:** ~30 minutes

---

## 📝 Notes

- All files are player-friendly and non-technical ✅
- Duplicate content has been removed ✅
- Terminology is consistent throughout ✅
- All labels referenced in forms exist in docs ✅
- Paths and links verified ✅
- Copy tightened for faster reading ✅

The repo is ready for production use!

---

**Audit Date:** March 30, 2026
