import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  String? name;
  String? time;
  String? content;
  num? numberOfComments;
  num? id;

  PostWidget(
      {super.key,
      required this.name,
      required this.content,
      required this.time,
      required this.id,
      required this.numberOfComments});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.person),
                    radius: 23,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("$time")
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_vert),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.close),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text('$content'),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
