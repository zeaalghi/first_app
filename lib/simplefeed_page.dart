import 'package:first_app/page.dart';
import 'package:first_app/post.dart';
import 'package:first_app/shared_pref.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

// import 'package:my_first_project/pertemuan3/story.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SimpleFeedPage extends StatelessWidget {
  SimpleFeedPage({super.key});
  var baseUrl = "https://b517-103-17-77-3.ngrok-free.app/api";

  Future<List<Post>> getData() async {
    var dio = Dio();
    var token = SharedPref.pref?.getString("token");
    var response = await dio.get("$baseUrl/post",
        options: Options(headers: {"Authorization": "Bearer $token"}));
    print(response);
    // print(token);

    List<Post> listPost =
        (response.data['data'] as List).map((e) => Post.fromJson(e)).toList();
    print("a");
    // print(listPost);
    return listPost;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> onLogout() async {
      var dio = Dio();
      var token = SharedPref.pref?.getString("token");
      try {
        var response = await dio.post("$baseUrl/logout",
            options: Options(headers: {"Authorization": "Bearer $token"}));
        SharedPref.pref?.remove("token");
        print(response);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } catch (e) {
        print("mohon maaf kesalahan email dan  password");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Instameter",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.redAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              onLogout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // posts
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: const CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text("ini tampilan ketika error");
                  } else {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data?.length,
                        itemBuilder: (ctx, index) {
                          print(index);
                          return Container(
                              color: Colors.white,
                              child: Column(children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${snapshot.data?[index].user.name}"),
                                    ],
                                  ),
                                ),
                                Text("${snapshot.data?[index].title}"),
                                Image.network(
                                  "https://b517-103-17-77-3.ngrok-free.app/storage/images/${snapshot.data?[index].picture}",
                                  width: MediaQuery.of(context).size.width,
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '${snapshot.data?[index].content}',
                                  textAlign: TextAlign.justify,
                                )
                              ]));
                        },
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
