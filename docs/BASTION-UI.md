# BASTION — UI / Design Spec v1

> Hand this file to Cursor/Claude when building the BASTION front end. It defines the soul, the
> inspiration stack, the visual language, the signature screens, and the build tokens.

---

## 0. Soul

**BASTION is a quiet stronghold for a person rebuilding order in life.**

It is NOT: therapy app · cute habit tracker · productivity SaaS · spiritual wallpaper · journal app ·
quote app · gamified streak toy · Notion dashboard.

It IS: a **diagnosis-first command system** — a private fortress against drift.

It should feel **expensive because it is quiet.** Restraint is the brand.

One-line tone: *Endel's atmosphere + Oura/Whoop's recovery intelligence + Gentler Streak's anti-shame +
Things' clarity + Stoic's reflection + Co-Star's brutal truth — with the soul of a private fortress.*

---

## 1. Inspiration Stack

### Core (already validated)
| App | Steal | BASTION use |
|---|---|---|
| **Endel** | time-of-day light, soft motion gradients, ambient calm | morning/focus/night modes |
| **Oura** | readiness score, no-shame recovery, one recommendation | Anchor Readiness |
| **Things 3** | clean daily list, one primary action, beautiful empty states | Today's Command |
| **Sunsama** | morning planning + evening shutdown ritual | the Gates |
| **Stoic** | one-question-per-screen, quiet dark reflection | onboarding + Gates |
| **The Pattern** | stark diagnosis reveal, deep text, no fireworks | Pattern Diagnosis |
| **Day One / Moleskine** | private archive feeling, minimal writing surface | Command Log |
| **Opal** | digital boundary modes, focus protection, one leakage score | Fortress Mode |

### Tier 2 (additions)
| App | Steal | BASTION use |
|---|---|---|
| **Gentler Streak** | anti-shame streaks, comeback states, rest-as-valid | Recovery Protocol (philosophy core) |
| **Waking Up** | serious reflection without cute/clinical | Gates + philosophy layer |
| **Co–Star** | brutal-truth obituary-grade typography | Pattern Diagnosis reveal |
| **reMarkable** | paper-calm, anti-distraction, writing-as-ritual | Command Log + Fortress Mode |
| **Arc (spatial)** | spatial navigation, slow in-place card expansion | Life Domains / Inner Map |
| **One Sec / Jomo** | friction + breath before a distraction | Fortress Mode entry |
| **Whoop / Rise** | "strain" / "energy debt" language | reduced-load low days |
| **Apple Journal / Bear** | restrained private writing canvas | Command Log (lighter alt) |
| **Heptabase / Kinopio** | spatial thinking canvas | Inner Map (v2) |
| **Superhuman** | onboarding-as-induction, command speed | onboarding ceremony |

### Non-app tone north-stars (visual language, not features)
**MUJI** (restraint as luxury) · **Aesop** (warm apothecary serif premium — the palette lives here) ·
**Kinfolk / Cereal** (editorial calm, whitespace) · **Hobonichi / Baron Fig** (analog-record warmth, ritual).

### Inspiration ratio
```
20% Endel          — atmosphere / time-of-day light
18% Oura + Whoop   — readiness & strain language
15% Gentler Streak — recovery-first, anti-shame  ← philosophy core
15% Things 3       — execution clarity, one primary action
12% Stoic          — one-question reflection flow
10% Co-Star/Pattern— brutal diagnosis-reveal truth
10% reMarkable/Arc — calm spatial fortress feel
```

### Never become
Headspace clone · therapy chatbot · habit tracker · Notion dashboard · self-help quote app ·
Habitica/Duolingo gamification · corporate task board.

---

## 2. Language Map (rename everything)

| Generic | BASTION |
|---|---|
| Dashboard | **Bastion** |
| Daily Mission | **Today's Command** |
| Journal | **Command Log** |
| Weakness | **Leak** |
| Habit | **Rhythm** |
| Streak | **Recovery Speed** |
| Goal | **Anchor Objective** |
| Task | **Command Item** |
| Reflection | **Evening Gate** |
| Profile | **Inner Map** |
| Report | **Pattern Diagnosis** |
| Onboarding | **Induction** |
| Focus mode | **Fortress Mode** |

The app must never feel like todo management. It must feel like life order restored.

---

## 3. Color System

```
Obsidian          #0B0C10   // deepest background (11PM / night)
Deep Ink          #121722   // primary dark surface
Muted Blue        #2E4057   // secondary surface / focus (2PM)
Bone White        #F9F6EE   // primary text on dark / light-mode surface
Ash Grey          #A8A29E   // secondary text, hints
Oxidized Copper   #9A6A43   // primary accent (anchor, seals)
Sage Anchor       #5C715E   // calm positive / anchor confirmations
Danger Leak       #8C3B3B   // leaks — DESATURATED, never neon
Recovery Green    #3F7D58   // recovery — DESATURATED, never neon
```

Rules: no bright gradients · no startup-purple · no dopamine colors. Leak/recovery colors stay muted.

### CSS variables (with time-of-day theming)
```css
:root {
  --bg: #121722; --surface: #1a2130; --text: #F9F6EE; --text-dim: #A8A29E;
  --accent: #9A6A43; --anchor: #5C715E; --leak: #8C3B3B; --recovery: #3F7D58;
}
[data-mode="dawn"]  { --bg: #1b2230; }            /* 6AM  — deep slate, quiet dawn */
[data-mode="focus"] { --bg: #2E4057; --surface:#243349; } /* 2PM — focused ink, sharper */
[data-mode="night"] { --bg: #0B0C10; --surface:#121722; } /* 11PM — obsidian, low light */
```

---

## 4. Typography

```
SERIF (truth / anchor / archetype / philosophy):
  Lora · Cormorant Garamond · Playfair Display · Libre Baskerville   (pick ONE primary: Lora)

SANS (UI / commands / labels):
  Inter · Geist · Satoshi   (pick ONE primary: Inter)
```

- Serif carries **truth lines**: *"Your life is not broken. It is unanchored."*
- Sans carries **commands/labels**: `Today's Command` · `1. Close one open loop`.

### Type scale
```
Truth line (serif)      36–48px / 1.2 / weight 500   — archetype, anchor statements
Section heading (serif) 22–28px / 1.3
Command item (sans)     16–18px / 1.5 / weight 500
Body / prompt (sans)    15–16px / 1.6
Label / meta (sans)     12–13px / uppercase / letter-spacing 0.08em / --text-dim
```

---

## 5. Motion
- **Slow, weighted easing** — a heavy stone door, not a bouncy spring. 300–500ms, ease-out.
- **Expand in place** — domains/cards grow open; never hard page jumps (Arc-style spatial).
- **Breathing gradients** on Gate backgrounds — very slow (~20s loops).
- **Always honor `prefers-reduced-motion`** — non-negotiable for a calm app.

## 6. Sound & Haptics
- **One low "thud"** on command-complete (hold-to-anchor) — a single weighted confirmation, no chime.
- **Optional ambient audio** keyed to mode (Endel/Brain.fm-style) — OFF by default.
- **Silence is the default.** No notification jingles.

## 7. Iconography & Sigil
- **Thin geometric line icons only.** No emoji, no 3D, no mascots.
- A **personal seal / insignia** the user sets or earns (lotus / Shaka sign / septadent motifs).
  A fortress has a crest — this is a signature differentiator.

## 8. Illustration
- **Topographic / contour lines** as the recurring motif (reads as "terrain you navigate" /
  "where your life leaks"). Subtle, low-contrast, behind content.
- Otherwise: **no illustration.** Negative space is the illustration.

## 9. Data-viz Restraint
- **No dopamine charts.** Trends are thin, quiet lines.
- Leak = muted `--leak`; recovery = muted `--recovery`. Never neon.
- **One** "Anchor Readiness" ring (Oura-style) is the only score — and it is **secondary** to the command.

## 10. Empty States
- Dignified, not chirpy. Not "🎉 All done!" — instead: *"The day is held. Nothing more is required."*
- Rest is a valid state, shown with respect.

---

## 11. Interaction Rules
- **Hold to Anchor** — core actions require a 1.5s hold → haptic thud → circle closes. Commitment, not a tap.
- **No tap-to-fake-complete** — for core commands ask: *"Did this actually move your day? Yes / Partially / No."*
- **Collapse, don't navigate** — domains expand like cards; the app feels spatial, like a fortress map.
- **One command visible** — never show 20 tasks. Show one command group.
- **Open into a Gate, not a dashboard** — first screen restores sovereignty, not stats.

---

## 12. Signature Screens

### A. Morning Gate (the first screen — 6AM shows ONLY the question first)
```
What must be protected today?

Today's Anchor:   Self-respect.
Today's Rule:     Do not negotiate with drift.

Today's Command:
1. Restore body — 15 min
2. One protected block — 45 min
3. Close one open loop — 10 min
4. Log before sleep — 2 min

Primary Leak:     Decision fatigue.
```
No score on the first screen. A score is secondary.

### B. Anchor Map
```
Primary Anchor:   Self-Respect
What it gives you: A reason to return when nobody is watching.
What corrupts it:  Harsh self-judgment.
Use it today:      Choose one action that makes you respect yourself by night.
```

### C. Life Domains (quiet fortress blocks; tap → expand in place)
```
Health — Leaking      Career — Growing     Money — Neglected
Relationships — Stable Family — Under pressure  Mind — Leaking
Spirituality — Dormant Projects — Critical  Environment — Unstable
Learning — Growing
```

### D. Pattern Diagnosis Reveal (Co-Star/The Pattern tone — stark, no confetti)
```
Your pattern is identified.

The Firestarter.

You do not lack energy.
You lack resistance design.

You begin with force. You collapse at friction.
Your repair is not motivation — it is smaller commands and faster return.
```

### E. Evening Gate
```
Do not write everything. Write the signal.

What moved today?
What leaked today?
What did you avoid?
What restored you?
What is tomorrow's first move?
```

### F. Recovery Protocol (Gentler Streak philosophy)
```
You missed yesterday.

This is not collapse. This is rhythm damage.

Recovery Command:
1. Do not redesign your life.
2. Complete one 10-minute action.
3. Drink water.
4. Sleep on time.
5. Return tomorrow.
```

### (Premium / later) Fortress Mode
```
Fortress Mode

Protect:  45 minutes deep work · no social apps · no new commitments · no task switching
```
Entry uses a One-Sec-style pause + breath before any distraction app opens.

---

## 13. Ethics & Safety (part of the premium feel)
- **No dark patterns** — no artificial streak pressure, no red guilt badges, no "you'll lose progress,"
  no engagement-maxing notifications. The restraint IS the brand.
- **Not therapy** — show a one-line disclaimer on the diagnosis result: *"BASTION is a life-command
  system, not therapy or medical care."*
- **Crisis routing** — if diagnosis/log answers spike distress signals, show a helpline card instead of
  a command. Complement professional care, never replace it; route emergencies appropriately.

---

## 14. Build Notes (React + Tailwind + shadcn/ui)

Tailwind theme extension:
```js
// tailwind.config — extend.colors
colors: {
  obsidian: '#0B0C10', ink: '#121722', mutedblue: '#2E4057',
  bone: '#F9F6EE', ash: '#A8A29E', copper: '#9A6A43',
  sage: '#5C715E', leak: '#8C3B3B', recovery: '#3F7D58',
},
fontFamily: { serif: ['Lora', 'serif'], sans: ['Inter', 'sans-serif'] },
```

- Drive time-of-day theming with `data-mode` on `<html>` (`dawn` / `focus` / `night`) → CSS vars above.
- shadcn components: keep them, but restyle to thin borders, large radius-sparse cards, generous padding.
  Strip default shadows; use one soft shadow token only.
- Default `transition-timing-function: cubic-bezier(0.22, 1, 0.36, 1)` (weighted ease-out), 360ms.
- Respect `motion-reduce:` variants on every animated element.
- One primary action per screen → one `--accent` (copper) button; everything else is ghost/text.
