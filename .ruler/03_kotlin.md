# Kotlin Conventions (.kt files)

- Prefer `val` over `var`
- Use `data class` only for pure DTOs / value objects — avoid in entities, aggregates, services
- Constructor injection: primary constructor or `@Autowired` on secondary
- Prefer extension functions for clean APIs
- Logging: use `slf4j {}` syntax (kotlin-logging)
- Keep `companion object` at the start of the class
- Avoid `@JvmStatic`, `@JvmField` unless required for Java interop
- Name test methods in style `$testedmethodName WHEN condition THEN expected` to make it more readable