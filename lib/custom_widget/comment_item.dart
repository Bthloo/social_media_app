import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  String name;
  String content;

  CommentItem({super.key, required this.name, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: Icon(Icons.person),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('$content')
            ],
          ),
        )
      ],
    );
  }
}
