# VO2 Governance

Centralized GitOps policies, reusable CI workflows, templates, and ADRs for VO2 projects.

## Reusable CI
Use in a repo's workflow:
```
jobs:
  call-governance-ci:
    uses: paulkiley/vo2-governance/.github/workflows/reusable-ci.yml@v1.0.0
    with:
      python-version: '3.11'
```

## Templates (Copier)
```
copier copy gh:paulkiley/vo2-governance .
```

## Bulk bump helper
Use `scripts/bulk_bump_workflow_refs.sh` to open PRs bumping the reusable CI version across repositories listed in a text file.
