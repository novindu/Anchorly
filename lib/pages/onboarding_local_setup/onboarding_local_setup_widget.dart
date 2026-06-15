import '/components/button/button_widget.dart';
import '/components/setup_step/setup_step_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import '/custom_code/actions/initialize_family_vault.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'onboarding_local_setup_model.dart';
export 'onboarding_local_setup_model.dart';

class OnboardingLocalSetupWidget extends StatefulWidget {
  const OnboardingLocalSetupWidget({super.key});

  static String routeName = 'OnboardingLocalSetup';
  static String routePath = '/onboardingLocalSetup';

  @override
  State<OnboardingLocalSetupWidget> createState() =>
      _OnboardingLocalSetupWidgetState();
}

class _OnboardingLocalSetupWidgetState
    extends State<OnboardingLocalSetupWidget> {
  late OnboardingLocalSetupModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Consent checkboxes for Australian Privacy Act + local data compliance (SS A28-29)
  bool _agreedUserAgreement = false;
  bool _agreedPrivacyPolicy = false;
  bool _agreedLocalDataTerms = false;
  bool _initializingVault = false;

  // Sample policy texts (for in-app dialogs on front page consent).
  // TODO: Replace with your final legal copy generated from the prompts below.
  // These are illustrative only and not legal advice.
  static const String _sampleUserAgreementText = '''
USER AGREEMENT (SAMPLE - REPLACE WITH FINAL)

By using Anchorly you agree that:
- This is a local-first family coordination tool. Your documents and signatures are stored primarily on your device.
- Anchorly does not provide legal, financial, medical or professional advice.
- You are responsible for maintaining the security of your device and vault passphrase.
- You consent to the collection of minimal coordination metadata in Firebase for family group functionality.
- Outbound sharing requires explicit multi-adult approval as configured in your rules.
- You will not use the app for any unlawful purpose.

Full terms will be provided at [your hosted URL].
''';

  static const String _samplePrivacyPolicyText = '''
PRIVACY POLICY (SAMPLE - REPLACE WITH FINAL)

Anchorly is designed with privacy by design under the Australian Privacy Act 1988 (APPs).

- Local data (documents, signatures, vault) never leaves your device unless you explicitly authorize outbound sharing.
- We collect only the minimum necessary for coordination: family membership, roles, and approval metadata.
- No AI processing occurs on your private files without your explicit consent on that specific action.
- All actions are logged in an immutable audit ledger you control.
- You can delete your local data at any time. Cloud metadata can be deleted via the app or by requesting deletion.
- We do not sell data. We do not use your content for training.

See the full policy and how to exercise your rights at [your hosted URL].
''';

  static const String _sampleLocalDataTermsText = '''
LOCAL DATA TERMS (SAMPLE - E2EE ENABLED)

Anchorly uses a real client-side encryption layer (AES-256-GCM with PBKDF2 key derivation from your vault passphrase).

- All documents and signatures are encrypted on-device before being written to your device's storage.
- The encryption key never leaves your device and is not known to us.
- Even if your device is lost or the local files are accessed by malware, the content remains protected without the correct passphrase.
- Family coordination metadata (rules toggles, membership) is stored in Firebase but sensitive payloads can be encrypted before upload.
- "End-to-end encryption active" refers to this client-side layer for local vault contents.

By agreeing you acknowledge that losing your vault passphrase will make your local encrypted data unrecoverable.
''';

  void _showPolicyDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(content)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingLocalSetupModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>(); // ensure FFAppState (with activeFamilyId) is available for familyGroupRef passing
    return Shortcuts(
      shortcuts: {},
      child: Actions(
        actions: {
          VoidCallbackIntent: CallbackAction<VoidCallbackIntent>(
            onInvoke: (intent) => intent.callback(),
          ),
        },
        child: Focus(
            autofocus: isShortcutsSupported,
            focusNode: _model.shortcutsFocusNode,
            child: GestureDetector(
              onTap: () {
                if (isShortcutsSupported &&
                    _model.shortcutsFocusNode.canRequestFocus) {
                  FocusScope.of(context)
                      .requestFocus(_model.shortcutsFocusNode);
                } else {
                  FocusScope.of(context).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                body: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Australian Privacy Act 1988 + APPs compliance disclaimer (deployed to local export; cloud direct via anchorly-mcp when token allows)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 4.0),
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            'Anchorly does not provide legal, financial, or medical advice. Always verify with official sources. Onboarding involves consent for local storage and optional cloud features (Australian Privacy Act 1988 compliance).',
                            style: FlutterFlowTheme.of(context).bodySmall.override(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 32.0, 24.0, 24.0),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.anchor,
                                  size: 48.0,
                                  color: const Color(0xFF005B94),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Welcome to Anchorly',
                                      style: FlutterFlowTheme.of(context)
                                          .headlineLarge
                                          .override(
                                            font: GoogleFonts.sourceSans3(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineLarge
                                                    .fontStyle,
                                            lineHeight: 1.2,
                                          ),
                                    ),
                                    Text(
                                      'Secure, local-first family coordination.',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            font: GoogleFonts.sourceSans3(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .fontStyle,
                                            lineHeight: 1.6,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 4.0)),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).info10,
                                borderRadius: BorderRadius.circular(6.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).info,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.shield_rounded,
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Anchorly stores your documents and signatures locally on this device. We never see your private files.',
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                font: GoogleFonts.sourceSans3(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .fontStyle,
                                                lineHeight: 1.6,
                                              ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 4.0),
                              child: Container(
                                child: Text(
                                  'Configuration Steps',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        font: GoogleFonts.sourceSans3(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                        lineHeight: 1.33,
                                      ),
                                ),
                              ),
                            ),
                            wrapWithModel(
                              model: _model.setupStepModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: SetupStepWidget(
                                bgIcon: FlutterFlowTheme.of(context).primary10,
                                icon: Icon(
                                  Icons.folder_shared_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 18.0,
                                ),
                                iconColor: FlutterFlowTheme.of(context).primary,
                                title: 'Secure Vault',
                                description:
                                    'Create encrypted local folder for documents',
                                completed: true,
                              ),
                            ),
                            wrapWithModel(
                              model: _model.setupStepModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: SetupStepWidget(
                                bgIcon:
                                    FlutterFlowTheme.of(context).secondary10,
                                icon: Icon(
                                  Icons.person_add_rounded,
                                  color: FlutterFlowTheme.of(context).secondary,
                                  size: 18.0,
                                ),
                                iconColor:
                                    FlutterFlowTheme.of(context).secondary,
                                title: 'Identity & Role',
                                description:
                                    'Set up your Adult profile and family group',
                                completed: false,
                              ),
                            ),
                            wrapWithModel(
                              model: _model.setupStepModel3,
                              updateCallback: () => safeSetState(() {}),
                              child: SetupStepWidget(
                                bgIcon: FlutterFlowTheme.of(context).accent10,
                                icon: Icon(
                                  Icons.draw_rounded,
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  size: 18.0,
                                ),
                                iconColor:
                                    FlutterFlowTheme.of(context).tertiary,
                                title: 'Digital Ink',
                                description:
                                    'Register your handwritten signature locally',
                                completed: false,
                              ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.lock_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 14.0,
                                        ),
                                        Text(
                                          'End-to-end encryption active',
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                font: GoogleFonts.sourceSans3(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontStyle,
                                                lineHeight: 1.27,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                    // Australian Privacy Act 1988 + APPs compliance: Required consent checkboxes + in-app policy viewers (SS A28-29)
// These are mandatory failsafes before "Initialize Family Vault".
// Clicking the links opens in-app dialogs with sample text (replace/enhance with your final legal copy).
// Local Data Terms now references the new real E2EE layer.
Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    // User Agreement
    Row(
      children: [
        Checkbox(
          value: _agreedUserAgreement,
          onChanged: (val) => safeSetState(() => _agreedUserAgreement = val ?? false),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => _showPolicyDialog(context, 'User Agreement', _sampleUserAgreementText),
            child: Text(
              'I have read and agree to the User Agreement',
              style: FlutterFlowTheme.of(context).labelSmall.override(
                    color: FlutterFlowTheme.of(context).primary,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        ),
      ],
    ),
    // Privacy Policy
    Row(
      children: [
        Checkbox(
          value: _agreedPrivacyPolicy,
          onChanged: (val) => safeSetState(() => _agreedPrivacyPolicy = val ?? false),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => _showPolicyDialog(context, 'Privacy Policy', _samplePrivacyPolicyText),
            child: Text(
              'I have read and agree to the Privacy Policy',
              style: FlutterFlowTheme.of(context).labelSmall.override(
                    color: FlutterFlowTheme.of(context).primary,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        ),
      ],
    ),
    // Local Data Terms (now points to real E2EE implementation)
    Row(
      children: [
        Checkbox(
          value: _agreedLocalDataTerms,
          onChanged: (val) => safeSetState(() => _agreedLocalDataTerms = val ?? false),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => _showPolicyDialog(context, 'Local Data Terms', _sampleLocalDataTermsText),
            child: Text(
              'I agree to Local Data Terms (device-only + client-side E2EE)',
              style: FlutterFlowTheme.of(context).labelSmall.override(
                    color: FlutterFlowTheme.of(context).primary,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        ),
      ],
    ),
    const SizedBox(height: 8),
    Text(
      'All boxes must be ticked for Australian Privacy Act 1988 / APP compliance before continuing.',
      textAlign: TextAlign.center,
      style: FlutterFlowTheme.of(context).labelSmall.override(
            color: FlutterFlowTheme.of(context).secondaryText,
            fontSize: 11,
          ),
    ),
  ],
),

                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if (!(_agreedUserAgreement &&
                                            _agreedPrivacyPolicy &&
                                            _agreedLocalDataTerms)) {
                                          return;
                                        }
                                        if (_initializingVault) {
                                          return;
                                        }

                                        safeSetState(() => _initializingVault = true);
                                        try {
                                          final result =
                                              await initializeFamilyVault();

                                          if (!mounted) return;

                                          if (result.notice != null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(result.notice!),
                                                duration:
                                                    const Duration(seconds: 8),
                                              ),
                                            );
                                          }

                                          context.goNamed(
                                            FamilyMemberManagementWidget
                                                .routeName,
                                            queryParameters: {
                                              'familyGroupRef': serializeParam(
                                                result.familyGroupRef,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                          );
                                        } catch (e) {
                                          if (!mounted) return;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Initialize failed: $e',
                                              ),
                                              duration:
                                                  const Duration(seconds: 10),
                                            ),
                                          );
                                        } finally {
                                          if (mounted) {
                                            safeSetState(
                                                () => _initializingVault = false);
                                          }
                                        }
                                      },
                                      child: wrapWithModel(
                                        model: _model.buttonModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: ButtonWidget(
                                          content: 'Initialize Family Vault',
                                          iconPresent: false,
                                          iconEndPresent: false,
                                          variant: 'primary',
                                          size: 'large',
                                          fullWidth: true,
                                          loading: _initializingVault,
                                          disabled: _initializingVault ||
                                              !(_agreedUserAgreement &&
                                                  _agreedPrivacyPolicy &&
                                                  _agreedLocalDataTerms),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'By ticking the boxes and continuing, you agree to the linked terms (Australian Privacy Act 1988 compliance).',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.sourceSans3(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .accent3,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                            lineHeight: 1.27,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 16.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
