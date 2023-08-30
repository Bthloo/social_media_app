import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        Text(userProvider.currentUser?.userFullName ?? ''),
        SizedBox(
          width: double.infinity,
          height: 30,
        ),
        Text(userProvider.currentUser?.userId.toString() ?? ''),
        SizedBox(
          width: double.infinity,
          height: 30,
        ),
        Text(userProvider.currentUser?.accessToken.toString() ?? ''),
      ],
    );
  }
}
