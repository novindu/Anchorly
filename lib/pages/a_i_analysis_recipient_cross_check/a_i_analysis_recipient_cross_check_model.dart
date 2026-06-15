import '/components/button/button_widget.dart';
import '/components/checkbox/checkbox_widget.dart';
import '/components/insight_row/insight_row_widget.dart';
import '/components/warning_box/warning_box_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'a_i_analysis_recipient_cross_check_widget.dart'
    show AIAnalysisRecipientCrossCheckWidget;
import 'package:flutter/material.dart';

class AIAnalysisRecipientCrossCheckModel
    extends FlutterFlowModel<AIAnalysisRecipientCrossCheckWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for InsightRow.
  late InsightRowModel insightRowModel1;
  // Model for InsightRow.
  late InsightRowModel insightRowModel2;
  // Model for WarningBox.
  late WarningBoxModel warningBoxModel;
  // Model for Checkbox.
  late CheckboxModel checkboxModel1;
  // Model for Checkbox.
  late CheckboxModel checkboxModel2;
  // Model for Checkbox.
  late CheckboxModel checkboxModel3;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    insightRowModel1 = createModel(context, () => InsightRowModel());
    insightRowModel2 = createModel(context, () => InsightRowModel());
    warningBoxModel = createModel(context, () => WarningBoxModel());
    checkboxModel1 = createModel(context, () => CheckboxModel());
    checkboxModel2 = createModel(context, () => CheckboxModel());
    checkboxModel3 = createModel(context, () => CheckboxModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    insightRowModel1.dispose();
    insightRowModel2.dispose();
    warningBoxModel.dispose();
    checkboxModel1.dispose();
    checkboxModel2.dispose();
    checkboxModel3.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
