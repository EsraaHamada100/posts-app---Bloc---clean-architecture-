import 'package:flutter/material.dart';
import '../../../domain/entities/post.dart';

import '../../pages/post_add_update_page.dart';

class UpdatePostButton extends StatelessWidget {
  final Post post;
  const UpdatePostButton({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PostAddUpdatePage(
              isUpdatePage: true,
              post: post,
            ),
          ),
        );
      },
      icon: const Icon(Icons.edit),
      label: const Text("Edit"),
    );
  }
}
