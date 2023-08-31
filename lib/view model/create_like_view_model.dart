import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api_manager.dart';
import '../api/models/post like response/CreateLikeResponse.dart';

class CreateLikeViewModel extends Cubit<CreateLikeViewState> {
  CreateLikeViewModel() : super(CreateLikeInitialState());

  void createLike({required num postId, required String token}) async {
    //var response = await ApiManager.register(name: name, email: email, password: password);
    emit(CreateLikeLoadingState(loadingMessage: 'Loading...'));
    try {
      var response = await ApiManager.createLike(
        postId,
        token,
      );
      emit(CreateLikeSuccessState(response: response));
    } on TimeoutException catch (ex) {
      emit(CreateLikeFailState(message: 'Please Check Your Internet'));
    }
    // catch (ex){
    //   emit(LoginFailState(message: 'Something Went Wrong \n $ex'));
    // }
  }
}

abstract class CreateLikeViewState {}

class CreateLikeInitialState extends CreateLikeViewState {}

class CreateLikeLoadingState extends CreateLikeViewState {
  String? loadingMessage;

  CreateLikeLoadingState({this.loadingMessage});
}

class CreateLikeSuccessState extends CreateLikeViewState {
  CreateLikeResponse? response;

  CreateLikeSuccessState({required this.response});
}

class CreateLikeFailState extends CreateLikeViewState {
  String? message;
  Exception? exception;

  CreateLikeFailState({this.message, this.exception});
}
