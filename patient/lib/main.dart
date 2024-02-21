import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:medi_connect/src/feature/fcm/notification_initialiser.dart';
import 'package:medi_connect/src/feature/login/auth_service.dart';
import 'package:medi_connect/src/utils/strings_english.dart';
import 'package:medi_connect/src/utils/theme_data.dart';
import 'firebase_options.dart';
import 'package:location/location.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await notification().notificationInitialiser();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Location location = Location();
  Stripe.publishableKey = FlutterConfig.get('STRIPE_API_KEY');
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }
  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }
  // LocationData locationData;
  // locationData = await location.getLocation();
  // print(locationData);
  // print(locationData.latitude);
  // print(locationData.longitude);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      themeMode: ThemeMode.system,
      theme:lightTheme,
      darkTheme: darkTheme,
      home:AuthService().handleAuthState(),
    );
  }
}
