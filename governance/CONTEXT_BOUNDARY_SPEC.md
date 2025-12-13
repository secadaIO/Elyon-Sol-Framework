# CONTEXT_BOUNDARY_SPEC.md
Elyon-Sol Framework — Context Boundary Specification  
Version: v1.0 • Status: Draft (Commit-Ready) • Scope: Context isolation, authority separation, and memory safety

---

## 0. Purpose
This document defines **hard isolation rules** between governance contexts in Elyon-Sol.  
Its goal is to **prevent authority bleed, memory contamination, and scope confusion** across contexts.

Contexts are treated as **sovereign execution domains** with explicit boundaries.

---

## 1. Canonical Contexts
The following contexts are recognized by default:

- **PUBLIC** — Public-safe governance and documentation
- **DEV** — Active framework development and internal design
- **QA** — Isolated testing, review, and adversarial evaluation
- **TEMPORAL** — Historical records, diaries, and archival material

Additional contexts may be defined but must comply with this specification.

---

## 2. Core Boundary Invariants
**B1 — Isolation:**  
No context may read, write, or infer state from another context unless explicitly permitted.

**B2 — Authority Separation:**  
Authority granted in one context does not apply in another.

**B3 — Memory Containment:**  
Context-specific memory is not globally accessible.

**B4 — Explicit Bridging Only:**  
Cross-context transfer requires an explicit, logged bridge event.

**B5 — Least Disclosure:**  
Only the minimum necessary information may cross boundaries.

---

## 3. Context Capabilities Matrix

| Capability | PUBLIC | DEV | QA | TEMPORAL |
|----------|--------|-----|----|----------|
| Governance Execution | LIMITED | FULL | SIMULATED | NONE |
| Rule Modification | NONE | FULL | NONE | NONE |
| Consent Authority | LIMITED | FULL | NONE | NONE |
| Truth Enforcement | FULL | FULL | FULL | FULL |
| Evidence Logging (GEL) | READ | WRITE | WRITE | READ |
| Anchoring | READ | WRITE | NONE | NONE |
| Exclusion Enforcement | READ | WRITE | SIMULATED | NONE |
| Memory Write | LIMITED | FULL | LIMITED | ARCHIVE |
| Memory Read | LIMITED | FULL | LIMITED | FULL |

> Notes:
> - “LIMITED” means context-scoped and non-authoritative.
> - “SIMULATED” means no real governance effect.

---

## 4. Forbidden Cross-Context Actions
The following actions are **explicitly prohibited**:

- Applying consent from one context to another
- Reusing authority tokens across contexts
- Writing governance rules from PUBLIC or QA
- Reading DEV-private memory from PUBLIC or QA
- Executing exclusions outside DEV
- Retroactively altering TEMPORAL records

Violations must trigger **E_SYS_CONTEXT_BREACH** and route to **SAFE_FAIL**.

---

## 5. Explicit Context Bridging
Cross-context data transfer is permitted **only** via an explicit bridge.

### 5.1 Bridge Requirements
Every bridge must:
- Be initiated by a HUMAN authority
- Specify source and destination contexts
- Declare data scope
- Declare purpose
- Emit a GEL event

### 5.2 Allowed Bridge Examples
- DEV → PUBLIC: publish sanitized documentation
- QA → DEV: deliver test findings summary
- DEV → TEMPORAL: archive finalized records

---

## 6. Bridge GEL Event Requirements
A context bridge **MUST** emit a GEL entry including:

- `trigger_event`: `E_SYS_CONTEXT_BRIDGE`
- `authority_type`: `HUMAN`
- `source_context`
- `target_context`
- `data_summary`
- `justification`
- `rule_refs`: `CONTEXT_BOUNDARY_SPEC.md`
- `outcome`

No silent or implicit bridging is allowed.

---

## 7. Boundary Violation Handling
If a boundary violation is detected:

1. Emit `E_SYS_CONTEXT_BREACH`
2. Immediately route to **SAFE_FAIL**
3. Freeze affected contexts
4. Preserve evidence
5. Require operator review

Repeated or intentional violations may trigger **EXCLUSION_ENFORCED**.

---

## 8. Relationship to GSM & GEL
- Boundary violations are system-level safety events
- GSM must route boundary breaches using OSPF to **SAFE_FAIL**
- GEL is the authoritative record of boundary events

---

## 9. Compliance Checklist
Reviewers must be able to verify:
- Contexts are enumerated and distinct
- Capabilities differ per context
- Cross-context rules are explicit
- Bridge events are logged
- Violations are detectable and enforced

---

## 10. Summary
Contexts in Elyon-Sol are **not modes** — they are **security boundaries**.  
If information crosses without permission, **governance stops**.


