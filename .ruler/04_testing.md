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
