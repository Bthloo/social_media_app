import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socila_app/api/api_manager.dart';

import '../api/models/register response/RegisterResponse.dart';

class RegisterViewModel extends Cubit<RegisterViewState> {
  RegisterViewModel() : super(InitialState());

  void register(
    String name,
    String email,
    String password,
  ) async {
    //var response = await ApiManager.register(name: name, email: email, password: password);
    emit(LoadingState(loadingMessage: 'Loading...'));
    try {
      var response = await ApiManager.register(
          name: name, email: email, password: password);
      emit(SuccessState(response));
    } on TimeoutException catch (ex) {
      emit(FailState(message: 'Please Check Your Internet'));
    } catch (ex) {
      emit(FailState(message: 'Something Went Wrong \n $ex'));
    }
  }
}

abstract class RegisterViewState {}

class InitialState extends RegisterViewState {}

class LoadingState extends RegisterViewState {
  String? loadingMessage;

  LoadingState({this.loadingMessage});
}

class SuccessState extends RegisterViewState {
  RegisterResponse response;

  SuccessState(this.response);
}

class FailState extends RegisterViewState {
  String? message;
  Exception? exception;

  FailState({this.message, this.exception});
}
