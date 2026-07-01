# CHANAKYA SSC — UI / Design Spec v1

> Hand this file to Cursor/Claude when building the CHANAKYA front end. Sibling spec to
> `docs/BASTION-UI.md`. Same command architecture underneath — opposite temperament.

---

## 0. Soul

**CHANAKYA is a battle command system for the SSC aspirant — an elite operator console for the exam war.**

It is NOT: content marketplace · course-card bazaar · banner-heavy homepage · discount-first storefront ·
teacher-photo gallery · PDF library · habit toy.

It IS: a **diagnosis-first command system** — *less bazaar, more war-room.*

Where BASTION is a quiet fortress (slow, warm, serif, calm), **CHANAKYA is darker, sharper, faster** —
a cold operator console. High contrast, gold accents, thin borders, keyboard-driven, mission-led.

One-line tone: *Linear's command console + Oura's recovery intelligence + Brilliant's active repair —
but darker and sharper.*

---

## 1. Inspiration Stack

### Core
| App | Steal | CHANAKYA use |
|---|---|---|
| **Linear** | Cmd-K command palette, thin borders, deep charcoal, fast nav, status tags, compact lists, sharp type | the entire console feel |
| **Oura** | recovery status, no-shame after a bad day, one recommendation, reduced load on low days | Recovery Status |
| **Brilliant** | question-first learning, tiny concept checks, instant feedback, short loops | Smart Notes as repair sessions |

### Supporting
| App | Steal | CHANAKYA use |
|---|---|---|
| **Raycast** | command palette as primary surface, extensions, keyboard everything | Cmd-K command layer |
| **Superhuman** | speed, keyboard shortcuts, onboarding-as-induction | operator flow |
| **Vercel / dev dashboards** | dark sharp data surfaces, status pills, restraint | Mock Leak Analysis, metrics |

### Study Indian exam apps only to learn what NOT to look like
Testbook · Adda247 · PW · Unacademy — content-marketplace products.
**Copy the feature inventory** (mocks, topic practice, answer analysis, current affairs).
**Reject the look:** marketplace clutter · banners · course-card overload · discount-first · too many CTAs ·
teacher/photo-heavy layout.

### Inspiration ratio
```
80% Linear     — command console
15% Oura       — recovery status (no shame)
 5% Brilliant  — active repair learning
```

### Never become
Testbook marketplace clutter · PW course banners · Unacademy educator gallery · Notion generic database ·
Habitica/Duolingo gamification · Asana corporate task board.

---

## 2. Language Map (war-room, not classroom)

| Generic | CHANAKYA |
|---|---|
| Dashboard | **War Room** (home = Today's Command) |
| Daily plan / mission | **Today's Command** |
| Task | **Command Item** |
| Weakness / weak topic | **Leak** |
| Mock analysis | **Mock Leak Analysis** |
| Notes | **Smart Notes / Repair Notes** |
| Practice set | **Repair Drill** |
| Revision | **Retest** |
| Study plan | **Campaign** |
| Streak | **Recovery Speed** |
| Profile | **Operator Dossier** |
| Report | **Pattern Diagnosis** |
| Search / actions | **Command Palette** (Cmd-K) |

The app must feel like an operator console, not a coaching app. The aspirant never asks "where do I go?" —
the app answers "here is the command."

---

## 3. Color System

Darker and sharper than BASTION. Cooler whites, **gold** (not copper) accent, higher contrast, sharper reds/greens.

```
Void Black        #08090B   // deepest background
Charcoal          #14161A   // primary surface
Gunmetal          #1E2228   // raised cards / panels
Steel Grey        #8A8F98   // secondary text, hints
Cold White        #ECEFF3   // primary text (cooler than BASTION's ivory)
Command Gold      #C9A227   // primary accent — command, focus, seals
Sharp Amber       #E0A106   // highlight / active state
Leak Red          #B23A3A   // leaks / weak topics (sharper than BASTION)
Strike Green      #2FA866   // correct / recovery / mastered
Signal Blue       #3B6FB0   // info / links / neutral tags
```

Rules: high-contrast dark · gold accent only (no purple, no rainbow) · status colors are crisp, not pastel.
This is the one place CHANAKYA is allowed more saturation than BASTION — it's a battlefield, not a fortress.

### CSS variables
```css
:root {
  --bg: #08090B; --surface: #14161A; --raised: #1E2228;
  --text: #ECEFF3; --text-dim: #8A8F98; --border: #262A31;
  --accent: #C9A227; --amber: #E0A106;
  --leak: #B23A3A; --strike: #2FA866; --signal: #3B6FB0;
}
```

---

## 4. Typography

**No serif.** A battlefield console is sharp sans + mono. (Serif is BASTION's signature, not CHANAKYA's.)

```
DISPLAY / HEADINGS (sharp grotesk):  Space Grotesk  (or Geist)
UI / BODY (sans):                    Inter  (or Geist)
MONO (tags · metrics · palette · timers · question IDs):  Geist Mono  (or JetBrains Mono / IBM Plex Mono)
```

The **mono** is the operator-console signature — use it for status pills, mark counts, timers, the Cmd-K
palette, and question/topic IDs. It's what makes it read as a war-room instrument, not a study app.

### Type scale
```
Command title (display) 24–30px / 1.2 / weight 600 — "TODAY'S COMMAND", archetype
Section heading (display)18–22px / 1.3 / weight 600
Command item (sans)      15–16px / 1.5 / weight 500
Body (sans)              14–15px / 1.6
Tag / metric / ID (mono) 12–13px / uppercase / letter-spacing 0.04em / --text-dim
```

---

## 5. Motion
- **Fast and snappy** (Linear/Raycast) — 120–200ms, sharp ease. The opposite of BASTION's slow stone-door.
- **Keyboard-first** — Cmd-K opens instantly; navigation feels instantaneous.
- Subtle, functional transitions only. No breathing gradients, no ambient drift — this is a tool, not a mood.
- Honor `prefers-reduced-motion`.

## 6. Sound & Haptics
- **Crisp, minimal feedback** — a short tick on command-complete / correct answer. No long chimes.
- Optional. Off by default. The console is silent unless it confirms an action.

## 7. Iconography
- **Thin, geometric line icons**, slightly sharper/smaller-radius than BASTION's. No emoji, no mascots.
- Status pills (mono): `LEAK` `RECOVERING` `MASTERED` `DUE` `RETEST` — Linear-style tags.

## 8. Layout & Surfaces
- **Thin 1px borders** (`--border`), **small radius (4–6px)** — sharp, not soft.
- **Compact lists** with status tags (Linear issue-list feel).
- One soft shadow token max; mostly borders, not shadows.
- Dense but uncluttered: information-rich like a dev dashboard, never a marketplace.

## 9. Data-viz
- **Sharp, functional** — accuracy bars, leak heat by topic, mark-leak trends. Crisp lines, mono labels.
- Leak = `--leak`, mastered = `--strike`. Allowed to be more vivid than BASTION (still not neon).
- One **Recovery Status** card is the headline signal — but the **command** is still the hero.

## 10. Empty States
- Operator-toned, not chirpy. Not "🎉 caught up!" — instead: *"No active leaks flagged. Run a diagnostic mock."*

---

## 11. Interaction Rules
- **Cmd-K command palette is the spine** — every action reachable by keyboard:
  `Start Today's Command · Repair Polity · Open Mock Leak Analysis · Log Marks Leaked · Retest Weak Pattern`.
- **Status tags everywhere** — every topic/command carries a mono pill (LEAK / RECOVERING / MASTERED).
- **One command group visible** — the War Room shows today's command, not a 30-item backlog.
- **No fake-complete** — completing a Repair Drill requires the actual retest, not a checkbox.
- **Open into the command** — home is Today's Command, not a course catalog.

---

## 12. Signature Screens

### A. War Room — Today's Command (home)
```
TODAY'S COMMAND

Primary Leak:        Polity — Article Traps        [LEAK]
Prescribed Repair:   Article 14 / 15 / 16 active recall

Mission:
1. Read repair note        — 7 min
2. Answer 20 trap questions — 15 min
3. Log 3 mistakes          — 5 min
4. Retest tomorrow

Recovery Status:     Returned after 1 missed day.
```

### B. Command Palette (Cmd-K)
```
⌘K
> Start Today's Command
  Repair Polity
  Open Mock Leak Analysis
  Log Marks Leaked
  Retest Weak Pattern
```

### C. Mock Leak Analysis
```
MOCK #14 — LEAK REPORT

Marks leaked:  -18
By cause:
  Silly mistakes      -7    [RECOVERING]
  Concept gap         -6    [LEAK]   → Polity Article traps
  Time mismanagement  -5    [LEAK]   → Quant DI section

Prescribed: 2 repair drills + 1 timed section retest.
```

### D. Smart Note = Repair Session (Brilliant-style, NOT a PDF)
```
Article 14 — Equality before Law

1 concept   → the idea, one screen
1 trap      → the exact way SSC twists it
1 active recall → answer before reveal
3-question repair drill → instant feedback
retest      → scheduled for tomorrow
```
Smart Notes are guided repair sessions, never walls of text.

### E. Recovery Status (Oura — no shame)
```
RECOVERY STATUS

Returned after 1 missed day.
Do not attempt a full mock today.

Today's reduced command:
1. Repair 2 weak topics
2. 20-question drill
3. Sleep on time
```

### F. Pattern Diagnosis Reveal (archetype — stark, no confetti)
```
Your pattern is identified.

The Silly-Mistake Bleeder.        (one of CHANAKYA's archetypes)

You do not have a knowledge gap.
You have an attention leak under time pressure.

Your repair is not more syllabus —
it is timed drills and a mistake log.
```

---

## 13. Ethics & Safety
- **No dark patterns** — no discount countdowns, no fake scarcity, no streak-guilt, no notification spam.
  The restraint is what makes it read as elite, not as a coaching-app funnel.
- Recovery language is **never shaming** after a missed day (Oura principle) — a missed day is rhythm
  damage, not failure.

---

## 14. Build Notes (React + Tailwind + shadcn/ui + Supabase)

Tailwind theme extension:
```js
// tailwind.config — extend
colors: {
  void: '#08090B', charcoal: '#14161A', gunmetal: '#1E2228',
  steel: '#8A8F98', coldwhite: '#ECEFF3', border: '#262A31',
  gold: '#C9A227', amber: '#E0A106',
  leak: '#B23A3A', strike: '#2FA866', signal: '#3B6FB0',
},
fontFamily: {
  display: ['Space Grotesk', 'sans-serif'],
  sans: ['Inter', 'sans-serif'],
  mono: ['Geist Mono', 'monospace'],
},
borderRadius: { DEFAULT: '5px', card: '6px' },  // sharp, not soft
```

- **Command palette:** use shadcn `command` (built on `cmdk`) — wire global ⌘K. This is the priority component.
- **Status pills:** small mono `Badge` variants — `leak` / `recovering` / `mastered` / `due` / `retest`.
- Dark theme only; thin `--border` on cards, minimal shadow.
- Fast transitions: `cubic-bezier(0.4, 0, 0.2, 1)`, ~150ms. No long easings.
- The **command is always the hero** — Recovery Status and metrics are secondary cards beneath it.
- Powered by **VYUH-1** (see `vyuh1_command_intelligence` in memory): the Spine computes leak/archetype
  deterministically; the LLM Voice writes the command/repair copy in the CHANAKYA battlefield tone.
