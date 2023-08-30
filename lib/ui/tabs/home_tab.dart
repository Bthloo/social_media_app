import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../custom_widget/bottom_sheet.dart';
import '../../custom_widget/post_widget.dart';
import '../../view model/posts_view_model.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});

  var viewModel = AllPostsViewModel();

  @override
  Widget build(BuildContext context) {
    viewModel.getAllPosts();
    return BlocBuilder<AllPostsViewModel, AllPostsState>(
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
                  itemBuilder: (context, index) => Column(
                        children: [
                          PostWidget(
                            id: 0,
                            name: '         ',
                            content: '         ',
                            time: '       ',
                            numberOfComments: 0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {}, child: const Text('Like')),
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
          return ListView.separated(
              itemBuilder: (context, index) => Column(
                    children: [
                      PostWidget(
                        id: state.response.results?.posts?[index].id,
                        name: state
                            .response.results?.posts?[index].user?.fullName
                            .toString(),
                        content: state.response.results?.posts?[index].content,
                        time: state.response.results?.posts?[index].createdAt,
                        numberOfComments: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {}, child: const Text('Like')),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AllCommentsWidget.routeName,
                                    arguments: state.response.results
                                            ?.posts?[index].id ??
                                        0);
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
              itemCount: state.response.results?.posts?.length ?? 0);
        } else
          return Container();
      },
    );
  }
}
