import 'package:flutter/material.dart';

void ShowSnackbar(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(massage),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.black,
    ));
  }