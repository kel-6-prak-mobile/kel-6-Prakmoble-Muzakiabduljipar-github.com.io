import 'package:api_project/models/album.dart';
import 'package:api_project/pages/photo_page.dart';
import 'package:api_project/pages/home_page.dart';
import 'package:api_project/pages/post_page.dart';
import 'package:api_project/pages/add_post.dart';
import 'package:api_project/models/post.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const home = "home";
  static const post = "post";
  static const album = "album";
  static const addPost = "add-post";
  static const editPost = "edit-post";

  static Page _homePageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage(child: HomePage());
  }

  static Page _postPageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage(
        child: PostPage(
      post: state.extra as Post,
    ));
  }

  static Page _albumPageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage(
        child: PhotoPage(
      albums: state.extra as Albums,
    ));
  }

  static Page _addPostPageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage(child: AddPostPage());
  }

  static Page _editPostPageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage(
        child: AddPostPage(
      post: state.extra as Post,
    ));
  }

  static GoRouter goRouter = GoRouter(
    routes: [
      GoRoute(
        path: "/home",
        name: home,
        pageBuilder: _homePageBuilder,
        routes: [
          GoRoute(
            name: post,
            path: "post",
            pageBuilder: _postPageBuilder,
          ),
          GoRoute(
            name: album,
            path: "album",
            pageBuilder: _albumPageBuilder,
          ),
          GoRoute(
            name: addPost,
            path: "add-post",
            pageBuilder: _addPostPageBuilder,
          ),
          GoRoute(
            name: editPost,
            path: "edit-post",
            pageBuilder: _editPostPageBuilder,
          )
        ],
      )
    ],
    initialLocation: "/home",
  );
}
