import 'package:flutter/cupertino.dart';

import '../api/models/login response/Results.dart';

class AuthProvider extends ChangeNotifier {
  LoginResults? currentUser;
}

// class UserProvider extends Cubit<CurrentUserState>{
//   UserProvider() :super(LoggedoutState());
//   bool isUserLoggedin(){
//     return state is LoggedInState;
//   }
//  login(LoggedInState loggedInState){
//   emit(loggedInState);
// }
// void logout(LoggedoutState loggedoutState){
//   emit(loggedoutState);
// }
// }
// abstract class CurrentUserState {}
// class LoggedInState extends CurrentUserState{
//   LoginResults? loginResult;
//
//   LoggedInState(this.loginResult);
// }
// class LoggedoutState extends CurrentUserState{}
