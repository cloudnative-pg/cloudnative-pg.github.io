# Implementation Notes: fix-ossf-1 (Phase 1)

Scope: Critical contrast fixes, accessible focus/skip link, and keyboard/ARIA improvements for nav CTA/menu.

Changes
- Added WCAG AA color tokens and updated `.bg-red-1`, nav text, and link colors to meet ≥4.5:1 contrast.
- Implemented global `:focus-visible` outlines and styled skip link; added skip link + `<main id="main-content">`.
- Converted mobile menu trigger to a keyboard/ARIA-compliant `<button>` with `aria-expanded` toggle + Escape close; improved logo alts/labels.
- Updated footer links to darker reds for contrast; minor hero CTA hover state.

Verification
- Contrast targets align with prescribed token values (`#DC2626` bg + white text, nav `#111827`, links `#B91C1C/#991B1B`).
- Keyboard: skip link focusable; menu button toggles `aria-expanded`, closes on Escape; focus rings visible.
