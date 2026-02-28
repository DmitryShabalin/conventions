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
