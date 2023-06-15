import 'package:api_project/controllers/post_controllers.dart';
import 'package:api_project/models/album.dart';
import 'package:api_project/models/comment.dart';
import 'package:api_project/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:api_project/models/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key, required this.post});
  final Post post;

  @override
  State<PostPage> createState() => PpostPageState();
}

class PpostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    final PostController postController = PostController();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Post'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                width: size.width,
                child: Text(
                  widget.post.body,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Expanded(
                child: FutureBuilder<List<Albums>>(
                  future: postController.fetchAlbum(widget.post.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        List<Albums> album = snapshot.data!;
                        return ListView.separated(
                          // scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Card(
                              // child: Image.network(album[index].title),
                              child: ListTile(
                                onTap: () {
                                  AppRouter.goRouter.pushNamed(AppRouter.album,
                                      extra: snapshot.data![index]);
                                },
                                title: Text(
                                  snapshot.data![index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: size.height * 0.01,
                            );
                          },
                          itemCount: album.length,
                        );
                      } else {
                        return Text('Belum ada Komentar');
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Text('Error');
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text('Comment'),
              SizedBox(
                height: size.height * 0.02,
              ),
              Expanded(
                child: FutureBuilder<List<Comment>>(
                  future: postController.fetchComments(widget.post.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        List<Comment> comment = snapshot.data!;
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(comment[index].name),
                                subtitle: Text(comment[index].body),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: size.height * 0.01,
                            );
                          },
                          itemCount: comment.length,
                        );
                      } else {
                        return Text('Belum ada Komentar');
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Text('Error');
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
