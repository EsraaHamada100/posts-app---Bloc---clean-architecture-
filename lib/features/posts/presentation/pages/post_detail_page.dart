import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../domain/entities/post.dart';
import '../widgets/post_detail_page/post_detail_widget.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Post detail"),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: PostDetailWidget(post: post),
    );
  }
}
