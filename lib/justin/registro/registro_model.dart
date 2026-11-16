import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'registro_widget.dart' show RegistroWidget;
import 'package:flutter/material.dart';

class RegistroModel extends FlutterFlowModel<RegistroWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for correo widget.
  FocusNode? correoFocusNode;
  TextEditingController? correoTextController;
  String? Function(BuildContext, String?)? correoTextControllerValidator;
  // State field(s) for contrasena widget.
  late FocusNode contrasenaPasswordVisibilityFocusNode;
  FocusNode? contrasenaFocusNode;
  TextEditingController? contrasenaTextController;
  late bool contrasenaVisibility;
  String? Function(BuildContext, String?)? contrasenaTextControllerValidator;
  // State field(s) for cContrasena widget.
  late FocusNode cContrasenaPasswordVisibilityFocusNode;
  FocusNode? cContrasenaFocusNode;
  TextEditingController? cContrasenaTextController;
  late bool cContrasenaVisibility;
  String? Function(BuildContext, String?)? cContrasenaTextControllerValidator;

  @override
  void initState(BuildContext context) {
    contrasenaPasswordVisibilityFocusNode = FocusNode();
    contrasenaVisibility = false;
    cContrasenaPasswordVisibilityFocusNode = FocusNode();
    cContrasenaVisibility = false;
  }

  @override
  void dispose() {
    correoFocusNode?.dispose();
    correoTextController?.dispose();

    contrasenaFocusNode?.dispose();
    contrasenaTextController?.dispose();
    contrasenaPasswordVisibilityFocusNode.dispose();
    cContrasenaFocusNode?.dispose();
    cContrasenaTextController?.dispose();
    cContrasenaPasswordVisibilityFocusNode.dispose();
  }
}
