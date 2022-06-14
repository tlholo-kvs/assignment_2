import 'package:backendless_sdk/backendless_sdk.dart';

class InitApp {
  static const String apiKeyAndroid =
      'B17A4C68-6ADB-4EBC-BFEC-CF70AE036FCC'; //add your own key
  static const String apiKeyIOS =
      '35EC0E1A-25CA-401F-8A35-0CA1A27D1957'; //add your own key
  static const String appID =
      '22773525-9A31-21B8-FF5D-8DBE06A5F700'; // add your own key

  static void initializeApp() async {
    await Backendless.initApp(
        androidApiKey: apiKeyAndroid,
        iosApiKey: apiKeyIOS,
        applicationId: appID);
  }
}
