import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'form_submit_button_widget.dart';
import 'text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final Post? post;
  final bool isUpdatePost;
  const FormWidget({required this.post, required this.isUpdatePost, super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  void validateThenUpdateOrAdd() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final Post post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text,
      );
      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // TextField - title
          TextFormFieldWidget(
            name: "Title",
            isMultiLine: false,
            controller: _titleController,
          ),
          // TextField - body
          TextFormFieldWidget(
            name: "Body",
            isMultiLine: true,
            controller: _bodyController,
          ),
          // button (add - update)
          FormSubmitButton(
            isUpdatePost: widget.isUpdatePost,
            onPressed: validateThenUpdateOrAdd,
          ),
        ],
      ),
    );
  }
}
