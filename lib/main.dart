import '/screens/chat_screen.dart';
import '/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Chat App',
        darkTheme: ThemeData(
            backgroundColor: Colors.pink,
            colorScheme: const ColorScheme.highContrastDark(
              primary: Colors.pink,
              secondary: Colors.deepPurple),
            buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.pink,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if(userSnapshot.connectionState == ConnectionState.waiting){
              return const SplashScreen();
            }
            if (userSnapshot.hasData) {
              return ChatScreen();
            }
            return AuthScreen();
          },
        ));
  }
}
