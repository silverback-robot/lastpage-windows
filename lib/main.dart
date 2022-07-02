import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lastpage/models/user_auth.dart';
import 'package:lastpage/models/user_uploads/user_upload_info.dart';
import 'package:lastpage/screens/window_frame.dart';
import 'package:lastpage/screens/fullscreen_view.dart';
import 'package:lastpage/screens/library.dart';
import 'package:lastpage/services/firestore_rest_api.dart';
import 'package:lastpage/widgets/auth/auth_redirect.dart';
import 'package:lastpage/widgets/auth/profile_redirect.dart';
import 'package:provider/provider.dart';
import 'package:lastpage/models/lastpage_colors.dart';
import 'package:lastpage/screens/auth_screen.dart';

// late Box<UserUploadInfo> storageBox;
void main() async {
  // Initialize Firebase
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: ' AIzaSyBLlStNa-K-gg6nr3mdQxm8KawRH4tPpJA ',
    appId: '1:891013314139:web:af19cfd86be6df38aa717e',
    messagingSenderId: '891013314139',
    projectId: 'lastpage-docscanner2-poc',
  ));

  // Initialize flutter_acrylic
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();

  // Initialize Hive for local storage of API Responses
  await Hive.initFlutter();
  Hive.registerAdapter<UserUploadInfo>(UserUploadInfoAdapter());
  await Hive.openBox<UserUploadInfo>('userStorage');

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserAuth>(create: ((context) => UserAuth())),
    ChangeNotifierProvider<FirestoreRestApi>(
        create: ((context) => FirestoreRestApi())),
  ], child: const MyApp()));

  doWhenWindowReady(() {
    const initialSize = Size(900, 550);
    appWindow.minSize = initialSize;
    // appWindow.maxSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LastPage',
      theme: ThemeData(
        primarySwatch: LastpageColors.white,
        canvasColor: LastpageColors.lightGrey,
        appBarTheme: const AppBarTheme(
          elevation: 1.2,
          backgroundColor: LastpageColors.white,
          iconTheme: IconThemeData(color: LastpageColors.darkGrey),
          titleTextStyle: TextStyle(
              color: LastpageColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
        listTileTheme: const ListTileThemeData(
          tileColor: LastpageColors.white,
          iconColor: LastpageColors.darkGrey,
        ),
        shadowColor: LastpageColors.lightGrey,
        primaryColor: LastpageColors.darkGrey,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            // primary: LastpageColors.black,
            secondary: LastpageColors.blue,
            tertiary: LastpageColors.lightGrey),
      ),
      home: const AuthRedirect(),
      routes: {
        AuthRedirect.routeName: (context) => const AuthRedirect(),
        AuthScreen.routeName: (context) => const AuthScreen(),
        ProfileRedirect.routeName: (context) => const ProfileRedirect(),
        WindowFrame.routeName: (context) => const WindowFrame(),
        Library.routeName: (context) => const Library(),
        FullscreenView.routeName: (context) => const FullscreenView(),
      },
    );
  }
}
