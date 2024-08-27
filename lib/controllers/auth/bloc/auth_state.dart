part of 'auth_bloc.dart';

class AuthState extends Equatable {

  const AuthState._({
    this.status = AuthenticationStatus.unknown,
    this.token = ""
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated(String token)
      : this._(status: AuthenticationStatus.authenticated, token: token);

  const AuthState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final String token;

  @override
  List<Object> get props => [status, token];
}
