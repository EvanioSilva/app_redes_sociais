import 'package:app_redes_sociais/controllers/main_controller.dart';
import 'package:app_redes_sociais/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddPostPage extends StatelessWidget {
  final Post post = Post();

  MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova postagem'),),

      body: _body(),

      bottomSheet: _botaoSalvar(),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.all(12),
      child: Form(
        key: controller.frmKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Informe o texto ...'
              ),
              onChanged: (value) => post.texto = value,
              validator: (value)  {
                if (value == null || value.isEmpty)
                  return 'Informe o texto ...';
                },
            ),
            SizedBox(height: 20),
            SvgPicture.asset('assets/images/new_post.svg',
              width: 100, height: 100,
            ),

          ],
        ),


      ),

    );
  }

  Widget _botaoSalvar() {
    return MaterialButton(
      color: Colors.blue,
      minWidth: 400,
      height: 50,
      onPressed: () {
        controller.addPost(post);
      },
      child: Text('Salvar',
        style: TextStyle(color: Colors.white),
      ),
    );

  }
}
