import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:socila_app/cubit/cubit.dart';
import 'package:socila_app/custom_widget/create_post.dart';
import 'package:socila_app/ui/tabs/notification_tab.dart';

import '../../cubit/states.dart';
import '../../providers/auth_provider.dart';
import '../tabs/friends_tab.dart';
import '../tabs/home_tab.dart';
import '../tabs/profile_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home';

//var viewModel = AllPostsViewModel();
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    authProvider.getToken(context);
    //getToken(context);
    //  viewModel.getAllPosts();
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.blueAccent,
                showSelectedLabels: true,
                unselectedIconTheme: const IconThemeData(color: Colors.grey),
                selectedIconTheme:
                    const IconThemeData(color: Colors.blueAccent),
                currentIndex: AppCubit.get(context).currentTapIndex,
                onTap: (index) {
                  AppCubit.get(context).changeIndex(index);
                  // if (currentTapIndex != index) {
                  //   setState(() {
                  //     currentTapIndex = index;
                  //   });
                  // }
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.people), label: 'Friends'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.notifications_active),
                      label: 'Notification'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Profile'),
                ],
              ),
              appBar: AppBar(
                leading:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, CreatePost.routeName);
                      },
                      icon: const Icon(Icons.add)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search_outlined)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.message)),
                ],
                title: const Text(
                  'فسبك',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: AppCubit.get(context)
                  .tabs[AppCubit.get(context).currentTapIndex]);
        },
      ),
    );
  }
}

List<Widget> tabs = [HomeTab(), FriendsTab(), NotificationTab(), ProfileTab()];
