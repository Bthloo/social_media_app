import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api_manager.dart';
import '../api/models/create post response/CreatePostResponse.dart';

class CreatePostViewModel extends Cubit<CreatePostViewState> {
  CreatePostViewModel() : super(CreatePostInitialState());

  void createPost({required String content, required String token}) async {
    //var response = await ApiManager.register(name: name, email: email, password: password);
    emit(CreatePostLoadingState(loadingMessage: 'Loading...'));
    try {
      var response = await ApiManager.createPost(content, token);
      emit(CreatePostSuccessState(response: response));
    } on TimeoutException catch (ex) {
      emit(CreatePostFailState(message: 'Please Check Your Internet'));
    }
    // catch (ex){
    //   emit(LoginFailState(message: 'Something Went Wrong \n $ex'));
    // }
  }
}

abstract class CreatePostViewState {}

class CreatePostInitialState extends CreatePostViewState {}

class CreatePostLoadingState extends CreatePostViewState {
  String? loadingMessage;

  CreatePostLoadingState({this.loadingMessage});
}

class CreatePostSuccessState extends CreatePostViewState {
  CreatePostResponse? response;

  CreatePostSuccessState({required this.response});
}

class CreatePostFailState extends CreatePostViewState {
  String? message;
  Exception? exception;

  CreatePostFailState({this.message, this.exception});
}
