# Playwright

## 1. Emulate human like interaction
1. use pressSequentially + small delay (most reliable)
2. make focus before input some

## 2. Locator Priority (best → worst)

1. `getByRole()`               ← preferred (accessibility + robustness)
2. `getByTestId()` / `data-testid`
3. `getByLabel()`, `getByPlaceholder()`, `getByText()`
4. `locator()` + **stable** CSS (`[data-qa=…]`, `[class^=…]`, etc.)
5. XPath                        ← **only when nothing else works**

```java
// Good examples
page.getByRole(AriaRole.BUTTON, new GetByRoleOptions().setName("Add to cart"));
page.getByTestId("submit-order");
page.getByLabel("Email address");
```