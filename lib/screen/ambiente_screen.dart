import 'package:ferchus_y_maxi/models/artefacto.dart';
import 'package:ferchus_y_maxi/providers/artefacto_form_provider.dart';
import 'package:ferchus_y_maxi/screen/screen.dart';
import 'package:ferchus_y_maxi/services/services.dart';
import 'package:ferchus_y_maxi/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmbienteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ambienteServices = Provider.of<AmbientesServices>(context);
    return ChangeNotifierProvider(
      create: (context) =>
          ArtefactoFormProvider(ambienteServices.selectedArtefacto),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.black,
              pinned: true,
              expandedHeight: 200,
              toolbarHeight: 50,
              flexibleSpace: FlexibleSpaceBar(
                  // expandedTitleScale: 40,
                  title: Text(ambienteServices.selectedAmbiente.name),
                  background: Opacity(
                    opacity: 0.8,
                    child: AmbienteImage(
                      url: ambienteServices.selectedAmbiente.picture,
                    ),
                  )),
            ),
            SliverFillRemaining(
              fillOverscroll: true,
              child: GestureDetector(
                onTap: () {
                  // artefactoServices.selectedAmbiente =
                  //     ambienteServices.selectedAmbiente[index];
                },
                child: ArtefactoCard(ambienteServices.selectedAmbiente.id!),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            // TODO: Agregar nuevo artefacto
            print('crear nuevo artefacto');
            _ingresarNuevoArtefacto(context);
            ambienteServices.selectedArtefacto =
                Artefacto(name: '', available: false);
          }),
          child: Icon(Icons.add_outlined),
        ),
      ),
    );
  }

  Future<dynamic> _ingresarNuevoArtefacto(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text('Ingrese el nombre'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // key: artefactoForm.formKey,
                child: TextFormField(
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'El nombre es obligatorio';
                    }
                  },
                ),
              ),
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
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
