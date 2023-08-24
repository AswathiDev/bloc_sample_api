
import 'dart:convert';

import 'package:bloc_sample_api/posts/models/post_model.dart';
import 'package:http/http.dart' as http;
class PostRepo{
static Future<List<PostModel>>fetchPost()async{
  var client = http.Client();
    List<PostModel> postList = [];
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

var result=jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        PostModel post =
            PostModel.fromMap(result[i]);
        postList.add(post);
      }
      return postList;
}
catch(e){
  print(e);
  return [];
}
}
}