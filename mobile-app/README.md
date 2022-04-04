# mobile_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Update App Logo (specify path in pubspec):
flutter pub run flutter_launcher_icons:main

Update Name Android:

android/app/src/main/AndroidManifest.xml
<application
        android:name="io.flutter.app.FlutterApplication"
        android:label="your_app_name"
        android:icon="@mipmap/ic_launcher">

Update Name iOS:

ios/Runner/Info.plist
<key>CFBundleName</key>
<string>your_app_name</string>
