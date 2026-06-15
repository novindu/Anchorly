import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'status_badge_model.dart';
export 'status_badge_model.dart';

class StatusBadgeWidget extends StatefulWidget {
  const StatusBadgeWidget({
    super.key,
    String? status,
    String? label,
  })  : this.status = status ?? '',
        this.label = label ?? '';

  final String status;
  final String label;

  @override
  State<StatusBadgeWidget> createState() => _StatusBadgeWidgetState();
}

class _StatusBadgeWidgetState extends State<StatusBadgeWidget> {
  late StatusBadgeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StatusBadgeModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget!.status == 'pending'
            ? FlutterFlowTheme.of(context).warning15
            : FlutterFlowTheme.of(context).success15,
        borderRadius: BorderRadius.circular(9999.0),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 14.0,
                height: 14.0,
                child: Stack(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  children: [
                    if (widget!.status == 'pending' ? true : false)
                      Icon(
                        Icons.schedule_rounded,
                        color: widget!.status == 'pending'
                            ? FlutterFlowTheme.of(context).warning
                            : FlutterFlowTheme.of(context).success,
                        size: 14.0,
                      ),
                    if (widget!.status == 'pending' ? false : true)
                      Icon(
                        Icons.check_circle_rounded,
                        color: widget!.status == 'pending'
                            ? FlutterFlowTheme.of(context).warning
                            : FlutterFlowTheme.of(context).success,
                        size: 14.0,
                      ),
                  ],
                ),
              ),
              Text(
                widget!.label,
                style: FlutterFlowTheme.of(context).labelSmall.override(
                      font: GoogleFonts.sourceSans3(
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelSmall.fontStyle,
                      ),
                      color: widget!.status == 'pending'
                          ? FlutterFlowTheme.of(context).warning
                          : FlutterFlowTheme.of(context).success,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelSmall.fontStyle,
                      lineHeight: 1.27,
                    ),
              ),
            ].divide(SizedBox(width: 4.0)),
          ),
        ),
      ),
    );
  }
}
