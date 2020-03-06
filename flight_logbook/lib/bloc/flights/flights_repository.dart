import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flightlogbook/bloc/authentication/authentication_repository.dart';
import 'package:flightlogbook/bloc/flights/flight_entry.dart';
import 'package:flutter/foundation.dart';

abstract class FlightsRepository {
  Future<List<FlightEntry>> getAllFlights();
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

  @override
  Future<List<FlightEntry>> getAllFlights() async {
    final currentUser = await _authRepository.getCurrentUser();

    // TODO orderByで順序を指定する
    return _firestore
        .collection('/flights')
        .where(FlightEntry.FIELD_UID, isEqualTo: currentUser.id)
        .getDocuments()
        .then(
      (QuerySnapshot snapshot) {
        return snapshot.documents
            .map((DocumentSnapshot entry) =>
                FlightEntry(id: entry.documentID, data: entry.data))
            .toList();
      },
    );
  }
}
