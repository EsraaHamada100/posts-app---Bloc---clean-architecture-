import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import '../../../../core/error/exceptions.dart';
import '../models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModels);
}

class PostsLocalImplWithSharedPreferences implements PostsLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String dbKey = "CACHED_POSTS";
  PostsLocalImplWithSharedPreferences({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(dbKey, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(dbKey);
    if (jsonString != null) {
      List decodedJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodedJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
