# Label Taxonomy

**Labels help organize issues.** This page explains what each means and when to use it.

See [triage-workflow.md](triage-workflow.md) for practical labeling decisions.

---

## Status Labels

What stage is this issue at?

### status:needs-triage
**When:** Issue just filed, hasn't been reviewed yet.
**Remove when:** You've read it and decided what it is.

### status:needs-info
**When:** You need the player to give more details before you can help.
**Remove when:** They provide the info or if there's no response after 2 weeks.

### status:confirmed
**When:** You've verified this is a real issue (you reproduced it or multiple reports confirm it).
**Keep:** Until it's fixed and released.

### status:in-progress
**When:** You're actively working on the fix.
**Replace with:** `fixed-next-patch` when ready.

### status:fixed-next-patch
**When:** Fix is done and will ship in the next update.
**Replace with:** `released` once the patch goes live.

### status:released
**When:** Issue is fixed in a released patch.
**Use:** When closing fixed issues, to show players the fix is available.

---

## Type Labels

What kind of issue is this?

### type:bug
Something isn't working as it should.
- Feature broken, unintended behavior, game crash, text error
- Example: "Trait isn't applying," "Skill stuck at level 2"

### type:compatibility
Two mods fight with each other.
- One mod disables features from another
- Example: "PlumAntics Skill mod + ModX breaks career progression"

### type:balance
A feature works but feels off (too strong, too weak, too frequent).
- Not a technical bug, but gameplay feedback
- Example: "Career perks level too fast," "Degree requirement is grindy"

### type:support
Player question or confusion.
- "How do I use this?" or "Is this a bug or intended?"
- Example: "Why don't I see the new interaction?" (answer: need right pack)

---

## Severity Labels (For Bugs Only)

How bad is the bug?

### severity:critical
Game-breaking or data-destroying.
- Game won't load, saves corrupt, progression blocked, feature completely unusable
- **Action:** Fix ASAP

### severity:major
Significant feature is broken.
- Feature doesn't work at all, but game is stable
- Player can't use that one feature
- **Action:** Fix soon, include in next patch

### severity:minor
Small issue with low impact.
- Cosmetic (text display), rare edge case, or easy workaround exists
- **Action:** Fix when convenient

---

## Mod Labels

Which mod does this affect?

### mod:aspirations
Astrological Aspirations

### mod:Simstrology
Simstrology Mod

### mod:careers
Simstrology Career Mod

### mod:degrees
Simstrology Degree Mod

### mod:skills
Simstrology Skill Mod

### mod:childhood
Simstrology Childhood Mod

**Apply one or more** depending on which mods are involved.

---

## Quick Reference: Typical Combinations

**Bug report** (player reports something broken):
- `status:confirmed` + `type:bug` + `severity:X` + `mod:X`

**Player can't reproduce issue**:
- `status:needs-info`

**Two mods fighting**:
- `status:confirmed` + `type:compatibility` + `mod:X` + `mod:Y`

**Balance feedback** (not a bug, but feels off):
- `type:balance` + `mod:X` (no severity label)

**Player question**:
- `type:support` (no severity label, no status label)

**Duplicate of existing issue**:
- Close + comment linking to original

---

**Last updated:** April 11, 2026
