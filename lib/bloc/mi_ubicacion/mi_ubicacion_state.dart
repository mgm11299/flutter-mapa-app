part of 'mi_ubicacion_bloc.dart';

//@immutable
//abstract class MiUbicacionState {}

//class MiUbicacionInitial extends MiUbicacionState {}

@immutable
class MiUbicacionState {
  final bool siguiendo;
  final bool existeUbicacion;
  final LatLng ubicacion;

  MiUbicacionState(
      {this.siguiendo = true,
      this.existeUbicacion = false,
      required this.ubicacion});

  MiUbicacionState copyWith({
    required bool siguiendo,
    required bool existeUbicacion,
    required LatLng ubicacion,
  }) =>
      new MiUbicacionState(
        siguiendo: siguiendo ?? this.siguiendo,
        existeUbicacion: existeUbicacion ?? this.existeUbicacion,
        ubicacion: ubicacion ?? this.ubicacion,
      );
}
