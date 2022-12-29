import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetalhesPostPage extends StatelessWidget {

  final String? titulo;
  final String? imagem;

  const DetalhesPostPage({Key? key, this.titulo, this.imagem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes do Post'),),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child:
          Center(
            child: Column(
              children: [
                Text(this.titulo!),
                SizedBox(
                  height: 20,
                ),
                SvgPicture.network(imagem!,
                  height: 200, width: 200,
                ),
              ],
            ),
          ),
      ),
    );
  }
}
