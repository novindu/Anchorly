import '/components/filter_tag/filter_tag_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'audit_log_privacy_ledger_widget.dart' show AuditLogPrivacyLedgerWidget;
import 'package:flutter/material.dart';

class AuditLogPrivacyLedgerModel
    extends FlutterFlowModel<AuditLogPrivacyLedgerWidget> {
  ///  Local state fields for this page.

  String? filter = 'All';

  ///  State fields for stateful widgets in this page.

  // Model for FilterTag.
  late FilterTagModel filterTagModel1;
  // Model for FilterTag.
  late FilterTagModel filterTagModel2;
  // Model for FilterTag.
  late FilterTagModel filterTagModel3;
  // Model for FilterTag.
  late FilterTagModel filterTagModel4;
  // Model for FilterTag.
  late FilterTagModel filterTagModel5;

  @override
  void initState(BuildContext context) {
    filterTagModel1 = createModel(context, () => FilterTagModel());
    filterTagModel2 = createModel(context, () => FilterTagModel());
    filterTagModel3 = createModel(context, () => FilterTagModel());
    filterTagModel4 = createModel(context, () => FilterTagModel());
    filterTagModel5 = createModel(context, () => FilterTagModel());
  }

  @override
  void dispose() {
    filterTagModel1.dispose();
    filterTagModel2.dispose();
    filterTagModel3.dispose();
    filterTagModel4.dispose();
    filterTagModel5.dispose();
  }
}
