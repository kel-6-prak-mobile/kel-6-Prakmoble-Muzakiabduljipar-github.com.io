import 'dart:developer';

import 'package:api_project/controllers/post_controllers.dart';
import 'package:api_project/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:api_project/models/post.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostController postController = PostController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Post>>(
          future: postController.fetchAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                inspect(snapshot.data!);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(snapshot.data![index].id.toString()),
                          onDismissed: (direction) {
                            postController
                                .delete(snapshot.data![index].id)
                                .then((result) {
                              if (result) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Post deleted'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed to delete post'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                setState(() {});
                              }
                            });
                          },
                          child: Card(
                            child: ListTile(
                              onLongPress: () {
                                AppRouter.goRouter.pushNamed(
                                  AppRouter.editPost,
                                  extra: snapshot.data![index],
                                );
                              },
                              onTap: () {
                                GoRouter.of(context).pushNamed(
                                  AppRouter.post,
                                  extra: snapshot.data![index],
                                );
                              },
                              title: Text(
                                snapshot.data![index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                snapshot.data![index].body,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: size.height * 0.0005,
                        );
                      },
                      itemCount: snapshot.data!.length),
                );
              } else {
                return const Text('tidak ada data');
              }
            } else {
              return Text('error');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            AppRouter.goRouter.pushNamed(AppRouter.addPost);
          },
          label: Text('Tambah')),
    );
  }
}
