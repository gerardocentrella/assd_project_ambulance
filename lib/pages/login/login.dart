import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/login/login_bloc.dart';
import '../../models/repository/authentication_repository.dart';
import '../../widgets/login_form.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const Login());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 100,
        toolbarHeight: 70,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 30, fontStyle: FontStyle.normal),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(70),
              child: Center(
                child: Image(
                  image: AssetImage('lib/assets/images/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: BlocProvider(
                create: (context) => LoginBloc(
                  authenticationRepository: context.read<AuthenticationRepository>(),
                ),
                child: const Scrollbar(child: LoginForm()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}