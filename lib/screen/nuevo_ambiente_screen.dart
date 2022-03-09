import 'package:ferchus_y_maxi/models/models.dart';
import 'package:ferchus_y_maxi/providers/ambiente_form_provider.dart';
import 'package:ferchus_y_maxi/services/ambiente_service.dart';
import 'package:flutter/material.dart';
import 'package:ferchus_y_maxi/widgets/widgets.dart';
import 'package:provider/provider.dart';

class NuevoAmbienteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ambienteServices = Provider.of<AmbientesServices>(context);
    return ChangeNotifierProvider(
      create: (_) => AmbienteFormProvider(ambienteServices.selectedAmbiente),
      child: _NuevoAmbienteBody(ambienteServices),
    );
  }
}

class _NuevoAmbienteBody extends StatelessWidget {
  final AmbientesServices ambienteServices;

  const _NuevoAmbienteBody(this.ambienteServices);

  @override
  Widget build(BuildContext context) {
    final ambienteForm = Provider.of<AmbienteFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            _Image(selected: ambienteServices.selectedAmbiente.picture),
            _AmbienteForm(),
            const SizedBox(height: 200),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save_outlined),
        onPressed: () async {
          if (!ambienteForm.isValidForm()) return;
          ambienteServices.saveOrCreateAmbiente(ambienteForm.ambiente);
        },
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final String? selected;

  const _Image({
    Key? key,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NuevoAmbienteImage(selected),
        Positioned(
          top: 100,
          left: 30,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 100,
          right: 30,
          child: IconButton(
            onPressed: () {
              // TODO: camara o galeria
            },
            icon: const Icon(
              Icons.camera_alt_outlined,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _AmbienteForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ambienteForm = Provider.of<AmbienteFormProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: ambienteForm.formKey,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: ambienteForm.ambiente.name,
                onChanged: (value) => ambienteForm.ambiente.name = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'El nombre es obligatorio';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Nombre del Ambiente',
                  labelText: 'Nombre',
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(45), bottomRight: Radius.circular(45)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      );
}
