import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/network/network_info.dart';
import 'features/posts/data/data_sources/posts_local_data_source.dart';
import 'features/posts/data/data_sources/posts_remote_data_source.dart';
import 'features/posts/data/repositories/posts_repository_impl.dart';
import 'features/posts/domain/repositories/post_repository.dart';
import 'features/posts/domain/usecases/add_post.dart';
import 'features/posts/domain/usecases/get_all_posts.dart';
import 'features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/posts/domain/usecases/delete_post.dart';
import 'features/posts/domain/usecases/update_post.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  /* Note : sl has callable class you can write it like that sl.call() */

  // External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker.createInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => internetConnectionChecker);

  // core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<InternetConnectionChecker>()));

  // Data sources

  /* I wrote the type after like that <PostsRemoteDataSource>
   only when I send the class that implement the class I need
   because I can initialize an abstract class */
  sl.registerLazySingleton<PostsRemoteDataSource>(
      () => PostsRemoteImplWithHttp(client: sl<http.Client>()));
  sl.registerLazySingleton<PostsLocalDataSource>(() =>
      PostsLocalImplWithSharedPreferences(
          sharedPreferences: sl<SharedPreferences>()));

  // repository
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
        remoteDataSource: sl<PostsRemoteDataSource>(),
        localDataSource: sl<PostsLocalDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ));

  // UseCases
  sl.registerLazySingleton(
      () => GetAllPostUseCase(repository: sl<PostsRepository>()));
  sl.registerLazySingleton(
      () => AddPostUseCase(repository: sl<PostsRepository>()));
  sl.registerLazySingleton(
      () => UpdatePostUseCase(repository: sl<PostsRepository>()));
  sl.registerLazySingleton(
      () => DeletePostUseCase(repository: sl<PostsRepository>()));

  // Bloc
  sl.registerFactory(
      () => PostsBloc(getAllPosts: sl<GetAllPostUseCase>()));
  sl.registerFactory<AddDeleteUpdatePostBloc>(() => AddDeleteUpdatePostBloc(
        addPost: sl<AddPostUseCase>(),
        updatePost: sl<UpdatePostUseCase>(),
        deletePost: sl<DeletePostUseCase>(),
      ));
}
