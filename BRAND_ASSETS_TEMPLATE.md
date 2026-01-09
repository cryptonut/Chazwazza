# Brand Assets Guide

> **Template for documenting brand guidelines and assets**

**Document Owner:** {{DOCUMENT_OWNER}}  
**Created:** {{DOCUMENT_CREATED_DATE}}  
**Last Updated:** {{DOCUMENT_LAST_UPDATED}}  
**Brand:** {{PROJECT_NAME}}

---

## Purpose

This document serves as the single source of truth for all brand assets, ensuring consistency across all touchpoints — website, app, marketing materials, investor documents, and communications.

---

## 🎨 Color Palette

### Primary Colors

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| **Primary** | `{{PRIMARY_COLOR}}` | rgb(X, X, X) | Main brand color, CTAs, key elements |
| **Primary Dark** | `{{PRIMARY_DARK}}` | rgb(X, X, X) | Hover states, emphasis |
| **Primary Light** | `{{PRIMARY_LIGHT}}` | rgb(X, X, X) | Backgrounds, subtle accents |

### Secondary Colors

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| **Accent** | `{{ACCENT_COLOR}}` | rgb(X, X, X) | Highlights, secondary actions |
| **Accent Dark** | `{{ACCENT_DARK}}` | rgb(X, X, X) | Hover states |
| **Accent Light** | `{{ACCENT_LIGHT}}` | rgb(X, X, X) | Backgrounds |

### Neutral Colors

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| **Dark** | `{{DARK_COLOR}}` | rgb(X, X, X) | Text, dark backgrounds |
| **Gray 700** | `{{GRAY_700}}` | rgb(X, X, X) | Secondary text |
| **Gray 500** | `{{GRAY_500}}` | rgb(X, X, X) | Muted text, borders |
| **Gray 300** | `{{GRAY_300}}` | rgb(X, X, X) | Light borders |
| **Gray 100** | `{{GRAY_100}}` | rgb(X, X, X) | Light backgrounds |
| **White** | `#FFFFFF` | rgb(255, 255, 255) | Backgrounds, text on dark |

### Status Colors

| Name | Hex | Usage |
|------|-----|-------|
| **Success** | `{{SUCCESS_COLOR}}` | Positive states, confirmations |
| **Warning** | `{{WARNING_COLOR}}` | Warnings, attention needed |
| **Error** | `{{ERROR_COLOR}}` | Errors, destructive actions |
| **Info** | `{{INFO_COLOR}}` | Informational messages |

### CSS Variables

```css
:root {
  /* Primary */
  --primary: {{PRIMARY_COLOR}};
  --primary-dark: {{PRIMARY_DARK}};
  --primary-light: {{PRIMARY_LIGHT}};
  
  /* Accent */
  --accent: {{ACCENT_COLOR}};
  --accent-dark: {{ACCENT_DARK}};
  --accent-light: {{ACCENT_LIGHT}};
  
  /* Neutrals */
  --dark: {{DARK_COLOR}};
  --gray-700: {{GRAY_700}};
  --gray-500: {{GRAY_500}};
  --gray-300: {{GRAY_300}};
  --gray-100: {{GRAY_100}};
  --white: #FFFFFF;
  
  /* Status */
  --success: {{SUCCESS_COLOR}};
  --warning: {{WARNING_COLOR}};
  --error: {{ERROR_COLOR}};
  --info: {{INFO_COLOR}};
  
  /* Semantic */
  --background: var(--dark);
  --foreground: var(--white);
  --border: var(--gray-500);
  --muted: var(--gray-700);
}
```

---

## 🔤 Typography

### Font Families

| Type | Font | Fallback | Usage |
|------|------|----------|-------|
| **Primary** | {{PRIMARY_FONT}} | system-ui, sans-serif | Headings, body text |
| **Monospace** | {{MONO_FONT}} | Consolas, monospace | Code, technical content |

### Font Import

```html
<!-- Google Fonts Example -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family={{PRIMARY_FONT_URL}}&display=swap" rel="stylesheet">
```

### Type Scale

| Name | Size | Weight | Line Height | Usage |
|------|------|--------|-------------|-------|
| **Display** | 72px | 700 | 1.1 | Hero headlines |
| **H1** | 48px | 700 | 1.2 | Page titles |
| **H2** | 36px | 600 | 1.25 | Section headers |
| **H3** | 24px | 600 | 1.3 | Subsections |
| **H4** | 20px | 600 | 1.4 | Card titles |
| **Body Large** | 18px | 400 | 1.6 | Lead paragraphs |
| **Body** | 16px | 400 | 1.6 | Default text |
| **Body Small** | 14px | 400 | 1.5 | Captions, metadata |
| **Caption** | 12px | 400 | 1.4 | Fine print |

### CSS Typography

```css
/* Headings */
h1 { font-size: 48px; font-weight: 700; line-height: 1.2; }
h2 { font-size: 36px; font-weight: 600; line-height: 1.25; }
h3 { font-size: 24px; font-weight: 600; line-height: 1.3; }
h4 { font-size: 20px; font-weight: 600; line-height: 1.4; }

/* Body */
body { font-size: 16px; font-weight: 400; line-height: 1.6; }
.lead { font-size: 18px; }
.small { font-size: 14px; }
.caption { font-size: 12px; }
```

---

## 🖼️ Logo

### Logo Variations

| Variation | Use Case | Min Size |
|-----------|----------|----------|
| **Primary** | Default usage | 120px wide |
| **Light** | Dark backgrounds | 120px wide |
| **Dark** | Light backgrounds | 120px wide |
| **Icon Only** | Favicons, app icons | 32px |
| **Horizontal** | Wide spaces, headers | 200px wide |
| **Stacked** | Square spaces | 100px wide |

### Logo Files

```
/brand/logos/
├── {{PROJECT_NAME}}-logo-primary.svg
├── {{PROJECT_NAME}}-logo-light.svg
├── {{PROJECT_NAME}}-logo-dark.svg
├── {{PROJECT_NAME}}-icon.svg
├── {{PROJECT_NAME}}-logo-horizontal.svg
├── {{PROJECT_NAME}}-logo-stacked.svg
└── /png/
    ├── {{PROJECT_NAME}}-logo-primary@1x.png
    ├── {{PROJECT_NAME}}-logo-primary@2x.png
    └── {{PROJECT_NAME}}-logo-primary@3x.png
```

### Logo Clear Space

Maintain clear space around the logo equal to the height of the logo mark (icon portion).

```
┌─────────────────────────────────┐
│                                 │
│    ┌─────┐                      │
│    │LOGO │  ← Clear space = X   │
│    └─────┘                      │
│       ↑                         │
│       X                         │
│                                 │
└─────────────────────────────────┘
```

### Logo Don'ts

- ❌ Don't stretch or distort
- ❌ Don't change colors outside palette
- ❌ Don't add effects (drop shadows, glows)
- ❌ Don't place on busy backgrounds
- ❌ Don't rotate or flip
- ❌ Don't use below minimum size

---

## 📏 Spacing System

### Base Unit

Base spacing unit: **4px**

### Spacing Scale

| Token | Value | Usage |
|-------|-------|-------|
| `space-1` | 4px | Tight spacing, icons |
| `space-2` | 8px | Related elements |
| `space-3` | 12px | Form elements |
| `space-4` | 16px | Default padding |
| `space-5` | 20px | Card padding |
| `space-6` | 24px | Section padding (small) |
| `space-8` | 32px | Section padding (medium) |
| `space-10` | 40px | Section padding (large) |
| `space-12` | 48px | Section margins |
| `space-16` | 64px | Page sections |
| `space-20` | 80px | Major sections |
| `space-24` | 96px | Hero sections |

### CSS Variables

```css
:root {
  --space-1: 4px;
  --space-2: 8px;
  --space-3: 12px;
  --space-4: 16px;
  --space-5: 20px;
  --space-6: 24px;
  --space-8: 32px;
  --space-10: 40px;
  --space-12: 48px;
  --space-16: 64px;
  --space-20: 80px;
  --space-24: 96px;
}
```

---

## 🔲 Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| `radius-sm` | 4px | Badges, tags |
| `radius-md` | 8px | Buttons, inputs |
| `radius-lg` | 12px | Cards |
| `radius-xl` | 16px | Modals, large cards |
| `radius-full` | 9999px | Avatars, pills |

---

## 🌗 Shadow System

| Token | Value | Usage |
|-------|-------|-------|
| `shadow-sm` | `0 1px 2px rgba(0,0,0,0.05)` | Subtle elevation |
| `shadow-md` | `0 4px 6px rgba(0,0,0,0.1)` | Cards, dropdowns |
| `shadow-lg` | `0 10px 15px rgba(0,0,0,0.1)` | Modals, popovers |
| `shadow-xl` | `0 20px 25px rgba(0,0,0,0.15)` | Large modals |
| `shadow-glow` | `0 0 20px {{PRIMARY_COLOR}}40` | Emphasis, CTAs |

---

## ✍️ Voice & Tone

### Brand Voice

| Attribute | Description | Example |
|-----------|-------------|---------|
| **Professional** | Expert but approachable | "We've built..." not "We kinda made..." |
| **Confident** | Certain but not arrogant | "We deliver..." not "We try to..." |
| **Clear** | Simple, no jargon | "Fast" not "Optimized throughput" |
| **Human** | Warm, conversational | "You'll love..." not "Users will..." |

### Tone by Context

| Context | Tone | Example |
|---------|------|---------|
| Marketing | Enthusiastic, inspiring | "Transform how you..." |
| Product | Helpful, instructive | "Click here to..." |
| Error | Apologetic, solution-focused | "Something went wrong. Try..." |
| Success | Celebratory, encouraging | "Great work! You've..." |
| Support | Empathetic, patient | "We understand. Let's..." |

### Writing Guidelines

| Do | Don't |
|----|-------|
| Use active voice | Use passive voice |
| Be specific | Be vague |
| Use "you" and "we" | Use "the user" or "one" |
| Keep sentences short | Write run-on sentences |
| Start with the benefit | Bury the lead |

---

## 📱 Application-Specific Assets

### Favicon Sizes

| Size | Platform | File |
|------|----------|------|
| 16x16 | Browser tabs | favicon-16.png |
| 32x32 | Browser tabs (retina) | favicon-32.png |
| 48x48 | Windows | favicon-48.png |
| 180x180 | iOS | apple-touch-icon.png |
| 192x192 | Android | android-chrome-192.png |
| 512x512 | Android splash | android-chrome-512.png |

### Social Media Sizes

| Platform | Image Type | Size |
|----------|------------|------|
| Twitter/X | Profile | 400x400 |
| Twitter/X | Header | 1500x500 |
| Twitter/X | Card | 1200x628 |
| LinkedIn | Profile | 400x400 |
| LinkedIn | Banner | 1584x396 |
| LinkedIn | Post | 1200x627 |
| Facebook | Profile | 320x320 |
| Facebook | Cover | 820x312 |
| Facebook | Post | 1200x630 |
| Instagram | Profile | 320x320 |
| Instagram | Post | 1080x1080 |
| Instagram | Story | 1080x1920 |

### Open Graph Defaults

```html
<meta property="og:title" content="{{PROJECT_NAME}} - {{TAGLINE}}">
<meta property="og:description" content="{{DESCRIPTION}}">
<meta property="og:image" content="{{OG_IMAGE_URL}}">
<meta property="og:url" content="{{WEBSITE_URL}}">
<meta property="og:type" content="website">
<meta name="twitter:card" content="summary_large_image">
```

---

## 📁 Asset Organization

### Folder Structure

```
/brand/
├── /logos/
│   ├── /svg/           # Vector originals
│   ├── /png/           # Rasterized versions
│   └── /special/       # One-off variations
├── /colors/
│   └── palette.ase     # Adobe Swatch Exchange
├── /typography/
│   └── /fonts/         # Licensed fonts (if applicable)
├── /icons/
│   └── /favicons/      # All favicon sizes
├── /social/
│   └── /templates/     # Social media templates
├── /photography/
│   └── /approved/      # Approved brand photos
└── README.md           # This file
```

---

## ✅ Brand Checklist

### New Project Setup

- [ ] Colors defined and documented
- [ ] Typography selected and imported
- [ ] Logo variations created
- [ ] Favicon set generated
- [ ] Social media assets prepared
- [ ] CSS variables configured
- [ ] Brand voice documented

### New Page/Feature

- [ ] Uses correct color palette
- [ ] Uses correct typography
- [ ] Spacing follows system
- [ ] Logo usage is correct
- [ ] Tone matches brand voice
- [ ] Responsive considerations

### Before Launch

- [ ] All assets in correct sizes
- [ ] Open Graph tags configured
- [ ] Favicon set complete
- [ ] Social profiles updated
- [ ] Brand consistency verified

---

## AI Agent Instructions

When working with brand assets:

1. **Never deviate** from documented colors, fonts, or styles
2. **Use CSS variables** not hardcoded values
3. **Maintain consistency** across all touchpoints
4. **Reference this document** when creating new UI
5. **Ask for clarification** if brand guidelines are unclear

---

*Template from [Chazwazza](https://github.com/cryptonut/Chazwazza) - Enterprise Project Starter Kit*

