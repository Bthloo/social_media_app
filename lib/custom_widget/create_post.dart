import 'package:flutter/material.dart';

class CreatePost extends StatelessWidget {
  static const String routeName = 'post';

  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                label: Text('Create a Post'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Publish'))
          ],
        ),
      ),
    );
  }
}
