# Delaware Makes - A Platform To Connect Local PPE Manufacturing Efforts with Organizations In Need

## Quick Start<br>
This site is written in Flutter, a cross-platform UI toolkit from google that uses the Dart programming language.



To get an introduction to Flutter, check out Google's Codelabs that enable you to learn the fundamentals online without downloading anything.
 - For a comparison between flutter and other platforms check out these articles:
      - [Introduction to Flutter for Web Developers](https://flutter.dev/docs/get-started/flutter-for/web-devs)
      - [Introduction to Flutter for React Native Developers](https://flutter.dev/docs/get-started/flutter-for/react-native-devs)
      - [Introduction to Flutter for IOS Developers](https://flutter.dev/docs/get-started/flutter-for/ios-devs)
      -[Introduction to Flutter for Android Developers](https://flutter.dev/docs/get-started/flutter-for/android-devs)
- To understand how flutter web works check out this [Web Support for Flutter](https://flutter.dev/web) article


**Required Software** <br/>
If you are interested in contributing, you'll need to download the following software
- [Flutter Web Install SDK](https://flutter.dev/docs/get-started/web)
      - [Windows Install Instructions](https://flutter.dev/docs/get-started/install/windows)    
      - [MacOS Install Instructions](https://flutter.dev/docs/get-started/install/macos)       
      - [Linux Install Instructions](https://flutter.dev/docs/get-started/install/linux)   
      - [ChromeOS Install Instructions](https://flutter.dev/docs/get-started/install/chromeos])
- [Chrome](https://www.google.com/chrome/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/)

## Flutter Environment Set Up <br/>
For this project, we only use Flutter Web, so to get that running on your computer, follow the instructions on [Flutter Web Install SDK](https://flutter.dev/docs/get-started/web). 

The first step is to download the Flutter SDK, no need to set up the Android or IOS development environments. Once you install the SDK, run the command:
```
flutter doctor
```
You should see something similar to what's shown below:

[todo]

Once Flutter is successfully installed, you will need to install [Chrome](https://www.google.com/chrome/)(if it's not already installed) so that you can run your code in the browser during development

Lastly, you will likely want to use Visual Studio Code as your code editor. Go to [Visual Studio Code](https://code.visualstudio.com/) to download the software. Then go to the "extensions" tab on the side and add the flutter extension and dart extension.
[picture below]



## Testing Flutter Install <br/>
Before you try running this project, make sure flutter is working properly by creating a new project.
/*
Todo
*/

**Project File Structure**<br>
- state/: Directory containing the majority of the logic of the site
        - AppState- the AppState class contains much of the core logic including initiating the database, handling forms, and dealing with user login
- migrations/: Directory for scriptable deployment files
- test/: Directory for test files for testing your application and contracts
- truffle-config.js: Truffle configuration file
```
lib
├── main.dart
├── root_widget.dart
├── routes.dart
├── theme.dart
├── state
│   ├── service_locator.dart
│   ├── app_state.dart
│   ├── db_interface.dart
│   ├── forms_tabs.dart
│   └── docs_repo.dart
├── pages
│   ├── about_us
│   │    └── about_us_page.dart
│   ├── designs
│   │    └── designs_page.dart
│   ├── profile
│   │    └── profile_page.dart
│   ├── resources
│   │    └── resources_page.dart
│   ├── home
│   |    ├── home_page.dart
│   │    └── components
│   │          ├── count.dart
│   │          ├── intro.dart
│   │          ├── maker_section.dart
│   │          └── request_section.dart
│   ├── locations
│   |    ├── locations.dart
│   │    └── components
│   │          ├── map_widget.dart
│   │          ├── claim_tile.dart
│   │          └── request_tile.dart
├── counters
│   ├── design_counts.dart
│   ├── group_counts.dart
│   ├── org_counts.dart
│   └──  request_counts.dart


```



**Setting Up Project Locally**




**Dependencies**




