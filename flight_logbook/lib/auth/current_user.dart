import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class CurrentUser extends Equatable {
  final String id;
  final String name;
  CurrentUser({
    @required this.id,
    @required this.name,
  })  : assert(id != null),
        assert(name != null);

  @override
  List<Object> get props => [id, name];
}
