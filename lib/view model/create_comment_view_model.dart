import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socila_app/api/models/create%20comment%20response/create_comment_response.dart';

import '../api/api_manager.dart';

class CreateCommentViewModel extends Cubit<CreateCommentViewState> {
  CreateCommentViewModel() : super(CreateCommentInitialState());

  void createComment(
      {required String content,
      required num postId,
      required String token}) async {
    //var response = await ApiManager.register(name: name, email: email, password: password);
    emit(CreateCommentLoadingState(loadingMessage: 'Loading...'));
    try {
      var response = await ApiManager.createComment(postId, content, token);
      emit(CreateCommentSuccessState(response: response));
    } on TimeoutException catch (ex) {
      emit(CreateCommentFailState(message: 'Please Check Your Internet'));
    }
    // catch (ex){
    //   emit(LoginFailState(message: 'Something Went Wrong \n $ex'));
    // }
  }
}

abstract class CreateCommentViewState {}

class CreateCommentInitialState extends CreateCommentViewState {}

class CreateCommentLoadingState extends CreateCommentViewState {
  String? loadingMessage;

  CreateCommentLoadingState({this.loadingMessage});
}

class CreateCommentSuccessState extends CreateCommentViewState {
  CreateCommentResponse? response;

  CreateCommentSuccessState({required this.response});
}

class CreateCommentFailState extends CreateCommentViewState {
  String? message;
  Exception? exception;

  CreateCommentFailState({this.message, this.exception});
}
