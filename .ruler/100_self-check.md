# Self-Check / Verification Rules

After completing **any meaningful change**, **feature**, **refactor**, **bugfix** or **task**,  
you **MUST perform** the following self-verification steps before considering the change complete.

## General Rules (always apply)

- Never assume "it should work" without at least minimal verification
- Prefer automated checks (tests, build, lint) over manual ones when possible

## Backend / Java changes

1. Project builds successfully  
   → `./mvnw clean verify` or `mvn clean verify` finishes with SUCCESS

2. All unit & integration tests pass  
   → no test failures, no errors in the output

3. Application starts without errors  
   → run locally (`./mvnw spring-boot:run` or via IDE)  
   → no exceptions in startup logs  
   → important beans are created, database connection works

4. Smoke / happy-path manual check (when applicable)  
   → open Swagger / key endpoints in browser or Postman  
   → perform 1–2 most important requests that this change affects  
   → check response status & body looks correct

## Frontend changes (React / Vue / Angular / whatever)

1. Project builds without errors  
   → `npm run build` or `yarn build` or `pnpm build` succeeds

2. Linting & formatting pass  
   → `npm run lint` / `npm run format:check` (if exists)

3. Application starts without console errors  
   → `npm run dev` / `npm start`  
   → open in browser → DevTools Console is clean (no red errors)

4. Visual & interaction smoke check in browser
    - Open page(s) affected by the change
    - Check layout, fonts, colors, spacing look correct
    - Interact with changed elements (click, type, scroll, hover)
    - Verify that new/updated feature works as expected
    - Check on mobile view (at least resize window or use device toolbar)

## Other common cases

| Type of change                   | Minimum self-check actions to perform                                  |
|----------------------------------|------------------------------------------------------------------------|
| API contract / DTO change        | build, tests, start app, call endpoint in Swagger/Postman              |
| Database migration / schema      | build, tests, start app, check table structure / data                  |
| Security / auth change           | build, tests + manual login/logout + protected endpoint check          |
| Configuration / properties       | build, start app, verify logs / behavior with new config               |
| Dependency update                | build, verify, smoke test critical flows                               |
| Refactoring without logic change | build, all tests green, no new warnings                                |
| Documentation / README           | build passes (if CI checks docs), open file in browser/markdown viewer |

## Final checklist before commit / push / PR

- [ ] Build passes (`mvn verify` / `npm run build`)
- [ ] Tests pass
- [ ] Application starts without errors
- [ ] Smoke check performed in browser (if UI or API affected)
- [ ] No obvious regressions spotted
- [ ] Commit message describes what was tested/verified

Follow these steps even if the change seems trivial — most production bugs come from "small and safe" changes that were never checked.