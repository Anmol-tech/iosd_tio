import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment_tree/widgets/comment_child_widget.dart';
import 'package:expanding_bottom_bar/expanding_bottom_bar.dart';

import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:iosd_tio/Pages/PostPage2.dart';
import 'package:iosd_tio/Pages/Posts.dart';
import 'package:iosd_tio/Pages/Thread.dart';
import 'package:octo_image/octo_image.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  var data;

  HomePage({Key key, @required this.data}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState(data: data);
}

class _HomePageState extends State<HomePage> {
  final themeColors = [Colors.black];
  Data data;
  int sendData = 0;
  int navbarIndex = 0;

  _HomePageState({@required this.data}) : super();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < data.subComment.length; i++) {
      List<CommentChildWidget> tempChild = [];
      for (int j = 0; j < data.subComment[i].length; j++) {
        tempChild.add(
          CommentChildWidget(
            content: Text(data.subComment[i][j].toString()),
            avatar: PreferredSize(
              preferredSize: Size.fromRadius(18),
              child: CircleAvatar(
                backgroundImage: AssetImage(data.subCommentAvatar[i][j]),
              ),
            ),
            avatarRoot: null,
            isLast: data.isSubCommnetLiked[i][j],
          ),
        );
      }
      data.commentChild.add(tempChild);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ExpandingBottomBar(
        navBarHeight: 70,
        backgroundColor: Colors.grey[200],
        items: [
          ExpandingBottomBarItem(
            icon: Icons.people,
            text: 'Anonymous\nCommunity',
            selectedColor: Colors.red,
          ),
          ExpandingBottomBarItem(
            icon: Icons.support_agent,
            text: 'Counselor\nSupport',
            selectedColor: Colors.red,
          )
        ],
        selectedIndex: navbarIndex,
        onIndexChanged: (index) => _handleBottomNav(index),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                child: OctoImage(
                  image: CachedNetworkImageProvider(
                    'https://iosd.tech/static/media/IOSD%20logo.e59da17f.png',
                  ),
                  progressIndicatorBuilder:
                      OctoProgressIndicator.circularProgressIndicator(),
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: themeColors[0],
        ),
        title: Text(
          'TalkItOut',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline_rounded,
              size: 28,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              size: 28,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10),
              child: Text(
                'Trending',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.red[400],
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: GestureDetector(
                            onDoubleTap: () => _makeFavorite(index),
                            child: Container(
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.3),
                                      BlendMode.darken),
                                  image: AssetImage(data.img[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  data.headingText[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    data.isLiked[index]
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _makeFavorite(index);
                                  },
                                  iconSize: 28,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    data.likeCount[index].toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.comment_outlined),
                                  color: Colors.black54,
                                  onPressed: () {
                                    _navigateToPost(index);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    data.totalComment[index].toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ThreadPage(
                                          dataPassed: data, index: index),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    bottom: 10,
                                    top: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: RichText(
                                    maxLines: 4,
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: data.comment[index].length > 190
                                              ? data.comment[index]
                                                  .substring(0, 190)
                                              : data.comment[index],
                                        ),
                                        if (data.comment[index].length > 190)
                                          TextSpan(
                                            text: "...",
                                          ),
                                        if (data.comment[index].length > 190)
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ThreadPage(
                                                            dataPassed: data,
                                                            index: index),
                                                  ),
                                                );
                                              },
                                            text: " Continue Reading",
                                            style: TextStyle(
                                              color: Colors.red[400],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              FractionalTranslation(
                                translation: Offset(0.6, -0.3),
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundImage: AssetImage(
                                    data.avatarIcon[index],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            data.time[index],
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: FlatButton(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              _navigateToPost(index);
                            },
                            child: Text(
                              'View all ' +
                                  data.totalComment[index] +
                                  ' comments',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.red[400]),
                            ),
                          ),
                        ),
                        // Container(
                        //   color: Colors.grey[300],
                        //   height: 5,
                        // )
                      ],
                    ),
                  );
                },
                itemCount: data.comment.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.grey[300],
                    thickness: 5,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _makeFavorite(int index) {
    setState(() {
      data.isLiked[index] = !data.isLiked[index];
      if (data.isLiked[index])
        data.likeCount[index]++;
      else
        data.likeCount[index]--;
    });
  }

  void _navigateToPost(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostPage(index: index, passdata: data),
      ),
    );
  }

  _handleBottomNav(int index) {
    setState(() {
      navbarIndex = index;
    });
  }
}
