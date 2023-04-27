import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../customWidgets/nocategory.dart';
import '../navigation.dart';
import 'logic.dart';

class AddNotesPage extends StatelessWidget {
  AddNotesPage({Key? key}) : super(key: key);

  final logic = Get.put(AddNotesLogic());
  final state = Get.find<AddNotesLogic>().state;

  @override
  Widget build(BuildContext context) {

    return WillPopScope(onWillPop: () async{
      logic.createNotes();
      return true;
    },
      child: Scaffold(
        backgroundColor: Color(0xFF010909),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {logic.createNotes().whenComplete(() {

                Get.back();

              });
                },
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.white,
              )),
          elevation: 0,
          title: Text(
            'Notes',
            style: GoogleFonts.actor(fontSize: 27, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 17,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(child: Nocategorybubble()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 11,
                ),
                child: TextField(
                  smartDashesType: SmartDashesType.disabled,
                  controller: logic.titleController,
                  autocorrect: true,
                  autofocus: false,
                  style: GoogleFonts.actor(fontSize: 27, color: Colors.white),
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: 27, color: Colors.grey.withOpacity(.4)),
                      hintText: "Title",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    DateFormat("mm:ss a").format(DateTime.now()),
                    style: TextStyle(
                        fontSize: 16, color: Colors.white.withOpacity(0.9)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 11, right: 11),
                child: TextField(
                  maxLines: 200,
                  controller: logic.noteController,
                  autofocus: true,
                  smartDashesType: SmartDashesType.disabled,
                  autocorrect: true,
                  style: GoogleFonts.actor(fontSize: 14, color: Colors.white),
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                      hintText: "Note something down",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
