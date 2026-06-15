import '/components/button/button_widget.dart';
import '/components/queue_alert/queue_alert_widget.dart';
import '/components/role_badge/role_badge_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'family_dashboard_widget.dart' show FamilyDashboardWidget;
import 'package:flutter/material.dart';

class FamilyDashboardModel extends FlutterFlowModel<FamilyDashboardWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for RoleBadge.
  late RoleBadgeModel roleBadgeModel;
  // Model for QueueAlert.
  late QueueAlertModel queueAlertModel;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    roleBadgeModel = createModel(context, () => RoleBadgeModel());
    queueAlertModel = createModel(context, () => QueueAlertModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    roleBadgeModel.dispose();
    queueAlertModel.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
