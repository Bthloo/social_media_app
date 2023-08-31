import '../api/models/post like response/CreateLikeResponse.dart';

abstract class AppState {}

class AppInitialState extends AppState {}

class ChangeBottomAppbarState extends AppState {}

class LikeButtonState extends AppState {
  CreateLikeResponse? response;

  LikeButtonState({required this.response});
}

class UnLikeButtonState extends AppState {}
