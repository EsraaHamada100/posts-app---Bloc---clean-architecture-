import 'package:flutter/material.dart';

import '../../../domain/entities/post.dart';
import 'delete_post_button.dart';
import 'update_post_button.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;
  const PostDetailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // post title
        Text(
          post.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(height: 50),
        // post body
        Text(
          post.body,
          style: const TextStyle(fontSize: 16),
        ),
        const Divider(height: 50),
        // buttons to control the post
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            UpdatePostButton(post: post),
            DeletePostButton(postId: post.id!),
          ],
        ),
      ],
    );
  }


}
