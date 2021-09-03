import 'dart:convert';
import 'package:darsstore/constants.dart';
import 'package:darsstore/screenshots/comment/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  // STEP - 6. DETAIL PAGE UCHUN ID NI OLIB KELIB YANA APIGA REQUEST JONATDIK
  var hero;
  int? id;
  DetailPage({Key? key, this.id, this.hero}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  TabController? _tabController;
  var characterData;
  void characterlarniOlibKel() async {
    Response res = await get(
        Uri.parse("https://breakingbadapi.com/api/characters/${widget.id}"));
    // print(res.body.toString());

    setState(() {
      characterData = jsonDecode(res.body);
    });
    // print("KELGAN CHARACTER:---" + characterData.toString());
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    characterlarniOlibKel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 70.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(CupertinoIcons.back, color: Colors.black, size: 28.0),
        ),
        actions: [
          Container(
            width: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  offset: Offset(0, 2),
                  blurRadius: 5.0,
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Comment(
                            id: widget.id, name: characterData[0]['name'])));
              },
              // STEP - 7 COMMENT SAHIFASINI QOSHDIK VA FIRESTORENI ACTIVE QILDIK
              child: Icon(CupertinoIcons.chat_bubble,
                  color: Colors.red, size: 20.0),
            ),
          ),
          SizedBox(width: 8.0),
          Container(
            width: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  offset: Offset(0, 2),
                  blurRadius: 5.0,
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              onPressed: () {},
              child: Icon(CupertinoIcons.search, color: Colors.red, size: 20.0),
            ),
          ),
          SizedBox(width: 24.0),
        ],
      ),
      body: characterData != null
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(characterData[0]["img"].toString()),
                    fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0)
                    ],
                    begin: Alignment.bottomRight,
                  ),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 1.5),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  characterData[0]["name"],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(height: kPadding / 2),
                                Text(
                                  characterData[0]["nickname"],
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(height: kPadding / 2),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.star_sharp,
                                        color: Colors.orange, size: 15.0),
                                    Icon(Icons.star_sharp,
                                        color: Colors.orange, size: 15.0),
                                    Icon(Icons.star_sharp,
                                        color: Colors.orange, size: 15.0),
                                    Icon(Icons.star_sharp,
                                        color: Colors.orange, size: 15.0),
                                    Icon(Icons.star_sharp,
                                        color: Colors.orange, size: 15.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: kPadding),
                          Container(
                            height: 600.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                              ),
                              color: Colors.orange,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32.0, vertical: 28.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("20 + Friends Where Here"),
                                      Text("+18"),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 28.0, horizontal: 32.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40.0),
                                        topRight: Radius.circular(40.0),
                                      ),
                                      color: Colors.black,
                                    ),
                                    child: Column(
                                      children: [
                                        TabBar(
                                          indicatorColor: Colors.orange,
                                          indicatorWeight: 2.5,
                                          labelStyle: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          indicatorSize:
                                              TabBarIndicatorSize.label,
                                          labelColor: Colors.white,
                                          controller: _tabController,
                                          tabs: [
                                            Tab(
                                              text: "Overview",
                                            ),
                                            Tab(
                                              text: "Gallery",
                                            ),
                                            Tab(
                                              text: "Reviews",
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16.0),
                                        Expanded(
                                          child: TabBarView(
                                            controller: _tabController,
                                            children: [
                                              Text(
                                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                                style: TextStyle(
                                                    color: Colors.redAccent.shade700),
                                              ),
                                              Text(
                                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                                style: TextStyle(
                                                    color: Colors.redAccent.shade700),
                                              ),
                                              Text(
                                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                                style: TextStyle(
                                                    color: Colors.redAccent.shade700),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: SpinKitCubeGrid(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.redAccent.shade700 : Colors.yellow,
                    ),
                  );
                },
              ),
            ),
    );
  }
}
