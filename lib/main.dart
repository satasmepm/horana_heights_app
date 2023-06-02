import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/customer_provider.dart';
import 'provider/network_service_provider.dart';
import 'provider/password_reset_provider.dart';
import 'screens/splash_screen/splash_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Request permission for notifications
  await FirebaseMessaging.instance.requestPermission();

  // Configure FCM message handling
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  // Get the initial message when the app is launched
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    print('App launched by a notification!');
    print('Message data: ${initialMessage.data}');

    if (initialMessage.notification != null) {
      print(
          'Message also contained a notification: ${initialMessage.notification}');
    }
  }
  // Get the FCM token
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  // print('FCM token: $fcmToken');

  final prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token');

  if (stringValue != null) {
    // print('token Value is : $stringValue');
  } else {
    if (fcmToken != null) {
      prefs.setString('token', fcmToken);
    }
    print('Value not found');
  }

  final networkManager = NetworkManager();
  final Connectivity connectivity = Connectivity();

  await networkManager
      .initConnectivity(connectivity); // Initialize network manager

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CustomerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PasswordResetProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const SplashScreen());
  }
}
