import 'package:flutter/material.dart';

class UserContentPage extends StatefulWidget {
  const UserContentPage({super.key});

  @override
  State<UserContentPage> createState() => _UserContentPageState();
}

class _UserContentPageState extends State<UserContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UserContentPage"),
      ),
    );
  }
}
