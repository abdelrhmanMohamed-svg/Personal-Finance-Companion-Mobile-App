# Performance Baselines

This document defines the performance standards for the Personal Finance Companion app.

## Target Metrics

| Metric | Target | Measurement Method |
|--------|--------|---------------------|
| Cold Start Time | < 3000ms | Flutter DevTools timeline |
| Frame Build Time | < 16ms average | flutter_driver performance |
| Memory Usage | < 150MB baseline | Observatory memory timeline |

## Measurement Methods

### Cold Start Time

1. Run app on physical device (not emulator)
2. Force stop app, then launch
3. Measure time from tap to first frame rendered
4. Target: under 3 seconds

### Frame Build Time

1. Enable performance overlay in app
2. Navigate through main user flows
3. Monitor frame times in DevTools
4. Target: 16ms per frame (60fps)

### Memory Usage

1. Launch app with Observatory enabled
2. Take initial memory snapshot (baseline)
3. Navigate through features
4. Compare against baseline
5. Target: under 150MB increase

## When to Run Benchmarks

### Per Feature

Run performance benchmarks:
- Before implementing major UI changes
- After significant refactoring
- Before release

### Before/After Optimization

1. **Before**: Run benchmarks, record baseline
2. **Optimize**: Implement performance improvements
3. **After**: Re-run benchmarks, verify improvement
4. **Document**: Save results in performance logs

### CI Integration (Future)

Automated performance tests in CI pipeline:
- Cold start test
- Memory leak detection
- Frame time monitoring

## Performance Anti-Patterns to Avoid

- Building full widget trees in `build()` methods
- Not using `const` constructors where possible
- Loading all data at startup instead of lazy loading
- Not using `ListView.builder` for long lists
- Creating new objects in widget rebuilds

## Profiling Tools

| Tool | Purpose |
|------|---------|
| Flutter DevTools | General performance analysis |
| Observatory | Memory profiling |
| flutter_driver | Automated performance tests |

## Reporting

When performance issues are found:
1. Document the specific metric failing
2. Include measurement method used
3. Record device/environment details
4. Propose optimization approach
