import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String name;
  final bool isMultiLine;
  final TextEditingController controller;
  const TextFormFieldWidget({
    super.key,
    required this.name,
    required this.isMultiLine,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: TextFormField(
        controller: controller,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return '$name can\'t be empty';
          }
          return null;
        },
        decoration: InputDecoration(hintText: name),
        minLines: isMultiLine ? 6 : 1,
        maxLines: isMultiLine ? 6 : 1,
      ),
    );
  }
}
