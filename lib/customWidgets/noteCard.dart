import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keep_notes/add_notes/view.dart';
import 'package:keep_notes/edit_page/logic.dart';
import 'package:keep_notes/edit_page/view.dart';
import 'package:keep_notes/homepage/model.dart';

class NoteCard extends StatefulWidget {
  NoteCard({Key? key, this.noteModel, this.noteModelList}) : super(key: key);
  final NoteModel? noteModel;
  final List<NoteModel>? noteModelList;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  bool isSelected = false;
  final logicdel = Get.put(EditPageLogic());
@override
  void initState() {
if ( widget.noteModel!.edit == true){
  isSelected=true;
}else{ isSelected=false;}

  // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    border: Border.all(color: Colors.white30),
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  splashColor: Colors.black,
                  onTap: () {
                    Get.to(
                        AddNotesPage(
                            addNoteStatus: AddNoteStatus.UPDATE,
                            noteModel: widget.noteModel),
                        transition: Transition.rightToLeft);
                  },
                  title: Text(
                      style: TextStyle(color: Colors.white),
                      "${widget.noteModel!.title == "" ? widget.noteModel!.description : widget.noteModel!.title}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            "No cartegory",
                            style: TextStyle(color: Colors.white70),
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
                          style: TextStyle(color: Colors.white70),
                          "${DateFormat("MMM dd EEE yyyy / h:mm a").format(DateTime.parse(widget.noteModel!.dateTime.toString()))}"),
                    ],
                  ),
                  trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value:isSelected,
                          onChanged: (value) {
                            setState(() {
                              isSelected = !isSelected;
                            });
                          },
                        )
                      ]),
                )),
          ),
        ),
      ),
    );
  }
}