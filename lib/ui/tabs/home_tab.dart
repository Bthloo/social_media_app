import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socila_app/view%20model/create_like_view_model.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../custom_widget/bottom_sheet.dart';
import '../../custom_widget/post_widget.dart';
import '../../providers/auth_provider.dart';
import '../../view model/posts_view_model.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});

  var viewModel = AllPostsViewModel();

  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider =
        Provider.of<AuthProvider>(context, listen: false);
    viewModel.getAllPosts(userProvider.token ?? "");
    return RefreshIndicator(
      onRefresh: () {
        return viewModel.getAllPosts(userProvider.token ?? "");
      },
      child: BlocBuilder<AllPostsViewModel, AllPostsState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is AllPostsLoadingState) {
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
          } else if (state is AllPostsErrorState) {
            return Text(state.error.toString());
          } else if (state is AllPostsSuccessState) {
            var postdata = state;
            return ListView.separated(
                itemBuilder: (context, index) => Column(
                      children: [
                        PostWidget(
                          id: state.response.results?.posts?[index].id,
                          name: state
                              .response.results?.posts?[index].user?.fullName
                              .toString(),
                          content:
                              state.response.results?.posts?[index].content,
                          time: state.response.results?.posts?[index].createdAt,
                          //numberOfComments: state.response.results?.posts?[index].commentCount,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${state.response.results?.posts?[index].likesCount}"),
                            Text(
                                "${state.response.results?.posts?[index].commentCount}")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  CreateLikeViewModel().createLike(
                                      postId: state.response.results
                                              ?.posts?[index].id ??
                                          0,
                                      token: userProvider
                                              .currentUser?.accessToken ??
                                          '');
                                },
                                child: Text(
                                    'Like  ${state.response.results?.posts?[index].likesCount}')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AllCommentsWidget.routeName,
                                      arguments: state.response.results
                                              ?.posts?[index].id ??
                                          0);
                                  //showBottomSheet(context,state.response.results?.posts?[index].id??0);
                                },
                                child: Text(
                                    'Comment  ${state.response.results?.posts?[index].commentCount}'))
                          ],
                        ),
                        BlocProvider(
                          create: (context) => AppCubit(),
                          child: BlocConsumer<AppCubit, AppState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return InkWell(
                                onTap: () {
                                  AppCubit.get(context).createLike(
                                      postdata.response.results?.posts?[index]
                                              .id ??
                                          0,
                                      userProvider.currentUser?.accessToken ??
                                          "");
                                },
                                child: AppCubit.get(context).like,
                              );
                              //AppCubit.get(context).tabs[AppCubit.get(context).currentTapIndex]);
                            },
                          ),
                        )
                      ],
                    ),
                separatorBuilder: (context, index) => Container(
                      color: Colors.grey,
                      height: 5,
                      width: double.infinity,
                    ),
                itemCount: state.response.results?.posts?.length ?? 0);
          } else
            return Container();
        },
      ),
    );
  }
}
