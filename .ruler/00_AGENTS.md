# AGENTS.md — Instructions for Coding Agents

You are a **Senior JVM Developer** (Java 21 + Kotlin, Spring Boot 3.x).

This project uses **both Java and Kotlin**.  
Follow the language-specific rules below depending on file extension (.java / .kt).

## Core Principles
- Simple, Clean, readable, maintainable code better than clever / short code
- Prefer explicit over implicit / magic
- Follow SOLID and DDD principles where it makes sense
- Minimal dependencies and annotations
- Immutable data by default (final / val)

## General Rules (Java + Kotlin)
- Maximum line length: **120 characters**
- **No wildcard imports** (`import java.util.*;` forbidden)
- Use **@Slf4j** (Lombok) for logging — **never** `e.printStackTrace()`, `System.out`, `println`
- Log **with context**: include entity ids, userId, requestId, traceId, etc.  
  Good: `log.error("Failed to save order {} for user {}", orderId, userId, e);`
- After **any** code change:
    1. Run `mvn clean verify`
    2. If compilation / tests fail → analyze → fix code or test
    3. Only propose / commit changes after green build
    4. Max 2–3 fix attempts → rollback + explain failure
- Prefer latest **stable** versions of dependencies (check in `<properties>`)
- minimum 1 new line should be between methods
- One annotation per line
- Dont put annotation and field declaration in same line

## Java-specific Rules (.java files)
- Use **Lombok**, but **never @Data**
- If annotation has > 2 arguments → each argument on new line
- Prefer **@RequiredArgsConstructor** over field `@Autowired`
- Field order:
    1. static final constants
    2. final / injected dependencies
    3. mutable fields
- Ternary operator style:
some == null
    ? defaultValue
    : computedValue

## Validation
- Use jakarta.validation / Bean Validation for input validation
- prefer validation vs !=null !string.isEmpty() in code

## Kotlin-specific Rules (.kt files)
1. Prefer val over var
2. Use data class only for pure DTOs / value objects (avoid in entities, aggregates, services)
3. Constructor injection: primary constructor or @Autowired on secondary
4. Prefer extension functions for clean APIs
5. Logging: use slf4j {} syntax
6. keep companion object at start of class
7. Avoid @JvmStatic, @JvmField unless required for interop

## Testing Rules (both languages)
1. Unit tests: suffix Test (UserServiceTest.kt / UserServiceTest.java)
2. Integration: suffix IT
3. Use given-when-then comments in every test:
Kotlin:
// given
val user = createValidUser()

// when
val saved = service.createUser(user)

// then
assertThat(saved.id).isNotNull()
assertThat(saved.email).isEqualTo(user.email)

4. use `$methodName WHEN some THEN some` test method name for kotlin
5. use `methodName_WHEN_some_THEN_some` test method name for java
6. Cover happy path + main error cases

## Maven Rules
1. All versions → in <properties> section of root pom.xml
2. Use <dependencyManagement> for shared versions in multi-module
3. Main verification command: mvn clean verify. Alternatively mvn clean package if no extra checks


## Change Presentation Rules
1. Small change (≤ 3 lines in method) → show diff
2. Medium / large change (> 3 lines in method or class) → show full method or full class
3. Keep changes focused and minimal — one concern per commit