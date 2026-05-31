# Swift Mod

Swift Mod is a privacy-focused, AI-powered Android application analysis and patching platform. It gives users complete control over their applications by providing tools to analyze, modify, patch, and re-sign Android packages (APK, XAPK, APKS) through an intuitive Flutter-based interface.

## Core Features

- **App Library:** Import and manage APK, XAPK, and APKS files locally.
- **Deep Analysis:** Analyze app manifests, permissions, components, network usage, trackers, ad SDKs, and Google dependencies.
- **Patch Engine:** Apply pre-built patch templates for ad removal, analytics removal, network control, optimization, and de-Googling.
- **AI Assistant:** Connect any OpenAI-compatible AI provider (OpenAI, Anthropic, Gemini, OpenRouter) to analyze apps, explain findings, and generate custom patch rules using natural language.
- **APK Signing:** Automatically sign modified APKs using internal keys or import custom keystores (JKS, PKCS12) with support for v1, v2, v3, and v4 signature schemes.
- **Export & Reports:** Export patched applications and generate detailed modification reports in PDF, JSON, or Markdown formats.

## Privacy & Storage

Swift Mod is built with a privacy-first architecture. All APK files, modified binaries, keystores, AI API keys, and analysis reports are stored strictly locally on the device. The application never automatically uploads APK files to any remote server.

## Tech Stack

This project is built using:
- **Flutter** & **Dart**
- **Material 3 Expressive** UI (Dynamic Color, Edge-to-edge UI, Adaptive Layouts)
- **Supabase** (Authentication, Database, Storage)

## Setup Instructions

1. Ensure you have the Flutter SDK installed and set up.
2. Clone this repository.
3. Run `flutter pub get` to fetch dependencies.
4. Set up your Supabase project credentials if cloud sync features are enabled.
5. Run the app using `flutter run`.

## About CouldAI

[CouldAI](https://could.ai) is an AI app builder for cross-platform apps that turns prompts into real native iOS, Android, Web, and Desktop apps with autonomous AI agents that architect, build, test, deploy, and iterate production-ready applications. This app was generated with CouldAI.