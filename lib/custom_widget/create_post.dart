import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../view model/create_post_view_model.dart';
import 'dialog.dart';

class CreatePost extends StatelessWidget {
  static const String routeName = 'post';
  var PostController = TextEditingController();

  CreatePost({super.key});

  var viewModel = CreatePostViewModel();

  // var allPostviewModel = AllPostsViewModel();
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Post'),
      ),
      body: BlocConsumer<CreatePostViewModel, CreatePostViewState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: PostController,
                  decoration: InputDecoration(
                    label: Text('Create a Post'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      viewModel.createPost(
                          content: PostController.text,
                          token: userProvider.token ?? '');
                      //  allPostviewModel.getAllPosts();
                    },
                    child: const Text('Publish'))
              ],
            ),
          );
        },
        bloc: viewModel,
        listenWhen: (previous, current) {
          if (previous is CreatePostLoadingState) {
            DialogUtilities.hideDialog(context);
          }
          if (current is CreatePostSuccessState ||
              current is CreatePostLoadingState ||
              current is CreatePostFailState) {
            return true;
          }
          return false;
        },
        buildWhen: (previous, current) {
          if (current is CreatePostInitialState) return true;
          return false;
        },
        listener: (context, state) {
          // event
          if (state is CreatePostFailState) {
            // show message
            DialogUtilities.showMessage(
                context,
                state.message ??
                    state.exception?.toString() ??
                    "Something Went Wrong",
                posstiveActionName: "ok");
          } else if (state is CreatePostLoadingState) {
            //show loading...
            DialogUtilities.ShowLoadingDialog(
                context, state.loadingMessage ?? "Loading...");
          } else if (state is CreatePostSuccessState) {
            if (state.response?.success == true) {
              DialogUtilities.showMessage(context, "Post Created Successfully",
                  posstiveActionName: "ok", posstiveAction: () {
                Navigator.pop(context);
                // AuthProvider userProvider =
                // Provider.of<AuthProvider>(context, listen: false);
                // userProvider.currentUser = state.response?.results;
                // Navigator.of(context)
                //     .pushReplacementNamed(HomeScreen.routeName);
              });
            } else if (state.response?.success == false) {
              DialogUtilities.showMessage(
                context,
                " ${state.response?.statusMessage}",
                posstiveActionName: "Ok",
              );
            }
            // show dialog
            // navigate to home screen
          }
        },
      ),
    );
  }
}
