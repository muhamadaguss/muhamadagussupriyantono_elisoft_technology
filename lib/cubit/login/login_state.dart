part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Result<UserModel>? result;
  final bool obsecure;
  const LoginState({
    this.result,
    this.obsecure = true,
  });

  @override
  List<Object?> get props => [
        result,
        obsecure,
      ];

  LoginState copyWith({
    Result<UserModel>? result,
    bool? obsecure,
  }) {
    return LoginState(
      result: result ?? this.result,
      obsecure: obsecure ?? this.obsecure,
    );
  }
}
