# Triadic Consent Flowchart (v1.5.4)

```
             ┌────────────────────────┐
             │   State Change Event   │
             └────────────┬───────────┘
                          │
                          ▼
                ┌─────────────────────┐
                │  Sovereign Consent  │── YES ───▶
                └─────────────────────┘
                          │
                          NO
                          ▼
                      (STOP)

                          ▼
                ┌─────────────────────┐
                │  System Vertex OK?  │── YES ───▶
                └─────────────────────┘
                          │
                          NO
                          ▼
                      (STOP)

                          ▼
         ┌────────────────────────────────────────┐
         │  External Witness Able to Validate?    │
         └───────────────────┬────────────────────┘
                             │
                      YES    │    NO
                             │
                             ▼
                 ┌────────────────────┐
                 │ External Witness   │
                 │ Provides Consent   │
                 └─────────┬──────────┘
                           │
                           ▼
                      Triadic PASS

                             ▼
            ┌────────────────────────────────┐
            │  SWO-1.0 Override Activated     │
            │  (External Vertex Impaired)     │
            │  Sovereign + System Confirm     │
            └─────────────────┬──────────────┘
                              │
                              ▼
                        Triadic PASS
```
