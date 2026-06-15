import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/button/button_widget.dart';
import '/components/member_row/member_row_widget.dart';
import '/components/permission_item/permission_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'family_member_management_widget.dart' show FamilyMemberManagementWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FamilyMemberManagementModel
    extends FlutterFlowModel<FamilyMemberManagementWidget> {
  ///  Local state fields for this page.

  bool? multiAdultApproval = true;

  bool? auditAccess = false;

  bool? signatureSharing = false;

  ///  State fields for stateful widgets in this page.

  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for PermissionItem.
  late PermissionItemModel permissionItemModel1;
  // Model for PermissionItem.
  late PermissionItemModel permissionItemModel2;
  // Model for PermissionItem.
  late PermissionItemModel permissionItemModel3;
  // Model for Button.
  late ButtonModel buttonModel2;
  // Model for Button.
  late ButtonModel buttonModel3;
  // Model for Button.
  late ButtonModel buttonModel4;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => ButtonModel());
    permissionItemModel1 = createModel(context, () => PermissionItemModel());
    permissionItemModel2 = createModel(context, () => PermissionItemModel());
    permissionItemModel3 = createModel(context, () => PermissionItemModel());
    buttonModel2 = createModel(context, () => ButtonModel());
    buttonModel3 = createModel(context, () => ButtonModel());
    buttonModel4 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    permissionItemModel1.dispose();
    permissionItemModel2.dispose();
    permissionItemModel3.dispose();
    buttonModel2.dispose();
    buttonModel3.dispose();
    buttonModel4.dispose();
  }
}
