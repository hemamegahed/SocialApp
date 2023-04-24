import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ksocial_app/shared/bloc_observer.dart';
import 'package:ksocial_app/shared/components/components.dart';
import 'package:ksocial_app/shared/components/constants.dart';
import 'package:ksocial_app/shared/cubit/cubit.dart';
import 'package:ksocial_app/shared/cubit/states.dart';
import 'package:ksocial_app/shared/network/local/cache_helper.dart';
import 'package:ksocial_app/shared/styles/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/social_layout.dart';
import 'modules/social_login/social_login_screen.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async { //this function for notification
  print('on background message');
  print(message.data.toString());
  showToast(msg: 'on background message', backgroundColor: Colors.green,);
}

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(); // we write it in the main after installing firebase_core in pubspec.yaml


  // foreground fcm (my note: this function work when app is opend and note notifiation will not be shown in top of phone but you can see ''on message' and the toast)
  FirebaseMessaging.onMessage.listen((event)
  {
    print('on message');
    print(event.data.toString());
    showToast(msg: 'on message', backgroundColor: Colors.green,);
  });

  // when click on notification to open app (my note: this function work when app is opend but in background and you click on notification to open the app note the function will not work untill you click on notification)
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print('on message opened app');
    print(event.data.toString());
    showToast(msg: 'on message opened app', backgroundColor: Colors.green,);
  });

  // background fcm  (my note: this function work when app is opend but in background when the notification arrive it will work)
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);//note we make function firebaseMessagingBackgroundHandler() in the top


  bool? isDark = CacheHelper.getData(key: 'isDark');

  uId = CacheHelper.getData(key: 'uId');
  Widget widget;

  if(uId != null) {
    widget = SocialLayout();
  } else {
      widget = SocialLoginScreen();
    }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget
{
  bool? isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()..changeAppMode(isDarkFromShared: isDark),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()..getUsers(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}