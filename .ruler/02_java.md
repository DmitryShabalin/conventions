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
