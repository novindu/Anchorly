import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'setup_step_model.dart';
export 'setup_step_model.dart';

class SetupStepWidget extends StatefulWidget {
  const SetupStepWidget({
    super.key,
    Color? bgIcon,
    this.icon,
    Color? iconColor,
    String? title,
    String? description,
    bool? completed,
  })  : this.bgIcon = bgIcon ?? const Color(0x00000000),
        this.iconColor = iconColor ?? const Color(0x00000000),
        this.title = title ?? 'Secure Vault',
        this.description =
            description ?? 'Create encrypted local folder for documents',
        this.completed = completed ?? true;

  final Color bgIcon;
  final Widget? icon;
  final Color iconColor;
  final String title;
  final String description;
  final bool completed;

  @override
  State<SetupStepWidget> createState() => _SetupStepWidgetState();
}

class _SetupStepWidgetState extends State<SetupStepWidget> {
  late SetupStepModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SetupStepModel());

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
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(6.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    widget!.bgIcon,
                    FlutterFlowTheme.of(context).primary10,
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
                        widget!.title,
                        'Secure Vault',
                      ),
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.sourceSans3(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                            lineHeight: 1.35,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget!.description,
                        'Create encrypted local folder for documents',
                      ),
                      maxLines: 2,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.sourceSans3(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                            lineHeight: 1.6,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
              ),
              Container(
                width: 20.0,
                height: 20.0,
                child: Stack(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  children: [
                    if (widget!.completed ? true : false)
                      Icon(
                        Icons.check_circle_rounded,
                        color: widget!.completed
                            ? FlutterFlowTheme.of(context).success
                            : FlutterFlowTheme.of(context).secondaryText,
                        size: 20.0,
                      ),
                    if (widget!.completed ? false : true)
                      Icon(
                        Icons.chevron_right_rounded,
                        color: widget!.completed
                            ? FlutterFlowTheme.of(context).success
                            : FlutterFlowTheme.of(context).secondaryText,
                        size: 20.0,
                      ),
                  ],
                ),
              ),
            ].divide(SizedBox(width: 16.0)),
          ),
        ),
      ),
    );
  }
}
