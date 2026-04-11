# Triage Workflow & GitHub Project Setup

Quick reference for handling issues and setting up public views.

---

## GitHub Project Setup (One-Time)

### Create Filtered Views

Players can see at-a-glance what's happening with your bugs.

1. **Go to:** Projects tab → New Project
2. **Choose:** Table or Kanban layout (doesn't matter)
3. **For each view below:** Create a new filter

#### View 1: "Open Bugs"
- Filter: `is:open type:bug status:confirmed -status:fixed-next-patch`
- Shows: Bugs you're working on
- Players see: What's actually broken

#### View 2: "Fixed in Next Patch"
- Filter: `is:open status:fixed-next-patch`
- Players see: What's coming in the next update

#### View 3: "Compatibility Issues" (Optional)
- Filter: `is:open type:compatibility`
- Players see: Known mod conflicts

**Note:** These are manual setup in GitHub UI. Filters use labels, so once labels exist, creating views takes 2 min each.

---

## How to Use Labels Consistently

### When a new issue arrives:

1. **Everyone gets `status:needs-triage`** (automatic from form)
2. **You add:** (use full label names)
   - `type:bug` or `type:support` or `type:balance` or `type:compatibility`
   - `severity:critical` or `severity:major` or `severity:minor` (only for bugs)
   - `mod:big3` or `mod:careers` or similar (whichever mod applies)
3. **Then:** Remove `status:needs-triage`, replace with `status:confirmed` (or `status:needs-info` if you need more details)

### As you work:
- `status:in-progress` when you start the fix
- `status:fixed-next-patch` when it's ready to ship
- Add `status:released` and close at release

---

## Quick Decision Tree

```
New issue arrives → Read the form

├─ Can't understand it?
│  └─ Comment: "Can you clarify..."
│     Add: `status:needs-info`
│
├─ Can reproduce it + it's broken?
│  └─ Add: `status:confirmed` + `type:bug` + `severity:X` + `mod:X`
│
├─ Two mods conflict?
│  └─ Add: `status:confirmed` + `type:compatibility` + `mod:X` + `mod:Y`
│
├─ Feature feels off?
│  └─ Add: `type:balance` + `mod:X`
│     (Feedback, not a bug—no severity label)
│
├─ It's a question?
│  └─ Add: `type:support`
│     Answer + close, or leave open
│
└─ Already reported?
   └─ Comment "Same as #123" 
      Close
```

---

## Email/Notification Workflow

**For you:**
1. GitHub notifies you of new issues
2. When convenient (3-7 days is cool for solo), check them
3. Comment + label
4. Move on

**For players:**
1. They see their issue get labeled
2. Status label tells them where it is
3. Notifications keep them in the loop

You don't need to manage email—GitHub handles it.

---

## Edge Cases (Keep It Simple)

### Can't reproduce
Comment: "I couldn't reproduce this with [your setup]. Can you clarify..."
Add: `status:needs-info`

If no response in 2 weeks, close: "Closing due to inactivity. Reopen if you have more details!"

### User is upset
Stay calm and kind:
"I understand this is frustrating. Here's what I'm working on: [brief update]"

### It's a game patch problem
Create one mega-issue: "Game Patch 2.1 broke multiple features"
Close other reports pointing to it: "See #999 for tracking"

### Compatibility issue you can't fix
Comment: "This is a conflict between two mods. Try [workaround]. If it persists, here's [creator contact]"
Label: `type:compatibility`
Leave open so players see it

---

## Severity Guidelines (For Bugs Only)

- **Critical:** Game won't load, saves corrupt, progression blocked
- **Major:** Feature doesn't work at all
- **Minor:** Small bug, cosmetic issue, rare edge case, workaround exists

---

## Closing Issues

### Bug is fixed
```
Fixed in v2.1.0! Get it on [Patreon/itch/CurseForge]
```
Close + add `status:released`

### It's a duplicate
```
Same as #123. Closing to consolidate discussion.
```
Close with link to original

### Can't fix it / won't fix
```
This would require [reason]. Here's what you can do: [workaround]
```
Close + add comment explaining

### Question answered
```
[Answer to their question]
```
Close when done

---

## Example: Your Week

**Monday:** Check Issues, see 3 new ones
- Bug report: Reproduce it → `confirmed` + `type:bug` + `severity:minor` + `mod:skills`
- Compat issue: Document → `confirmed` + `type:compatibility` + `mod:big3` + `mod:other`
- Question: Answer → Close

**Wednesday:** Someone replies asking for more info on the bug
- They provide details → Now you can reproduce → Keep `confirmed`

**Friday:** You fix the bug
- Commit fix → Comment "Fixed in [commit]" → Change to `fixed-next-patch`

**Two weeks later:** Release time
- Close the issue → Comment "Released in v2.2.0"

Done. Next issue.

---

## Remember

- **Responding in 3-7 days is fine** — you're solo
- **Transparency is gold** — players understand slow fixes if you communicate
- **You don't need to fix everything** — it's okay to say "won't fix" and explain why
- **Labels are your friend** — filter by status to see what needs attention

---

**Last updated:** March 2026
