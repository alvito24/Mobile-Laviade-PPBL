---
name: Laviade Studio
colors:
  surface: '#f9f9f6'
  surface-dim: '#dadad7'
  surface-bright: '#f9f9f6'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f4f4f1'
  surface-container: '#eeeeeb'
  surface-container-high: '#e8e8e5'
  surface-container-highest: '#e2e3e0'
  on-surface: '#1a1c1b'
  on-surface-variant: '#444748'
  inverse-surface: '#2f312f'
  inverse-on-surface: '#f1f1ee'
  outline: '#747878'
  outline-variant: '#c4c7c7'
  surface-tint: '#5f5e5e'
  primary: '#000000'
  on-primary: '#ffffff'
  primary-container: '#1c1b1b'
  on-primary-container: '#858383'
  inverse-primary: '#c8c6c5'
  secondary: '#675d4e'
  on-secondary: '#ffffff'
  secondary-container: '#eee1cd'
  on-secondary-container: '#6d6353'
  tertiary: '#000000'
  on-tertiary: '#ffffff'
  tertiary-container: '#1d1b1a'
  on-tertiary-container: '#868381'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e5e2e1'
  primary-fixed-dim: '#c8c6c5'
  on-primary-fixed: '#1c1b1b'
  on-primary-fixed-variant: '#474646'
  secondary-fixed: '#eee1cd'
  secondary-fixed-dim: '#d2c5b2'
  on-secondary-fixed: '#211b0f'
  on-secondary-fixed-variant: '#4e4637'
  tertiary-fixed: '#e6e1df'
  tertiary-fixed-dim: '#cac6c3'
  on-tertiary-fixed: '#1d1b1a'
  on-tertiary-fixed-variant: '#484645'
  background: '#f9f9f6'
  on-background: '#1a1c1b'
  surface-variant: '#e2e3e0'
typography:
  display:
    fontFamily: Archivo Narrow
    fontSize: 40px
    fontWeight: '700'
    lineHeight: 44px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Archivo Narrow
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 36px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Archivo Narrow
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: 0em
  headline-sm:
    fontFamily: Archivo Narrow
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: 0em
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
    letterSpacing: 0em
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: 0em
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0em
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
  label-sm:
    fontFamily: Inter
    fontSize: 10px
    fontWeight: '500'
    lineHeight: 14px
    letterSpacing: 0.03em
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  base: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  2xl: 48px
  margin-mobile: 16px
  gutter-mobile: 12px
---

## Brand & Style
The brand personality is rooted in contemporary streetwear culture: curated, confident, and utilitarian. It targets a youth-centric audience that values authenticity and "quiet luxury" within the street fashion space. 

The design style is **Minimalist-Modern with a Brutalist edge**. It prioritizes high-quality product photography and bold typography over decorative interface elements. The UI should feel like a physical lookbook—structured, spacious, and tactile. By stripping away non-essential styling like gradients and heavy shadows, the design system emphasizes the "drop" culture and the physical textures of the apparel.

## Colors
The palette is dominated by a high-contrast monochrome foundation to reflect the raw aesthetic of streetwear. 

- **Primary & Text:** #111111 is used for all primary actions, headings, and core UI elements to ensure maximum impact and legibility.
- **Background:** #F7F7F4 (Off-White) provides a warmer, more premium feel than pure white, reducing eye strain and mimicking high-end paper stock.
- **Accent:** #D8CBB8 (Soft Beige) is reserved for subtle highlights, category tags, or secondary call-to-actions to introduce a curated, earthy tone.
- **Functional:** Status colors are saturated but used sparingly to maintain the minimalist aesthetic.

## Typography
The typography uses a pairing of **Archivo Narrow** for headlines and **Inter** for body text. 

- **Headlines:** Archivo Narrow provides a condensed, impactful look characteristic of street signage and industrial branding. It should be set with tight leading and slight negative letter spacing for a "locked-in" appearance.
- **Body:** Inter ensures high legibility for product descriptions and technical details. 
- **Labels:** Use uppercase for labels and small metadata to create a clear distinction from body content, reinforcing the utilitarian aesthetic.

## Layout & Spacing
This design system utilizes a **Fluid Grid** for mobile, centered around a 4px baseline. 

- **Margins:** Standard mobile screens use a 16px side margin.
- **Gutter:** 12px gutters between grid items (e.g., product catalog views) to allow for tight, dense information architecture without clutter.
- **Rhythm:** Vertical spacing should follow the 8px incremental scale (8, 16, 24, 32, 48). Use larger gaps (48px) to separate major sections like "New Drops" from "Categories."

## Elevation & Depth
Depth is achieved through **Tonal Layers** and **Low-Contrast Outlines** rather than shadows. 

- **Surfaces:** Use #FFFFFF (Surface White) for cards and interactive containers placed on the #F7F7F4 (Off-White) background.
- **Borders:** A 1px solid border (#E5E5E5) defines the boundaries of cards and input fields. 
- **Active State:** Elements in a focused or pressed state should use a thicker 2px border or a solid #111111 fill to indicate depth, rather than a shadow. This maintains the flat, "printed" feel of the interface.

## Shapes
The shape language is **Soft** but disciplined. 

A 0.25rem (4px) corner radius is the standard for cards, buttons, and input fields. This slight rounding removes the harshness of a purely "sharp" brutalist design while maintaining a technical, modern edge. 

- **Buttons/Inputs:** 4px radius.
- **Large Sections:** 8px (rounded-lg) for container-level groupings.
- **Icons:** Use geometric, stroke-based icons with consistent 2px line weights to match the typography.

## Components
- **Buttons:** Primary buttons are solid #111111 with #FFFFFF text, 4px radius, and no shadow. Secondary buttons are outlined with a 1px #111111 border.
- **Cards:** Product cards use the Surface White background with a 1px Light Gray border. Product imagery should be aspect-ratio locked (4:5 or 1:1) to keep the grid uniform.
- **Input Fields:** 1px #E5E5E5 border with 16px internal padding. Labels are positioned above the field in `label-md` uppercase style.
- **Chips:** Used for sizing (e.g., S, M, L, XL). Unselected: Light Gray border; Selected: Solid Black fill with White text.
- **Lists:** Clean dividers (#E5E5E5) between items. Use `body-md` for primary list text and `muted-text` for secondary information.
- **States:** 
    - *Loading:* Shimmer/Skeleton screens using the #F7F7F4 and #E5E5E5 colors.
    - *Success/Error:* Use the functional color palette in small icons or subtle top-banners.