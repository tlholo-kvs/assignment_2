import 'package:backendless_sdk/backendless_sdk.dart';

class InitApp {
  static const String apiKeyAndroid =
      '34001CA4-E43DE-44B60-94677-342EFCF38782'; //add your own key
  static const String apiKeyIOS =
      'FB4C825E8-B4F01-48752-8B548-3ADF87659663'; //add your own key
  static const String appID =
      '5D0957284-F282D-FAC84-FF8BB-5489CB2C83100'; // add your own key

  static void initializeApp() async {
    await Backendless.initApp(
        androidApiKey: apiKeyAndroid,
        iosApiKey: apiKeyIOS,
        applicationId: appID);
  }
}
