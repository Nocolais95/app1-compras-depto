import 'package:ferchus_y_maxi/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class AmbienteCard extends StatelessWidget {
  final Ambiente ambiente;

  const AmbienteCard({Key? key, required this.ambiente}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: _CardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(ambiente.picture),
            _AmbienteDetails(ambiente.name),
            _EditIcon(ambiente)
          ],
        ),
      ),
    );
  }

  BoxDecoration _CardBorders() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 7,
        ),
      ],
    );
  }
}

class _EditIcon extends StatelessWidget {
  final Ambiente ambienteSelected;

  const _EditIcon(this.ambienteSelected);
  @override
  Widget build(BuildContext context) {
    final ambienteServices = Provider.of<AmbientesServices>(context);
    return Positioned(
      top: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        child: Container(
          width: 40,
          height: 40,
          color: Colors.indigo,
          child: IconButton(
            onPressed: () {
              ambienteServices.selectedAmbiente = ambienteSelected.copy();
              Navigator.pushNamed(context, 'nuevo ambiente');
              print(ambienteSelected.name);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _AmbienteDetails extends StatelessWidget {
  final String name;

  const _AmbienteDetails(this.name);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Container(
        width: 160,
        height: 40,
        decoration: _buildBoxDecorationDetails(),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecorationDetails() => const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      );
}

class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage(this.url);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: url == null
            ? const Image(
                image: AssetImage('assets/no-image.png'),
                fit: BoxFit.cover,
              )
            : FadeInImage(
                placeholder: const AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(url!),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
