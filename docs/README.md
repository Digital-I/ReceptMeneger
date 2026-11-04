# ReceptMeneger Documentation

**Last Updated**: 2026-11-05

This directory contains documentation for the ReceptMeneger project, organized by category.

## Quick Links

- **New to the project?** Start with [ReceptMeneger Codebase Overview](architecture/ReceptMeneger-Codebase-Overview.md)
- **Setting up tests?** See [Dialog Testing Guide](testing/DIALOG_TESTING_GUIDE.md) and [Edge Case Testing Guide](testing/EDGE_CASE_TESTING_GUIDE.md)
- **Writing edge case tests?** Check [Edge Case Catalog](testing/EDGE_CASE_CATALOG.md)
- **Following workflows?** Check [Issue Workflow](workflows/ISSUE_WORKFLOW.md)
- **Adding localization?** Read [L10N Protocol](workflows/L10N_PROTOCOL.md)
- **Designing UI/UX?** Check [design/ux/](design/ux/)
- **Implementing UI components?** Start with [UI Component Library](design/component_library.md)

---

## Documentation Structure

```
docs/
├── README.md (this file)
│
├── design/               # Visual & UX Design
│   ├── ux/               # Feature-specific UX designs
│   └── *.md              # Design tokens, theme, visual identity
│
├── architecture/         # System Architecture & Technical Decisions
├── testing/              # Testing Guides & Resources
└── workflows/            # Development Workflows & Processes
```

---

## Design (Visual & UX Design)

**Purpose**: Visual design system and feature-specific UX designs.

### Visual Design System

| Document | Purpose | Status |
|----------|---------|--------|
| [component_library.md](design/component_library.md) | UI Component Library — quick reference for all components and patterns | ✅ Current |
| [design-tokens.md](design/design-tokens.md) | Core design tokens (colors, spacing, typography) | ✅ Current |
| [theme_usage.md](design/theme_usage.md) | Flutter theme implementation patterns | ✅ Current |
| [visual_identity.md](design/visual_identity.md) | ReceptMeneger visual identity ("Cultured & Flavorful") | ✅ Current |
| [button_patterns.md](design/button_patterns.md) | Full button pattern reference | ✅ Current |
| [input_patterns.md](design/input_patterns.md) | Full form input pattern reference | ✅ Current |
| [navigation_patterns.md](design/navigation_patterns.md) | Full navigation element pattern reference | ✅ Current |

### Feature UX Designs

UX designs and user flow documentation for specific features.

| Document | Feature | Status |
|----------|---------|--------|
| [meal-plan-summary-design.md](design/ux/meal-plan-summary-design.md) | Meal Plan Summary Feature | ✅ Current |

---

## Architecture & Design

| Document | Purpose | Status |
|----------|---------|--------|
| [ReceptMeneger-Codebase-Overview.md](architecture/ReceptMeneger-Codebase-Overview.md) | Comprehensive architecture overview, data models, services, and patterns | ✅ Current |
| [RECOMMENDATION_ENGINE.md](architecture/RECOMMENDATION_ENGINE.md) | Recommendation service architecture and scoring factors | ✅ Current |
| [Dependency-Injection-Strategy.md](architecture/Dependency-Injection-Strategy.md) | ServiceProvider pattern and DI approach | ✅ Current |

---

## Testing Documentation

### Testing Guides

| Document | Purpose | Status |
|----------|---------|--------|
| [DIALOG_TESTING_GUIDE.md](testing/DIALOG_TESTING_GUIDE.md) | Comprehensive guide for testing dialogs with DialogTestHelper | ✅ Current |
| [EDGE_CASE_TESTING_GUIDE.md](testing/EDGE_CASE_TESTING_GUIDE.md) | Comprehensive guide for edge case testing patterns and helpers | ✅ Current |
| [EDGE_CASE_CATALOG.md](testing/EDGE_CASE_CATALOG.md) | Catalog of edge cases and EdgeCaseTestHelpers usage | ✅ Current |
| [MOCK_DATABASE_ERROR_SIMULATION.md](testing/MOCK_DATABASE_ERROR_SIMULATION.md) | Mock database error simulation reference | ✅ Current |
| [BACKUP_FIXTURE_PROTOCOL.md](testing/BACKUP_FIXTURE_PROTOCOL.md) | Backup fixture protocol | ✅ Current |
| [E2E_TESTING.md](testing/E2E_TESTING.md) | End-to-end testing guidelines | ✅ Current |
| [createTestableWidget-pattern.md](testing/createTestableWidget-pattern.md) | Pattern for creating testable widgets | ✅ Current |
| [RecipeProvider-test-setup.md](testing/RecipeProvider-test-setup.md) | Provider testing setup guide | ✅ Current |
| [Revised-Flutter-Integration-Testing-Guidelines.md](testing/Revised-Flutter-Integration-Testing-Guidelines.md) | Integration testing approach and guidelines | ✅ Current |
| [TEST_COVERAGE_SETUP.md](testing/TEST_COVERAGE_SETUP.md) | Test coverage setup | ✅ Current |
| [TEST_GOVERNANCE.md](testing/TEST_GOVERNANCE.md) | Governance rules for keeping test counts accurate; log naming conventions; when to update docs | ✅ Current |

### Testing Documentation Hierarchy

For testing-related work, follow this hierarchy:

```
1. Testing Guides (start here for implementation)
   ├─ DIALOG_TESTING_GUIDE.md (for dialog tests)
   ├─ EDGE_CASE_TESTING_GUIDE.md (for edge case tests)
   └─ EDGE_CASE_CATALOG.md (edge case reference & helpers)

2. Test Files
   ├─ test/widgets/ (dialog/widget tests)
   ├─ test/edge_cases/ (edge case tests)
   ├─ test/regression/ (critical regression tests)
   └─ test/edge_cases/performance/ (performance benchmarks)
```

---

## Workflows & Processes

| Document | Purpose | Status |
|----------|---------|--------|
| [ISSUE_WORKFLOW.md](workflows/ISSUE_WORKFLOW.md) | GitHub issue management, Git Flow, branching strategy | ✅ Current |
| [L10N_PROTOCOL.md](workflows/L10N_PROTOCOL.md) | Localization workflow for English/Portuguese | ✅ Current |
| [RELEASE_WORKFLOW.md](workflows/RELEASE_WORKFLOW.md) | Release process, versioning, and automated pipeline | ✅ Current |
| [DATABASE_MIGRATION_WORKFLOW.md](workflows/DATABASE_MIGRATION_WORKFLOW.md) | Database migration workflow | ✅ Current |
| [SEED_DATA_WORKFLOW.md](workflows/SEED_DATA_WORKFLOW.md) | Seed data workflow | ✅ Current |

---

## Document Status Legend

- ✅ **Current**: Up-to-date and actively maintained
- ⚠️ **May need update**: Potentially outdated, review recommended

---

## Maintenance Notes

### Regular Updates Needed

- **EDGE_CASE_CATALOG.md**: Add new edge cases as discovered during development
- **EDGE_CASE_TESTING_GUIDE.md**: Update when new testing patterns emerge
- **ReceptMeneger-Codebase-Overview.md**: Update when architecture changes
- **RECOMMENDATION_ENGINE.md**: Update when recommendation factors change

---

## Naming Conventions

**Visual Design**: `docs/design/{topic}.md`
- Example: `design-tokens.md`, `visual_identity.md`

**UX Design**: `docs/design/ux/{feature-name}-design.md`
- Example: `meal-plan-summary-design.md`

**Testing Guide**: `docs/testing/{TOPIC}_GUIDE.md` or `{topic}-pattern.md`

**Workflow**: `docs/workflows/{NAME}_WORKFLOW.md` or `{NAME}_PROTOCOL.md`

---

## Contributing to Documentation

When adding or updating documentation:

1. **Follow naming conventions** above for consistency
2. **Include "Last Updated" date** at the top of the file
3. **Update this README** if adding new documents
4. **Cross-reference** related documents with links
5. **Use clear headers** for easy navigation
6. **Include examples** where helpful
7. **Keep format consistent** with existing docs

---

## Questions?

If you can't find what you're looking for:
- Check the main project [README.md](../README.md)
- Search across documentation files for keywords

---

**Maintained by**: Екатерина Медведева
**Primary Audience**: Developers, Contributors
**Repository**: receptmeneger (private)
