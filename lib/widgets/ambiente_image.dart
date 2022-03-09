import 'package:flutter/material.dart';

class AmbienteImage extends StatelessWidget {
  final String? url;

  const AmbienteImage({
    Key? key,
    this.url,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
      ),
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
    );
  }
}
