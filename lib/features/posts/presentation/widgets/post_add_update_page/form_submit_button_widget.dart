import 'package:flutter/material.dart';

class FormSubmitButton extends StatelessWidget {
  final bool isUpdatePost;
  final void Function() onPressed;
  const FormSubmitButton({
    super.key,
    required this.isUpdatePost,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(isUpdatePost ? Icons.edit : Icons.add),
      label: Text(isUpdatePost ? "Update" : "Add"),
    );
  }
}
