# CHANAKYA V2 — MASTER PLAN
> Prototype → Twin Specialized Apps (SSC + UPSC)
> Written 10 June 2026 · Trial run 11–12 June · SSC full launch **13 June 2026**

---

## 0. THE DECISION

The CHANAKYA SSC app (built 30 May – 10 June) is now declared the **prototype**. It proved the thesis end-to-end: diagnosis → archetype → mock → AI report → command dashboard → daily logs → payments. From this foundation we build **two specialized apps**:

1. **CHANAKYA SSC** — the refined launch product
2. **CHANAKYA UPSC** — the premium sibling, on the same engine

Everything below: mistakes to correct, philosophy to imbibe, UX to optimize, architecture to share, marketing to fire, and the 72-hour path to launch.

---

## 1. SEQUENCING — THE ONE STRATEGIC LAW

**Launch the SSC prototype on 13 June AS-IS (polished, not rebuilt). Build V2 architecture + UPSC after launch, fed by real user data.**

Why: a rebuild before launch means launching blind later. The prototype IS the market test. Every funnel number from launch week (where users drop in onboarding, which archetypes convert, what people actually pay for) becomes the spec for V2. Sun Tzu: *win first, then seek battle* — the launch is reconnaissance for V2.

- **Track A (10–13 June):** trial run, fixes, launch SSC v1
- **Track B (post-launch):** Turborepo monorepo → rebuild SSC on shared core → build UPSC on the same core

---

## 2. MISTAKES → LESSONS (the honest prototype audit)

### Engineering debts (verified in code/DB)
| # | Mistake | Lesson for V2 |
|---|---------|---------------|
| 1 | **Migration drift** — live DB has 11 tables; repo has only `001_payment_links.sql`. Migrations 005–007 applied via MCP, never committed | Every migration is a file in `supabase/migrations/` FIRST, applied second. Repo = single source of truth |
| 2 | Schema-drift bugs (`is_published` vs `status`) shipped and were found by breakage | Run `supabase gen types typescript` → column mismatches become compile errors, not runtime bugs |
| 3 | Webhook DB writes failed **silently** | Structured logging + Make.com → Telegram alert on every payment/webhook error. Silence is the enemy |
| 4 | One giant commit (whole app in one push) — no history to bisect | Feature branches, small commits, PR discipline even solo |
| 5 | Env chaos — placeholders lingered for days; payment-mode coupled to unfilled keys | Zod-validated env schema; app fails fast at boot with a named list of missing vars |
| 6 | Hardcoded values found at launch-check time (countdown, email, year) | Config-first: `lib/site.ts` pattern from day one in both V2 apps |
| 7 | Zero automated tests — every regression found by hand | Playwright smoke tests for the 5 money flows: login, diagnosis, mock, payment, report |
| 8 | **Analytics never wired** (PostHog/Clarity planned, never installed) — we cannot see funnels | ✅ FIXED 10 June: PostHog + Clarity wired (`lib/analytics.ts`, `AnalyticsProvider`); funnel events on login, every diagnosis card, mock start/submit, payment initiate/complete/fail. Just paste 2 keys in `.env.local` |
| 9 | RLS policies never audited | Trial-run security pass: attempt cross-user reads with anon key |

### What the prototype got RIGHT (carry forward untouched)
- Answer security: gate page strips `answer/explanation/shortcut` server-side; paywall enforced server-side; completed attempts redirect — **verified clean**
- Origin-derived auth redirects (zero-config across environments)
- `question_note_links` — the wrong-answer → remedial-note bridge (the quiet genius; make it a V2 centerpiece)
- Idempotent content migrations (ON CONFLICT DO UPDATE)
- Design laws (one card/screen, do-this-next, recovery > streaks, no shame, no fake scarcity)

### Product/process lessons
- Content was the bottleneck, not code (gates 7–10 still missing) → V2: scripted Daksha pipeline with validation CLI, not chat-paste
- CORRECTION (verified 10 June): onboarding ALREADY autosaves + resumes via localStorage, and the TestEngine ALREADY has question palette, mark-for-review, and progress restore. The prototype is better than remembered — V2 upgrade is **cross-device** (server-side) resume, not local resume
- Only ~19 of 42 cards feed the scoring engine — the rest feed report context or nothing. Audit each card: score, context, or cut
- Features built before validation (3 leaderboards, 3 tiers) — launch data decides what survives

---

## 3. THE PHILOSOPHY LAYER — FIVE DOCTRINES, FIVE MECHANICS

Each thinker maps to a concrete product mechanic — not decoration, function:

| Doctrine | Thinker | Product mechanic |
|----------|---------|------------------|
| **The Strategy** | Chanakya (Arthashastra/Niti) | The Command Dashboard — "do this next," never "what do you want?" The system's voice. Saam-Daam-Dand-Bhed = adaptive difficulty |
| **The War** | Sun Tzu (Art of War) | Know the enemy + know yourself = PYQ trap intelligence + identity diagnosis. "Every battle is won before it is fought" = the Gate prep cycle. Terrain = syllabus mapping |
| **The Detachment** | Krishna (Bhagavad Gita) | Daily log + recovery design. *Karmanye vadhikaraste* — your right is to the action, never the fruit. Post-mock screens show process metrics BEFORE score. The despondent Arjuna = the aspirant after a bad mock; the report is the Gita moment |
| **The Inner Citadel** | Marcus Aurelius (Meditations) | Morning anchor ritual + evening 2-line reflection in the daily log. "The obstacle is the way" = wrong answers auto-feed the smart-notes remediation loop |
| **The Ritual** | Confucius (Analects) | Habit cadence + level-completion ceremonies + reverence for small daily acts. The mentor-student honorific tone |

**Product feature:** "Doctrine of the Day" — one line from the five corpora, selected by archetype + recent behavior (missed day → Krishna on detachment; bad mock → Aurelius on obstacles; pre-exam → Sun Tzu on preparation). Zero content cost, infinite depth, brand-defining.

---

## 4. UI/UX REVIEW — THE OPTIMIZATION LIST

### Onboarding & cards (highest priority — it's the funnel mouth)
1. ~~Autosave + resume~~ EXISTS (localStorage). V2: **cross-device resume** (persist progress server-side so a phone→desktop switch continues)
2. Audit all 42 cards: keep ~19 scoring cards + best context cards; target ≤30 total — use launch-week PostHog per-card drop-off data to decide
3. Level-completion dopamine: progress celebration between the 7 levels ("Level 3 of 7 — your discipline profile is forming")
4. **Hinglish toggle** for card text — the audience is Hindi-medium majority
5. Mobile-first pass at 360px width — audience is 90% mobile

### Test engine (exam realism = product credibility)
6. Palette + mark-for-review + restore ALREADY EXIST (verified) — trial-run task is to compare against the real SSC CBT screen and close cosmetic gaps (colors, section tabs)
7. Section-time warnings (15/5 min) without inducing panic (no red flashing — calm amber, per no-shame law)

### Report & sharing (the viral loop)
8. **Shareable archetype card** — auto-generated image ("I am a Comeback Warrior — CHANAKYA SSC") for WhatsApp/Instagram status. This is the growth engine; treat as launch feature
9. Free mini-diagnosis BEFORE any paywall (converts "trust me" into "test me" — the objection killer)

### Dashboard
10. Enforce max-4 mission items; single "do this next" CTA above the fold
11. Doctrine of the Day slot

---

## 5. V2 ARCHITECTURE — ONE ENGINE, TWO ARMIES

```
chanakya/  (Turborepo monorepo — Turbo free tier)
├── apps/
│   ├── ssc/        → chanakyassc.netlify.app   (gold/dark theme)
│   └── upsc/       → chanakyaupsc.netlify.app  (deep blue/ivory theme)
├── packages/
│   ├── core/       → diagnosis engine, scoring, archetypes, mock engine, report prompts
│   ├── ui/         → ShadCN components + theme tokens (one design system, two skins)
│   ├── content/    → schemas, validators, Daksha pipeline CLI
│   └── db/         → Supabase clients + generated types
```

- **Exam-as-config:** marking scheme, sections, timing, gate structure = JSON config per app, not code. SSC: 100Q/60min/+2/−0.5. UPSC Prelims: 100Q/120min/+2/−0.66 + CSAT. One TestEngine reads both
- **Two Supabase free projects** (free tier allows exactly 2 active): same schema, separate data, separate auth
- **Netlify Pro** hosts both apps from one repo (two sites, two base dirs)
- "Syncing across parallels" = fix a bug in `packages/core` once → both apps inherit it

---

## 6. CHANAKYA UPSC — SPECIALIZATION NOTES

- **MVP = Prelims-only** (objective format → full engine reuse). Mains/essay evaluation = phase 2 (needs AI evaluation pipeline)
- Psychology shifts: older aspirants (24–32), multi-year cycles, optional-subject dilemma, working-professional preparation, deeper sunk-cost wounds → recalibrate archetype cascade + add cards (attempt count matters MORE here)
- Content: NCERT-first smart notes; UPSC PYQ trap corpus is massive and public
- The Chanakya brand fits UPSC *better* than SSC (the original civil-service strategist) — the twin launch strengthens both
- **Pricing premium:** UPSC aspirants spend 10–50× more. Ladder: Scout ₹0 → Warrior ₹999 → Commander ₹2,999 (capped) → War Room ₹9,999 cohort

---

## 7. PRICING & MARKETING (carry-forward from the 11-card playbook)

### Pricing
- **SSC (CANONICAL, in code since 11 June):** Scout ₹0 (full diagnosis + Gate 1 + report) → Founding Warrior ₹499 (genuinely capped founding cohort, rises to ₹999 steady) → Commander ₹999 launch → ₹1,999 (honestly capped by founder review hours)
- **UPSC:** premium ladder above
- Sell **direction + proximity**, never content volume. Never paywall trap alerts (acquisition engine). Price per attempt-cycle, no lifetime deals

### Marketing engine (all free/owned tools)
**AI video trailers (free platforms):**
- Google AI Pro → **Veo via Flow** for cinematic trailer shots (the Struggle → Selection arc)
- ChatGPT Plus → scripts + storyboards; Gemini → Hinglish variants
- CapCut/Canva free → editing, captions, reels assembly
- Existing asset: `marketing/trailer-script.md` + `/trailer` page — the script is already written

**Content per channel:**
| Channel | Content | Cadence |
|---------|---------|---------|
| Instagram (primary) | Trap-of-the-day reels (60 ready in `smart_notes`), archetype quiz, War Room breakdowns, AI trailer | Daily |
| YouTube Shorts | Same reels repurposed + 1 long-form "How I got AIR 91" | 3×/week |
| Telegram | Community + daily trap + founder presence (the moat) | Daily |
| WhatsApp | Broadcast channel: one trap + one doctrine line | Daily |
| Reddit | Honest founder posts in SSC subs (no spam — value posts with story) | 2×/week |

**The four pillars** (from playbook): Burn the Streak (polarizing) · War Room (proof) · Trap Alerts (free value) · Which Warrior Are You? (convert)

**Launch sequence:**
- 11 June: teaser trailer drops (all channels) — "Something is coming for the warriors"
- 12 June: origin story + free diagnosis link goes live to early list
- 13 June: launch post + founding cohort opens (₹499, honestly capped) + founder live in Telegram all day

### Platform roadmap (in priority order)
1. **Website** — now (13 June)
2. **PWA** — week 1 post-launch: same Next.js app made installable (manifest + service worker) → "app" on Android/Windows home screens, zero store fees, one codebase
3. **Android** — Capacitor/TWA wrap of the PWA → Play Store (₹2,500 one-time fee) when revenue justifies
4. **Windows** — PWA install via Edge covers it (native Tauri wrapper only if demanded)
5. **iOS** — last ($99/yr + Mac required; SSC/UPSC audience is overwhelmingly Android — defer until data argues otherwise)

---

## 8. TOOLS & RESOURCES ARSENAL (what we have, role assignment)

| Tool | Plan | Role in the system |
|------|------|--------------------|
| **Claude Pro** (+ Claude Code) | Paid | Chief architect — codebase, migrations, content engine, strategy docs, this plan |
| **Cursor Pro** | Paid | In-editor surgical edits, fast iteration during trial run |
| **ChatGPT Plus** | Paid | Second-opinion content gen, poster/thumbnail images, ad scripts |
| **Google AI Pro** | Paid | Gemini long-context (PYQ PDF analysis), **Veo/Flow for AI trailers**, NotebookLM (syllabus + source organization) |
| **Perplexity** | Free | Current-affairs research, GK fact verification for question bank |
| **Netlify Pro** | Paid | Hosting both apps, deploy previews, env management |
| **Make.com** | Free | Payment-link bridge, Telegram automation, error alerting |
| **Supabase** | Free ×2 | One project per app (free tier = exactly 2 active projects) |
| **Turborepo** | Free | V2 monorepo build system |
| **ShadCN UI** | Free | Shared component system across both apps |
| Razorpay | 2% txn | Payments (UPI) |
| Groq | Free | LLaMA 3.3 70B — report generation, note generation |
| Resend / Telegram Bot | Free | Email + community automation |
| PostHog + MS Clarity | Free | Funnels + session replays (WIRE BEFORE LAUNCH) |
| Cloudflare R2 | Free 10GB | Asset/question storage at scale |

---

## 9. THE 72-HOUR PLAN — 10 → 13 JUNE

### Today, 10 June (rest of day) — Keys & wiring
- [ ] Runbook steps 1–5: fill 4 secrets → Supabase Auth URLs → Razorpay webhook → Make.com activation → Netlify deploy with 7 env vars
- [ ] Wire PostHog + Clarity (can't trial-run blind)
- [ ] Confirm support mailbox + exam date in `lib/site.ts`

### 11 June — Trial Day 1: FUNCTION
- [ ] Full E2E as a real user, 3 devices (desktop, Android Chrome, small/old phone): signup → diagnosis (test resume/refresh behavior) → Gate 1 → report → payment (link mode, ₹1 test) → daily log → notes
- [ ] Security pass: RLS cross-user read attempt with anon key; verify webhook writes payments
- [ ] Drop teaser trailer on all channels (evening)
- [ ] Write the fix list; fix P0s same day

### 12 June — Trial Day 2: POLISH
- [ ] Fix remaining Day-1 bugs; re-run E2E
- [ ] Content QA: spot-check 10 questions per gate (60 total) for answer/explanation correctness
- [ ] Seed Telegram + WhatsApp channels; schedule 13 June content
- [ ] Origin story + free diagnosis link to early list
- [ ] If Razorpay KYC live: flip `NEXT_PUBLIC_PAYMENT_MODE=api` and test ₹1 real payment

### 13 June — LAUNCH
- [ ] Morning: launch post all channels; founding cohort opens
- [ ] Founder present in Telegram ALL DAY (proximity is the product)
- [ ] Watch PostHog funnels live: where do users drop in the 42 cards? (this number designs V2 onboarding)
- [ ] Hotfix window open; evening Day-1 numbers review

### Post-launch (Track B begins)
Week 1: PWA + shareable archetype card + gates 7–10 · Week 2–3: Turborepo migration, core extraction · Week 4+: CHANAKYA UPSC Prelims MVP on shared core.

---

*One engine. Two armies. The prototype proved the weapon works — now we forge two of them, properly.*
