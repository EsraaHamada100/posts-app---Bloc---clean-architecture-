import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../models/post_model.dart';
import 'package:http/http.dart' as http;

// here I make that abstract so It's not dependant in library if anything
// happens to http library I con simply make another class that implement
// it with Dio for example
abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

const baseUrl = "https://jsonplaceholder.typicode.com";

class PostsRemoteImplWithHttp implements PostsRemoteDataSource {
  final http.Client client;
  PostsRemoteImplWithHttp({required this.client});
  final header = {'Content-Type': 'application/json'};
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse(baseUrl + '/posts/'),
      headers: header,
    );
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };

    final response =
        await client.post(Uri.parse('$baseUrl/posts/'), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse('$baseUrl+/posts/$postId'),
      headers: header,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final body = {
      'id': postModel.id.toString(),
      'title': postModel.title,
      'body': postModel.body,
    };
    final response = await client.put(
      Uri.parse('$baseUrl/posts/${postModel.id}'),
      body: body,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
