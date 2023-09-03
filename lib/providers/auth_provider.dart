import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/login response/Results.dart';

class AuthProvider extends ChangeNotifier {
  LoginResults? currentUser;
  String? token;
  int? id;

  Future<void> getToken(BuildContext context) async {
    //var userProvider = Provider.of<AuthProvider>(context, listen: false);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? action = prefs.getString('token').toString();
    currentUser?.accessToken = action;
    notifyListeners();
    // print(action);
    // print(userProvider.currentUser?.accessToken);
    //userProvider.currentUser?.accessToken = action;
  }
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
