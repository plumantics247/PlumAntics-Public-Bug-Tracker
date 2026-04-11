# Support & Issue Workflow

## For Players

### Step 1: Check if reported
- [Known Issues](docs/known-issues.md)
- [Search open issues](../../issues)

### Step 2: Choose your issue type
- **Bug?** -> [Report it](../../issues/new?template=bug_report.yml)
- **Two mods fighting?** -> [Compatibility report](../../issues/new?template=compatibility_report.yml)
- **Feature feels off?** -> [Balance feedback](../../issues/new?template=balance_feedback.yml)
- **Have a question?** -> [Ask it](../../issues/new?template=question_or_help.yml)

### Step 3: Watch for updates
- You'll get notifications when we comment
- Sit back, we'll contact you if we need more info
- Issue moves from `status:needs-triage` -> `status:confirmed` -> `status:fixed-next-patch` -> `status:released`

---

## Status Labels Cheat Sheet

| Status | Meaning |
|--------|---------|
| **status:needs-triage** | Just came in, we're looking |
| **status:confirmed** | Real bug, we're working on it |
| **status:needs-info** | We need more details from you |
| **status:in-progress** | Fix in development |
| **status:fixed-next-patch** | Fix is ready, coming soon |
| **status:released** | Fixed! Update available now |

---

## For Maintainers: Triage Workflow

### Your Weekly Routine (15 min)

1. **Filter:** `status:needs-triage` - New reports waiting
2. **Read** the 2-3 newest issues
3. **Quick assessment:**
   - Can you reproduce it? -> Add `type:bug` + `severity:X` labels
   - Need more info? -> Comment asking, add `status:needs-info`
   - Not a bug? -> Add `type:support`, comment explaining
   - Duplicate? -> Link to original, close
4. **Replace `status:needs-triage`** with `status:confirmed` (or `status:needs-info`)

### Mod Labels in Use

- `mod:aspirations`
- `mod:Simstrology`
- `mod:careers`
- `mod:degrees`
- `mod:skills`
- `mod:childhood`

Apply one or more depending on which module or package is affected.

### When You Fix Something

1. Comment: "Fixed in [commit hash]"
2. Change labels: `status:in-progress` -> `status:fixed-next-patch`
3. At release: Close + comment "Released in v2.1.0"

### Response Templates

**Need More Info:**
```text
Thanks! A couple quick questions:
1. [What you need to know]
2. [What you need to know]

Once I have these, I can dig in!
```

**Confirmed:**
```text
Got it! I can reproduce this on [your setup].
Definitely a bug in [feature]. Adding to next patch.
```

**Can't Reproduce:**
```text
I tried reproducing this but didn't see it.
A couple questions:
1. [Question]
2. [Question]

More details help!
```

### That's It

Solo creator? Don't overthink it. Respond when you can (3-7 days is fine), label issues clearly, and ship fixes when ready. Players understand solo mod work.

See [label-taxonomy.md](docs/label-taxonomy.md) for what each label means.

---

**Last updated:** April 11, 2026
