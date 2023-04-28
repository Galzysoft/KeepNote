import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keep_notes/homepage/model.dart';
import '../customWidgets/nocategory.dart';
import '../navigation.dart';
import 'logic.dart';

enum AddNoteStatus { ADD, UPDATE }

class AddNotesPage extends StatefulWidget {
  AddNotesPage({
    Key? key,
    this.addNoteStatus = AddNoteStatus.ADD,
    this.noteModel,
  }) : super(key: key);
  final AddNoteStatus addNoteStatus;
  final NoteModel? noteModel;

  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  final logic = Get.put(AddNotesLogic());

  final state = Get.find<AddNotesLogic>().state;

  String get getDate {
    if (widget.addNoteStatus == AddNoteStatus.UPDATE) {
      return "${DateFormat("MMM dd EEE yyyy / h:mm:ss a").format(DateTime.parse(widget.noteModel!.dateTime!))}";
    } else {
      return "${DateFormat("MMM dd EEE yyyy / h:mm:ss a").format(DateTime.now())}";

    }
  }

  @override
  void initState() {
    if (widget.addNoteStatus == AddNoteStatus.UPDATE) {
      logic.titleController.text = widget.noteModel!.title!;
      logic.noteController.text = widget.noteModel!.description!;
    } // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.addNoteStatus == AddNoteStatus.ADD) {
          logic.createNotes();
        }else{
          logic.updateNotes(id:int.parse( widget.noteModel!.id!));
        }
        logic.titleController.clear();
        logic.noteController.clear();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF010909),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                if (widget.addNoteStatus == AddNoteStatus.ADD) {
                  logic.createNotes().whenComplete(() {
                    Get.back();
                  });
                  logic.titleController.clear();
                  logic.noteController.clear();
                } else {
                  logic.updateNotes(id:int.parse( widget.noteModel!.id!)).whenComplete(() {    Get.back();});

                  logic.titleController.clear();
                  logic.noteController.clear();
                }
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
                    getDate,
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
