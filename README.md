# SimpleFit

**This application is not currently available on either the App Store or Google Play Store. Any existing applications on these platforms are not associated with this one.**

SimpleFit is an iOS and Android mobile fitness application that allows users to create, record, and easily walk through their own workouts without premium subscriptions, ads, and other intrusions. I primarily made this because a few of my friends and I have been using regular notes apps in the past and that was getting annoying. Plus Flutter is cool. There are many great fitness applications out there already, but for me they are too bloated.

## Setting Up

### iOS
1. Clone the repository and change to the client directory. 
2. Run `flutter pub get`.
3. Download GoogleService-Info.plist from Firebase iOS application.
4. Open ios/Runner.xcodeproj folder with XCode.
5. Right click Runner folder and choose Add Files to "Runner".
6. Find GoogleService-Info.plist and click Add.

### Android
1. Clone the repository and change to the client directory.
2. Run `flutter pub get`.
3. Download google-services.json from Firebase Android application.
4. Add google-services.json to android/app folder.

## Running

### Virtual Device
1. Start iOS simulator or Android emulator.
2. Run `flutter run`.
    - Note that this starts the application in debug mode which slows down the application.
    
### Physical Device
1. Connect iOS or Android device to computer.
2. Run `flutter run --release`.
