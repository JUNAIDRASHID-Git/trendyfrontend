import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trendychef/Presentation/intro/page/intro.dart';
import 'package:trendychef/Presentation/search/bloc/search_bloc.dart';
import 'package:trendychef/l10n/app_localizations.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyBbZSwAKla4HLoCapMPrg5ShlQHWYgFf6g",
          authDomain: "trendy-admin-83285.firebaseapp.com",
          projectId: "trendy-admin-83285",
          storageBucket: "trendy-admin-83285.firebasestorage.app",
          messagingSenderId: "846595955923",
          appId: "1:846595955923:web:f97cefc9d3bcf473a70826",
        ),
      );
      runApp(const MyApp());
    },
    (error, stackTrace) {
      debugPrint('Unhandled error: $error');
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void changeLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(create: (_) => SearchBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TrendyChef',
        theme: ThemeData(),
        locale: _locale,
        supportedLocales: const [
          Locale('en'), // English
          Locale('ar'), // Arabic
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (final supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: const IntroPage(),
      ),
    );
  }
}
