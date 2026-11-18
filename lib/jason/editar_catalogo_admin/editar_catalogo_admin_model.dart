import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'editar_catalogo_admin_widget.dart' show EditarCatalogoAdminWidget;
import 'package:flutter/material.dart';

class EditarCatalogoAdminModel
    extends FlutterFlowModel<EditarCatalogoAdminWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for txtDesc widget.
  FocusNode? txtDescFocusNode;
  TextEditingController? txtDescTextController;
  String? Function(BuildContext, String?)? txtDescTextControllerValidator;
  // State field(s) for txtNombre widget.
  FocusNode? txtNombreFocusNode;
  TextEditingController? txtNombreTextController;
  String? Function(BuildContext, String?)? txtNombreTextControllerValidator;
  // State field(s) for drpCategoria widget.
  String? drpCategoriaValue;
  FormFieldController<String>? drpCategoriaValueController;
  // State field(s) for txtPrice widget.
  FocusNode? txtPriceFocusNode;
  TextEditingController? txtPriceTextController;
  String? Function(BuildContext, String?)? txtPriceTextControllerValidator;
  // State field(s) for txtDuration widget.
  FocusNode? txtDurationFocusNode;
  TextEditingController? txtDurationTextController;
  String? Function(BuildContext, String?)? txtDurationTextControllerValidator;
  // State field(s) for switchFeatured widget.
  bool? switchFeaturedValue1;
  // State field(s) for switchFeatured widget.
  bool? switchFeaturedValue2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    txtDescFocusNode?.dispose();
    txtDescTextController?.dispose();

    txtNombreFocusNode?.dispose();
    txtNombreTextController?.dispose();

    txtPriceFocusNode?.dispose();
    txtPriceTextController?.dispose();

    txtDurationFocusNode?.dispose();
    txtDurationTextController?.dispose();
  }
}
