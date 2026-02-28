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
