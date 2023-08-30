import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socila_app/api/api_manager.dart';

import '../api/models/login response/LoginResponse.dart';

class LoginViewModel extends Cubit<LoginViewState> {
  LoginViewModel() : super(LoginInitialState());

  void login({required String email, required String password}) async {
    //var response = await ApiManager.register(name: name, email: email, password: password);
    emit(LoginLoadingState(loadingMessage: 'Loading...'));
    try {
      var response = await ApiManager.login(email: email, password: password);
      emit(LoginSuccessState(response: response));
    } on TimeoutException catch (ex) {
      emit(LoginFailState(message: 'Please Check Your Internet'));
    }
    // catch (ex){
    //   emit(LoginFailState(message: 'Something Went Wrong \n $ex'));
    // }
  }
}

abstract class LoginViewState {}

class LoginInitialState extends LoginViewState {}

class LoginLoadingState extends LoginViewState {
  String? loadingMessage;

  LoginLoadingState({this.loadingMessage});
}

class LoginSuccessState extends LoginViewState {
  LoginResponse? response;

  LoginSuccessState({required this.response});
}

class LoginFailState extends LoginViewState {
  String? message;
  Exception? exception;

  LoginFailState({this.message, this.exception});
}
