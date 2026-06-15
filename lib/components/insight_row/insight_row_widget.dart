import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'insight_row_model.dart';
export 'insight_row_model.dart';

class InsightRowWidget extends StatefulWidget {
  const InsightRowWidget({
    super.key,
    Color? bgColor,
    this.icon,
    Color? iconColor,
    String? label,
    String? value,
  })  : this.bgColor = bgColor ?? const Color(0xFFE8F0FE),
        this.iconColor = iconColor ?? const Color(0xFF1967D2),
        this.label = label ?? 'Document Type',
        this.value = value ?? 'Government / Welfare';

  final Color bgColor;
  final Widget? icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  State<InsightRowWidget> createState() => _InsightRowWidgetState();
}

class _InsightRowWidgetState extends State<InsightRowWidget> {
  late InsightRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InsightRowModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              widget!.bgColor,
              Color(0xFFE8F0FE),
            ),
            borderRadius: BorderRadius.circular(6.0),
            shape: BoxShape.rectangle,
          ),
          alignment: AlignmentDirectional(0.0, 0.0),
          child: widget!.icon!,
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                valueOrDefault<String>(
                  widget!.label,
                  'Document Type',
                ),
                style: FlutterFlowTheme.of(context).labelSmall.override(
                      font: GoogleFonts.sourceSans3(
                        fontWeight:
                            FlutterFlowTheme.of(context).labelSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelSmall.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).labelSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelSmall.fontStyle,
                      lineHeight: 1.27,
                    ),
              ),
              Text(
                valueOrDefault<String>(
                  widget!.value,
                  'Government / Welfare',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.sourceSans3(
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      lineHeight: 1.65,
                    ),
              ),
            ].divide(SizedBox(height: 2.0)),
          ),
        ),
      ].divide(SizedBox(width: 16.0)),
    );
  }
}
