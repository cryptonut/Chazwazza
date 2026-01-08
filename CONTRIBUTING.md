# Contributing to Chazwazza

Thank you for your interest in contributing to Chazwazza! This document provides guidelines for contributing to the project.

---

## 📋 Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [How Can I Contribute?](#how-can-i-contribute)
3. [Suggesting New Templates](#suggesting-new-templates)
4. [Improving Existing Templates](#improving-existing-templates)
5. [Reporting Issues](#reporting-issues)
6. [Pull Request Process](#pull-request-process)
7. [Style Guidelines](#style-guidelines)

---

## Code of Conduct

This project adheres to a Code of Conduct that all contributors are expected to follow:

- **Be Respectful**: Treat everyone with respect and consideration
- **Be Constructive**: Provide helpful feedback and suggestions
- **Be Inclusive**: Welcome contributors of all backgrounds and experience levels
- **Be Professional**: Keep discussions focused on improving the project

---

## How Can I Contribute?

### 🆕 Suggesting New Templates

Have an idea for a new template that would benefit the community?

1. **Check Existing Issues**: Look for similar suggestions first
2. **Open an Issue**: Use the "Template Suggestion" template
3. **Describe the Template**:
   - What problem does it solve?
   - Who would use it?
   - What should it include?
4. **Provide Examples**: If possible, share examples or references

### 🔧 Improving Existing Templates

Found a way to make a template better?

1. **Open an Issue First**: Discuss significant changes before implementing
2. **Fork the Repository**: Create your own copy
3. **Make Your Changes**: Follow the style guidelines
4. **Submit a Pull Request**: Reference the related issue

### 🐛 Reporting Issues

Found a problem?

1. **Check Existing Issues**: Avoid duplicates
2. **Create a Detailed Issue**:
   - Which template is affected?
   - What's wrong?
   - What did you expect?
   - How can we reproduce it?

### 📝 Improving Documentation

- Fix typos and grammatical errors
- Clarify confusing sections
- Add missing information
- Improve examples

---

## Suggesting New Templates

When suggesting a new template, please include:

### Template Proposal Format

```markdown
## Template Name

### Purpose
What problem does this template solve?

### Target Audience
Who would use this template?

### Proposed Contents
What sections should it include?

### Example Use Case
Describe a scenario where this template would be used.

### Similar Templates
Are there existing templates that cover part of this?

### References
Any existing resources or standards this should follow?
```

### Good Template Candidates

✅ Templates that are:
- Technology-agnostic (or clearly marked for specific tech)
- Broadly applicable across projects
- Following established standards (ISO, IEEE, etc.)
- Filling a gap in the current set

❌ Templates that are:
- Too project-specific
- Duplicating existing templates
- Not related to software development
- Proprietary or restricted

---

## Pull Request Process

### Before Submitting

1. **Discuss First**: Open an issue for significant changes
2. **One Change Per PR**: Keep PRs focused and atomic
3. **Update Documentation**: Ensure README reflects any changes
4. **Test Your Changes**: Verify templates work as intended

### PR Checklist

```markdown
- [ ] I have read the CONTRIBUTING.md guidelines
- [ ] I have checked for similar existing issues/PRs
- [ ] My changes follow the style guidelines
- [ ] I have updated the README if needed
- [ ] I have added/updated examples if applicable
- [ ] My commit messages are clear and descriptive
```

### PR Title Format

Use conventional commit format:

```
type(scope): description

Examples:
- feat(template): add API documentation template
- fix(agent-guide): correct typo in verification section
- docs(readme): update quick start instructions
- style(changelog): improve formatting consistency
```

### Review Process

1. **Automated Checks**: Must pass (if configured)
2. **Maintainer Review**: At least one approval required
3. **Feedback**: Address any requested changes
4. **Merge**: Squash and merge when approved

---

## Style Guidelines

### Document Formatting

#### Headers
```markdown
# Document Title (H1 - only one per document)

## Major Section (H2)

### Subsection (H3)

#### Minor Subsection (H4)
```

#### Tables
```markdown
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Data     | Data     | Data     |
```

#### Code Blocks
````markdown
```language
// Code here
```
````

#### Template Variables
```markdown
{{VARIABLE_NAME}}  - Use double curly braces
{{SCREAMING_CASE}} - Use SCREAMING_CASE for variable names
```

### Writing Style

- **Be Clear**: Write for humans first
- **Be Concise**: Avoid unnecessary words
- **Be Consistent**: Follow established patterns
- **Be Inclusive**: Use gender-neutral language
- **Be Actionable**: Provide concrete guidance

### File Naming

| Type | Convention | Example |
|------|------------|---------|
| Markdown docs | SCREAMING_SNAKE_CASE.md | `AGENT_EXCELLENCE_GUIDE.md` |
| Scripts | snake_case_template.ext | `build_and_distribute_template.ps1` |
| Config files | lowercase | `.gitignore`, `LICENSE` |

### Template Variables

- Use `{{VARIABLE_NAME}}` format
- Use SCREAMING_SNAKE_CASE
- Be descriptive: `{{PROJECT_NAME}}` not `{{PN}}`
- Group related variables in documentation

---

## Recognition

Contributors will be recognized in:

- The project's README
- Release notes when their contribution ships
- The Contributors section (if maintained)

---

## Questions?

If you have questions about contributing:

1. Check existing issues and documentation
2. Open a discussion or issue
3. Reach out to maintainers

---

**Thank you for helping make Chazwazza better! 🎉**

