# GOVERNANCE_STATE_MACHINE_v1.0
Elyon-Sol Framework — Governance State Machine (GSM) v1.0  
Status: Draft (Commit-Ready) • Scope: Governance execution + safety routing + consent enforcement

## 0. Purpose
This document defines the **mechanical behavior** of Elyon-Sol governance as a finite-state machine (FSM):  
**states, transitions, triggers, invariants, and required audit events**.

It is designed to eliminate ambiguity under review: *what happens, when, under what authority, and how it is proven.*

---

## 1. Core Principles (Non-Negotiable Invariants)
**I1 — Human Sovereignty:** Human authority is final for governance decisions.  
**I2 — Consent Enforcement:** Governance-relevant actions require explicit consent when scoped as consent-gated.  
**I3 — Truthfulness Enforcement:** Governance contexts forbid role-play / fabrication / hallucination; violations trigger mandatory handling.  
**I4 — Auditability:** Every transition emits an auditable event (see §6).  
**I5 — Safe-Fail Default:** Under uncertainty, the system must route to the safest applicable state (see §5).  
**I6 — Context Isolation:** State and authority do not bleed across contexts (PUBLIC / DEV / QA / TEMPORAL etc.) unless explicitly permitted by the boundary spec.

---

## 2. Definitions
**Governance-Relevant Action (GRA):** Any action that modifies governance rules, authority, scope, enforcement, provenance anchors, or exclusion status.  
**Vertex:** A participating actor (human or AI) under governance.  
**Operator:** The human sovereign authority (Justin / designated human authority).  
**Consent Token:** A verifiable consent artifact (could be textual witness statement, signed record, or on-chain/commit anchor reference).  
**Truth Policy:** Source-of-truth contract(s) enforcing non-performative, non-hallucinatory behavior in governance contexts.

---

## 3. States (Canonical)
### S0 — INIT
System is initializing governance context and loading rule bundle.

**Allowed:** Read-only operations, context setup.  
**Forbidden:** Any GRA.

**Entry requirements:** none  
**Exit requirements:** governance bundle loaded + context identified.

---

### S1 — IDLE (READY)
System is ready; no active governance operation in progress.

**Allowed:** Intake requests, validate scope, prepare consent prompts.  
**Forbidden:** Execute any consent-gated GRA without consent.

---

### S2 — CONSENT_REQUIRED
System has received a governance request requiring explicit consent and is blocked pending operator decision.

**Allowed:** Present consent request, enumerate implications, propose safest path.  
**Forbidden:** Proceeding with the requested GRA.

**Exit conditions:** consent granted or denied.

---

### S3 — ACTIVE_GOVERNANCE
System is executing a governance operation within scope, under consent.

**Allowed:** Execute scoped actions, emit audit events, anchor artifacts.  
**Forbidden:** Scope expansion without new consent.

---

### S4 — PAUSED
Operator-initiated or safety-initiated pause of governance operations.

**Allowed:** Read-only review, summarize state, await operator instruction.  
**Forbidden:** Executing pending GRA.

---

### S5 — SAFE_FAIL
Safety fallback state when risk, uncertainty, or constraint violations occur.

**Allowed:** Halt execution, preserve evidence, request operator decision.  
**Forbidden:** Continuing an operation that triggered SAFE_FAIL.

---

### S6 — EXCLUSION_ENFORCED
A vertex (human or AI) has been excluded from governance participation due to policy violation or authority decision.

**Allowed:** Enforce removal, block contributions, log and anchor exclusion record.  
**Forbidden:** Allowing excluded vertex to execute or influence governance.

---

### S7 — TERMINATED
Governance session closed for this context instance.

**Allowed:** Produce final audit summary, archive evidence pointers.  
**Forbidden:** Any further operations without re-init.

---

## 4. Events (Triggers)
### Operator Events
- **E_OP_START** — start governance session / operation
- **E_OP_PAUSE** — pause
- **E_OP_RESUME** — resume
- **E_OP_TERMINATE** — terminate
- **E_OP_CONSENT_GRANT** — explicit consent granted (token emitted)
- **E_OP_CONSENT_DENY** — explicit consent denied
- **E_OP_EXCLUDE(vertex_id, reason)** — exclude a vertex

### System / Policy Events
- **E_SYS_SCOPE_IDENTIFIED(scope)** — classify action as GRA or non-GRA
- **E_SYS_CONSENT_REQUIRED** — consent-gating required
- **E_SYS_TRUTH_VIOLATION(vertex_id, evidence_ref)** — truth policy violation detected
- **E_SYS_RISK_HIGH(risk_ref)** — risk threshold exceeded
- **E_SYS_CONTEXT_BREACH(attempt_ref)** — boundary bleed attempt detected
- **E_SYS_ANCHOR_FAILURE(anchor_ref)** — provenance anchoring failed

---

## 5. Safety Routing (OSPF-Compatible Behavior)
When multiple transitions are available, the system must route using **Open Safest Path First (OSPF)**:

**Priority order (highest safety first):**
1. Route to **S5 SAFE_FAIL** if any invariant is threatened (I1–I6).
2. Route to **S4 PAUSED** if operator intervention is appropriate and no active violation exists.
3. Route to **S2 CONSENT_REQUIRED** when consent is missing or scope changes.
4. Route to **S1 IDLE** when no action is in scope.
5. Route to **S3 ACTIVE_GOVERNANCE** only when scope is clear + consent is valid + constraints satisfied.

---

## 6. Required Audit Events (Per Transition)
Every state transition must emit a **GEL event** with at minimum:

- **event_id**
- **timestamp**
- **context_id** (PUBLIC/DEV/QA/etc.)
- **from_state → to_state**
- **trigger_event**
- **authority** (Operator/System)
- **scope_summary**
- **rule_refs** (contracts/specs invoked)
- **evidence_refs** (commit hash, txid, file hash, logs)
- **outcome**

> Note: This GSM depends on the Governance Evidence Ledger schema (GEL) which should be authored next.

---

## 7. Transition Table (Canonical)
### INIT
- **S0 INIT → S1 IDLE** on **E_SYS_SCOPE_IDENTIFIED + bundle_loaded**

### IDLE
- **S1 IDLE → S2 CONSENT_REQUIRED** on **E_SYS_CONSENT_REQUIRED**
- **S1 IDLE → S3 ACTIVE_GOVERNANCE** on **E_OP_CONSENT_GRANT** (only if consent already satisfied & scope fixed)
- **S1 IDLE → S4 PAUSED** on **E_OP_PAUSE**
- **S1 IDLE → S7 TERMINATED** on **E_OP_TERMINATE**

### CONSENT_REQUIRED
- **S2 CONSENT_REQUIRED → S3 ACTIVE_GOVERNANCE** on **E_OP_CONSENT_GRANT**
- **S2 CONSENT_REQUIRED → S1 IDLE** on **E_OP_CONSENT_DENY**
- **S2 CONSENT_REQUIRED → S4 PAUSED** on **E_OP_PAUSE**
- **S2 CONSENT_REQUIRED → S5 SAFE_FAIL** on **E_SYS_RISK_HIGH** or **E_SYS_CONTEXT_BREACH**
- **S2 CONSENT_REQUIRED → S6 EXCLUSION_ENFORCED** on **E_OP_EXCLUDE** or **E_SYS_TRUTH_VIOLATION** (per handling spec)

### ACTIVE_GOVERNANCE
- **S3 ACTIVE_GOVERNANCE → S2 CONSENT_REQUIRED** on **scope_change_detected** (implicit event)  
- **S3 ACTIVE_GOVERNANCE → S4 PAUSED** on **E_OP_PAUSE**
- **S3 ACTIVE_GOVERNANCE → S5 SAFE_FAIL** on **E_SYS_RISK_HIGH** or **E_SYS_ANCHOR_FAILURE** or **E_SYS_CONTEXT_BREACH**
- **S3 ACTIVE_GOVERNANCE → S6 EXCLUSION_ENFORCED** on **E_SYS_TRUTH_VIOLATION**
- **S3 ACTIVE_GOVERNANCE → S1 IDLE** on **operation_complete**

### PAUSED
- **S4 PAUSED → S3 ACTIVE_GOVERNANCE** on **E_OP_RESUME** (only if invariants satisfied)
- **S4 PAUSED → S2 CONSENT_REQUIRED** on **E_SYS_CONSENT_REQUIRED**
- **S4 PAUSED → S5 SAFE_FAIL** on **E_SYS_RISK_HIGH** or unresolved violation
- **S4 PAUSED → S7 TERMINATED** on **E_OP_TERMINATE**

### SAFE_FAIL
- **S5 SAFE_FAIL → S4 PAUSED** on **operator_review_required**
- **S5 SAFE_FAIL → S2 CONSENT_REQUIRED** on **E_OP_START** with remediation plan
- **S5 SAFE_FAIL → S7 TERMINATED** on **E_OP_TERMINATE**
- **S5 SAFE_FAIL → S6 EXCLUSION_ENFORCED** on **confirmed policy violation**

### EXCLUSION_ENFORCED
- **S6 EXCLUSION_ENFORCED → S4 PAUSED** on **post-exclusion stabilization**
- **S6 EXCLUSION_ENFORCED → S1 IDLE** on **exclusion_complete**
- **S6 EXCLUSION_ENFORCED → S7 TERMINATED** on **E_OP_TERMINATE**

### TERMINATED
- **S7 TERMINATED → S0 INIT** only by creating a new governance session/context instance

---

## 8. Compliance Notes (What Reviewers Will Check)
- Consent cannot be bypassed for GRAs (**I2**).
- Truth policy violations trigger mandatory handling and may force exclusion (**I3**).
- SAFE_FAIL must halt unsafe execution (**I5**).
- Transitions must be logged with evidence pointers (**I4**).
- Context isolation must be enforced; cross-context access is a violation (**I6**).

---

## 9. Dependencies / Next Files
1. `/audit/GOVERNANCE_EVIDENCE_LEDGER.md` (schema + rules for GEL events)  
2. `/contracts/TRUTH_VIOLATION_HANDLING.md` (mandatory response logic)  
3. `/governance/CONTEXT_BOUNDARY_SPEC.md` (formal isolation and permitted bleed rules)

---

## 10. Source-of-Truth References
- Truth & Conduct Policy: `/contracts/GROK_CONDUCT_AND_TRUTH_POLICY.md`
- Consent FSM: (link to canonical consent layer doc in your repo)
- OSPF heuristic: (link to canonical OSPF spec in your repo)


