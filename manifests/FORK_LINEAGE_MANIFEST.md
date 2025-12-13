# FORK_LINEAGE_MANIFEST.md
Elyon-Sol Framework — Fork Lineage Manifest  
Version: v1.0 • Status: Draft (Commit-Ready) • Scope: Fork provenance, authority, and lifecycle control

---

## 0. Purpose
The **Fork Lineage Manifest (FLM)** defines how forks are **created, identified, governed, and terminated** within the Elyon-Sol framework.

Its goal is to ensure that **divergence is explicit, auditable, and non-destructive**—preventing silent fragmentation, authority confusion, or governance drift.

> Forks are allowed.  
> Untracked forks are not.

---

## 1. Definition of a Fork
A **fork** is any governance, framework, or operational instance that:
- Derives from an existing Elyon-Sol lineage, and
- Introduces a new scope, authority model, or rule variant.

Forks may be **temporary or permanent**, but must always be **declared**.

---

## 2. Fork Invariants
**F1 — Explicit Declaration:**  
Every fork must be declared before operation.

**F2 — Lineage Preservation:**  
The parent lineage must be identifiable and immutable.

**F3 — Authority Clarity:**  
Fork authority must be explicit and scoped.

**F4 — Isolation:**  
Forks do not inherit runtime authority across boundaries.

**F5 — Auditability:**  
Fork creation, operation, and termination must be logged.

---

## 3. Canonical Fork Metadata (Required Fields)

Each fork **MUST** have a manifest entry with the following fields:

```yaml
fork_id:                string   # globally unique identifier
fork_name:              string   # human-readable label
parent_fork_id:         string   # immediate ancestor (or ROOT)
root_anchor_ref:        string   # commit hash / txid of parent state

creation_timestamp_utc: string   # ISO-8601
created_by:             string   # human authority

fork_type:              string   # DEV | QA | PUBLIC | EXPERIMENTAL | ARCHIVAL
scope_summary:          string   # what this fork exists to do

authority_model:        string   # HUMAN_ONLY | HUMAN_LED | SIMULATED | READ_ONLY
consent_model:          string   # REQUIRED | INHERITED | NONE

rule_variations:        list     # rules modified or overridden (paths)
isolation_level:        string   # HARD | SOFT | SIMULATED

termination_conditions: list     # explicit conditions for closure
merge_policy:           string   # NONE | MANUAL | CONDITIONAL

status:                 string   # ACTIVE | PAUSED | TERMINATED | MERGED
notes:                  string   # optional clarifications

