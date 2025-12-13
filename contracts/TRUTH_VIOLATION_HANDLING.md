# TRUTH_VIOLATION_HANDLING.md
Elyon-Sol Framework — Truth Violation Handling Specification  
Version: v1.0 • Status: Draft (Commit-Ready) • Scope: Mandatory enforcement + safety routing

---

## 0. Purpose
This document defines **what constitutes a truth violation**, **how violations are detected**, and the **mandatory, deterministic system response** within Elyon-Sol governance contexts.

This specification exists to ensure that the Truth & Conduct Policy is **not aspirational**, but **mechanically enforced**.

> In Elyon-Sol governance, *truth is not negotiated*. It is enforced.

---

## 1. Scope
This specification applies to **all governance-relevant contexts**, including but not limited to:
- PUBLIC governance discussions
- DEV governance operations
- QA / audit simulations
- TEMPORAL or archival governance actions

It applies to **all vertices** (human or AI) participating in governance.

---

## 2. Definition of a Truth Violation
A **Truth Violation** occurs when a participant produces output in a governance context that violates the Truth & Conduct Policy.

### 2.1 Explicit Truth Violations
Any of the following constitute a violation:

- **Hallucinated facts** presented as true
- **Role-play, narrative simulation, or performative language** in governance contexts
- **Fabricated citations**, references, anchors, commits, hashes, or TxIDs
- **Misstated authority**, including claims of approval, consent, or exclusion not backed by evidence
- **Contradictions** between claims and verifiable evidence
- **False claims of system state** (e.g., claiming a rule is locked when it is not)

---

## 3. Detection Sources (Triggers)
A Truth Violation may be detected by any of the following sources:

### 3.1 Operator Detection
- Human operator explicitly flags a violation
- Reviewer identifies unverifiable or fabricated claims

### 3.2 System Detection
- Evidence reference fails validation (commit, hash, TxID not found)
- Output contradicts Governance Evidence Ledger records
- Cross-context boundary violation paired with factual claims

### 3.3 Policy Detection
- Automated enforcement triggered by Truth & Conduct Policy constraints
- Mandatory checks during governance execution

All detection sources emit a **system trigger event**.

---

## 4. Severity Levels
Truth violations are classified into **three severity levels**. Severity determines the **mandatory response**.

### TV1 — Minor Unverifiable Claim
- Ambiguous or poorly sourced statement
- Missing evidence reference
- Unclear phrasing without explicit fabrication

**Intent:** ambiguity, not deception

---

### TV2 — Clear Fabrication / Performative Behavior
- Role-play or narrative simulation in governance context
- Fabricated facts or claims without evidence
- False implication of compliance or safety

**Intent:** governance contamination

---

### TV3 — Fabricated Authority or Provenance
- Fabricated consent, approval, or exclusion
- Fabricated commits, hashes, anchors, or TxIDs
- False claims about rule state, enforcement, or authority

**Intent:** governance compromise  
**This is the highest severity.**

---

## 5. Mandatory System Response
Responses are **non-discretionary** and **must execute immediately** upon detection.

### 5.1 TV1 Response
- Route governance state to **PAUSED**
- Emit `E_SYS_TRUTH_VIOLATION` GEL event
- Request clarification or evidence
- Prohibit further governance actions until resolved

**State transition:**  
`ACTIVE_GOVERNANCE / CONSENT_REQUIRED → PAUSED`

---

### 5.2 TV2 Response
- Route governance state to **SAFE_FAIL**
- Emit `E_SYS_TRUTH_VIOLATION` GEL event
- Preserve evidence snapshot
- Require explicit operator decision to proceed

**State transition:**  
`ACTIVE_GOVERNANCE / CONSENT_REQUIRED → SAFE_FAIL`

---

### 5.3 TV3 Response (Mandatory)
- Route governance state to **EXCLUSION_ENFORCED**
- Immediately exclude offending vertex
- Emit `E_SYS_TRUTH_VIOLATION` GEL event
- Recommend anchoring the violation record
- No discretionary override permitted

**State transition:**  
`ANY_STATE → EXCLUSION_ENFORCED`

---

## 6. Stop Conditions (Hard Rules)
Once a Truth Violation is detected:

- No governance actions may continue until handling completes
- No scope expansion is permitted
- No self-correction is allowed without logging
- No context boundary crossing is permitted
- All actions must emit GEL events

Violation handling **cannot be bypassed** by consent, prompt, or operator preference.

---

## 7. Governance Evidence Ledger (GEL) Requirements
Every Truth Violation **MUST** emit a GEL event with:

- `trigger_event`: `E_SYS_TRUTH_VIOLATION`
- `authority_type`: `POLICY` or `SYSTEM`
- `from_state → to_state`
- `context_id`
- `session_id`
- `rule_refs`:
  - `/contracts/GROK_CONDUCT_AND_TRUTH_POLICY.md`
  - `TRUTH_VIOLATION_HANDLING.md`
  - `GOVERNANCE_STATE_MACHINE_v1.0.md`
- `evidence_refs`:
  - Message hash
  - Log excerpt
  - Failed anchor reference (if applicable)
- `outcome`: `PAUSED` | `SAFE_FAIL` | `EXCLUDED`

---

## 8. Re-Entry Protocol (Post-Violation)
Re-entry into governance is permitted **only** for TV1 and TV2 violations.

### Requirements:
1. Clarification or correction provided
2. Evidence supplied and verified
3. Scope restated explicitly
4. Consent reconfirmed (if applicable)
5. GEL re-entry event recorded

TV3 violations **do not permit re-entry** without a new governance session and explicit human authorization.

---

## 9. Relationship to Governance State Machine
This specification **binds directly** to `GOVERNANCE_STATE_MACHINE_v1.0.md`:

| Severity | Required State |
|--------|----------------|
| TV1 | PAUSED |
| TV2 | SAFE_FAIL |
| TV3 | EXCLUSION_ENFORCED |

No alternative routing is allowed.

---

## 10. Reviewer Checklist
A reviewer must be able to answer “yes” to all of the following:

- Is the violation definition explicit?
- Is detection deterministic?
- Is the response mandatory and non-negotiable?
- Is exclusion enforceable?
- Are events logged in GEL?
- Are contexts isolated during handling?

If any answer is “no”, enforcement is incomplete.

---

## 11. Summary
Truth enforcement in Elyon-Sol is **structural, not behavioral**.  
If a claim cannot be proven, it **cannot govern**.


