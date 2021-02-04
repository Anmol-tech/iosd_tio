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
  _PostPageState createState() => _PostPageState(todo: todo, data: passdata);
}

class _PostPageState extends State<PostPage> {
  Data data;
  var cm2 =
      'asdasdashdhasjkdhaskdhaskdhasjhdjkashdjkahskjdhasjkdhkashdkashdkjashdkjashkjdhaskjdhaksjhdkajshdkjashdkashkdahs;lgkas;kjgalgnalskfhasfhajksfhd';
  var todo;

  _PostPageState({@required this.todo, @required this.data}) : super();

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
                      image: AssetImage(data.img[todo]),
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
                          data.headingText[todo],
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
                                !data.isLiked[todo]
                                    ? Icons.favorite_outline
                                    : Icons.favorite,
                                color: !data.isLiked[todo]
                                    ? Colors.white
                                    : Colors.red[400],
                                size: 28,
                              ),
                              onPressed: () {
                                setState(() {
                                  data.isLiked[todo] = !data.isLiked[todo];
                                  if (data.isLiked[todo])
                                    data.likeCount[todo]++;
                                  else
                                    data.likeCount[todo]--;
                                });
                              },
                            ),
                            Text(
                              data.likeCount[todo].toString(),
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
                        content: Container(
                            color: Colors.red, child: Text('hello world')),
                        isLast: false,
                      ),
                      [
                        CommentChildWidget(
                          content: Text('hgh'),
                          avatar: null,
                          avatarRoot: null,
                          isLast: false,
                        )
                      ],
                      avatarRoot: (context, data) => PreferredSize(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assert/images/av2.png'),
                        ),
                        preferredSize: Size.fromRadius(28),
                      ),
                      contentChild: (context, data) {
                        data.toStringShort();
                        return Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          child: Stack(
                            children: [
                              Text('asdsdasdasdas'),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: FractionalTranslation(
                                  translation:
                                      Offset(0, 'asdsdasdasdas'.length / 21),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.favorite_outline,
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
                      },
                      contentRoot: (context, data) {
                        return commentRoot();
                      },
                      avatarChild: (context, data) => PreferredSize(
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assert/images/avatar.png'),
                        ),
                        preferredSize: Size.fromRadius(28),
                      ),
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

  Column commentRoot() {
    return Column(
      children: [
        Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          child: Stack(
            children: [
              Text(data.comment[todo]),
              Align(
                alignment: Alignment.bottomRight,
                child: FractionalTranslation(
                  translation: Offset(0, cm2.length / 30),
                  child: Container(
                    alignment: Alignment.center,
                    width: 50,
                    height: 15,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_outline,
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
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 50,
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
    );
  }
}
