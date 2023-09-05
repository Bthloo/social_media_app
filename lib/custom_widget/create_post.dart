import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../view model/create_post_view_model.dart';
import 'dialog.dart';

var postController = TextEditingController();
var viewModel = CreatePostViewModel();

class CreatePost extends StatelessWidget {
  static const String routeName = 'post';

  const CreatePost({super.key});

  // var allPostviewModel = AllPostsViewModel();
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Post'),
      ),
      body: BlocConsumer<CreatePostViewModel, CreatePostViewState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 100,
                    controller: postController,
                    decoration: const InputDecoration(
                      label: Text('Create a Post'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.blueAccent),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        viewModel.createPost(
                            content: postController.text,
                            token: userProvider.token ?? '');
                        //  allPostviewModel.getAllPosts();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Publish',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                )
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
