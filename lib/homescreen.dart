import 'dart:convert';

import 'package:api/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<postsModel> postList = [];
  Future<List<postsModel?>> getPostApi() async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/1/comments'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      postList.clear();
      for (Map i in data) {
        postList.add(postsModel.fromJson(i));
        return postList;
      }
    } else {
      postList;
    }
    return postList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 231, 173),
        centerTitle: true,
        title: const Text(
          "Api Integration",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 106, 27, 120),
          ),
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.purple,
            ),
            child: const Text(
              "Test Api",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Column(
                          children: [
                            Text(postList[index].postId.toString()),
                            const Divider(),
                            Text(postList[index].id.toString()),
                            Text(postList[index].name.toString()),
                            Text(postList[index].email.toString()),
                            Text(postList[index].body.toString()),
                          ],
                        ));
                      });
                  // return const Text("Loading");
                } else {
                  return const Text("Please Wait!!!");
                  // return ListView.builder(
                  //     itemCount: postList.length,
                  //     itemBuilder: (context, index) {
                  //       return Card(
                  //           child: Column(
                  //         children: [
                  //           Text(postList[index].title.toString()),
                  //           Text(postList[index].body.toString())
                  //         ],
                  //       ));
                  //     });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
