import 'package:dartz/dartz.dart';
import '../repositories/post_repository.dart';

import '../../../../core/error/failures.dart';

class DeletePostUseCase{
  final PostsRepository repository;
  DeletePostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(int postId)async{
    return await repository.deletePost(postId);
  }
}