import 'package:dartz/dartz.dart';
import '../repositories/post_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class AddPostUseCase{
  final PostsRepository repository;
  AddPostUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}