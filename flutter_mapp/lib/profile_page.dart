import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: const Icon(Icons.person),
          title: Text('User Profile $index'),
          subtitle: const Text('This is the user profile page.'),
          trailing: const Icon(Icons.select_all),
        );
      },
    );
  }
}
