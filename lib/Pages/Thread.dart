import 'dart:math';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iosd_tio/Pages/Posts.dart';

// ignore: must_be_immutable
class ThreadPage extends StatefulWidget {
  var dataPassed;

  var index;

  ThreadPage({Key key, @required this.dataPassed, @required this.index})
      : super(key: key);
  @override
  _ThreadPageState createState() =>
      _ThreadPageState(userData: dataPassed, index: index);
}

class _ThreadPageState extends State<ThreadPage> {
  Data userData;
  TextEditingController commentController = TextEditingController();
  int index;

  _ThreadPageState({@required this.userData, @required this.index}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white38,
        title: Text(
          'Thread',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(userData.avatarIcon[index]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Text(userData.comment[index]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                icon: Icon(
                                  userData.isLiked[index]
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: Colors.red[400],
                                ),
                                onPressed: () {
                                  setState(() {
                                    setState(() {
                                      userData.isLiked[index] =
                                          !userData.isLiked[index];
                                      if (userData.isLiked[index])
                                        userData.rootCommentLikeCount[index]++;
                                      else
                                        userData.rootCommentLikeCount[index]--;
                                    });
                                  });
                                },
                              ),
                              Text(
                                userData.rootCommentLikeCount[index] <= 0
                                    ? 'Like'
                                    : userData.rootCommentLikeCount[index]
                                        .toString(),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Text(
                            userData.time[index],
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 8,
                    ),
                    Column(
                      children: [
                        LimitedBox(
                          maxWidth: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,

                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: userData.subComment[index].length,
                            itemBuilder: (context, idx) {
                              return Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: AssetImage(userData
                                              .subCommentAvatar[index][idx]),
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
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .8,
                                          child: Text(
                                              userData.subComment[index][idx]),
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
                                                style: TextStyle(
                                                    color: Colors.grey),
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
                                                userData.isSubCommnetLiked[
                                                        index][idx] =
                                                    !userData.isSubCommnetLiked[
                                                        index][idx];
                                                if (userData.isSubCommnetLiked[
                                                    index][idx])
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    userData.isSubCommnetLiked[
                                                            index][idx]
                                                        ? Icons.favorite
                                                        : Icons
                                                            .favorite_outline,
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
                                                    style:
                                                        TextStyle(fontSize: 12),
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
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                // width: MediaQuery.of(context).size.width * .90,
                // height: 40,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 10.0),
                color: Colors.white,
                child: TextField(
                  controller: commentController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    fillColor: Colors.red,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        print('Send');
                        _addComment();
                      },
                    ),
                    hintText: 'Write a reply...',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addComment() {
    if (commentController.text != '')
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
