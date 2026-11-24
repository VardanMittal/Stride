# Decisions

| Date | Decision | Reason |
| --- | --- | --- |
| 2026-11-24 | Desktop target is Windows. | The supplied development environment is Windows and no alternate laptop OS was supplied. |
| 2026-11-24 | Android application ID is `dev.vardanmittal.stride`. | Derived from the repository owner; this must be confirmed before the first release because it cannot change afterward. |
| 2026-11-24 | Flutter is pinned to 3.50.0. | Current stable release at project creation. |
| 2026-11-24 | Platform runners are generated in CI during Milestone 0. | Flutter is intentionally not installed in the local workspace. Generated runners will be committed once CI validates the bootstrap. |
