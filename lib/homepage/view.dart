import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keep_notes/add_notes/view.dart';
import 'package:keep_notes/homepage/model.dart';

import '../to_do/view.dart';
import 'logic.dart';

class HomepagePage extends StatefulWidget {
  HomepagePage({Key? key}) : super(key: key);

  @override
  State<HomepagePage> createState() => _HomepagePageState();
}

class _HomepagePageState extends State<HomepagePage> {
  final logic = Get.put(HomepageLogic());

  final state = Get.find<HomepageLogic>().state;
  int selectedIndex = 0;

  @override
  initState() {
    logic.startTimer();

    super.initState();
  }

  @override
  void dispose() {
    setState(() {
      logic.timer!.cancel();
      print('timmer have stoped ${logic.timer!.isActive}');
    });
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          height: Get.height,
          width: Get.width,
          "assets/back.jpeg",
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            height: Get.height,
            width: Get.width,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverPadding(
                  padding: EdgeInsets.all(8),
                  sliver: SliverList(
                      delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 54,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 14,
                        ),
                        Text(
                          "All notes",
                          style: GoogleFonts.actor(
                              fontSize: 40, color: Colors.white),
                        ),
                        IconButton(
                          color: Colors.grey,
                          onPressed: () {},
                          icon: Icon(Icons.arrow_drop_down_sharp),
                        )
                      ],
                    ),
                    SizedBox(height: 23),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: TextFormField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.cyanAccent,
                              ),
                              borderRadius: BorderRadius.circular(29),
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.grey,
                              size: 28,
                            ),
                            hintText: "Search for notes",
                            fillColor: Color(0xFF2E2E2E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(29),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                  ])),
                )
              ],
              body: StreamBuilder<List<NoteModel>>(
                  stream: logic.allNoteControllers.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                       return ListView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 100,
                            width: Get.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.3),
                                        border:
                                            Border.all(color: Colors.white30),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ListTile(
                                      splashColor: Colors.black,
                                      onTap: () {
                                        Get.to(
                                            AddNotesPage(
                                                addNoteStatus:
                                                    AddNoteStatus.UPDATE,
                                                noteModel:
                                                    snapshot.data![index]),
                                            transition: Transition.rightToLeft);
                                      },
                                      title: Text(
                                          style: TextStyle(color: Colors.white),
                                          "${snapshot.data![index].title == "" ? snapshot.data![index].description : snapshot.data![index].title}"),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "No cartegory",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Icon(
                                                Icons.folder_copy_outlined,
                                                color: Colors.white70,
                                                size: 15,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                              style: TextStyle(
                                                  color: Colors.white70),
                                              "${DateFormat("MMM dd EEE yyyy / h:mm a").format(DateTime.parse(snapshot.data![index].dateTime.toString()))}"),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ),
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return Center(child: Icon(Icons.hourglass_empty));
                    }
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
