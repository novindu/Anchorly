import 'package:cloud_firestore/cloud_firestore.dart';

import '/app_state.dart';

/// Scopes Firestore queries to the active family when an id is set.
Query familyScopedQuery(
  Query query, {
  String? familyId,
  String field = 'familyId',
}) {
  final id = familyId ?? FFAppState().activeFamilyId;
  if (id.isEmpty) {
    return query;
  }
  return query.where(field, isEqualTo: id);
}