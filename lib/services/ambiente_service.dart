import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ferchus_y_maxi/models/models.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

class AmbientesServices extends ChangeNotifier {
  final String _baseUrl = 'comprar-cosas-depto-default-rtdb.firebaseio.com';
  final List<Ambiente> ambientes = [];
  late List<Artefacto> artefactos = [];

  late Ambiente selectedAmbiente;
  late Artefacto selectedArtefacto;

  bool isLoading = true;
  bool isSaving = false;

  AmbientesServices() {
    loadAambiente();
    // loadArtefacto();
  }

  updateAvailability(bool value, bool disponible) {
    // print(value);
    disponible = value;
    notifyListeners();
  }

  loadAambiente() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'ambiente.json');
    final resp = await http.get(url);

    final Map<String, dynamic> ambientesMap = json.decode(resp.body);

    ambientesMap.forEach((key, value) {
      final tempAmbiente = Ambiente.fromMap(value);
      tempAmbiente.id = key;
      ambientes.add(tempAmbiente);
    });
    notifyListeners();
  }

  Future<List<Artefacto>> getArtefactos(String artId) async {
    if (artefactos.isNotEmpty) artefactos = [];

    isLoading = true;
    final url = Uri.https(_baseUrl, 'ambiente/$artId/artefacto.json');
    final resp1 = await http.get(url);
    Map<String, dynamic> artefactoMap = json.decode(resp1.body);

    artefactoMap == null
        ? artefactoMap = {}
        : artefactoMap.forEach((key, value) {
            final tempArtefacto = Artefacto.fromMap(value);
            tempArtefacto.id = key;
            artefactos.add(tempArtefacto);
          });
    notifyListeners();
    return artefactos;
  }

  Future saveOrCreateAmbiente(Ambiente ambiente) async {
    isSaving = true;
    notifyListeners();

    if (ambiente.id == null) {
      // Es necesario crear
      // await createAmbiente(ambiente);
    } else {
      // Actualizar
      await updateAmbiente(ambiente);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateAmbiente(Ambiente ambiente) async {
    final url = Uri.https(_baseUrl, 'ambiente/${ambiente.id}.json');
    final resp = await http.put(url, body: ambiente.toJson());

    // Esto es para buscar el id del producto
    final index = ambientes.indexWhere((element) => element.id == ambiente.id);
    ambientes[index] = ambiente;
    return ambiente.id!;
  }

  Future<String> createAmbiente(Ambiente ambiente) async {
    final url = Uri.https(_baseUrl, 'ambiente.json');
    final resp = await http.post(url, body: ambiente.toJson());

    final decodeData = json.decode(resp.body);
    print(decodeData);
    ambiente.id = decodeData['name'];

    ambientes.add(ambiente);

    return ambiente.id!;
  }

  // Future<List<Artefacto>> createArtefactos(String id) async {
  //   final url1 = Uri.https(_baseUrl, 'ambiente/${id}/artefacto.json');
  //   final resp1 = await http.post(url1);

  //   final art = json.decode(resp1.body);
  // }
}
