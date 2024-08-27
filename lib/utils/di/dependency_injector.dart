
import 'package:assd_project_ambulance/controllers/gps/gps_bloc.dart';
import 'package:assd_project_ambulance/models/repository/emergency_repository.dart';
import 'package:assd_project_ambulance/models/repository/position_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth/bloc/auth_bloc.dart';
import '../../controllers/patient_controller.dart';
import '../../controllers/patient_reached/patient_reached_bloc.dart';
import '../../models/repository/authentication_repository.dart';
import '../../models/repository/token_repository.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({super.key, required this.child});

  @override
  Widget build(BuildContext context) =>
      _repositories(child: _block(child: child));

  /*
  Widget _providers({required Widget child}) => MultiProvider(
    providers:const [
    ],
    child: child,
  );

  Widget _mappers({required Widget child}) => MultiProvider(
    providers: const [],
    child: child,
  );
  */

  Widget _repositories({required Widget child}) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => PositionRepository()),
          RepositoryProvider(create: (context) => EmergencyRepository("baseURL")),
          RepositoryProvider(create: (context) => AuthenticationRepository()),
          RepositoryProvider(create: (context) => UserRepository()),
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
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
              tokenRepository: context.read<TokenRepository>()
            )..add(AuthenticationSubscriptionRequested()),
          ),
          BlocProvider<GpsBloc>(
            create: (context) => GpsBloc(
              positionRepository: context.read<PositionRepository>(),
              emergencyRepository: context.read<EmergencyRepository>(),
            ),
          ),
          BlocProvider<PatientReachedBloc>(
            create: (context) => PatientReachedBloc(context.read<PatientReachedController>()),
          ),
        ],
        child: child,
      );
}
