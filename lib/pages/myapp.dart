import 'package:assd_project_ambulance/pages/cards/patient_reached_form.dart';
import 'package:assd_project_ambulance/pages/cardsinprova/patient_reached_form2.dart';
import 'package:assd_project_ambulance/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/auth/bloc/auth_bloc.dart';
import '../models/repository/authentication_repository.dart';
import '../utils/di/dependency_injector.dart';
import 'home.dart';
import 'home_page.dart';
import 'package:assd_project_ambulance/pages/login.dart';

/*
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _AppViewState();
}

class _AppViewState extends State<MyApp> {
  _AppViewState();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => DependencyInjector(child:
    MaterialApp(
        home: const Login(),
        routes: {
          '/homepage': (context) => const Home(),
          '/login' : (context) => const Login(),
        }
    )
  );
}
*/

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _AppViewState();
}

class _AppViewState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) => DependencyInjector(child:
  MaterialApp(
      routes: {'/patientreached' : (context) => const PatientReachedForm2(),},
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  Home.route(),
                      (route) => false,
                );
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  Login.route(),
                      (route) => false,
                );
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    ));
}
