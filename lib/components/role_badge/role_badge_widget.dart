import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'role_badge_model.dart';
export 'role_badge_model.dart';

class RoleBadgeWidget extends StatefulWidget {
  const RoleBadgeWidget({
    super.key,
    Color? bgColor,
    String? label,
    Color? textColor,
  })  : this.bgColor = bgColor ?? const Color(0x00000000),
        this.label = label ?? '',
        this.textColor = textColor ?? const Color(0xFF1A365D);

  final Color bgColor;
  final String label;
  final Color textColor;

  @override
  State<RoleBadgeWidget> createState() => _RoleBadgeWidgetState();
}

class _RoleBadgeWidgetState extends State<RoleBadgeWidget> {
  late RoleBadgeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RoleBadgeModel());

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
        color: widget!.bgColor,
        borderRadius: BorderRadius.circular(4.0),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(4.0, 6.0, 4.0, 6.0),
        child: Container(
          child: Text(
            widget!.label,
            style: FlutterFlowTheme.of(context).labelSmall.override(
                  font: GoogleFonts.sourceSans3(
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  ),
                  color: valueOrDefault<Color>(
                    widget!.textColor,
                    Color(0xFF1A365D),
                  ),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  lineHeight: 1.27,
                ),
          ),
        ),
      ),
    );
  }
}
