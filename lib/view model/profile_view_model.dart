import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../api/api_manager.dart';
import '../api/models/profile response/ProfileResponse.dart';

class ProfileViewModel extends Cubit<ProfileState> {
  ProfileViewModel() : super(ProfileLoadingState());

  static ProfileViewModel get(context) => BlocProvider.of(context);

  getProfile(int id) async {
    try {
      var response = await ApiManager.getProfile(id);
      //response.results;
      emit(ProfileSuccessState(response));
    } on TimeoutException catch (ex) {
      emit(ProfileErrorState('Please Check Your Internet \n $ex'));
    } on ClientException catch (ex) {
      emit(ProfileErrorState("Please Check Your Internet \n $ex"));
    } on IOException catch (ex) {
      emit(ProfileErrorState(ex.toString()));
    } catch (ex) {
      emit(ProfileErrorState('Something Went Wrong \n $ex'));
    }
  }
}

abstract class ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  ProfileResponse response;

  ProfileSuccessState(this.response);
}

class ProfileErrorState extends ProfileState {
  String? error;

  ProfileErrorState(this.error);
}
