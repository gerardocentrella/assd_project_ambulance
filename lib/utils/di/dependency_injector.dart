import 'package:assd_project_ambulance/controllers/emergency/emergency_bloc.dart';
import 'package:assd_project_ambulance/controllers/gps/gps_bloc.dart';
import 'package:assd_project_ambulance/controllers/message_controller.dart';
import 'package:assd_project_ambulance/controllers/services/websocket_manager.dart';
import 'package:assd_project_ambulance/models/repository/ambulanceId_repository.dart';
import 'package:assd_project_ambulance/models/repository/emergencyId_repository.dart';
import 'package:assd_project_ambulance/models/repository/position_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth/bloc/auth_bloc.dart';
import '../../controllers/emergency_room_reached_controller.dart';
import '../../controllers/path/path_bloc.dart';
import '../../controllers/patientFormBloc/patient_form_bloc.dart';
import '../../controllers/patient_controller.dart';
import '../../controllers/services/emergency_room_reached_service.dart';
import '../../controllers/services/patient_reached_service.dart';
import '../../models/repository/authentication_repository.dart';
import '../../models/repository/token_repository.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return _repositories(
      child: _controllers(
        child: _block(child: child),
      ),
    );
  }

  Widget _controllers({required Widget child}) => MultiProvider(
        providers: [
          Provider<PatientReachedService>(
              create: (context) =>
                  PatientReachedService(context.read<TokenRepository>())),
          ProxyProvider<PatientReachedService, PatientReachedController>(
              update: (context, service, previous) =>
                  PatientReachedController(service)),
          Provider<EmergencyRoomReachedService>(
              create: (context) =>
                  EmergencyRoomReachedService(context.read<TokenRepository>())),
          ProxyProvider<EmergencyRoomReachedService,
                  EmergencyRoomReachedController>(
              update: (context, service, previous) =>
                  EmergencyRoomReachedController(service)),
          Provider<WebSocketManager>(create: (context) => WebSocketManager()),
          ProxyProvider<WebSocketManager, MessageController>(
              update: (context, service, previous) =>
                  MessageController(service)),
        ],
        child: child,
      );

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
          RepositoryProvider(create: (context) => AuthenticationRepository()),
          RepositoryProvider(create: (context) => TokenRepository()),
          RepositoryProvider(create: (context) => AmbulanceIdRepository()),
          RepositoryProvider(create: (context) => EmergencyIdRepository())
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
              messageController: context.read<MessageController>(),
                authenticationRepository:
                    context.read<AuthenticationRepository>(),
                tokenRepository: context.read<TokenRepository>())
              ..add(AuthenticationSubscriptionRequested()),
          ),
          BlocProvider<GpsBloc>(
            create: (context) => GpsBloc(
              // aggiunta per controller e repository
              messageController: context.read<MessageController>(),
              ambulanceIdRepository: context.read<AmbulanceIdRepository>(),
            ),
          ),
          BlocProvider<EmergencyBloc>(
            create: (context) => EmergencyBloc(
                context.read<MessageController>(),
                context.read<AmbulanceIdRepository>(),
                context.read<EmergencyIdRepository>()
            ),
          ),
          BlocProvider<PatientFormBloc>(
            create: (context) => PatientFormBloc(
              context.read<PatientReachedController>(),
              context.read<EmergencyIdRepository>(),
            ),
          ),

          /*
          BlocProvider<PathBloc>(
            create: (context) => PathBloc(
              context.read<MessageController>(),
              context.read<AmbulanceIdRepository>(),
            ),
          ),

           */

        ],
        child: child,
      );
}
