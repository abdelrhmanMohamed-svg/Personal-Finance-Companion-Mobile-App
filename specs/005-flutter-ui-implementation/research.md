# Research: Phase 2.1: UI Implementation (Flutter)

**Date**: 2026-04-04  
**Feature**: Phase 2.1: UI Implementation

---

## Decision 1: Design Token Source

**Decision**: Google Stitch MCP (primary), local `design/` folder (fallback)

**Rationale**: User confirmed this approach. Google Stitch MCP generates design tokens directly. Local `design/` folder provides resilience if MCP is unavailable.

**Alternatives Considered**:
- Google Stitch MCP only - rejected due to reliability risk
- Local design files only - rejected; loses AI-generated design benefits

---

## Decision 2: Design Token Format

**Decision**: Any format from Google Stitch, convert as needed

**Rationale**: Google Stitch may output design tokens in various formats. The implementation should handle conversion rather than restricting the source format.

**Alternatives Considered**:
- JSON only - too restrictive
- Dart ThemeData directly - limits design flexibility

---

## Decision 3: Responsive UI Approach

**Decision**: ScreenUtil for responsive sizing

**Rationale**: 
- ScreenUtil is already in project dependencies (per plan.md)
- Provides consistent scaling across screen sizes
- Works well for mobile-only apps with known width ranges (320px-414px)
- Best practice for Flutter mobile apps

**Alternatives Considered**:
- MediaQuery only - more verbose, less consistent
- LayoutBuilder - good for specific widgets but verbose for screens
- Sizer package - similar but ScreenUtil is already in dependencies

---

## Decision 4: UI Performance

**Decision**: Defer to Phase 8 (UX and Polish)

**Rationale**: Phase 8 explicitly covers loading states, empty states, error handling, smooth navigation. UI implementation phase should focus on correctness and component creation.

---

## Decision 5: Testing Scope

**Decision**: Mobile only (iOS and Android), no tablets

**Rationale**: Project plan explicitly states "mobile devices only". Tablets and desktops are explicitly out of scope.

---

## Decision 6: Theme Mode

**Decision**: Light mode only for MVP

**Rationale**: Dark mode can be added in Phase 8. Phase 2.1 focuses on getting core UI implemented.

---

## Research Findings

### Google Stitch Integration
- Google Stitch MCP provides design tokens (colors, typography, spacing)
- Output format varies; conversion to Flutter ThemeData required
- Can use design-to-code workflow for direct implementation

### ScreenUtil Best Practices
- Initialize ScreenUtil in main.dart before runApp()
- Use design draft size (typically 375x812 for iPhone X) as reference
- All sizes defined using ScreenUtil helper methods (e.g., `ScreenUtil().setWidth(100)`)
- Font sizes scale proportionally to screen width

### Design Token Structure (Typical)
```json
{
  "colors": {
    "primary": "#...",
    "secondary": "#...",
    "background": "#..."
  },
  "typography": {
    "headline": { "fontSize": 24, "fontWeight": "bold" },
    "body": { "fontSize": 16 }
  },
  "spacing": {
    "small": 8,
    "medium": 16,
    "large": 24
  }
}
```
