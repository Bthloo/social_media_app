import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socila_app/view%20model/all_comments_view_model.dart';

import '../providers/auth_provider.dart';
import '../view model/create_comment_view_model.dart';
import 'comment_item.dart';
import 'dialog.dart';

class AllCommentsWidget extends StatelessWidget {
  static const String routeName = 'fdf';
  final formkey = GlobalKey<FormState>();
  final commentController = TextEditingController();
  var allCommentsViewModel = AllCommentViewModel();
  var createCommentViewModel = CreateCommentViewModel();

  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider =
        Provider.of<AuthProvider>(context, listen: false);
    var arrg = ModalRoute.of(context)?.settings.arguments as num;
    allCommentsViewModel.getAllPosts(arrg);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Text(''),
          TextButton(onPressed: () {}, child: const Text('Like')),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<AllCommentViewModel, AllCommentState>(
              bloc: allCommentsViewModel,
              builder: (context, state) {
                if (state is AllCommentLoadingState) {
                  return Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return CommentItem(
                              name: '                      ',
                              content: '                   ',
                            );
                          }),
                    ),
                  );
                } else if (state is AllCommentErrorState) {
                  return Text(
                    state.error.toString(),
                  );
                } else if (state is AllCommentSuccessState) {
                  if (state.response.results?.comments?.length == 0) {
                    return Expanded(
                        child:
                            Container(child: Text('There is no comments yet')));
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => CommentItem(
                        name: state.response.results!.comments?[index].user
                                ?.fullName ??
                            '',
                        content:
                            state.response.results?.comments?[index].content ??
                                '',
                      ),
                      itemCount: state.response.results?.comments?.length ?? 0,
                    ),
                  );
                } else
                  return Container();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child:
                  BlocConsumer<CreateCommentViewModel, CreateCommentViewState>(
                bloc: createCommentViewModel,
                listenWhen: (previous, current) {
                  if (previous is CreateCommentLoadingState) {
                    DialogUtilities.hideDialog(context);
                  }
                  if (current is CreateCommentSuccessState ||
                      current is CreateCommentLoadingState ||
                      current is CreateCommentFailState) {
                    return true;
                  }
                  return false;
                },
                buildWhen: (previous, current) {
                  if (current is CreateCommentInitialState) return true;
                  return false;
                },
                listener: (context, state) {
                  // event
                  if (state is CreateCommentFailState) {
                    // show message
                    DialogUtilities.showMessage(
                        context,
                        state.message ??
                            state.exception?.toString() ??
                            "Something Went Wrong",
                        posstiveActionName: "ok");
                  } else if (state is CreateCommentLoadingState) {
                    //show loading...
                    DialogUtilities.ShowLoadingDialog(
                        context, state.loadingMessage ?? "Loading...");
                  } else if (state is CreateCommentSuccessState) {
                    if (state.response?.success == true) {
                      Fluttertoast.showToast(
                          msg: "Comment Created Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.black,
                          fontSize: 16.0);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.white,
                          duration: Duration(milliseconds: 200),
                          showCloseIcon: true,
                          closeIconColor: Colors.black,
                          shape: StadiumBorder(),
                          content: Text(
                            'Comment Created Successfully',
                            style: TextStyle(color: Colors.black),
                          )));
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
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                          child: Form(
                        key: formkey,
                        child: TextFormField(
                          controller: commentController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 2,
                                )),
                            labelText: 'Enter Your Comment',
                            //suffixIcon: ,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0xFF0D47A1)),
                            ),
                          ),
                        ),
                      )),
                      IconButton(
                          onPressed: () {
                            createComment(arrg, context);
                            commentController.clear();
                          },
                          icon: Icon(
                            Icons.send,
                            size: 40,
                          ))
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  void createComment(num postId, BuildContext context) async {
    AuthProvider userProvider =
        Provider.of<AuthProvider>(context, listen: false);
    if (formkey.currentState?.validate() == false) {
      return;
    }
    createCommentViewModel.createComment(
        content: commentController.text,
        postId: postId,
        token: userProvider.currentUser?.accessToken ?? '');
  }
}
