import 'package:ferchus_y_maxi/models/models.dart';
import 'package:flutter/material.dart';

class AmbienteFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Creamos esto para manejar mejor el ambiente, para poder editarlo si quiero
  Ambiente ambiente;

  // Es importante que este ambiente sea una copia del seleccionado
  AmbienteFormProvider(
    this.ambiente,
  );

  bool isValidForm() {
    print(ambiente.name);
    return formKey.currentState?.validate() ?? false;
  }
}
