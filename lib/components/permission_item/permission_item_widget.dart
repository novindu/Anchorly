import '/components/switch_component/switch_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'permission_item_model.dart';
export 'permission_item_model.dart';

class PermissionItemWidget extends StatefulWidget {
  const PermissionItemWidget({
    super.key,
    this.icon,
    String? label,
    String? desc,
    bool? enabled,
    String? onChange,
  })  : this.label = label ?? 'Multi-Adult Approval',
        this.desc = desc ?? 'Require 2 adults for external sends',
        this.enabled = enabled ?? false,
        this.onChange = onChange ?? '';

  final Widget? icon;
  final String label;
  final String desc;
  final bool enabled;
  final String onChange;

  @override
  State<PermissionItemWidget> createState() => _PermissionItemWidgetState();
}

class _PermissionItemWidgetState extends State<PermissionItemWidget> {
  late PermissionItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PermissionItemModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget!.icon!,
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
                    'Multi-Adult Approval',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.sourceSans3(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.65,
                      ),
                ),
                Text(
                  valueOrDefault<String>(
                    widget!.desc,
                    'Require 2 adults for external sends',
                  ),
                  style: FlutterFlowTheme.of(context).labelSmall.override(
                        font: GoogleFonts.sourceSans3(
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelSmall
                              .fontWeight,
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
              ].divide(SizedBox(height: 4.0)),
            ),
          ),
          wrapWithModel(
            model: _model.switchComponentModel,
            updateCallback: () => safeSetState(() {}),
            child: SwitchComponentWidget(
              label: '',
              labelPresent: false,
              variant: 'iOS',
              active: valueOrDefault<bool>(
                widget!.enabled,
                false,
              ),
            ),
          ),
        ].divide(SizedBox(width: 16.0)),
      ),
    );
  }
}
