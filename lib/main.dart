import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() {
  runApp(DataAction());
}

class DataAction extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DataActionState();
  }
}

class DataActionState extends State<DataAction> {
  bool getDataCalled;
  // List<Post> receivedData;

  // Future<List<Post>> getData() async {
  //   var uri = 'https://jsonplaceholder.typicode.com/posts/1/comments';
  //   final response = await get(uri);
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       // this.receivedData = Post.convertToPostObj(jsonDecode(response.body));
  //       this.receivedData = jsonDecode(response.body);
  //       this.getDataCalled = true;
  //     });
  //     return this.receivedData;
  //   } else {
  //     throw Exception('Failed to load the posts');
  //   }
  // }

  var receivedData;

  Future<Response> getData() async {
    var uri = 'https://jsonplaceholder.typicode.com/posts/1/comments';
    final response = await get(uri);
    if (response.statusCode == 200) {
      setState(() {
        // this.receivedData = Post.convertToPostObj(jsonDecode(response.body));
        this.receivedData = jsonDecode(response.body);
        this.getDataCalled = true;
      });
    } else {
      throw Exception('Failed to load the posts');
    }
  }

  @override
  void initState() {
    super.initState();
    this.getDataCalled = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Http Request App'),
          backgroundColor: Color.fromRGBO(140, 45, 255, 0.8),
        ),
        body: Center(
          child: Column(
            children: [
              RaisedButton(
                child: Text("Press to get data"),
                onPressed: getData,
                color: Color.fromRGBO(0, 50, 250, 0.8),
              ),
              Container(
                color: Color.fromRGBO(0, 50, 250, 0.7),
                child: Column(
                    children: this.getDataCalled
                        ? [
                            Text(
                              receivedData[2].toString(),
                            )
                          ]
                        : [
                            Text('Default stuff'),
                          ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Post {
  int postId;
  int id;
  String name;
  String email;
  String body;

  Post({this.postId, this.id, this.name, this.email, this.body});

  static List<Post> convertToPostObj(List<Map<String, dynamic>> decodedJson) {
    List<Post> postsList;
    for (int i = 0; i < decodedJson.length; i++) {
      postsList.add(
        Post(
          postId: decodedJson[i]['postId'],
          id: decodedJson[i]['id'],
          name: decodedJson[i]['name'],
          body: decodedJson[i]['body'],
          email: decodedJson[i]['email'],
        ),
      );
    }
    return postsList;
    //  Post(
    //   postId: jsonResponse['postId'],
    //   id: jsonResponse['id'],
    //   email: jsonResponse['email'],
    //   body: jsonResponse['body'],
    // );
  }
}
