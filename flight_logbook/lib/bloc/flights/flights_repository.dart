import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flightlogbook/bloc/authentication/authentication_repository.dart';
import 'package:flightlogbook/bloc/flights/flight_entry.dart';
import 'package:flutter/foundation.dart';

abstract class FlightsRepository {
  Future<List<FlightEntry>> getAllFlights(int year);

  Future<FlightEntry> addFlight(int year, FlightEntry newEntry);

  Future<void> removeFlight(int year, String flightId);
}

class FirestoreFlightsRepository extends FlightsRepository {
  final Firestore _firestore;
  final FirebaseAuthenticationRepository _authRepository;

  FirestoreFlightsRepository({
    @required FirebaseAuthenticationRepository authRepository,
    Firestore firestore,
  })  : assert(authRepository != null),
        _firestore = firestore ?? Firestore.instance,
        _authRepository = authRepository;

  static String flightsCollectionPathOf({
    @required String uid,
    @required int year,
  }) =>
      "/users/${uid}/years/${year}/flights";

  static String flightDocumentPathOf({
    @required String uid,
    @required int year,
    @required String flightId,
  }) =>
      "${flightsCollectionPathOf(year: year, uid: uid)}/${flightId}";

  @override
  Future<List<FlightEntry>> getAllFlights(int year) async {
    final currentUser = await _authRepository.getCurrentUser();

    // TODO orderByで順序を指定する
    return _firestore
        .collection(flightsCollectionPathOf(uid: currentUser.id, year: year))
        .where(FlightEntry.FIELD_UID, isEqualTo: currentUser.id)
        .getDocuments()
        .then(
      (QuerySnapshot snapshot) {
        return snapshot.documents
            .map(
              (DocumentSnapshot entry) => FlightEntry(
                id: entry.documentID,
                data: entry.data,
              ),
            )
            .toList();
      },
    );
  }

  @override
  Future<FlightEntry> addFlight(int year, FlightEntry newEntry) async {
    final currentUser = await _authRepository.getCurrentUser();

    final Map<String, dynamic> data = Map.from(newEntry.data);
    data[FlightEntry.FIELD_UID] = currentUser.id;
    final DocumentReference createdDocRef = await Firestore.instance
        .collection(flightsCollectionPathOf(uid: currentUser.id, year: year))
        .add(data);
    return FlightEntry(
      id: createdDocRef.documentID,
      data: data,
    );
  }

  @override
  Future<void> removeFlight(int year, String flightId) async {
    final currentUser = await _authRepository.getCurrentUser();
    await _firestore
        .document(
          flightDocumentPathOf(
            uid: currentUser.id,
            year: year,
            flightId: flightId,
          ),
        )
        .delete();
  }
}
