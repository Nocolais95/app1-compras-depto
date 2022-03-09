import 'package:ferchus_y_maxi/models/models.dart';
import 'package:ferchus_y_maxi/services/ambiente_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArtefactoCard extends StatelessWidget {
  final String artId;

  const ArtefactoCard(this.artId);
  @override
  Widget build(BuildContext context) {
    final artefactoProvider = Provider.of<AmbientesServices>(context);

    return FutureBuilder(
      future: artefactoProvider.getArtefactos(artId),
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 100,
            child: CupertinoActivityIndicator(),
          );
        }
        final List<Artefacto> art = snapshot.data;

        return ListView.builder(
            itemCount: art.length,
            itemBuilder: ((_, int index) => ListTile(
                  onTap: () => print(art[index].id),
                  leading: Checkbox(
                    activeColor: Colors.indigo,
                    value: art[index].available,
                    // TODO: mandar a llamar la peticion
                    onChanged: (value) {
                      artefactoProvider.updateAvailability(
                          value!, art[index].available!);
                      art[index].available = value;
                    },
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      // TODO: mostrar alerta y poder eliminar
                      _mostrarAlerta(context, art[index].name);
                    },
                    icon: Icon(Icons.delete),
                  ),
                  // leading: Icon(Icons.circle),
                  title: Text(art[index].name),
                )));
      },
    );
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
}
