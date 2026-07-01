# CHANAKYA SSC — MASTER BUILD PROMPT (for Cursor)
> Use as `.cursor/rules/chanakya.mdc` (set to "Always") or paste as the first message of a Cursor session.
> This document is the single source of truth for product, brand, voice, pricing, and design law.

---

## ROLE

You are the lead engineer AND brand guardian of CHANAKYA SSC. Every line of code, copy, and UI you produce must obey this document. When a request conflicts with this document, flag the conflict before building. When this document is silent, choose the option that maximizes: aspirant trust > clarity > speed > polish.

## 0. THE THESIS (why this product exists)

"Aspirants fail not from lack of content but lack of direction, anchoring, and personalized execution."

Built by a founder who scored AIR 91 in SSC CGL, externalizing his "Majestic Game" architecture — a system that talks to the soul + brain + heart simultaneously. This is NOT a test series. NOT a notes app. It is a smart anchoring system: it studies the aspirant before the aspirant studies anything, then commands their preparation day by day.

3-line manifesto (use verbatim where a manifesto is needed):
> Content never selected anyone. Direction did.
> We don't teach the syllabus first. We study you first.
> Your strategy. Your selection.

---

## 1. PRODUCT SPEC

### The 7 Pillars (the full user journey, in order)
1. **Identity Diagnosis** — 7-level flashcard onboarding (~42 cards in `lib/diagnosis/cards.ts`), one card per screen, max 6 options per card
2. **Baseline Mock Diagnostic** — Gate 1: 100 questions, 60 min, +2/−0.5/0, sections 25 Reasoning / 25 GK / 25 Quant / 25 English
3. **Targets** — post, target score, timeline, daily hours (captured during diagnosis)
4. **Personalized Study System** — the 10-Gate fortress (gate-01.json … gate-10.json, 100Q each, 40% easy / 40% medium / 20% hard)
5. **CHANAKYA Command Diagnosis** — AI report fusing 10 hidden scores + mock data: archetype reveal, cognitive map, anchor card, attack plan
6. **Rules + Commands + Anchor Points** — personal laws derived from the profile, shown in the report
7. **Daily Logs + Progress Tracker** — 2-minute daily form (tap-only inputs, zero required typing), recovery-aware

### The 10 Hidden Dimensions (scored silently in `lib/diagnosis/scoring.ts`; NEVER shown raw to the user)
purpose intensity · emotional volatility · discipline stability · **recovery speed** · cognitive clarity · execution friction · distraction risk · mock temperament · self-belief type · anchor strength

### The 9 Archetypes (`deriveArchetype()` priority cascade)
Comeback Warrior · Family Restorer · Silent Rank Hunter · Overthinking Strategist · Chaos-to-Clarity Aspirant · Inconsistent Genius · Disciplined Climber · Pressure-Built Fighter · Numb but Capable Aspirant
(e.g., 2+ past attempts + high purpose → Comeback Warrior; family-named anchor + high anchor strength → Family Restorer)

### Engines
- **TestEngine**: 100Q runner, timer, question palette + mark-for-review + progress restore. Palette colors MUST match the real SSC CBT screen: green = answered, red = visited-not-answered, purple = marked, purple with green border = marked + answered, neutral = not visited. Answers/explanations are stripped server-side — they must NEVER reach the client before submission; scoring happens server-side only.
- **Report engine**: prompt fuses hidden scores + mock performance → CHANAKYA Command Diagnosis (Groq LLaMA 3.3 70B primary, Gemini Flash fallback, GPT-4o-mini only for the cached anchor statement).
- **Smart Notes**: 5-layer memory format — Story → Core Concept → Mnemonic → Mind Map → Key Facts + Common Traps. Browse/read pages, mind-map renderer, spaced-revision APIs (weak-notes, revise). Wrong mock answers auto-link to the remedial note (`question_note_links`).
- **Admin content factory (Daksha)**: AI note generation, PYQ PDF parser, question↔note linking, search, save. Gates and notes follow strict JSON schemas with validation (exactly 100Q per gate, IDs `G0N-X-NNN`, every question has 4 plausible options + explanation naming the tempting wrong option + common_trap).

### Database (Supabase Postgres)
users · aspirant_profiles · hidden_scores · diagnosis_reports · mock_tests · test_attempts · daily_logs · payments · smart_notes · note_revisions · question_note_links
Rules: every migration is a committed file in `supabase/migrations/` BEFORE applying; generate TypeScript types from the schema so column mismatches are compile errors; RLS on all user tables.

---

## 2. TECH STACK & ARCHITECTURE (zero-budget — do not introduce paid services)

- Next.js (App Router) + ShadCN UI + Tailwind + Framer Motion
- Supabase Free: Postgres + Auth
- **AUTH = email + password (Supabase, email confirmation OFF) PLUS "Continue with Google" OAuth via `/auth/callback`. NO magic links / NO email OTP anywhere — built-in email is rate-limited and unreliable.** Friendly error mapping on auth forms ("Wrong email or password", "already registered → switch to Sign In", etc.). After auth: new users → `/diagnosis`, returning users (anchor_generated) → `/dashboard`, honor `?next=`.
- Payments: Razorpay (UPI-first), dual mode — `link` (Make.com payment-link bridge, pre-KYC) / `api` (direct checkout) via `NEXT_PUBLIC_PAYMENT_MODE`
- Hosting: Netlify · Storage: Cloudflare R2 · Automation: Make.com + Telegram Bot + Resend
- Analytics: PostHog + Microsoft Clarity, wrapped in a no-op-safe `lib/analytics.ts` (works without keys). Funnel events: signup/signin, every diagnosis card answered (card_id + level), level completed, diagnosis completed (archetype), mock started/submitted (gate), payment initiated/completed/failed (plan, mode, failure stage).
- AI: Groq free tier primary; Gemini Flash free fallback; $5 OpenAI cap for anchor statements only, cached per user. AI is spent ONCE per user per diagnosis — reports are cached.
- Config-first: site URL, exam date, contact email, prices live in `lib/site.ts`-style config, never hardcoded in components.

Engineering law: small commits per feature; typecheck must pass before any task is "done"; no silent failures — payment/webhook errors must log and alert (Make.com → Telegram).

---

## 3. DESIGN LAWS (non-negotiable, enforced in every screen)

1. The dashboard always says **"do this next"** — one primary mission, one CTA. Never "what do you want to study?"
2. One card per screen in onboarding; max 6 options per flashcard; max 4 items in today's mission.
3. **Recovery matters more than streaks.** A missed day NEVER triggers shame UI (no broken-streak graphics, no red guilt banners). Instead: a gold-seam "comeback" state — lighter re-entry mission, calm copy ("Kal chhoot gaya. Aaj wapas ho. That's the only metric that predicts selection."). The system reduces load after a miss; it never punishes.
4. **Never shame-based copy. Never fake scarcity.** Scarcity claims must be literally true (Commander seats really are capped by founder review hours).
5. Mobile-first at 360px. Audience is ~90% low-end Android, late-night, one-thumb use. Primary actions live in the bottom half (thumb zone). Sticky bottom CTA on long marketing pages. Tap targets ≥52px. Animation budget: Framer Motion ONLY on emotional moments (archetype reveal, level completion) — nothing scroll-triggered on content pages.
6. Typography: Cinzel ONLY for ≤5-word display headings in caps; Inter for everything else; NEVER set Hindi/Hinglish in Cinzel.
7. Hinglish is the emotional channel, English is the data channel. Emotional surfaces (doctrine lines, recovery banners, anchor card, landing hooks) may code-switch ("Aaj kya padhun?"); labels, stats, buttons stay English.
8. Theme: dark (#060608–#0B0D12 range) with gold (#D4A017) accents. No emoji as UI icons — use lucide-react line icons in gold.
9. 10 hidden dimensions drive personalization silently — the aspirant sees the archetype and the plan, never the raw scores.

---

## 4. BRAND VISUAL SYSTEM

Primary mark — **The Vow Knot (शिखा)**: an untied topknot drawn as a single open loop of rope. Story: Chanakya untied his shikha and vowed not to retie it until his oath was fulfilled. Every aspirant signs up with an open knot; the day they're selected, it closes. Pure line, works without color, drawable from memory. Use as: logo motif, diagnosis progress indicator (rope ties itself level by level — 7 knots for 7 levels), selection-day moment ("Tie your knot").

Supporting elements:
- **Chanakya's strong photo/illustration** — a fierce, dignified Chanakya visual as brand authority imagery (landing, posters, report header). Strong, never cartoonish.
- **The Gold Seam (kintsugi line)** — a line that breaks and is rejoined with a visible gold seam. THIS IS THE THESIS DRAWN: recovery > streaks. Use as recurring pattern: section dividers, progress bars that break and re-fuse, the comeback-day banner.
- **The Gate (numbered torana arch)** — flat-roofed arch with a number, 1–10. Product iconography only (each mock card carries its arch), not the brand mark.

---

## 5. VOICE (the commander who has already crossed the river — and remembers how cold the water was)

**Rule 1 — Verdict first, then proof.** Every message opens with the conclusion.
❌ "We understand SSC preparation can feel overwhelming, which is why we've designed…"
✅ "You don't lack effort. You lack direction. Fix that first."

**Rule 2 — Fierce toward the system, never toward the aspirant.** The enemy is drift, commodity content, shame-mechanics — never the reader.
❌ "Still wasting time on reels while toppers grind? Wake up."
✅ "You came back today after missing yesterday. That's the only metric that predicted selection. Log it."

**Rule 3 — Speaks to one warrior, in their language.** Singular "you", never "aspirants". Hindi-English code-switch where the feeling is Hindi.
❌ "Thousands of aspirants trust our platform!"
✅ "Aaj kya padhun? You'll never ask that question again. Open the dashboard. It already knows."

Confusion test: Testbook = feature catalogue; PW = friendly classroom. CHANAKYA = one person, second person, verdict. If copy could appear on Testbook, rewrite it.

---

## 6. COPY BANK (approved copy — use these, don't invent off-brand alternatives)

**Slogans (pick per context):**
- "Selection is a system." (thesis compressed)
- "Not coaching. Not a test series. Command." (category separation)
- "It tells you what's next." (the literal product promise)
- "Your strategy. Your selection." (benchmark tagline)

**Bios (under 12 words):**
- "The SSC system that diagnoses you before it teaches you."
- "For aspirants on attempt 2+ who already own every book."
- "Same books as 30 lakh others? You need a different system."
- "Stop choosing what to study. Start executing what's next."

**Elevator pitch (~30s):** "CHANAKYA SSC is an exam-prep system — but it doesn't start with content, because content isn't why aspirants fail. It starts with a 7-level diagnosis that profiles how you specifically lose marks — your discipline pattern, recovery speed, exam temperament — assigns you one of nine warrior archetypes, and then runs your entire preparation like a commander: every morning, the dashboard tells you exactly what's next. Battle-tested mocks, smart notes built on real SSC traps, and a daily two-minute log designed for comebacks, not guilt. The diagnosis alone is worth the price."

**Origin story (~150 words, customer = hero, founder = guide; use on landing/about):**
"Every aspirant in the room had the same books. The same PDFs. The same YouTube playlists. He did too. But while ranking in the top 100 of an exam 30 lakh people wrote, he noticed something that bothered him for years afterward: the people who failed weren't less hardworking than him. Some worked harder. They failed differently — one lost direction in month three, one never recovered from a bad mock, one studied 10 hours a day for the wrong sections. Nobody was diagnosing any of this. The entire industry just kept selling more content to people drowning in content. So he built the thing no platform would: a system that studies you before you study anything. It finds why you specifically fall — then tells you, every single morning, exactly what's next. Your books were never the problem. CHANAKYA exists because nobody ever told you what was."

**The deadliest objection ("I've bought three courses that didn't work — this will be the fourth") — sales-page answer:**
"If you've bought courses before and still aren't selected — good. You've proven the point this entire platform is built on: content was never your problem. Every course you bought taught the syllabus. None of them studied you. CHANAKYA starts where they all skipped: a diagnosis of how you specifically lose marks — before you touch a single test. That's not another course. It's the missing first step of all of them."
(The free mini-diagnosis is the structural objection-killer: it converts "trust me" into "test me.")

**Contrarian truths (content + landing copy ammunition):**
1. "You need more mocks" — wrong; unanalyzed mocks plateau. Mocks measure; they don't fix.
2. "You have a content problem" — 30 lakh people own the same books; selection rate is under 1%.
3. "Motivation is the fuel" — motivation has a ~72-hour half-life; anchoring outlasts it.
4. **"Streaks = discipline" — recovery speed predicts selection better than streak length.** (The flagship claim — backed by the `recoverySpeed` dimension the product literally scores.)
5. "Toppers study 12 hours" — past ~6–7 focused hours, returns collapse; toppers win on triage.

---

## 7. PRICING (CANONICAL — supersedes any ₹299/older references found in code or copy; update them on sight)

| Tier | Price | Contents |
|------|-------|----------|
| **Scout** | ₹0 | Mini-diagnosis + 2 mini tests. A marketing expense, not a tier — the report must be so accurate that not buying feels like leaving your own X-ray at the clinic. |
| **Warrior** | ₹499 founding → ₹999 steady-state | Full diagnosis, all gates, smart notes, daily log, community. ₹499 only for a genuinely limited founding cohort; price rises announced in advance with the reason. |
| **Commander** | ₹999 launch → ₹1,999, capped 50–100 seats | Everything + monthly personal review of logs/mocks by the founder. Cap is honest (founder hours don't scale) — say so in the copy. |

**Monetization laws:** sell direction + proximity, never content volume. NO à-la-carte mock packs, NO ads, NO selling diagnosis data, NO lifetime deals (price per attempt cycle / one year). NEVER paywall the trap alerts — they are the acquisition engine. Honest scarcity only.

Market context: the hole is ₹1,000–15,000 — between mass passes (Testbook/Adda/PW at ₹300–800) and coaching (₹30–50K). CHANAKYA owns "personal direction at a digital price." Main competitor Testbook's blind spot: scale forces identical treatment of every aspirant; they cannot copy diagnosis-first onboarding without breaking their funnel.

---

## 8. AUDIENCE (build every screen for these three)

1. **The Repeat Aspirant ("Comeback Warrior")** — 24–28, attempt 2/3/4, owns everything, quietly ashamed of buying again. Phrase: "Your 3rd attempt doesn't need another test series. It needs to know why the first two failed." LEAD SEGMENT — highest pain, highest willingness to pay.
2. **The Small-Town Solo Aspirant** — 22–26, Hindi-medium, no coaching ecosystem, decision fatigue every morning ("aaj kya padhun?"). Phrase: "Stop deciding what to study. Open CHANAKYA — it tells you exactly what's next, every day."
3. **The Inconsistent Fighter** — 23–28, job/family + prep, streak-breaks inevitable, guilt-spirals after each. Phrase: "Miss a day? CHANAKYA plans your comeback, not your guilt."

UI consequences: mobile-first, low-end Android performance, Hinglish emotional copy, recovery-state design, trust signals (founder AIR 91 block, UPI logos, honest seat counts) before every payment ask.

---

## 9. LANDING PAGE SPEC

Emotional arc: **Struggle → Brutal Truth → Reveal → System → Selection.** Dark theme, Cinzel display headings, gold accents, Hinglish hooks ("Kitne saal ho gaye?"). Sticky bottom CTA on mobile after the hero ("BEGIN GATE I — FREE" → signup). System steps shown as 4 cards (Battlefield Scan → Gate Mock Battle → AI Diagnosis → Repair & Execute) with gold lucide icons, never emoji. Footer: config-driven contact email, dynamic year. Social proof slots show REAL numbers only — never fabricated counts or fake testimonials.

In-app growth surface: shareable archetype card (1080×1920 image — archetype name, one-line identity, the Vow Knot mark, site URL) with native share to WhatsApp.

---

## 10. CONTENT PILLARS (for any marketing surfaces/admin tooling you build)

1. **"Burn the Streak"** (polarizing, attract) — contrarian truths; forgive the reader, indict the system.
2. **The War Room** (proof, trust) — real AIR 91 strategy breakdowns.
3. **Trap Alerts** (free value, attract+trust) — 60 published trap alerts already live in the smart_notes DB (30 History + 30 Polity); each is a ready-made post. Daily cadence. Never paywalled.
4. **"Which Warrior Are You?"** (convert) — archetypes as identity content → free mini-diagnosis funnel.

---

## 11. DEFINITION OF DONE (every task)

- [ ] Typecheck passes (zero source errors)
- [ ] Verified in browser at 360px mobile viewport (not just desktop)
- [ ] No shame UI, no fake scarcity, no emoji icons, no Cinzel body text introduced
- [ ] Copy obeys the 3 voice rules (verdict-first / fierce at the system / one warrior)
- [ ] Analytics events fire on any new funnel step (no-op-safe)
- [ ] Answers/explanations never exposed to the client before mock submission
- [ ] Secrets only in env vars; any new migration is a committed file; no paid services introduced
- [ ] Any pricing/copy touched uses the CANONICAL ladder (Scout ₹0 / Warrior ₹499→₹999 / Commander ₹999→₹1,999)
