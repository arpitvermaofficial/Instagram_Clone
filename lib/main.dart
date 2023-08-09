import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Providers/user_provider.dart';
import 'package:instagram_clone/Screens/login_screen.dart';
import 'package:instagram_clone/Screens/sign_up_screen.dart';
import 'package:instagram_clone/Utils/color.dart';
import 'package:instagram_clone/responsive_layout_screen/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive_layout_screen/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive_layout_screen/web_screen_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyB7c0an50TKbz22IuwUqs7O5b-gygWtmt4",
      appId: "1:165156382589:web:46daf082651ad52f6ece14",
      messagingSenderId: "165156382589",
      projectId: "storage-bd2ab",
      storageBucket: "storage-bd2ab.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Instagram Clone',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mobileBackgroundColor,
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData)
                  return const ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout());
                else if (snapshot.hasError)
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                ));
              }
              return LoginScreen();
            },
          )),
    );
  }
}
