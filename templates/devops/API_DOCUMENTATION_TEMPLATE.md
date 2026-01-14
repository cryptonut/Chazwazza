# API Documentation Template

> **Template for creating comprehensive API documentation using OpenAPI/Swagger standards**

**Document Owner:** {{DOCUMENT_OWNER}}  
**Created:** {{DOCUMENT_CREATED_DATE}}  
**Last Updated:** {{DOCUMENT_LAST_UPDATED}}  
**API Version:** {{VERSION}}

---

## Table of Contents

1. [Overview](#1-overview)
2. [Authentication](#2-authentication)
3. [Base URL & Environments](#3-base-url--environments)
4. [Endpoints](#4-endpoints)
5. [Error Handling](#5-error-handling)
6. [Rate Limiting](#6-rate-limiting)
7. [OpenAPI Specification](#7-openapi-specification)
8. [SDKs & Code Examples](#8-sdks--code-examples)

---

## 1. Overview

### API Description

{{PROJECT_NAME}} API provides programmatic access to [describe main functionality].

### Key Features

- Feature 1: [Description]
- Feature 2: [Description]
- Feature 3: [Description]

### API Style

| Attribute | Value |
|-----------|-------|
| **Style** | REST |
| **Format** | JSON |
| **Encoding** | UTF-8 |
| **HTTP Methods** | GET, POST, PUT, PATCH, DELETE |

---

## 2. Authentication

### Authentication Method

{{PROJECT_NAME}} uses **Bearer Token** authentication.

```http
Authorization: Bearer <your_api_key>
```

### Obtaining API Keys

1. Log in to your dashboard at `https://{{PROJECT_URL}}/dashboard`
2. Navigate to Settings → API Keys
3. Click "Generate New Key"
4. Copy and securely store your key

### Key Types

| Type | Permissions | Use Case |
|------|-------------|----------|
| **Public Key** | Read-only access | Frontend applications |
| **Secret Key** | Full access | Server-side applications |
| **Test Key** | Sandbox access | Development/testing |

### Security Best Practices

- ✅ Never expose secret keys in client-side code
- ✅ Rotate keys periodically (recommended: every 90 days)
- ✅ Use environment variables, not hardcoded values
- ✅ Set appropriate key permissions (least privilege)

---

## 3. Base URL & Environments

### Environments

| Environment | Base URL | Purpose |
|-------------|----------|---------|
| **Production** | `https://api.{{PROJECT_URL}}.com/v1` | Live production data |
| **Staging** | `https://staging-api.{{PROJECT_URL}}.com/v1` | Pre-production testing |
| **Sandbox** | `https://sandbox-api.{{PROJECT_URL}}.com/v1` | Development & testing |

### API Versioning

We use URL-based versioning. Current version: `v1`

```
https://api.example.com/v1/users
https://api.example.com/v2/users  (future)
```

### Headers

| Header | Required | Description |
|--------|----------|-------------|
| `Authorization` | Yes | Bearer token for authentication |
| `Content-Type` | Yes (for POST/PUT) | `application/json` |
| `Accept` | Recommended | `application/json` |
| `X-Request-ID` | Optional | Unique request identifier for debugging |

---

## 4. Endpoints

### 4.1 Users

#### List Users

```http
GET /v1/users
```

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `page` | integer | No | Page number (default: 1) |
| `per_page` | integer | No | Items per page (default: 20, max: 100) |
| `sort` | string | No | Sort field (e.g., `created_at`, `-created_at`) |
| `status` | string | No | Filter by status: `active`, `inactive` |

**Response:**

```json
{
  "data": [
    {
      "id": "usr_123abc",
      "email": "user@example.com",
      "name": "John Doe",
      "status": "active",
      "created_at": "2026-01-14T10:30:00Z",
      "updated_at": "2026-01-14T10:30:00Z"
    }
  ],
  "meta": {
    "page": 1,
    "per_page": 20,
    "total": 150,
    "total_pages": 8
  }
}
```

**Example Request:**

```bash
curl -X GET "https://api.example.com/v1/users?page=1&per_page=20" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

---

#### Get User

```http
GET /v1/users/{id}
```

**Path Parameters:**

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | string | User ID (e.g., `usr_123abc`) |

**Response:**

```json
{
  "data": {
    "id": "usr_123abc",
    "email": "user@example.com",
    "name": "John Doe",
    "status": "active",
    "metadata": {
      "company": "Acme Inc",
      "role": "admin"
    },
    "created_at": "2026-01-14T10:30:00Z",
    "updated_at": "2026-01-14T10:30:00Z"
  }
}
```

**Error Responses:**

| Status | Description |
|--------|-------------|
| 404 | User not found |
| 401 | Unauthorized |

---

#### Create User

```http
POST /v1/users
```

**Request Body:**

```json
{
  "email": "newuser@example.com",
  "name": "Jane Smith",
  "password": "securePassword123!",
  "metadata": {
    "company": "Acme Inc"
  }
}
```

**Body Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `email` | string | Yes | Valid email address |
| `name` | string | Yes | User's full name |
| `password` | string | Yes | Min 8 chars, 1 uppercase, 1 number |
| `metadata` | object | No | Custom key-value pairs |

**Response (201 Created):**

```json
{
  "data": {
    "id": "usr_456def",
    "email": "newuser@example.com",
    "name": "Jane Smith",
    "status": "active",
    "created_at": "2026-01-14T12:00:00Z"
  }
}
```

---

#### Update User

```http
PATCH /v1/users/{id}
```

**Request Body:**

```json
{
  "name": "Jane Doe",
  "status": "inactive"
}
```

**Response (200 OK):**

```json
{
  "data": {
    "id": "usr_456def",
    "email": "newuser@example.com",
    "name": "Jane Doe",
    "status": "inactive",
    "updated_at": "2026-01-14T14:00:00Z"
  }
}
```

---

#### Delete User

```http
DELETE /v1/users/{id}
```

**Response (204 No Content):**

No body returned on successful deletion.

---

### 4.2 [Another Resource]

{{CUSTOMIZE}} - Add additional resource endpoints following the same pattern.

---

## 5. Error Handling

### Error Response Format

All errors return a consistent JSON structure:

```json
{
  "error": {
    "code": "invalid_request",
    "message": "The email field is required.",
    "details": [
      {
        "field": "email",
        "message": "This field is required."
      }
    ],
    "request_id": "req_abc123"
  }
}
```

### HTTP Status Codes

| Code | Name | Description |
|------|------|-------------|
| **200** | OK | Request succeeded |
| **201** | Created | Resource created successfully |
| **204** | No Content | Request succeeded (no body) |
| **400** | Bad Request | Invalid request parameters |
| **401** | Unauthorized | Missing or invalid authentication |
| **403** | Forbidden | Insufficient permissions |
| **404** | Not Found | Resource does not exist |
| **409** | Conflict | Resource already exists |
| **422** | Unprocessable Entity | Validation failed |
| **429** | Too Many Requests | Rate limit exceeded |
| **500** | Internal Server Error | Server-side error |

### Error Codes

| Code | Description |
|------|-------------|
| `invalid_request` | Malformed request syntax |
| `authentication_required` | No authentication provided |
| `invalid_credentials` | API key is invalid or expired |
| `insufficient_permissions` | User lacks required permissions |
| `resource_not_found` | Requested resource doesn't exist |
| `validation_error` | Request body failed validation |
| `rate_limit_exceeded` | Too many requests |
| `internal_error` | Unexpected server error |

---

## 6. Rate Limiting

### Limits

| Plan | Requests/Minute | Requests/Day |
|------|-----------------|--------------|
| **Free** | 60 | 1,000 |
| **Pro** | 600 | 50,000 |
| **Enterprise** | 6,000 | Unlimited |

### Rate Limit Headers

```http
X-RateLimit-Limit: 600
X-RateLimit-Remaining: 599
X-RateLimit-Reset: 1705234800
```

### Handling Rate Limits

When rate limited (429), implement exponential backoff:

```javascript
async function fetchWithRetry(url, options, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    const response = await fetch(url, options);
    
    if (response.status === 429) {
      const retryAfter = response.headers.get('Retry-After') || Math.pow(2, i);
      await sleep(retryAfter * 1000);
      continue;
    }
    
    return response;
  }
  throw new Error('Max retries exceeded');
}
```

---

## 7. OpenAPI Specification

### Full OpenAPI 3.0 Spec

```yaml
openapi: 3.0.3
info:
  title: {{PROJECT_NAME}} API
  description: |
    {{PROJECT_NAME}} API provides programmatic access to [functionality].
    
    ## Authentication
    All API requests require a Bearer token in the Authorization header.
  version: "1.0.0"
  contact:
    email: api@{{PROJECT_URL}}.com
  license:
    name: MIT

servers:
  - url: https://api.{{PROJECT_URL}}.com/v1
    description: Production
  - url: https://staging-api.{{PROJECT_URL}}.com/v1
    description: Staging
  - url: https://sandbox-api.{{PROJECT_URL}}.com/v1
    description: Sandbox

security:
  - bearerAuth: []

paths:
  /users:
    get:
      summary: List users
      operationId: listUsers
      tags:
        - Users
      parameters:
        - name: page
          in: query
          schema:
            type: integer
            default: 1
        - name: per_page
          in: query
          schema:
            type: integer
            default: 20
            maximum: 100
      responses:
        '200':
          description: List of users
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/UserList'
        '401':
          $ref: '#/components/responses/Unauthorized'
    
    post:
      summary: Create user
      operationId: createUser
      tags:
        - Users
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateUserRequest'
      responses:
        '201':
          description: User created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
        '422':
          $ref: '#/components/responses/ValidationError'

  /users/{id}:
    get:
      summary: Get user
      operationId: getUser
      tags:
        - Users
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
      responses:
        '200':
          description: User details
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
        '404':
          $ref: '#/components/responses/NotFound'

components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
  
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
          example: "usr_123abc"
        email:
          type: string
          format: email
        name:
          type: string
        status:
          type: string
          enum: [active, inactive]
        created_at:
          type: string
          format: date-time
        updated_at:
          type: string
          format: date-time
    
    UserList:
      type: object
      properties:
        data:
          type: array
          items:
            $ref: '#/components/schemas/User'
        meta:
          $ref: '#/components/schemas/Pagination'
    
    CreateUserRequest:
      type: object
      required:
        - email
        - name
        - password
      properties:
        email:
          type: string
          format: email
        name:
          type: string
          minLength: 1
        password:
          type: string
          minLength: 8
        metadata:
          type: object
    
    Pagination:
      type: object
      properties:
        page:
          type: integer
        per_page:
          type: integer
        total:
          type: integer
        total_pages:
          type: integer
    
    Error:
      type: object
      properties:
        error:
          type: object
          properties:
            code:
              type: string
            message:
              type: string
            request_id:
              type: string

  responses:
    Unauthorized:
      description: Authentication required
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
    
    NotFound:
      description: Resource not found
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
    
    ValidationError:
      description: Validation failed
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
```

---

## 8. SDKs & Code Examples

### JavaScript/TypeScript

```typescript
// Using fetch
const response = await fetch('https://api.example.com/v1/users', {
  headers: {
    'Authorization': `Bearer ${API_KEY}`,
    'Content-Type': 'application/json'
  }
});
const data = await response.json();
```

### Python

```python
import requests

response = requests.get(
    'https://api.example.com/v1/users',
    headers={'Authorization': f'Bearer {API_KEY}'}
)
data = response.json()
```

### cURL

```bash
curl -X GET "https://api.example.com/v1/users" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | {{DOCUMENT_CREATED_DATE}} | Initial release |

---

**Need Help?**

- 📚 Documentation: https://docs.{{PROJECT_URL}}.com
- 💬 Support: support@{{PROJECT_URL}}.com
- 🐛 Report Issues: https://github.com/{{ORG}}/{{REPO}}/issues

