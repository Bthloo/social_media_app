import 'package:flutter/material.dart';
import 'package:socila_app/custom_widget/create_post.dart';
import 'package:socila_app/ui/tabs/notification_tab.dart';

import '../tabs/friends_tab.dart';
import '../tabs/home_tab.dart';
import '../tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//var viewModel = AllPostsViewModel();
  int currentTapIndex = 0;

  @override
  Widget build(BuildContext context) {
    //  viewModel.getAllPosts();
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blueAccent,
          showSelectedLabels: true,
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          selectedIconTheme: IconThemeData(color: Colors.blueAccent),
          currentIndex: currentTapIndex,
          onTap: (index) {
            if (currentTapIndex != index) {
              setState(() {
                currentTapIndex = index;
              });
            }
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friends'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active), label: 'Notification'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CreatePost.routeName);
                },
                icon: Icon(Icons.add)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
            IconButton(onPressed: () {}, icon: Icon(Icons.message)),
          ],
          title: const Text(
            'فسبك',
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: tabs[currentTapIndex]);
  }
}

List<Widget> tabs = [HomeTab(), FriendsTab(), NotificationTab(), ProfileTab()];
