import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/string/failure.dart';
import '../../../../../core/string/messages.dart';
import '../../../domain/entities/post.dart';

import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';
import 'package:dartz/dartz.dart';
part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;
  AddDeleteUpdatePostBloc({
    required this.addPost,
    required this.updatePost,
    required this.deletePost,
  }) : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      // adding a post
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await addPost(event.post);
        emit(failureOrSuccessState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } // updating a post
      else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await updatePost(event.post);
        emit(failureOrSuccessState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } // deleting a post
      else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await deletePost(event.postId);
        emit(
          failureOrSuccessState(failureOrDoneMessage, DELETE_SUCCESS_MESSAGE),
        );
      }
    });
  }
  AddDeleteUpdatePostState failureOrSuccessState(
      Either<Failure, Unit> failureOrDoneMessage, String successMessage) {
    return failureOrDoneMessage.fold(
      (failure) => ErrorAddDeleteUpdatePostState(
        message: mapFailureToString(failure),
      ),
      (_) => SuccessAddDeleteUpdatePostState(message: successMessage),
    );
  }
}
