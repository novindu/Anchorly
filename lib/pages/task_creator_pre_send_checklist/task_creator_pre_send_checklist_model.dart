import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/button/button_widget.dart';
import '/components/checklist_item/checklist_item_widget.dart';
import '/components/recipient_card/recipient_card_widget.dart';
import '/components/switch_component/switch_component_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'task_creator_pre_send_checklist_widget.dart'
    show TaskCreatorPreSendChecklistWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TaskCreatorPreSendChecklistModel
    extends FlutterFlowModel<TaskCreatorPreSendChecklistWidget> {
  ///  Local state fields for this page.

  String? assignedTo;

  String? recipientId;

  String? instructions;

  bool? aiEnabled = true;

  List<dynamic> checklistItems = [];
  void addToChecklistItems(dynamic item) => checklistItems.add(item);
  void removeFromChecklistItems(dynamic item) => checklistItems.remove(item);
  void removeAtIndexFromChecklistItems(int index) =>
      checklistItems.removeAt(index);
  void insertAtIndexInChecklistItems(int index, dynamic item) =>
      checklistItems.insert(index, item);
  void updateChecklistItemsAtIndex(int index, Function(dynamic) updateFn) =>
      checklistItems[index] = updateFn(checklistItems[index]);

  ///  State fields for stateful widgets in this page.

  // Model for RecipientCard.
  late RecipientCardModel recipientCardModel;
  // Model for ChecklistItem.
  late ChecklistItemModel checklistItemModel;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for SwitchComponent.
  late SwitchComponentModel switchComponentModel;
  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    recipientCardModel = createModel(context, () => RecipientCardModel());
    checklistItemModel = createModel(context, () => ChecklistItemModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    switchComponentModel = createModel(context, () => SwitchComponentModel());
    textFieldModel = createModel(context, () => TextFieldModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    recipientCardModel.dispose();
    checklistItemModel.dispose();
    buttonModel1.dispose();
    switchComponentModel.dispose();
    textFieldModel.dispose();
    buttonModel2.dispose();
  }
}
