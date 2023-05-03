import 'package:get/get.dart';
import 'package:keep_notes/homepage/model.dart';

import 'state.dart';

class EditPageLogic extends GetxController {
  final EditPageState state = EditPageState();
  List<NoteModel> totalList = [];
  List<NoteModel> editList = [];
}
