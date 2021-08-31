import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState(ubicacion: new LatLng(0.0, 0.0)));

  // Geolocator
  final _geolocator = new Geolocator();
  late StreamSubscription<Position> _positionSubscription;

  void iniciarSeguimiento() {
    final locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    _positionSubscription = Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.high, distanceFilter: 10)
        .listen((Position position) {
      final nuevaUbicacion = new LatLng(position.latitude, position.longitude);
      add(OnUbicacionCambio(nuevaUbicacion));
    });

    /*
    _positionSubscription = this
        ._geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      final nuevaUbicacion = new LatLng(position.latitude, position.longitude);
      add(OnUbicacionCambio(nuevaUbicacion));
    }); */
  }

  void cancelarSeguimiento() {
    _positionSubscription?.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState(MiUbicacionEvent event) async* {
    if (event is OnUbicacionCambio) {
      print(event);
      yield state.copyWith(
          existeUbicacion: true, ubicacion: event.ubicacion, siguiendo: true);
    }
  }
}
