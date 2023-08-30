import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../api/api_manager.dart';
import '../api/models/all post response/PostsResponse.dart';

class AllPostsViewModel extends Cubit<AllPostsState> {
  AllPostsViewModel() : super(AllPostsLoadingState());

  void getAllPosts() async {
    try {
      var response = await ApiManager.getAllPosts();
      //response.results;
      emit(AllPostsSuccessState(response));
    } on TimeoutException catch (ex) {
      emit(AllPostsErrorState('Please Check Your Internet \n $ex'));
    } on ClientException catch (ex) {
      emit(AllPostsErrorState("Please Check Your Internet \n $ex"));
    } on IOException catch (ex) {
      emit(AllPostsErrorState(ex.toString()));
    } catch (ex) {
      emit(AllPostsErrorState('Something Went Wrong \n $ex'));
    }
  }
}

abstract class AllPostsState {}

class AllPostsLoadingState extends AllPostsState {}

class AllPostsSuccessState extends AllPostsState {
  PostsResponse response;

  AllPostsSuccessState(this.response);
}

class AllPostsErrorState extends AllPostsState {
  String? error;

  AllPostsErrorState(this.error);
}
