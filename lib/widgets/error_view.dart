import 'package:flutter/material.dart';
import '../constants/gaps.dart';

class ErrorView extends StatelessWidget {
  final String errorMsg;

  const ErrorView({
    super.key,
    required this.errorMsg,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/error.png',
            width: 140,
          ),
          Gaps.vGap10,
          Text(
            errorMsg,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 17,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
