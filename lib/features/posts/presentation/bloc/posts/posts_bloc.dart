import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/string/failure.dart';

import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostUseCase getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async{
      if(event is GetAllPostsEvent || event is RefreshPostsEvent){
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        failureOrPosts.fold((failure) {
          emit(ErrorPostsState(message:  mapFailureToString(failure)));
        } , (posts) {
          emit(LoadedPostsState(posts: posts));
        });
      }


    });
  }

}
