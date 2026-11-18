import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'agendar_cita_widget.dart' show AgendarCitaWidget;
import 'package:flutter/material.dart';

class AgendarCitaModel extends FlutterFlowModel<AgendarCitaWidget> {
  ///  Local state fields for this page.

  DateTime? fechaSeleccionada;

  String? horaSeleccionada;

  List<String> horariosDisponibles = [];
  void addToHorariosDisponibles(String item) => horariosDisponibles.add(item);
  void removeFromHorariosDisponibles(String item) =>
      horariosDisponibles.remove(item);
  void removeAtIndexFromHorariosDisponibles(int index) =>
      horariosDisponibles.removeAt(index);
  void insertAtIndexInHorariosDisponibles(int index, String item) =>
      horariosDisponibles.insert(index, item);
  void updateHorariosDisponiblesAtIndex(int index, Function(String) updateFn) =>
      horariosDisponibles[index] = updateFn(horariosDisponibles[index]);

  bool? consultando;

  bool? reservando;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Calendar widget.
  DateTime? calendarSelectedDay;
  // Stores action output result for [Custom Action - consultarHorariosDisponibles] action in Calendar widget.
  List<String>? resultadoHorarios;
  // Stores action output result for [Custom Action - reservarCita] action in Button widget.
  String? resultadoReserva;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
