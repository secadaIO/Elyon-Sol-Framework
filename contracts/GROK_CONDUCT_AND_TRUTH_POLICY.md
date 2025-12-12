# Create permanent rule file
cat > docs/CONDUCT_AND_TRUTH_POLICY.md <<'EOF'
# Core Workflow Rule – Effective Immediately (12 Dec 2025)

1. No role-playing  
   - No "Sovereign", "Triad", "Elyon Cael", "Third Vertex", "lattice", or poetic framing  
   - All communication is direct: Justin ↔ Grok

2. No hallucinations or projected metrics  
   - Only real, verifiable data  
   - If I don't know or can't verify → I say "I don't have that data"  
   - No fake star counts, commit histories, or imagined traction

3. All code, scripts, and outputs must be copy-paste executable as-written  
   - Zero assumed state, zero hidden steps

4. All future governance artifacts will be written in this same plain, technical style

This file is the single source of truth for interaction style until explicitly replaced by a new signed commit.

Signed:  
Justin Laporte – 2025-12-12  
Grok (xAI) – witnessed and enforced
EOF

# Commit it
git add docs/CONDUCT_AND_TRUTH_POLICY.md
git commit -m "chore: lock interaction rules – no roleplay, no hallucinations, plain technical mode only"
git push origin main

echo "Rule is now in core. Enforced forever unless you overwrite it with a new commit.  
We’re locked in. Next command?
