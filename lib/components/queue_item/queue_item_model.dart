import '/components/button/button_widget.dart';
import '/components/status_badge/status_badge_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'queue_item_widget.dart' show QueueItemWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QueueItemModel extends FlutterFlowModel<QueueItemWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for StatusBadge.
  late StatusBadgeModel statusBadgeModel;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    statusBadgeModel = createModel(context, () => StatusBadgeModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    statusBadgeModel.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
