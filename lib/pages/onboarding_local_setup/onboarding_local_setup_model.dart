import '/components/button/button_widget.dart';
import '/components/setup_step/setup_step_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'onboarding_local_setup_widget.dart' show OnboardingLocalSetupWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnboardingLocalSetupModel
    extends FlutterFlowModel<OnboardingLocalSetupWidget> {
  ///  State fields for stateful widgets in this page.

  final shortcutsFocusNode = FocusNode();
  // Model for SetupStep.
  late SetupStepModel setupStepModel1;
  // Model for SetupStep.
  late SetupStepModel setupStepModel2;
  // Model for SetupStep.
  late SetupStepModel setupStepModel3;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    shortcutsFocusNode.requestFocus();
    setupStepModel1 = createModel(context, () => SetupStepModel());
    setupStepModel2 = createModel(context, () => SetupStepModel());
    setupStepModel3 = createModel(context, () => SetupStepModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    setupStepModel1.dispose();
    setupStepModel2.dispose();
    setupStepModel3.dispose();
    buttonModel.dispose();
  }
}
