import 'dart:convert';
import 'dart:math';
import 'package:darsstore/constants.dart';
import 'package:darsstore/models/character.dart';
import 'package:darsstore/screenshots/detailsPage/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

// 4 - Step API ga http request jonatayapmiz
class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<Character> characterlarListi = [];
  int dataLength = 0;
  int randomImgAndName = 0;
  void characterlarniOlibKel() async {
    Response res =
        await get(Uri.parse("https://breakingbadapi.com/api/characters/"));
    // print(res.body.toString());
    var data = jsonDecode(res.body);
    // print(data[0]["name"]);
    // STEP - 5 API characterlarini bitta listga qoshdik
    setState(() {
      for (var i = 0; i < data.length; i++) {
        Character k = Character();
        k.id = data[i]["char_id"];
        k.name = data[i]["name"];
        k.img = data[i]["img"];
        k.birthday = data[i]["birthday"];
        k.portrayed = data[i]["portrayed"];
        k.nickname = data[i]["nickname"];
        characterlarListi.add(k);
      }
      dataLength = data.length;
      randomImgAndName = Random().nextInt(dataLength);
    });
  }

  @override
  void initState() {
    super.initState();
    characterlarniOlibKel();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    return characterlarListi.length != 0
        ? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              children: [
                // SEARCH SECTION
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Search your location',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                SizedBox(height: kPadding),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  width: width,
                  height: 300.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          characterlarListi[randomImgAndName].img.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 30, right: 150),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              characterlarListi[randomImgAndName]
                                  .name
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        Text(
                          characterlarListi[randomImgAndName]
                              .birthday
                              .toString(),
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star_sharp,
                                color: Colors.orange, size: 20.0),
                            Icon(Icons.star_sharp,
                                color: Colors.orange, size: 20.0),
                            Icon(Icons.star_sharp,
                                color: Colors.orange, size: 20.0),
                            Icon(Icons.star_sharp,
                                color: Colors.orange, size: 20.0),
                            Icon(Icons.star_sharp,
                                color: Colors.orange, size: 20.0),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // PICTURES SECTION
                Container(
                  height: size.height * 0.7,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.2 / 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 25,
                    ),
                    itemCount: characterlarListi.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                id: characterlarListi[index].id,
                                hero: "pic$index",
                              ),
                            ),
                          );
                        },
                        child: HeroMode(
                          enabled: true,
                          child: Hero(
                            tag: "pic$index",
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              characterlarListi[index]
                                                  .img
                                                  .toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    characterlarListi[index].name.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
                                            color: Colors.redAccent.shade700),
                                  ),
                                  SizedBox(height: 3.0),
                                  Text(
                                    characterlarListi[index]
                                        .nickname
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.0,
                                            color: Colors.redAccent.shade700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: SpinKitCubeGrid(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? Colors.redAccent.shade700
                        : Colors.orange,
                  ),
                );
              },
            ),
          );
  }
}
