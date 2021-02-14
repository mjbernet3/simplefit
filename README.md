# SimpleFit

***This application is not currently available on either the App Store or Google Play Store. Any existing applications on these platforms are not associated with this one.***

SimpleFit is an iOS and Android mobile fitness application that allows users to create, record, and easily walk through their own workouts without premium subscriptions, ads, and other intrusions. I primarily made this because a few of my friends and I have been using regular notes apps in the past and that was getting annoying. Plus Flutter is cool. There are many great fitness applications out there already, but for me they are too bloated.

## Setting Up

### iOS
1. Clone repository and change to client directory. 
2. Run `flutter pub get`.
3. Download GoogleService-Info.plist from Firebase iOS application.
4. Open ios/Runner.xcodeproj directory with XCode.
5. Right click Runner directory and choose Add Files to "Runner".
6. Find GoogleService-Info.plist and click Add.

### Android
1. Clone repository and change to client directory.
2. Run `flutter pub get`.
3. Download google-services.json from Firebase Android application.
4. Add google-services.json to android/app directory.

## Running

### Virtual Device
1. Start iOS simulator or Android emulator.
2. Run `flutter run`.
    - Note that this starts the application in debug mode which slows down the application.
    
### Physical Device
1. Connect iOS or Android device to computer.
2. Run `flutter run --release`.
    - Note that this requires the connected device to be configured for development.

## Codebase Overview

### Client Organization
Contains the code for the Flutter application. This organization refers to /lib, since other subdirectories and files are for configuration.
- **/components:** Page-specific or shared widgets
- **/models:** In-memory representations of stored data
- **/pages:** Root widgets for application pages
- **/services:** Communicate with backend services
- **/utils:** Utilities used throughout the application
  - /structures: Simple data structures for preventing too many parameters
  - app_error: Displays an error message within the current context
  - app_router: Handles navigation between pages
  - app_theme: Contains app-wide styling (only dark theme for now)
  - auth_builder: Monitors authentication status of user and rebuilds app accordingly
  - constants: Constant values such as colors and stat bounds
  - formatter: Converts inputs into certain displayable outputs
  - page_builder: Calculates page bounds and then builds page content
  - validator: Functions for validating user input
- **/view_models:** Manage the state and important information of pages

### Server Organization
Contains the code for Firebase Cloud Functions. This organization refers to /functions/src, since other files are for configuration.
- **index.ts:** Functions to deploy and run on server
  - Once enough functions are needed they will not all be in one file
