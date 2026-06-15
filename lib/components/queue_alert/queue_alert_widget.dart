import '/components/button/button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'queue_alert_model.dart';
export 'queue_alert_model.dart';

class QueueAlertWidget extends StatefulWidget {
  const QueueAlertWidget({
    super.key,
    String? count,
  }) : this.count = count ?? '';

  final String count;

  @override
  State<QueueAlertWidget> createState() => _QueueAlertWidgetState();
}

class _QueueAlertWidgetState extends State<QueueAlertWidget> {
  late QueueAlertModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QueueAlertModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.count != '',
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFE8EDF2),
          borderRadius: BorderRadius.circular(6.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Color(0xFFC5D1DE),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      color: Color(0xFF1A365D),
                      size: 20.0,
                    ),
                    Text(
                      'Outbound Authorization Required',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.sourceSans3(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            color: Color(0xFF1A365D),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                            lineHeight: 1.35,
                          ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
                Text(
                  '${widget.count} items are pending approval before they can be sent externally.',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.sourceSans3(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: Color(0xFF1A365D),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.5,
                      ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.goNamed(OutboundAuthorizationQueueWidget.routeName);
                  },
                  child: wrapWithModel(
                    model: _model.buttonModel,
                    updateCallback: () => safeSetState(() {}),
                    child: ButtonWidget(
                      content: 'Review Queue',
                      iconPresent: false,
                      iconEndPresent: false,
                      variant: 'primary',
                      size: 'medium',
                      fullWidth: true,
                      loading: false,
                      disabled: false,
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 16.0)),
            ),
          ),
        ),
      ),
    );
  }
}
