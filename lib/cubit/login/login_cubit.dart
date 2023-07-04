import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../injector_container.dart';
import '../../model/user_model.dart';
import '../../repositories/login_repository.dart';
import '../../repositories_impl/login_repository_impl.dart';
import '../../utils/result.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository = sl<LoginRepositoryImpl>();
  LoginCubit() : super(const LoginState());

  void changeViewPassword() {
    emit(
      state.copyWith(obsecure: !state.obsecure),
    );
  }

  void login(Map<String, dynamic> body) async {
    emit(
      state.copyWith(
        result: Result.loading(),
      ),
    );
    final result = await loginRepository.login(body);

    result.fold((failure) {
      emit(
        state.copyWith(
          result: Result.error(failure.message),
        ),
      );
    }, (result) {
      //convert usermodel
      final user = result.toJson();
      sl<SharedPreferences>().setString(
        'user',
        jsonEncode(user),
      );
      emit(
        state.copyWith(
          result: Result.completed(result),
        ),
      );
    });
  }
}
