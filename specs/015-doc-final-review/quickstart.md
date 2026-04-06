# Quick Start Guide - Personal Finance Companion

**For new developers**: Get up and running in under 30 minutes!

## Prerequisites

- Flutter SDK 3.x+
- Dart 3.x+
- Supabase account (free tier works)
- iOS Simulator / Android Emulator (optional)

## Step 1: Clone the Repository

```bash
git clone <repository-url>
cd personal_finance_companion_mobile_app
```

## Step 2: Install Dependencies

```bash
flutter pub get
```

## Step 3: Configure Supabase

1. Create a project at [supabase.com](https://supabase.com)
2. Get your project URL and anon key
3. Copy `.env.example` to `.env` (create if doesn't exist)
4. Add your credentials:

```
SUPABASE_URL=your_project_url
SUPABASE_ANON_KEY=your_anon_key
```

## Step 4: Run the App

```bash
flutter run
```

## Quick Reference

| Task | Command |
|------|---------|
| Run app | `flutter run` |
| Run tests | `flutter test` |
| Build iOS | `flutter build ios` |
| Build Android | `flutter build apk` |
| Analyze code | `flutter analyze` |

## Troubleshooting

- **Build fails**: Run `flutter clean && flutter pub get`
- **Supabase connection**: Verify credentials in `.env`
- **iOS simulator**: Use `xcrun simctl list` to check available devices

## Next Steps

- Read the full [README.md](../README.md) for architecture details
- Review feature structure in `lib/features/`
- Check code quality guidelines in `docs/`