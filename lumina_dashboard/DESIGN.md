# Design System Strategy: The Digital Atelier

## 1. Overview & Creative North Star
The "Creative North Star" for this design system is **The Digital Atelier**. 

In an atelier, work is both functional and artisanal. This system moves away from the rigid, sterile "SaaS-box" aesthetic and instead treats the dashboard as a curated editorial space. We achieve this through "Soft Minimalism"—a philosophy that prioritizes breathing room (whitespace), tonal depth over structural lines, and intentional asymmetry. 

While the data may be heavy (analytics and tasks), the interface should feel light. By leveraging high-contrast typography scales (Manrope for high-level displays vs. Inter for functional data) and overlapping, layered surfaces, we create a sense of tactile luxury. The goal is a workspace that feels like a premium physical desktop: organized, soft to the touch, and intellectually clear.

---

## 2. Colors
Our palette is rooted in soft pastels—creams, dusty pinks, and muted blues—that reduce cognitive fatigue in task-heavy environments.

### The "No-Line" Rule
**Explicit Instruction:** Do not use 1px solid borders to section off areas. Separation must be achieved through background color shifts. Use the `surface` token for the base and `surface_container` variants for distinct zones. A sidebar should sit on a different tonal tier than the main content, not be separated by a line.

### Surface Hierarchy & Nesting
Treat the UI as physical layers.
*   **Base:** `background` (#fffcf7).
*   **Primary Work Area:** `surface_container_low` (#fcf9f4).
*   **Interactive Cards:** `surface_container_lowest` (#ffffff) to create a subtle "pop" from the background.
*   **Active Elements:** Use `primary_container` (#a7bdfb) for highlight areas.

### The "Glass & Gradient" Rule
To add soul to the UI, floating elements (like modals or hovering navigation states) should utilize Glassmorphism. Use a semi-transparent `surface` color with a `backdrop-filter: blur(20px)`. Main CTAs or Hero Stat cards should use a subtle linear gradient transitioning from `primary` (#4d639b) to `primary_container` (#a7bdfb) at a 135-degree angle.

---

## 3. Typography
We utilize a dual-font strategy to balance editorial character with high-density legibility.

*   **Display & Headlines (Manrope):** Our "Authoritative" voice. Used for `display-lg` through `headline-sm`. Its geometric yet warm curves provide a premium, modern feel.
*   **Body & Labels (Inter):** Our "Functional" voice. Inter’s high x-height and neutral personality ensure that complex analytics and task lists remain legible even at the `label-sm` (0.6875rem) scale.

**Hierarchy Tip:** Use `on_surface_variant` (#656461) for secondary body text to create a clear visual distinction between primary data and metadata without using different font sizes.

---

## 4. Elevation & Depth
In the Digital Atelier, depth is felt, not seen. We avoid heavy dropshadows in favor of tonal layering.

*   **The Layering Principle:** Place a `surface_container_lowest` card on top of a `surface_container` background. The subtle shift from #f6f3ee to #ffffff creates enough contrast for the eye to perceive a "lift" without visual noise.
*   **Ambient Shadows:** For floating components (like a profile popover), use a diffused shadow: `box-shadow: 0 12px 32px rgba(56, 56, 53, 0.06);`. The shadow color is a low-opacity version of `on_surface`, making it feel like natural light.
*   **The "Ghost Border":** If accessibility requires a container boundary, use the `outline_variant` (#bbb9b4) at 20% opacity. This "Ghost Border" provides a hint of structure without breaking the soft aesthetic.
*   **Roundedness:** Use the `xl` (1.5rem) scale for large cards and the `md` (0.75rem) scale for interactive components like buttons. This reinforces the "modern and approachable" brand personality.

---

## 5. Components

### Buttons
*   **Primary:** Solid `primary` (#4d639b) with `on_primary` (#ffffff) text. Use `rounded-md` (0.75rem).
*   **Secondary:** `secondary_container` (#ffc3be) background. This provides a soft, pinkish pastel "alt" action that feels cohesive with the brand.
*   **Tertiary:** No background; `primary` text. Use for low-emphasis actions.

### Cards & Lists
*   **The Divider Forbid:** Never use `<hr>` tags or border-bottoms. Use `1.5rem` to `2rem` of vertical spacing to separate list items, or alternate background colors between `surface_container_low` and `surface_container_lowest`.
*   **Stats Cards:** Use `headline-md` for the metric and `label-md` for the descriptor.

### Input Fields
*   **Style:** Background `surface_container_high` (#f0eee8) with a `none` border. On focus, transition to a `Ghost Border` using the `primary` color at 40% opacity.
*   **Error State:** Use `error` (#c0262d) for text, but keep the input background a soft `error_container` (#fb5151) at 10% opacity.

### Navigation Sidebar
*   The sidebar should be a solid `surface_container_lowest` block.
*   **Active State:** Use a "pill" shape (`rounded-full`) with a `secondary_container` background to highlight the current page.

---

## 6. Do's and Don'ts

### Do:
*   **Do** embrace white space. If a layout feels "busy," increase the padding to the `xl` scale.
*   **Do** use asymmetrical layouts for dashboards. Not every card needs to be the same height; let content dictate the container size.
*   **Do** use `tertiary` (#006f7c) for success states or positive growth trends—it’s a sophisticated alternative to "standard" green.

### Don't:
*   **Don't** use pure black (#000000) for text. Always use `on_surface` (#383835) to maintain the soft tonal balance.
*   **Don't** use sharp corners. Every interactive element must have at least a `sm` (0.25rem) radius.
*   **Don't** use heavy, opaque borders. They act as "visual speedbumps" and destroy the atelier's flow.
*   **Don't** use standard "Material Design" blue. Stick to the curated `primary` (#4d639b) for a more bespoke, high-end feel.