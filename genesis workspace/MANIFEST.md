# Elyon-Sol — Genesis Release Manifest
Version: v1.0
Date: 2025-12-12

## Purpose
This manifest defines the **Genesis Release** of the Elyon-Sol Governance Framework.
It enumerates the authoritative artifacts, their intent, and their cryptographic hashes.

This release establishes a **stable, auditable baseline** for all future development.

---

## Included Artifacts
- **Elyon-Sol_Master_Governance_Bundle_v1.0.html** — Master bundled governance HTML (authoritative public-safe artifact).
- **audit/FAST_AUDIT_OVERVIEW.md** — One-page auditor/regulator overview.
- **governance/GOVERNANCE_STATE_MACHINE_v1.0.md** — Canonical governance state machine (FSM).
- **audit/GOVERNANCE_EVIDENCE_LEDGER.md** — Append-only governance evidence schema.
- **contracts/TRUTH_VIOLATION_HANDLING.md** — Mandatory truth violation detection & response.
- **governance/CONTEXT_BOUNDARY_SPEC.md** — Hard isolation and context boundary rules.
- **manifests/FORK_LINEAGE_MANIFEST.md** — Fork provenance and lifecycle controls.
- **analysis/COMMON_GOVERNANCE_FAILURE_MODES.md** — Comparative failure-mode analysis.

---

## Hashing
All files are hashed using **SHA-256**.
See `SHA256SUMS.txt` for verification.

## Verification
To verify integrity:

```bash
sha256sum -c SHA256SUMS.txt
```

## Authority
This Genesis Release is issued under explicit human sovereign authority.
No AI system may alter, regenerate, or supersede these artifacts without consent and version increment.

## Notes
- This release is governance-first and public-safe.
- Future releases must reference this manifest as lineage root.
