import 'dart:ui';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iosd_tio/Pages/PostData.dart';
import 'package:iosd_tio/Pages/Posts.dart';

// ignore: must_be_immutable
class PostPage extends StatefulWidget {
  int index;
  Data passdata;
  PostPage({Key key, @required this.index, @required this.passdata})
      : super(key: key);

  @override
  _PostPageState createState() =>
      _PostPageState(index: index, userData: passdata);
}

class _PostPageState extends State<PostPage> {
  Data userData;

  int index;
  TextEditingController commentController = TextEditingController();
  _PostPageState({@required this.index, @required this.userData}) : super();

  DatabaseReference _databaseRefrence = FirebaseDatabase.instance.reference();
  final _makeCall = MakeCall();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<PostData>>(
          stream: _makeCall.firebaseCalls(_databaseRefrence).asStream(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 230,
                        // snap: true,
                        pinned: true,
                        // floating: true,
                        backgroundColor: Colors.transparent,
                        flexibleSpace: FlexibleSpaceBar(
                          background: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.3),
                                      BlendMode.darken),
                                  image:
                                      NetworkImage(snapshot.data[index].banner),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapshot.data[index].text,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            !userData.isLiked[index]
                                                ? Icons.favorite_outline
                                                : Icons.favorite,
                                            color: !userData.isLiked[index]
                                                ? Colors.white
                                                : Colors.red[400],
                                            size: 28,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              userData.isLiked[index] =
                                                  !userData.isLiked[index];
                                              if (userData.isLiked[index])
                                                userData.likeCount[index]++;
                                              else
                                                userData.likeCount[index]--;
                                            });
                                          },
                                        ),
                                        Text(
                                          snapshot.data[index].like_no
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        iconTheme: IconThemeData(
                          color: Colors.black87,
                        ),
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          tooltip: 'Back',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        actions: [
                          IconButton(
                            icon: Icon(
                              Icons.notifications_outlined,
                              size: 28,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              print(index);
                            },
                          ),
                        ],
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, idx) => Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8.0),
                                child: CustomRadioButton(
                                  elevation: 0,
                                  // absoluteZeroSpacing: true,
                                  enableShape: true,
                                  defaultSelected: 'Top',
                                  unSelectedColor: Colors.grey[300],
                                  unSelectedBorderColor: Colors.transparent,
                                  selectedBorderColor: Colors.transparent,
                                  buttonLables: [
                                    'Top',
                                    'New',
                                    'My',
                                    'Counselor',
                                  ],
                                  buttonValues: [
                                    'Top',
                                    'New',
                                    'My',
                                    'Counselor',
                                  ],
                                  width: 80,
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 9)),
                                  radioButtonValue: (value) {
                                    print(value);
                                  },
                                  selectedColor: Theme.of(context).accentColor,
                                ),
                              ),
                            ],
                          ),
                          childCount: 1,
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, idx) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot
                                          .data[index].comments[idx].avatar),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey[300]),
                                      width: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.landscape
                                          ? MediaQuery.of(context).size.width *
                                              0.9
                                          : MediaQuery.of(context).size.width *
                                              .8,
                                      child: Text(snapshot
                                          .data[index].comments[idx].comment),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.09),
                                          child: Text(
                                            userData.time[idx],
                                            textAlign: TextAlign.end,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 2),
                                          child: Icon(
                                            Icons.reply,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                    FractionalTranslation(
                                      translation: Offset(-0.1, -0.4),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            userData.isCommentLiked[index] =
                                                !userData.isCommentLiked[index];
                                            if (userData.isCommentLiked[index])
                                              userData.rootCommentLikeCount[
                                                  index]++;
                                            else
                                              userData.rootCommentLikeCount[
                                                  index]--;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 70,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  offset: Offset(0, 0.5))
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                userData.isCommentLiked[index]
                                                    ? Icons.favorite
                                                    : Icons.favorite_outline,
                                                color: Colors.red[400],
                                                size: 14,
                                              ),
                                              Text(
                                                userData.rootCommentLikeCount[
                                                            index] <=
                                                        0
                                                    ? 'Like'
                                                    : userData
                                                        .rootCommentLikeCount[
                                                            index]
                                                        .toString(),
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.2),
                                  child: TextField(
                                    controller: commentController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.send),
                                        onPressed: () => _addComment(snapshot),
                                      ),
                                      hintText: 'Write a reply...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          childCount: 1,
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, idx) => Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.2),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot
                                          .data[index].comments[idx].avatar),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey[300]),
                                      width: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.landscape
                                          ? MediaQuery.of(context).size.width *
                                              0.7
                                          : MediaQuery.of(context).size.width *
                                              .6,
                                      child: Text(snapshot
                                          .data[index].comments[idx].comment),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.09),
                                          child: Text(
                                            userData.time[idx],
                                            textAlign: TextAlign.end,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 2),
                                          child: Icon(
                                            Icons.reply,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                    FractionalTranslation(
                                      translation: Offset(-0.2, -0.5),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            userData.isSubCommnetLiked[index]
                                                    [idx] =
                                                !userData.isSubCommnetLiked[
                                                    index][idx];
                                            if (userData
                                                .isSubCommnetLiked[index][idx])
                                              userData.subCommnetLikedCount[
                                                  index][idx]++;
                                            else
                                              userData.subCommnetLikedCount[
                                                  index][idx]--;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 70,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  offset: Offset(0, 0.5))
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                userData.isSubCommnetLiked[
                                                        index][idx]
                                                    ? Icons.favorite
                                                    : Icons.favorite_outline,
                                                color: Colors.red[400],
                                                size: 14,
                                              ),
                                              Text(
                                                userData.subCommnetLikedCount[
                                                            index][idx] <=
                                                        0
                                                    ? 'Like'
                                                    : userData
                                                        .subCommnetLikedCount[
                                                            index][idx]
                                                        .toString(),
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          childCount: snapshot.data[index].comments.length,
                        ),
                      )
                    ],
                  );
                }
              case ConnectionState.none:
                return loading();
              case ConnectionState.waiting:
                return loading();
              case ConnectionState.active:
                return loading();
              default:
                return loading();
            }
          }),
    );
  }

  loading() => Center(
        child: CircularProgressIndicator(),
      );

  void _addComment(snapshot) {
    if (commentController.text != '') {
      _databaseRefrence
          .child('/content/Posts/' +
              index.toString() +
              '/comments/' +
              (snapshot.data[index].comments.length).toString() +
              '/')
          .set(
        {
          'avatar':
              "https://firebasestorage.googleapis.com/v0/b/iosd-tio.appspot.com/o/av.jpg?alt=media&token=c702b0af-3a8c-40b5-816b-e40ed71c98ca",
          'comment': commentController.text
        },
      );

      setState(() {
        userData.subComment[index].add(commentController.text.toString());
        userData.subCommentAvatar[index].add('assert/images/avatar.png');
        userData.time.add('1 sec ago');
        userData.isSubCommnetLiked[index].add(false);
        userData.subCommnetLikedCount[index].add(0);
        commentController.clear();
      });
    }
  }
}
