import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socila_app/cubit/states.dart';

import '../api/api_manager.dart';
import '../ui/tabs/friends_tab.dart';
import '../ui/tabs/home_tab.dart';
import '../ui/tabs/notification_tab.dart';
import '../ui/tabs/profile_tab.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentTapIndex = 0;
  bool isLike = true;
  Icon like = Icon(Icons.play_arrow);
  List<Widget> tabs = [
    HomeTab(),
    FriendsTab(),
    NotificationTab(),
    ProfileTab()
  ];

  void changeIndex(int index) {
    currentTapIndex = index;

    emit(ChangeBottomAppbarState());
  }

  void createLike(num postId, String token) async {
    if (isLike == false) {
      //player.play();
      like = Icon(Icons.play_arrow);
      isLike = true;
      var response = await ApiManager.createLike(
        postId,
        token,
      );
      emit(LikeButtonState(response: response));
      print('puse');
    } else {
      // player.pause();
      like = Icon(Icons.other_houses);
      isLike = false;
      emit(UnLikeButtonState());
      print('play');
    }
  }
}
