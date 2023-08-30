import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:socila_app/api/models/all%20comments%20response/CommentsResponse.dart';

import '../api/api_manager.dart';

class AllCommentViewModel extends Cubit<AllCommentState> {
  AllCommentViewModel() : super(AllCommentLoadingState());

  void getAllPosts(num postId) async {
    try {
      var response = await ApiManager.getAllComments(postId);
      //response.results;
      emit(AllCommentSuccessState(response));
    } on TimeoutException catch (ex) {
      emit(AllCommentErrorState('Please Check Your Internet \n $ex'));
    } on ClientException catch (ex) {
      emit(AllCommentErrorState("Please Check Your Internet \n $ex"));
    } on IOException catch (ex) {
      emit(AllCommentErrorState(ex.toString()));
    } catch (ex) {
      emit(AllCommentErrorState('Something Went Wrong \n $ex'));
    }
  }
}

abstract class AllCommentState {}

class AllCommentLoadingState extends AllCommentState {}

class AllCommentSuccessState extends AllCommentState {
  CommentsResponse response;

  AllCommentSuccessState(this.response);
}

class AllCommentErrorState extends AllCommentState {
  String? error;

  AllCommentErrorState(this.error);
}
