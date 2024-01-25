import 'package:flutter/material.dart';

import '../constants/gaps.dart';

class EmptyView extends StatelessWidget {
  final String message;

  const EmptyView({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty.png',
            width: 140,
          ),
          Gaps.vGap10,
          Text(
            message,
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
