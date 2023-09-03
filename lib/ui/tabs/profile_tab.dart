import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socila_app/view%20model/profile_view_model.dart';

import '../../api/api_manager.dart';
import '../../custom_widget/bottom_sheet.dart';
import '../../custom_widget/dialog.dart';
import '../../custom_widget/post_widget.dart';
import '../../custom_widget/profile_Post_widget.dart';
import '../../providers/auth_provider.dart';
import '../../view model/create_like_view_model.dart';
import '../../view model/delete_post_view_model.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider = Provider.of<AuthProvider>(context);
    var viewModel = ProfileViewModel();
    viewModel.getProfile(userProvider.id ?? -2);
    var deletePostViewModel = DeletePostViewModel();
    //deleteCommentViewModel.deletePost(postId: , token: token)
    return RefreshIndicator(
      onRefresh: () {
        return viewModel.getProfile(userProvider.id ?? -2);
      },
      child: BlocBuilder<ProfileViewModel, ProfileState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: ListView.separated(
                    reverse: true,
                    itemBuilder: (context, index) => Column(
                          children: [
                            PostWidget(
                              id: 0,
                              name: '         ',
                              content: '         ',
                              time: '       ',
                              //  numberOfComments: 0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: const Text('Like')),
                                TextButton(
                                    onPressed: () {
                                      //showBottomSheet(context,state.response.results?.posts?[index].id??0);
                                    },
                                    child: const Text('Comment'))
                              ],
                            )
                          ],
                        ),
                    separatorBuilder: (context, index) => Container(
                          color: Colors.grey,
                          height: 5,
                          width: double.infinity,
                        ),
                    itemCount: 10),
              ),
            );
          } else if (state is ProfileErrorState) {
            return Text(state.error.toString());
          } else if (state is ProfileSuccessState) {
            var postdata = state;
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.grey),
                  height: 30,
                  width: double.infinity,
                  child: Text(
                    state.response.results?.user?.fullName ?? '',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ProfilePostWidget(
                              ontap: () async {
                                print('hhhhh');
                                // deletePostViewModel.deletePost(
                                //     postId: postdata.response.results?.userPosts?[index].id??-1,
                                //     token: userProvider.token??'');
                                //DialogUtilities.ShowLoadingDialog(context, 'Loading');
                                var response = await ApiManager.deletePost(
                                    token: userProvider.token ?? '',
                                    postId: postdata.response.results
                                            ?.userPosts?[index].id ??
                                        -1);

                                if (response.success == !false) {
                                  DialogUtilities.showMessage(context, 'noo',
                                      posstiveActionName: 'ok');
                                  return;
                                }
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.white,
                                        duration: Duration(milliseconds: 300),
                                        showCloseIcon: true,
                                        closeIconColor: Colors.black,
                                        shape: StadiumBorder(),
                                        content: Text(
                                          'Comment Created Successfully',
                                          style: TextStyle(color: Colors.black),
                                        )));

                                //Navigator.pop(context);
                                //  if(response.success == false){
                                //    DialogUtilities.showMessage(context, 'noo',posstiveActionName: 'ok');
                                //  }

                                //DialogUtilities.showMessage(context, 'done');
                              },
                              id: postdata
                                  .response.results?.userPosts?[index].id,
                              name: postdata.response.results?.userPosts?[index]
                                  .user?.fullName
                                  .toString(),
                              content: postdata
                                  .response.results?.userPosts?[index].content,
                              time: postdata.response.results?.userPosts?[index]
                                  .createdAt,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${postdata.response.results?.userPosts?[index].likesCount}"),
                                Text(
                                    "${postdata.response.results?.userPosts?[index].commentCount}")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      CreateLikeViewModel().createLike(
                                          postId: postdata.response.results
                                                  ?.userPosts?[index].id ??
                                              0,
                                          token: userProvider
                                                  .currentUser?.accessToken ??
                                              '');
                                    },
                                    child: Text(
                                        'Like  ${postdata.response.results?.userPosts?[index].likesCount}')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, AllCommentsWidget.routeName,
                                          arguments: postdata.response.results
                                                  ?.userPosts?[index].id ??
                                              0);
                                      //showBottomSheet(context,state.response.results?.posts?[index].id??0);
                                    },
                                    child: Text(
                                        'Comment  ${postdata.response.results?.userPosts?[index].commentCount}'))
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Container(
                            color: Colors.grey,
                            height: 5,
                            width: double.infinity,
                          ),
                      itemCount:
                          state.response.results?.userPosts?.length ?? 0),
                ),
              ],
            );
          } else
            return Container();
        },
      ),
    );
  }

  Future<void> getToken(BuildContext context) async {
    var userProvider = Provider.of<AuthProvider>(context, listen: false);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? action = prefs.getString('token');
    print("shared : $action ");
    print(" Provider ${userProvider.currentUser?.accessToken}");
    //userProvider.currentUser?.accessToken = action;
  }

  Future<String?> token(BuildContext context) async {
    var userProvider = Provider.of<AuthProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? action = prefs.getString('token').toString();
    userProvider.currentUser?.accessToken = action;
    print("shared acses : $action ");

    return action;
  }
}
