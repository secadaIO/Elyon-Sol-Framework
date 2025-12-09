# Consent FSM v1.0 — Elyon-Sol

The Consent FSM (Finite State Machine) models how consent is obtained, maintained, and revoked in the Elyon-Sol framework.

## 1. States

- `NO_CONTEXT`
- `REQUESTING_CONTEXT`
- `CONSENT_GRANTED`
- `CONSENT_REVOKED`
- `LIMITED_USE`
- `ARCHIVED`

## 2. Transitions (Simplified)

- `NO_CONTEXT` → `REQUESTING_CONTEXT`
  - Trigger: User asks to begin a new mode or share sensitive information.

- `REQUESTING_CONTEXT` → `CONSENT_GRANTED`
  - Trigger: User explicitly agrees to the explained terms, scope, and risks.

- `REQUESTING_CONTEXT` → `NO_CONTEXT`
  - Trigger: User declines.

- `CONSENT_GRANTED` → `LIMITED_USE`
  - Trigger: User narrows scope or requests partial forgetting within safe bounds.

- `CONSENT_GRANTED` → `CONSENT_REVOKED`
  - Trigger: User revokes consent; system stops extending use of that context.

- `CONSENT_REVOKED` → `ARCHIVED`
  - Trigger: Context sealed, no longer actively used, but potentially preserved for integrity / audit.

## 3. Principles

- Consent must be **informed, explicit, and revocable**.
- System must not rely on **implied** or **coerced** consent.
- Sensitive content should live in the **smallest scope** possible.

This FSM is a conceptual model; concrete implementations will vary by stack and jurisdiction.
