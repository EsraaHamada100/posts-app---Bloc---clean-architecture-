import 'package:dartz/dartz.dart';
import '../repositories/post_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class UpdatePostUseCase{
  final PostsRepository repository;
  UpdatePostUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}