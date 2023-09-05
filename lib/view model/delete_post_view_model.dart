import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api_manager.dart';
import '../api/models/delete post response/DeletePostResponse.dart';

class DeletePostViewModel extends Cubit<DeletePostViewState> {
  DeletePostViewModel() : super(DeletePostInitialState());

  void deletePost({required num postId, required String token}) async {
    var response = await ApiManager.deletePost(token: token, postId: postId);
    emit(DeletePostLoadingState(loadingMessage: 'Loading...'));
    // try {
    //   var response = await ApiManager.deletePost(token: token, postId: postId);
    //   if (response >= 200 && response < 300) {
    //     emit(DeletePostSuccessState(response));
    //   }
    // } on TimeoutException catch (ex) {
    //   emit(DeletePostFailState(message: ex.toString()));
    // } catch (ex) {
    //   emit(DeletePostFailState(message: 'Something Went Wrong \n $ex'));
    // }
  }
}

abstract class DeletePostViewState {}

class DeletePostInitialState extends DeletePostViewState {}

class DeletePostLoadingState extends DeletePostViewState {
  String? loadingMessage;

  DeletePostLoadingState({this.loadingMessage});
}

class DeletePostSuccessState extends DeletePostViewState {
  // DeletePostResponse? response;
  int response;

  DeletePostSuccessState(this.response);
}

class DeletePostFailState extends DeletePostViewState {
  String? message;
  Exception? exception;
  DeletePostResponse? response;

  DeletePostFailState({this.message, this.exception, this.response});
}
