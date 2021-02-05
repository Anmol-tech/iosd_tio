import 'package:comment_tree/widgets/comment_child_widget.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iosd_tio/Pages/Posts.dart';

// ignore: must_be_immutable
class PostPage extends StatefulWidget {
  int todo;
  Data passdata;
  PostPage({Key key, @required this.todo, @required this.passdata})
      : super(key: key);

  @override
  _PostPageState createState() =>
      _PostPageState(todo: todo, userData: passdata);
}

class _PostPageState extends State<PostPage> {
  Data userData;
  var cm2 =
      'asdasdashdhasjkdhaskdhaskdhasjhdjkashdjkahskjdhasjkdhkashdkashdkjashdkjashkjdhaskjdhaksjhdkajshdkjashdkashkdahs;lgkas;kjgalgnalskfhasfhajksfhd';
  var todo;

  _PostPageState({@required this.todo, @required this.userData}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                          Colors.black.withOpacity(0.3), BlendMode.darken),
                      image: AssetImage(userData.img[todo]),
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
                          userData.headingText[todo],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                !userData.isLiked[todo]
                                    ? Icons.favorite_outline
                                    : Icons.favorite,
                                color: !userData.isLiked[todo]
                                    ? Colors.white
                                    : Colors.red[400],
                                size: 28,
                              ),
                              onPressed: () {
                                setState(() {
                                  userData.isLiked[todo] =
                                      !userData.isLiked[todo];
                                  if (userData.isLiked[todo])
                                    userData.likeCount[todo]++;
                                  else
                                    userData.likeCount[todo]--;
                                });
                              },
                            ),
                            Text(
                              userData.likeCount[todo].toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
                  print(todo);
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CommentTreeWidget<CommentChildWidget,
                        CommentChildWidget>(
                      CommentChildWidget(
                        avatar: null,
                        avatarRoot: null,
                        content: null,
                        isLast: false,
                      ),
                      getSubComments(),
                      avatarRoot: (context, data) => rootCommentAvatar(data),
                      contentChild: (context, data) => commentChild(data),
                      contentRoot: (context, data) => commentRoot(),
                      avatarChild: (context, data) => childCommentAvatar(data),
                      treeThemeData: TreeThemeData(
                        lineColor: Colors.transparent,
                        lineWidth: 0,
                      ),
                    ),
                  ),
                ],
              ),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }

  PreferredSize childCommentAvatar(CommentChildWidget data) {
    return data.avatar;
  }

  PreferredSize rootCommentAvatar(CommentChildWidget data) {
    return PreferredSize(
      child: CircleAvatar(
        backgroundImage: AssetImage(userData.avatarIcon[todo]),
      ),
      preferredSize: Size.fromRadius(28),
    );
  }

  Widget commentChild(CommentChildWidget data) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                data.isLast = !data.isLast;
              });
            },
            child: Stack(
              alignment: Alignment.bottomRight,
              textDirection: TextDirection.ltr,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    data.content
                        .toString()
                        .substring(6, data.content.toString().length - 2),
                    textAlign: TextAlign.start,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FractionalTranslation(
                    translation: Offset(0, 0.8),
                    child: Container(
                      alignment: Alignment.center,
                      width: 70,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, offset: Offset(0, 0.5))
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            data.isLast
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: Colors.red[400],
                            size: 14,
                          ),
                          Text(
                            'Like',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            '3 d',
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Colors.grey[400],
            ),
          ),
        ),
      ],
    );
  }

  Widget commentRoot() {
    return GestureDetector(
      onTap: () {
        setState(() {
          userData.isCommentLiked[todo] = !userData.isCommentLiked[todo];
        });
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
            child: commentStackWidget(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              '3 d',
              style: TextStyle(
                color: Colors.grey[400],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(0),
            // height: 50,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Write a reply...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget commentStackWidget() {
    return GestureDetector(
      onTap: () {
        setState(() {
          userData.isCommentLiked[todo] = !userData.isCommentLiked[todo];
        });
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              userData.comment[todo],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FractionalTranslation(
              translation: Offset(0, 1),
              child: Container(
                alignment: Alignment.center,
                width: 70,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(color: Colors.grey, offset: Offset(0, 0.5))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      userData.isCommentLiked[todo]
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: Colors.red[400],
                      size: 14,
                    ),
                    Text(
                      'Like',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<CommentChildWidget> getSubComments() {
    return userData.commentChild[todo];
  }
}
