import 'package:ferchus_y_maxi/models/models.dart';
import 'package:flutter/material.dart';

class ArtefactoFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Creamos esto para manejar mejor el ambiente, para poder editarlo si quiero
  Artefacto artefacto;

  // Es importante que este ambiente sea una copia del seleccionado
  ArtefactoFormProvider(
    this.artefacto,
  );

  bool isValidForm() {
    print(artefacto.name);
    return formKey.currentState?.validate() ?? false;
  }
}
