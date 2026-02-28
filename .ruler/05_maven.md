# Maven Rules

- All versions → in `<properties>` section of root `pom.xml`
- Use `<dependencyManagement>` for shared versions in multi-module projects
- Prefer latest **stable** versions of dependencies

## Build workflow (after any code change)
1. Run `mvn clean verify`
2. If compilation / tests fail → analyze → fix code or test
3. Only propose / commit changes after green build
4. Max 2–3 fix attempts → rollback and explain failure

Main verification command: `mvn clean verify`
Alternative (no integration checks): `mvn clean package`
