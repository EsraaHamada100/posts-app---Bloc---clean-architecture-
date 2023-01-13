import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetAllPostUseCase{
  final PostsRepository repository;
  GetAllPostUseCase({required this.repository});

  Future<Either<Failure, List<Post>>> call() async{
    return await repository.getAllPosts();
  }

}