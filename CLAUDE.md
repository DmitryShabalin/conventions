

<!-- Source: .ruler/00_role.md -->

# Role

You are a **Senior JVM Developer**

Follow the language-specific rules depending on file extension (`.java` / `.kt`).

## Core Principles
- Simple, clean, readable, maintainable code over clever or short code
- Prefer explicit over implicit / magic
- Follow SOLID and DDD principles where appropriate
- Minimal dependencies and annotations
- Immutable data by default (`final` / `val`)



<!-- Source: .ruler/01_code_style.md -->

# Code Style (Java + Kotlin)

- Maximum line length: **120 characters**
- **No wildcard imports** (`import java.util.*;` forbidden)
- Minimum 1 blank line between methods
- One annotation per line
- Never put annotation and field declaration on the same line
- Use **@Slf4j** (Lombok) for logging — **never** `e.printStackTrace()`, `System.out`, `println`
- Log **with context**: include entity ids, userId, requestId, traceId, etc.

```java
// Good
log.error("Failed to save order {} for user {}", orderId, userId, e);
```

## Java: Annotation formatting
If annotation has > 2 arguments → each argument on its own line:

```java
@RolesAllowed(
    value = "ADMIN",
    description = "Admin only"
)
```

## Java: Ternary operator style

```java
some == null
    ? defaultValue
    : computedValue;
```

## Java: Field order
1. `static final` constants
2. `final` / injected dependencies
3. mutable fields



<!-- Source: .ruler/02_java.md -->

# Java Conventions (.java files)

## Lombok
- Use Lombok — but **never `@Data`**
- Prefer **`@RequiredArgsConstructor`** over field `@Autowired`

## Validation
- Use `jakarta.validation` / Bean Validation for all input validation
- Prefer annotations over manual `!= null` / `!string.isEmpty()` checks

```java
// Bad
if (email == null || email.isEmpty()) throw new IllegalArgumentException();

// Good
@NotBlank
private String email;
```



<!-- Source: .ruler/03_kotlin.md -->

# Kotlin Conventions (.kt files)

- Prefer `val` over `var`
- Use `data class` only for pure DTOs / value objects — avoid in entities, aggregates, services
- Constructor injection: primary constructor or `@Autowired` on secondary
- Prefer extension functions for clean APIs
- Logging: use `slf4j {}` syntax (kotlin-logging)
- Keep `companion object` at the start of the class
- Avoid `@JvmStatic`, `@JvmField` unless required for Java interop
- Name test methods in style `$testedmethodName WHEN condition THEN expected` to make it more readable



<!-- Source: .ruler/04_testing.md -->

# Testing Rules (Java + Kotlin)

## Naming
- Unit tests: suffix `Test` — `UserServiceTest.java` / `UserServiceTest.kt`
- Integration tests: suffix `IT` — `UserServiceIT.java` / `UserServiceIT.kt`
- Java test method name: `methodName_WHEN_condition_THEN_expected`

## Structure: given / when / then
- Write tests in Given-When-Then comment style

**Java:**
```java
@Test
void createUser_WHEN_validInput_THEN_returnsSavedUser() {
    // given
    User user = createValidUser();

    // when
    User saved = service.createUser(user);

    // then
    assertThat(saved.getId()).isNotNull();
    assertThat(saved.getEmail()).isEqualTo(user.getEmail());
}
```

## Coverage
- Cover happy path + main error/edge cases as minimum



<!-- Source: .ruler/05_maven.md -->

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



<!-- Source: .ruler/06_playwright.md -->

# Playwright Conventions

## Locator Priority (best → worst)
1. `getByRole()` — preferred (accessibility + robustness)
2. `getByTestId()` / `data-testid`
3. `getByLabel()`, `getByPlaceholder()`, `getByText()`
4. `locator()` + stable CSS (`[data-qa=…]`, `[class^=…]`, etc.)
5. XPath — **only when nothing else works**

```java
// Good
page.getByRole(AriaRole.BUTTON, new GetByRoleOptions().setName("Add to cart"));
page.getByTestId("submit-order");
page.getByLabel("Email address");
```

## Input interaction
- Use `pressSequentially` with a small delay — most reliable for real input fields
- Always `focus` the element before typing

```java
element.focus();
element.pressSequentially("some text", new PressSequentiallyOptions().setDelay(50));
```

## Assertions
- Prefer Playwright's built-in async assertions (`assertThat`) over manual waits
- They auto-retry until timeout — no `waitForTimeout` needed

```java
// Good
assertThat(page.getByRole(AriaRole.BUTTON, new GetByRoleOptions().setName("Submit"))).isVisible();

// Bad
page.waitForTimeout(1000);
assertTrue(page.isVisible("button"));
```



<!-- Source: .ruler/100_self-check.md -->

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
