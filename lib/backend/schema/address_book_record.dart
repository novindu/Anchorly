import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AddressBookRecord extends FirestoreRecord {
  AddressBookRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  bool hasPhone() => _phone != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _category = snapshotData['category'] as String?;
    _email = snapshotData['email'] as String?;
    _phone = snapshotData['phone'] as String?;
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: '(default)')
      .collection('address_book');

  static Stream<AddressBookRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AddressBookRecord.fromSnapshot(s));

  static Future<AddressBookRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AddressBookRecord.fromSnapshot(s));

  static AddressBookRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AddressBookRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AddressBookRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AddressBookRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AddressBookRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AddressBookRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAddressBookRecordData({
  String? name,
  String? category,
  String? email,
  String? phone,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'category': category,
      'email': email,
      'phone': phone,
    }.withoutNulls,
  );

  return firestoreData;
}

class AddressBookRecordDocumentEquality implements Equality<AddressBookRecord> {
  const AddressBookRecordDocumentEquality();

  @override
  bool equals(AddressBookRecord? e1, AddressBookRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.category == e2?.category &&
        e1?.email == e2?.email &&
        e1?.phone == e2?.phone;
  }

  @override
  int hash(AddressBookRecord? e) =>
      const ListEquality().hash([e?.name, e?.category, e?.email, e?.phone]);

  @override
  bool isValidKey(Object? o) => o is AddressBookRecord;
}
