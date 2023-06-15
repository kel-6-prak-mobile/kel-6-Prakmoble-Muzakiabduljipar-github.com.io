import 'dart:convert';
import 'dart:io';

import 'package:api_project/models/album.dart';
import 'package:api_project/models/photo.dart';
import 'package:api_project/services/post_services.dart';
import 'package:api_project/models/post.dart';
import 'package:api_project/models/comment.dart';

class PostController {
  Future<List<Post>> fetchAll() async {
    return await PostService().fetch().then((res) {
      if (res.statusCode == HttpStatus.ok) {
        var jsonData = jsonDecode(res.body);
        return List.generate(
          jsonData.length,
          (index) => Post.fromMap(
            jsonData[index],
          ),
        );
      } else {
        throw Exception();
      }
    });
  }

  Future<List<Comment>> fetchComments(int id) async {
    return await PostService().fetchComment(id).then((res) {
      var jsonData = jsonDecode(res.body);
      if (res.statusCode == HttpStatus.ok) {
        return List.generate(
            jsonData.length, (index) => Comment.fromMap(jsonData[index]));
      } else {
        throw Exception();
      }
    });
  }

  Future<List<Albums>> fetchAlbum(int id) async {
    return await PostService().fetchAlbum(id).then((res) {
      var jsonData = jsonDecode(res.body);
      if (res.statusCode == HttpStatus.ok) {
        return List.generate(
            jsonData.length, (index) => Albums.fromMap(jsonData[index]));
      } else {
        throw Exception();
      }
    });
  }

  Future<List<Photos>> fetchPhotos(int id) async {
    return await PostService().fetchPhoto(id).then((res) {
      var jsonData = jsonDecode(res.body);
      if (res.statusCode == HttpStatus.ok) {
        return List.generate(
            jsonData.length, (index) => Photos.fromMap(jsonData[index]));
      } else {
        throw Exception();
      }
    });
  }

  Future<dynamic> delete(int id) async {
    return await PostService().delete(id).then((res) {
      if (res.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> create(Post post) async {
    return await PostService().create(post).then((res) {
      if (res.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> patch(Post post) async {
    return await PostService()
        .patch(id: post.id, title: post.title, body: post.body)
        .then((res) {
      if (res.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    });
  }
}
