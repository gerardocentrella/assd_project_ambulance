import 'package:assd_project_ambulance/pages/cards/patient_reached_form.dart';
import 'package:assd_project_ambulance/pages/utils/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/auth/bloc/auth_bloc.dart';
import '../models/repository/authentication_repository.dart';
import '../utils/di/dependency_injector.dart';
import 'home.dart';
import 'package:assd_project_ambulance/pages/login/login.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _AppViewState();
}

class _AppViewState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) => DependencyInjector(
      child: MaterialApp(
        routes: {
          '/patientreached': (context) => const PatientReachedForm(),
        },
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