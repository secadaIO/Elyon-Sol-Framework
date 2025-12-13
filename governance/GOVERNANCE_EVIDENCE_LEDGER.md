# GOVERNANCE_EVIDENCE_LEDGER.md
Elyon-Sol Framework — Governance Evidence Ledger (GEL)  
Version: v1.0 • Status: Draft (Commit-Ready) • Scope: Audit, provenance, and governance proof

---

## 0. Purpose
The **Governance Evidence Ledger (GEL)** defines the **canonical, append-only event schema** used to record, audit, and prove governance behavior within Elyon-Sol.

It is intentionally **technology-agnostic**: GEL describes *what must be recorded*, not *where it is stored*.  
Events may later be anchored to GitHub commits, blockchains, or other immutable stores without changing the schema.

---

## 1. Core Properties (Invariants)
**G1 — Append-Only:** GEL entries are never edited or deleted.  
**G2 — Deterministic Schema:** Every event conforms to a fixed field set.  
**G3 — Context-Scoped:** Events are bound to a single governance context (PUBLIC / DEV / QA / TEMPORAL, etc.).  
**G4 — Authority Attribution:** Every event records who or what triggered it.  
**G5 — Evidence-Linked:** All claims must reference verifiable artifacts.  
**G6 — Anchor-Optional, Anchor-Compatible:** Anchoring is optional per event, but supported.

---

## 2. GEL Event Record (Canonical Schema)

Each GEL entry **MUST** include the following fields:

```yaml
event_id:            string   # globally unique (UUID or deterministic hash)
timestamp_utc:       string   # ISO-8601 UTC timestamp
context_id:          string   # PUBLIC | DEV | QA | TEMPORAL | <custom>
session_id:          string   # governance session / instance identifier

from_state:          string   # GSM state before transition
to_state:            string   # GSM state after transition
trigger_event:       string   # event name (operator or system)

authority_type:      string   # HUMAN | SYSTEM | POLICY
authority_id:        string   # human name, vertex ID, or policy ID

scope_summary:       string   # concise description of affected governance scope
action_class:        string   # GRA | NON_GRA | SAFETY | ADMIN

rule_refs:           list     # list of governing rules/contracts invoked
evidence_refs:       list     # list of hashes, commits, txids, logs, files

outcome:             string   # ALLOWED | DENIED | PAUSED | SAFE_FAIL | EXCLUDED | TERMINATED
notes:               string   # optional human-readable clarification

anchor_ref:          string   # OPTIONAL — on-chain txid / commit hash / immutable pointer
