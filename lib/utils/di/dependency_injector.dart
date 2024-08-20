
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/auth/bloc/auth_bloc.dart';
import '../../models/repository/authentication_repository.dart';
import '../../models/repository/user_repository.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({super.key, required this.child});

  @override
  Widget build(BuildContext context) =>  _repositories(child: _block(child: child));

  /*
  Widget _providers({required Widget child}) => MultiProvider(
    providers:const [],
    child: child,
  );

  Widget _mappers({required Widget child}) => MultiProvider(
    providers: const [],
    child: child,
  );
  */

  Widget _repositories({required Widget child}) => MultiRepositoryProvider(
    providers:[
     RepositoryProvider(
        create: (context) => AuthenticationRepository()
     ),
      RepositoryProvider(
          create: (context) => UserRepository()
      ),
    ],
    child: child,
  );

   /*
  Widget _useCases({required Widget child}) => MultiProvider(
    providers:const [],
    child: child,
  );
  */


  Widget _block({required Widget child}) => MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
            userRepository: context.read<UserRepository>(),
        )..add(AuthenticationSubscriptionRequested()),
      ),
    ],
    child: child,
  );
}
