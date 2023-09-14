import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CommentListPage extends StatefulWidget {
  final int postId;

  CommentListPage({required this.postId});

  @override
  _CommentListPageState createState() => _CommentListPageState();
}

class _CommentListPageState extends State<CommentListPage> {
  List<dynamic> comments = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/${widget.postId}/comments'));
    if (response.statusCode == 200) {
      setState(() {
        comments = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Comments'),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return ListTile(
            title: Text(comment['name']),
            subtitle: Text(comment['body']),
          );
        },
      ),
    );
  }
}
