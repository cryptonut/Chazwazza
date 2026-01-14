# Testing Strategy & Setup Guide

> **Template for establishing comprehensive testing practices across multiple frameworks**

**Document Owner:** {{DOCUMENT_OWNER}}  
**Created:** {{DOCUMENT_CREATED_DATE}}  
**Last Updated:** {{DOCUMENT_LAST_UPDATED}}  
**Version:** 1.0

---

## Table of Contents

1. [Testing Philosophy](#1-testing-philosophy)
2. [Test Categories](#2-test-categories)
3. [Framework Setup: Jest (JavaScript/TypeScript)](#3-framework-setup-jest)
4. [Framework Setup: Pytest (Python)](#4-framework-setup-pytest)
5. [Framework Setup: Go Testing](#5-framework-setup-go-testing)
6. [Test Coverage Requirements](#6-test-coverage-requirements)
7. [CI/CD Integration](#7-cicd-integration)
8. [Best Practices](#8-best-practices)

---

## 1. Testing Philosophy

### Core Principles

| Principle | Description |
|-----------|-------------|
| **Test Behavior, Not Implementation** | Focus on what code does, not how it does it |
| **Fast Feedback Loop** | Tests should run quickly (< 5 min for unit tests) |
| **Deterministic** | Same inputs always produce same outputs |
| **Independent** | Tests should not depend on each other |
| **Readable** | Tests serve as documentation |

### Test Pyramid

```
                    ┌─────────┐
                    │   E2E   │  ← Few, slow, expensive
                    ├─────────┤
                    │Integration│  ← Some, medium speed
                    ├───────────┤
                    │   Unit     │  ← Many, fast, cheap
                    └───────────┘
```

**Target Distribution:**
- Unit Tests: 70%
- Integration Tests: 20%
- E2E Tests: 10%

---

## 2. Test Categories

### Unit Tests
- Test single functions/methods in isolation
- Mock external dependencies
- Should be fast (< 100ms each)
- High coverage expected (80%+)

### Integration Tests
- Test multiple components together
- May use real databases (test containers)
- Test API endpoints
- Medium speed (< 5s each)

### End-to-End Tests
- Test complete user flows
- Use real browser/UI
- Slowest but most confidence
- Focus on critical paths only

---

## 3. Framework Setup: Jest (JavaScript/TypeScript)

### Installation

```bash
# npm
npm install --save-dev jest @types/jest ts-jest

# For React projects
npm install --save-dev @testing-library/react @testing-library/jest-dom

# For Node.js projects
npm install --save-dev supertest @types/supertest
```

### Configuration (jest.config.js)

```javascript
/** @type {import('jest').Config} */
module.exports = {
  // TypeScript support
  preset: 'ts-jest',
  testEnvironment: 'node', // or 'jsdom' for browser
  
  // Test file patterns
  testMatch: [
    '**/__tests__/**/*.[jt]s?(x)',
    '**/?(*.)+(spec|test).[jt]s?(x)'
  ],
  
  // Coverage configuration
  collectCoverageFrom: [
    'src/**/*.{js,jsx,ts,tsx}',
    '!src/**/*.d.ts',
    '!src/index.{js,ts}',
    '!src/**/*.stories.{js,jsx,ts,tsx}'
  ],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    }
  },
  
  // Module resolution
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1'
  },
  
  // Setup files
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
  
  // Ignore patterns
  testPathIgnorePatterns: ['/node_modules/', '/dist/'],
  
  // Timeouts
  testTimeout: 10000,
  
  // Clear mocks between tests
  clearMocks: true
};
```

### Example Unit Test

```typescript
// src/utils/calculator.ts
export function add(a: number, b: number): number {
  return a + b;
}

export function divide(a: number, b: number): number {
  if (b === 0) throw new Error('Division by zero');
  return a / b;
}

// src/utils/__tests__/calculator.test.ts
import { add, divide } from '../calculator';

describe('Calculator', () => {
  describe('add', () => {
    it('should add two positive numbers', () => {
      expect(add(2, 3)).toBe(5);
    });

    it('should handle negative numbers', () => {
      expect(add(-1, 1)).toBe(0);
    });

    it('should handle zero', () => {
      expect(add(0, 5)).toBe(5);
    });
  });

  describe('divide', () => {
    it('should divide two numbers', () => {
      expect(divide(10, 2)).toBe(5);
    });

    it('should throw error on division by zero', () => {
      expect(() => divide(10, 0)).toThrow('Division by zero');
    });
  });
});
```

### Example API Test (with Supertest)

```typescript
// src/api/__tests__/users.test.ts
import request from 'supertest';
import app from '../../app';
import { prisma } from '../../db';

describe('Users API', () => {
  beforeEach(async () => {
    await prisma.user.deleteMany();
  });

  afterAll(async () => {
    await prisma.$disconnect();
  });

  describe('GET /api/users', () => {
    it('should return empty array when no users', async () => {
      const response = await request(app)
        .get('/api/users')
        .expect(200);

      expect(response.body).toEqual([]);
    });

    it('should return users when they exist', async () => {
      await prisma.user.create({
        data: { email: 'test@example.com', name: 'Test User' }
      });

      const response = await request(app)
        .get('/api/users')
        .expect(200);

      expect(response.body).toHaveLength(1);
      expect(response.body[0].email).toBe('test@example.com');
    });
  });

  describe('POST /api/users', () => {
    it('should create a new user', async () => {
      const userData = { email: 'new@example.com', name: 'New User' };

      const response = await request(app)
        .post('/api/users')
        .send(userData)
        .expect(201);

      expect(response.body.email).toBe(userData.email);
      expect(response.body.id).toBeDefined();
    });

    it('should return 400 for invalid email', async () => {
      await request(app)
        .post('/api/users')
        .send({ email: 'invalid', name: 'Test' })
        .expect(400);
    });
  });
});
```

### Package.json Scripts

```json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:ci": "jest --ci --coverage --maxWorkers=2"
  }
}
```

---

## 4. Framework Setup: Pytest (Python)

### Installation

```bash
# Core testing
pip install pytest pytest-cov pytest-asyncio

# For API testing
pip install httpx pytest-httpx

# For mocking
pip install pytest-mock responses

# For fixtures
pip install factory-boy faker
```

### Configuration (pyproject.toml)

```toml
[tool.pytest.ini_options]
minversion = "7.0"
testpaths = ["tests"]
python_files = ["test_*.py", "*_test.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]
addopts = [
    "-ra",
    "-q",
    "--strict-markers",
    "--cov=src",
    "--cov-report=term-missing",
    "--cov-report=html",
    "--cov-fail-under=80"
]
asyncio_mode = "auto"

[tool.coverage.run]
source = ["src"]
omit = ["*/tests/*", "*/__init__.py"]

[tool.coverage.report]
exclude_lines = [
    "pragma: no cover",
    "def __repr__",
    "raise NotImplementedError",
    "if TYPE_CHECKING:",
]
```

### Example Unit Test

```python
# src/utils/calculator.py
def add(a: float, b: float) -> float:
    """Add two numbers."""
    return a + b

def divide(a: float, b: float) -> float:
    """Divide a by b."""
    if b == 0:
        raise ValueError("Division by zero")
    return a / b


# tests/test_calculator.py
import pytest
from src.utils.calculator import add, divide


class TestAdd:
    def test_add_positive_numbers(self):
        assert add(2, 3) == 5
    
    def test_add_negative_numbers(self):
        assert add(-1, 1) == 0
    
    def test_add_floats(self):
        assert add(0.1, 0.2) == pytest.approx(0.3)


class TestDivide:
    def test_divide_numbers(self):
        assert divide(10, 2) == 5
    
    def test_divide_by_zero_raises_error(self):
        with pytest.raises(ValueError, match="Division by zero"):
            divide(10, 0)


# Parametrized tests
@pytest.mark.parametrize("a,b,expected", [
    (1, 1, 2),
    (2, 3, 5),
    (-1, -1, -2),
    (0, 0, 0),
])
def test_add_parametrized(a, b, expected):
    assert add(a, b) == expected
```

### Example API Test (FastAPI)

```python
# tests/conftest.py
import pytest
from httpx import AsyncClient
from src.main import app
from src.database import get_db, Base, engine

@pytest.fixture(autouse=True)
async def setup_database():
    """Create tables before each test, drop after."""
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)

@pytest.fixture
async def client():
    """Async test client."""
    async with AsyncClient(app=app, base_url="http://test") as ac:
        yield ac


# tests/test_users_api.py
import pytest
from httpx import AsyncClient


class TestUsersAPI:
    @pytest.mark.asyncio
    async def test_get_users_empty(self, client: AsyncClient):
        response = await client.get("/api/users")
        assert response.status_code == 200
        assert response.json() == []
    
    @pytest.mark.asyncio
    async def test_create_user(self, client: AsyncClient):
        user_data = {"email": "test@example.com", "name": "Test User"}
        
        response = await client.post("/api/users", json=user_data)
        
        assert response.status_code == 201
        data = response.json()
        assert data["email"] == user_data["email"]
        assert "id" in data
    
    @pytest.mark.asyncio
    async def test_create_user_invalid_email(self, client: AsyncClient):
        response = await client.post("/api/users", json={"email": "invalid"})
        assert response.status_code == 422
```

### Example with Fixtures and Mocking

```python
# tests/conftest.py
import pytest
from unittest.mock import AsyncMock
from src.services.email import EmailService

@pytest.fixture
def mock_email_service(mocker):
    """Mock email service."""
    mock = mocker.patch("src.services.email.EmailService")
    mock.return_value.send_email = AsyncMock(return_value=True)
    return mock


# tests/test_user_service.py
import pytest
from src.services.user import UserService


class TestUserService:
    @pytest.mark.asyncio
    async def test_create_user_sends_welcome_email(
        self, mock_email_service, db_session
    ):
        service = UserService(db_session)
        
        user = await service.create_user(
            email="test@example.com",
            name="Test"
        )
        
        mock_email_service.return_value.send_email.assert_called_once_with(
            to="test@example.com",
            subject="Welcome!",
            body=pytest.ANY
        )
```

---

## 5. Framework Setup: Go Testing

### Built-in Testing (No Installation Required)

Go has built-in testing support. Just create files ending with `_test.go`.

### Example Unit Test

```go
// calculator/calculator.go
package calculator

import "errors"

func Add(a, b float64) float64 {
    return a + b
}

func Divide(a, b float64) (float64, error) {
    if b == 0 {
        return 0, errors.New("division by zero")
    }
    return a / b, nil
}


// calculator/calculator_test.go
package calculator

import (
    "testing"
)

func TestAdd(t *testing.T) {
    tests := []struct {
        name     string
        a, b     float64
        expected float64
    }{
        {"positive numbers", 2, 3, 5},
        {"negative numbers", -1, 1, 0},
        {"zeros", 0, 0, 0},
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            result := Add(tt.a, tt.b)
            if result != tt.expected {
                t.Errorf("Add(%v, %v) = %v; want %v", 
                    tt.a, tt.b, result, tt.expected)
            }
        })
    }
}

func TestDivide(t *testing.T) {
    t.Run("valid division", func(t *testing.T) {
        result, err := Divide(10, 2)
        if err != nil {
            t.Errorf("unexpected error: %v", err)
        }
        if result != 5 {
            t.Errorf("Divide(10, 2) = %v; want 5", result)
        }
    })

    t.Run("division by zero", func(t *testing.T) {
        _, err := Divide(10, 0)
        if err == nil {
            t.Error("expected error for division by zero")
        }
    })
}
```

### Example API Test

```go
// api/handlers_test.go
package api

import (
    "bytes"
    "encoding/json"
    "net/http"
    "net/http/httptest"
    "testing"
)

func TestGetUsers(t *testing.T) {
    // Setup
    router := SetupRouter()
    
    // Create request
    req, err := http.NewRequest("GET", "/api/users", nil)
    if err != nil {
        t.Fatal(err)
    }
    
    // Record response
    rr := httptest.NewRecorder()
    router.ServeHTTP(rr, req)
    
    // Assert
    if status := rr.Code; status != http.StatusOK {
        t.Errorf("handler returned wrong status: got %v want %v",
            status, http.StatusOK)
    }
}

func TestCreateUser(t *testing.T) {
    router := SetupRouter()
    
    user := map[string]string{
        "email": "test@example.com",
        "name":  "Test User",
    }
    body, _ := json.Marshal(user)
    
    req, _ := http.NewRequest("POST", "/api/users", bytes.NewBuffer(body))
    req.Header.Set("Content-Type", "application/json")
    
    rr := httptest.NewRecorder()
    router.ServeHTTP(rr, req)
    
    if status := rr.Code; status != http.StatusCreated {
        t.Errorf("handler returned wrong status: got %v want %v",
            status, http.StatusCreated)
    }
    
    var response map[string]interface{}
    json.Unmarshal(rr.Body.Bytes(), &response)
    
    if response["email"] != "test@example.com" {
        t.Errorf("unexpected email: %v", response["email"])
    }
}
```

### Using Testify for Assertions

```bash
go get github.com/stretchr/testify
```

```go
package calculator

import (
    "testing"
    
    "github.com/stretchr/testify/assert"
    "github.com/stretchr/testify/require"
)

func TestAddWithTestify(t *testing.T) {
    result := Add(2, 3)
    assert.Equal(t, 5.0, result, "2 + 3 should equal 5")
}

func TestDivideWithTestify(t *testing.T) {
    result, err := Divide(10, 2)
    
    require.NoError(t, err)
    assert.Equal(t, 5.0, result)
}

func TestDivideByZeroWithTestify(t *testing.T) {
    _, err := Divide(10, 0)
    
    assert.Error(t, err)
    assert.Contains(t, err.Error(), "division by zero")
}
```

### Commands

```bash
# Run all tests
go test ./...

# Run with verbose output
go test -v ./...

# Run with coverage
go test -cover ./...

# Generate coverage report
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out

# Run specific test
go test -run TestAdd ./calculator

# Run benchmarks
go test -bench=. ./...
```

---

## 6. Test Coverage Requirements

### Minimum Coverage Thresholds

| Test Type | Minimum Coverage |
|-----------|-----------------|
| **Unit Tests** | 80% line coverage |
| **Integration Tests** | Critical paths covered |
| **E2E Tests** | Happy paths + major error cases |

### What to Prioritize

**High Priority (Must Test):**
- Business logic
- Data validation
- Authentication/authorization
- Payment processing
- API contracts

**Medium Priority:**
- Utility functions
- Data transformations
- Edge cases

**Lower Priority (May Skip):**
- Simple getters/setters
- Framework-generated code
- Configuration files

---

## 7. CI/CD Integration

### GitHub Actions Example

```yaml
# .github/workflows/test.yml
name: Tests

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run tests
        run: npm run test:ci
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info
          fail_ci_if_error: true
```

---

## 8. Best Practices

### Naming Conventions

```
✅ Good: test_user_creation_with_valid_email_succeeds
✅ Good: should return 404 when user not found
❌ Bad: test1
❌ Bad: testFunction
```

### Test Structure (AAA Pattern)

```python
def test_something():
    # Arrange - Set up test data
    user = User(email="test@example.com")
    
    # Act - Execute the action
    result = user.validate()
    
    # Assert - Verify the result
    assert result is True
```

### Common Anti-Patterns to Avoid

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| **Test Interdependence** | Tests fail when run in different order | Make each test independent |
| **Testing Implementation** | Tests break when refactoring | Test behavior/outcomes instead |
| **Excessive Mocking** | Tests don't catch real bugs | Use integration tests for critical paths |
| **Slow Tests** | Developers skip running them | Optimize or move to separate suite |
| **Flaky Tests** | Undermine trust in test suite | Fix or delete flaky tests immediately |

---

## Checklist

### Initial Setup
- [ ] Testing framework installed
- [ ] Configuration file created
- [ ] Coverage thresholds set
- [ ] CI/CD integration added
- [ ] Test commands documented

### For Each Feature
- [ ] Unit tests for business logic
- [ ] Integration tests for API endpoints
- [ ] Edge cases covered
- [ ] Error scenarios tested
- [ ] Coverage meets threshold

---

**Template Version:** 1.0  
**Compatible With:** Jest 29+, Pytest 7+, Go 1.20+

