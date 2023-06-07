import 'package:flutter/material.dart';

class AddCard extends StatefulWidget {
  final Future<void> Function()? onTap;
  final bool canAdd;
  const AddCard({super.key, required this.onTap, this.canAdd = true});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: 90,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Center(
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.blue,
                size: 20,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 110,
          width: 90,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              onTap: () async {
                if (widget.onTap != null && widget.canAdd) {
                  await widget.onTap!();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
