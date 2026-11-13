import 'package:app_redes_sociais/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetalhesPostPage extends StatelessWidget {

  final Post post;

  const DetalhesPostPage({Key? key, required this.post}) : super(key: key);

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
                Text(post.texto!),
                SizedBox(
                  height: 20,
                ),
                SvgPicture.network(post.imagem!,
                  height: 200, width: 200,
                ),
              ],
            ),
          ),
      ),
    );
  }
}
