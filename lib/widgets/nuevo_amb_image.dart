import 'package:flutter/material.dart';

class NuevoAmbienteImage extends StatelessWidget {
  final String? url;

  NuevoAmbienteImage(this.url);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: SafeArea(
        child: Container(
          decoration: _buildBoxDecoration(),
          width: double.infinity,
          height: 350,
          child: Opacity(
            opacity: 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              ),
              child: url == null
                  ? Image(
                      image: AssetImage('assets/no-image.png'),
                      fit: BoxFit.cover,
                    )
                  : FadeInImage(
                      image: NetworkImage(url!),
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        // color: Colors.red,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      );
}
