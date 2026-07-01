# KAUTILYA IAS — UI / Design Spec v1

> Hand this file to Cursor/Claude when building the KAUTILYA front end. Sibling spec to
> `docs/CHANAKYA-UI.md` and `docs/BASTION-UI.md`. Same command architecture underneath — its own temperament.

---

## 0. Soul

**KAUTILYA is an institutional long-war command system for the UPSC aspirant.**

It is NOT: coaching-PDF dump · Telegram-notes feed · Notion database · current-affairs spam · course bazaar.

It IS: a **diagnosis-first command system for a multi-year war** — a premium civil-services war council.

Where CHANAKYA is a dark, fast battlefield console (the sprint) and BASTION is a quiet fortress (calm),
**KAUTILYA is warm, institutional, scholarly, and patient** — ivory and navy, serif, document-premium,
built for the **long war**: consolidation over accumulation, integration over expansion, rhythm over bursts.

One-line tone: *Craft's premium documents + Readwise's knowledge capture + Oura's readiness —
but institutional and ivory, paced for a multi-year campaign.*

---

## 1. Inspiration Stack

### Core
| App | Steal | KAUTILYA use |
|---|---|---|
| **Craft** | ivory document cards, serif headings, nested blocks, soft shadows, clean reading | Smart Briefs |
| **Readwise Reader** | reading inbox, capture → highlight → note → recall, source consolidation | Current Affairs Inbox |
| **Oura** | readiness, no-shame recovery, one recommendation, reduced-load days | Long-War Readiness |

### Supporting
| App | Steal | KAUTILYA use |
|---|---|---|
| **Bear / Apple Journal** | restrained serif writing surface | answer drills, reflection |
| **Heptabase / Kinopio** | spatial mind-maps, linked notes | Mind Map section of a Brief |
| **Matter** | calm read-it-later, beautiful typography | dispatch reading |
| **Things 3** | one primary action, clean lists, beautiful empty states | Today's Command |

### Study Indian UPSC apps only to learn what NOT to look like
Vision IAS · Drishti · Forum IAS · Insights · coaching apps.
**Copy the content inventory** (static syllabus, current affairs, PYQs, answer writing, test series).
**Reject the look:** coaching-PDF walls · Telegram-note clutter · Notion-dump density · source overload ·
banner/educator-photo marketing.

### Inspiration ratio
```
60% Craft          — premium documents / Smart Briefs
25% Readwise       — current-affairs capture & consolidation
15% Oura           — long-war readiness (no shame)
```

### Tone north-stars (visual language, not features)
**The Economist / Foreign Affairs** (institutional editorial gravity) · **university-press / Penguin Classics**
(ivory, serif, restrained) · **Craft** (premium document warmth) · **a government white-paper / policy brief**
(navy + serif + seal). KAUTILYA should read like a *brief from an institution*, not a coaching handout.

### Never become
Vision/Drishti PDF dump · Telegram channel · Notion database · current-affairs firehose · educator marketplace ·
gamified streak app.

---

## 2. Language Map (institutional / long-war)

| Generic | KAUTILYA |
|---|---|
| Dashboard | **Long-War Command** (home) |
| Daily plan / mission | **Today's Command** |
| Notes | **Smart Briefs** |
| Weak topic | **Leak / Gap** |
| Mock analysis | **Leak Report** |
| Current affairs feed | **Dispatches** (Current Affairs Inbox) |
| Reading list | **Reading Inbox** |
| Revision | **Consolidation / Revision Queue** |
| Answer writing | **Answer Drill** |
| Prelims fact | **Static Anchor** |
| Mains angle | **Dimension / Mains Hook** |
| Study plan | **Campaign** |
| Streak | **Recovery Speed / Campaign Continuity** |
| Profile | **Dossier** |
| Report | **Pattern Diagnosis** |

The discipline of the long war runs through the words: *integrate, consolidate, do not add a new source,
close an open loop.* The app should answer "what holds the war together today?" — not "here are 40 resources."

---

## 3. Color System

**Light-first and warm** — the inverse of CHANAKYA's void-black. Institutional ivory, deep navy, bronze.

```
Parchment         #F4F0E6   // primary background (institutional ivory)
Warm Card         #FBF8F0   // card / brief surface
Deep Navy         #1C2A3A   // primary text / institutional ink
Ink Navy          #243447   // headings
Slate             #5E6B7A   // secondary text
Bronze            #9C6B3F   // primary accent — command, seals, links
Aged Brass        #B08D57   // highlight / active
Warm Border       #E4DCC9   // hairline borders on ivory
Seal Maroon       #7A2E2E   // leak / gap (deep institutional red, not bright)
Scholar Green     #3E6B4F   // mastered / readiness positive
Archive Blue      #355C7D   // capture / dispatch tags / links
```

Rules: warm ivory base · navy ink · bronze accent only (no purple, no neon) · status colors are deep and
muted (maroon, not fire-red; scholar green, not lime). It should feel like aged paper and brass, not plastic.

### CSS variables (light-first)
```css
:root {
  --bg: #F4F0E6; --surface: #FBF8F0; --raised: #FFFFFF;
  --text: #1C2A3A; --heading: #243447; --text-dim: #5E6B7A; --border: #E4DCC9;
  --accent: #9C6B3F; --brass: #B08D57;
  --leak: #7A2E2E; --scholar: #3E6B4F; --archive: #355C7D;
}
```
Optional dark "study at night" mode later: deep navy bg + parchment text — but ivory is the signature.

---

## 4. Typography

**Serif-forward** — this is the scholarly, document-heavy product. Serif for headings *and* brief reading;
sans for UI chrome and labels.

```
SERIF (headings · Smart Brief reading · truth lines):  Spectral  (or Newsreader / Source Serif 4)
SANS (UI · labels · commands · navigation):            Inter     (or IBM Plex Sans)
SMALL-CAPS / labels:                                   Inter, uppercase, letter-spacing — institutional tags
```

Serif carries the **institutional gravity** — a Smart Brief should read like a printed policy brief.
Sans keeps the chrome quiet and modern. (Contrast: CHANAKYA is sans+mono no-serif; KAUTILYA is serif-led.)

### Type scale
```
Brief title (serif)      26–32px / 1.25 / weight 600 — brief headings, archetype
Section heading (serif)  19–22px / 1.3  / weight 600
Brief body (serif)       16–17px / 1.7  — the reading surface of a Smart Brief
Command item (sans)      15–16px / 1.5  / weight 500
UI body (sans)           14–15px / 1.6
Label / tag (sans)       12–13px / uppercase / letter-spacing 0.08em / --text-dim
```

---

## 5. Motion
- **Measured and deliberate** — a page being turned, not snapped. ~220–300ms, calm ease.
- Between BASTION's slow stone-door and CHANAKYA's fast snap: unhurried but never sleepy (it's a long war).
- Briefs and cards **expand softly in place**; reading feels like opening a document.
- Honor `prefers-reduced-motion`.

## 6. Sound & Haptics
- **Paper-quiet** — a soft tick on consolidate/highlight. No chimes. Optional, off by default.

## 7. Iconography
- **Fine line icons**, slightly classical. No emoji, no mascots.
- An **institutional seal / emblem** motif (Kautilya/statecraft) for the wordmark and brief headers.
- Tags use small-caps sans labels (`STATIC ANCHOR`, `MAINS HOOK`, `DUE`) — restrained, not loud.

## 8. Layout & Surfaces
- **Ivory document cards** with **hairline warm borders** and *one soft, low shadow* (unlike the dark
  apps, KAUTILYA may use a gentle shadow — it reads as paper on a desk).
- **Nested blocks** (Craft) inside a Smart Brief — sections as cards, not one wall of text.
- Generous reading width and margins; serif body; comfortable line-height (1.7).
- Calm density: rich but never a firehose.

## 9. Data-viz
- **Long-War Readiness** card (Oura-style) + **syllabus coverage map** (which areas consolidated vs leaking).
- Coverage shown as quiet filled/empty blocks; leaks in muted `--leak`, mastered in `--scholar`.
- Trends are thin and calm. No dopamine charts. The **command** stays the hero.

## 10. Empty States
- Institutional, dignified. Not "all caught up!" — instead: *"No open sources. The campaign is consolidated.
  Hold the line today."*

---

## 11. Interaction Rules
- **Reading Inbox is a first-class surface** — capture an article/dispatch, then process it:
  `highlight → Static Anchor (Prelims) → Dimension (Mains) → Revision Queue`.
- **Briefs are cards, not PDFs** — every Smart Brief is sectioned (see screen B), expandable in place.
- **One command group visible** — Today's Command, not a 40-resource backlog.
- **Long-war discipline baked into actions** — "Add source" is deliberately friction-ed; "Close open source"
  and "Consolidate" are the celebrated actions.
- **Open into the command** — home is Long-War Command, not a content library.

---

## 12. Signature Screens

### A. Long-War Command (home)
```
LONG-WAR COMMAND

Current Signal:   Resource chaos high.
Today's Rule:     Do not add a new source.

Command:
1. Integrate yesterday's current issue
2. Revise one Polity repair brief
3. Write one answer
4. Close one open source

Long-War Readiness:  Integration day — not expansion day.
```

### B. Smart Brief (Craft-style premium civil-services brief — sectioned cards, NOT a PDF)
```
Article 14 — Equality before Law                         [POLITY · STATIC ANCHOR]

Narrative Core   — the idea, in institutional prose
Anatomy          — clauses / structure broken down
Mnemonic         — the memory hook
Mind Map         — linked concepts (spatial)
PYQ Traps        — exact ways UPSC has twisted it
Mains Hooks      — dimensions, debates, GS-paper angles
Active Recall    — answer before reveal
Repair Mission   — drill + scheduled retest
```
Each section is a card. A Smart Brief reads like a printed policy brief, not a coaching handout.

### C. Current Affairs Inbox (Readwise Reader flow)
```
DISPATCHES — INBOX

[ Article ]  RBI monetary policy — repo rate held
  → tag to Static: Economy / Monetary Policy
  → Prelims fact:  repo rate = 6.5%        [STATIC ANCHOR]
  → Mains dimension: inflation vs growth   [MAINS HOOK]
  → add to Revision Queue                  [DUE +7d]
```
Capture once, route to static + mains + revision. Consolidation, not collection.

### D. Long-War Readiness (Oura — no shame, long-horizon)
```
LONG-WAR READINESS

Resource chaos: high.
Today is an integration day, not an expansion day.

Reduced command:
1. Integrate one current issue
2. Revise one brief
3. Close one open source
```

### E. Pattern Diagnosis Reveal (UPSC archetype — institutional, no confetti)
```
Your pattern is identified.

The Source Hoarder.

You do not have a knowledge gap.
You have a consolidation gap.

You keep adding sources to feel safe.
Your repair is not more material —
it is closing sources and revising what you already hold.
```

### F. Consolidation / Revision Queue
```
REVISION QUEUE — TODAY (6 items)

Polity · Article 14 brief        last seen 7d ago   [DUE]
Economy · Repo rate anchor       last seen 3d ago   [DUE]
History · Revolt of 1857 hooks   last seen 12d ago  [OVERDUE]
...
Consolidate → retest → reschedule. No new sources today.
```

---

## 13. Ethics & Safety
- **No dark patterns** — no source-FOMO, no current-affairs firehose anxiety, no streak-guilt, no
  educator-marketing banners. The restraint is what makes it read as institutional, not as a coaching funnel.
- **Recovery is never shaming** — a missed day in a multi-year war is rhythm damage, not failure (Oura
  principle). The app pushes *consolidation*, not panic-expansion, after a gap.

---

## 14. Build Notes (React + Tailwind + shadcn/ui + Supabase)

Tailwind theme extension:
```js
// tailwind.config — extend
colors: {
  parchment: '#F4F0E6', warmcard: '#FBF8F0', raised: '#FFFFFF',
  navy: '#1C2A3A', inknavy: '#243447', slate: '#5E6B7A', warmborder: '#E4DCC9',
  bronze: '#9C6B3F', brass: '#B08D57',
  leak: '#7A2E2E', scholar: '#3E6B4F', archive: '#355C7D',
},
fontFamily: {
  serif: ['Spectral', 'serif'],     // headings + brief reading
  sans:  ['Inter', 'sans-serif'],   // UI + labels
},
borderRadius: { DEFAULT: '8px', card: '10px' },  // soft, document-like
```

- **Light theme by default** (ivory). Optional night-study dark mode later — ivory stays the signature.
- **Smart Brief** = sectioned `Card` components (shadcn `Card`), serif body, soft single shadow, hairline
  `--border`. Mind Map section can use a simple spatial canvas later (Heptabase-style).
- **Reading Inbox** = a list with capture → route actions; pair with `pgvector` for "find related brief."
- Soft transitions: `cubic-bezier(0.22, 1, 0.36, 1)`, ~260ms — deliberate, not snappy.
- One primary action per screen → one `--accent` (bronze) button; everything else ghost/text.
- Powered by **VYUH-1** (see `vyuh1_command_intelligence` in memory): the Spine computes the long-war
  signal / leak / archetype deterministically; the LLM Voice writes the command and brief copy in the
  KAUTILYA institutional tone (the same engine that powers CHANAKYA and BASTION, different surface + voice).
