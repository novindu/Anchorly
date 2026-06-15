import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  static const _kActiveFamilyId = 'ff_activeFamilyId';
  static const _kCurrentUserRole = 'ff_currentUserRole';
  static const _kCloudSyncActive = 'ff_cloudSyncActive';

  Future initializePersistedState() async {
    final prefs = await SharedPreferences.getInstance();
    _activeFamilyId = prefs.getString(_kActiveFamilyId) ?? '';
    _currentUserRole = prefs.getString(_kCurrentUserRole) ?? 'Adult';
    _cloudSyncActive = prefs.getBool(_kCloudSyncActive) ?? false;
  }

  Future persistState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kActiveFamilyId, _activeFamilyId);
    await prefs.setString(_kCurrentUserRole, _currentUserRole);
    await prefs.setBool(_kCloudSyncActive, _cloudSyncActive);
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _currentUserRole = 'Adult';
  String get currentUserRole => _currentUserRole;
  set currentUserRole(String value) {
    _currentUserRole = value;
  }

  String _activeFamilyId = '';
  String get activeFamilyId => _activeFamilyId;
  set activeFamilyId(String value) {
    _activeFamilyId = value;
  }

  bool _cloudSyncActive = false;
  bool get cloudSyncActive => _cloudSyncActive;
  set cloudSyncActive(bool value) {
    _cloudSyncActive = value;
  }
}