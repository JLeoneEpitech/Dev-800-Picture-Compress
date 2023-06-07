import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
