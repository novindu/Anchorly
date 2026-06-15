import '/components/button/button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'queue_alert_widget.dart' show QueueAlertWidget;
import 'package:flutter/material.dart';

class QueueAlertModel extends FlutterFlowModel<QueueAlertWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
