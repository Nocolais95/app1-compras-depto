// import 'package:ferchus_y_maxi/models/models.dart';
import 'package:ferchus_y_maxi/models/ambiente.dart';
import 'package:flutter/material.dart';

import 'package:ferchus_y_maxi/services/services.dart';
import 'package:ferchus_y_maxi/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ambientesServices = Provider.of<AmbientesServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambientes'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: ambientesServices.ambientes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            // Aca creamos una copia del producto para no perder la informacion, es una buena practica
            ambientesServices.selectedAmbiente =
                ambientesServices.ambientes[index].copy();
            Navigator.pushNamed(context, 'ambiente');
          },
          // TODO: Eliminar ese ambiente, pero mostrar un mensaje de alerta
          onLongPress: () {
            print('desea eliminar ${ambientesServices.ambientes[index].name}?');
            _mostrarAlerta(context, ambientesServices.ambientes[index].name);
          },
          child: AmbienteCard(
            ambiente: ambientesServices.ambientes[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // Crear un nuevo ambiente, definir una pantalla de creacion
        onPressed: (() {
          print(ambientesServices);
          ambientesServices.selectedAmbiente = Ambiente(name: '');
          Navigator.pushNamed(context, 'nuevo ambiente');
        }),
      ),
    );
  }
}

Future<dynamic> _mostrarAlerta(context, String name) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Text('Eliminar'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Desea eliminar $name ?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Ok'),
          ),
        ],
      );
    },
  );
}
