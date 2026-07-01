import 'package:flutter/material.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(child: Text('Sign In screen',style: TextStyle(
      color: Colors.black87
    ))));
  }
}
