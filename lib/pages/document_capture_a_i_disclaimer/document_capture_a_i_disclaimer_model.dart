import '/components/disclaimer_modal/disclaimer_modal_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'document_capture_a_i_disclaimer_widget.dart'
    show DocumentCaptureAIDisclaimerWidget;
import 'package:flutter/material.dart';

class DocumentCaptureAIDisclaimerModel
    extends FlutterFlowModel<DocumentCaptureAIDisclaimerWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for DisclaimerModal.
  late DisclaimerModalModel disclaimerModalModel;

  @override
  void initState(BuildContext context) {
    disclaimerModalModel = createModel(context, () => DisclaimerModalModel());
  }

  @override
  void dispose() {
    disclaimerModalModel.dispose();
  }
}
