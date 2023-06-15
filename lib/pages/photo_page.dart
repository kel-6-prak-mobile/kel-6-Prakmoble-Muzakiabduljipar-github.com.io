import 'package:api_project/controllers/post_controllers.dart';
import 'package:api_project/models/album.dart';
import 'package:flutter/material.dart';
import 'package:api_project/models/photo.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({super.key, required this.albums});
  final Albums? albums;

  @override
  State<PhotoPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    final PostController postController = PostController();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Album'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Photos>>(
              future: postController.fetchPhotos(widget.albums!.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    List<Photos> photo = snapshot.data!;
                    return ListView.separated(
                      // scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.01),
                          child: Card(
                            elevation: 4,
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      'Title : ${photo[index].title}',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Image.network(snapshot.data![index].url),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: size.height * 0.01,
                        );
                      },
                      itemCount: photo.length,
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
      )),
    );
  }
}
