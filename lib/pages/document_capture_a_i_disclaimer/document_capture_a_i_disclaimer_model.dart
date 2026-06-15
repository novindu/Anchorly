import '/components/disclaimer_modal/disclaimer_modal_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'document_capture_a_i_disclaimer_widget.dart'
    show DocumentCaptureAIDisclaimerWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
