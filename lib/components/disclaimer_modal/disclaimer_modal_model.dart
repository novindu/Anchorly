import '/components/button/button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'disclaimer_modal_widget.dart' show DisclaimerModalWidget;
import 'package:flutter/material.dart';

class DisclaimerModalModel extends FlutterFlowModel<DisclaimerModalWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
