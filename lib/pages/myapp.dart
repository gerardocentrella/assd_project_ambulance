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
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return DependencyInjector(
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        onGenerateRoute: _onGenerateRoute,
        builder: (context, child) => AuthenticationListener(
          navigator: _navigator,
          child: child,
        ),
      ),
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/patientreached':
        return MaterialPageRoute(
          builder: (_) => const PatientReachedForm(),
        );
      default:
        return SplashPage.route();
    }
  }
}

class AuthenticationListener extends StatelessWidget {
  final Widget? child;
  final NavigatorState navigator;

  const AuthenticationListener({
    required this.navigator,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            navigator.pushAndRemoveUntil<void>(
              Home.route(),
                  (route) => false,
            );
            break;
          case AuthenticationStatus.unauthenticated:
            navigator.pushAndRemoveUntil<void>(
              Login.route(),
                  (route) => false,
            );
            break;
          case AuthenticationStatus.unknown:
            break;
        }
      },
      child: child,
    );
  }
}
