import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  int? id;
  String? name;
  Comment({this.id, this.name});
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  List<dynamic> commentList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // DBGA MALUMOT YOZ
  void dbSet(String? commentText) async {
    await _firestore.collection('characters').doc(widget.id.toString()).set(
      {
        'comments': FieldValue.arrayUnion([commentText]),
      },
      SetOptions(merge: true),
    );
    setState(() {});
  }

  // DBDAN MALUMOT OL
  void dbGet() async {
    var comments = await _firestore.collection('characters').get();
    for (var comment in comments.docs) {
      if (comment.id == widget.id.toString()) {
        commentList = (comment["comments"]);
      }
    }
    print("COMMENT LIST: " + commentList.toString());
    setState(() {});
  }

  void removeFromList(String cmt) async {
    commentList.remove(cmt);
    await _firestore
        .collection('characters')
        .doc(widget.id.toString())
        .set({"comments": commentList});

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    dbGet();
  }

  Widget commentChild(data) {
    return commentList.length != 0
        ? ListView(
            children: [
              for (var i = 0; i < commentList.length; i++)
                Padding(
                  padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () async {
                        // Display the image in large form.
                        print("Comment Clicked");
                      },
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: new BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(50))),
                        child: CircleAvatar(
                          radius: 50,
                          child: Text(commentList[i][0]),
                        ),
                      ),
                    ),
                    title: Text(
                      commentList[i].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      commentList[i].toString(),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        print("Bosildi: ${commentList[i]}");
                        removeFromList(commentList[i]);
                      },
                    ),
                  ),
                )
            ],
          )
        : Center(
            child: InkWell(
              child: Text(
                "SAY 'GOOD' IF YOU CAN !!!",
                style: TextStyle(fontSize: 30.0),
              ),
              onTap: () {
                dbSet('GOOD');
              },
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page"),
        elevation: 0,
        backgroundColor: Color(0xFF15141A),
      ),
      body: Container(
        child: CommentBox(
          userImage: "https://i.ibb.co/vsWf0KM/ali.jpg",
          child: commentChild(commentList),
          labelText: 'Type message to send...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                var value = commentController.text;
                commentList.insert(0, value);
              });
              dbSet(commentController.text.toString());
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Color(0xFF15141A),
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
