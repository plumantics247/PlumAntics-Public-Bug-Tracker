# GitHub Workflows & Automation

This file documents automation helpers and GitHub Actions that can speed up issue triage.

## Current Setup

This repository uses GitHub's native features:
- **Issue Forms** — Guided intake for different issue types
- **Labels** — Organize and filter issues
- **Projects** — Create views for public tracking
- **Notifications** — Stay on top of new reports

No external services or bots required.

---

## Possible Future Automations

If you want to add GitHub Actions later, here are useful ones:

### Auto-label based on keywords
Create a workflow that reads issue titles/descriptions and applies labels automatically. Example:
- Issue contains "error"/"crash" → `severity:major`
- Issue mentions another mod name → `type:compatibility`

### Comment templates for common responses
- "Need More Info" template
- "Won't Fix" explanation
- "Duplicate" link to original

### Stale issue management
Auto-comment on issues with no activity after 30 days, offer to close if no response.

### Release notes linking
When you close an issue with a release, automatically comment with a link to patch notes.

---

## Manual Processes (The Current Way)

For now, the workflow is intentionally simple and human-driven:

1. **Review** — Read new issues, assess them
2. **Respond** — Ask questions or confirm
3. **Label** — Tag with type, status, mod, severity
4. **Track** — Update status as you fix
5. **Close** — Link to patch notes or explanation

This keeps overhead low and lets you stay in control.

---

## If You Add GitHub Actions Later

- Keep workflows simple and non-intrusive
- Test in a test repo first
- Document what the action does
- Consider labeling bot comments so players know they're automated

---

**For now:** The manual process is fine. As the project grows, this section can expand.
