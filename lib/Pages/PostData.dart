import 'package:firebase_database/firebase_database.dart';

class PostData {
  String banner;
  List<Comments> comments;
  String commnet_no;
  String date_time;
  String like_no;
  String text;

  PostData(
      {this.banner,
      this.comments,
      this.commnet_no,
      this.date_time,
      this.like_no,
      this.text});

  factory PostData.fromJSON(Map<dynamic, dynamic> json) {
    return PostData(
      banner: json['banner'].toString(),
      comments: parseComments(json),
      commnet_no: json['comments_no'].toString(),
      date_time: json['data_time'].toString(),
      like_no: json['like_no'].toString(),
      text: json['text'].toString(),
    );
  }

  static parseComments(Map json) {
    var pList = json['comments'] as List;
    List<Comments> comments =
        pList.map((data) => Comments.fromJSON(data)).toList();
    return comments;
  }
}

class Comments {
  String avatar;
  String comment;
  Comments({this.avatar, this.comment});
  factory Comments.fromJSON(Map<dynamic, dynamic> json) {
    return Comments(
        avatar: json['avatar'].toString(), comment: json['comment'].toString());
  }
}

class Post {
  List<PostData> posts;
  Post({this.posts});

  factory Post.fromJSON(Map<dynamic, dynamic> json) {
    return Post(posts: parsePosts(json));
  }

  static List<PostData> parsePosts(Map json) {
    var pList = json['Posts'] as List;
    List<PostData> postList =
        pList.map((data) => PostData.fromJSON(data)).toList();
    return postList;
  }
}

class MakeCall {
  List<PostData> listItems = [];

  Future<List<PostData>> firebaseCalls(
      DatabaseReference databaseReference) async {
    listItems.clear();
    Post postList;
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic, dynamic> jsonResponse = dataSnapshot.value['content'];
    postList = new Post.fromJSON(jsonResponse);
    listItems.addAll(postList.posts);
    // print(dataSnapshot.value['content']['Posts'][0]);
    return listItems;
  }
}
