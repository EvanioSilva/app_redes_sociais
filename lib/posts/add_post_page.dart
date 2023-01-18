import 'package:app_redes_sociais/controllers/main_controller.dart';
import 'package:app_redes_sociais/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddPostPage extends StatelessWidget {

  MainController controller = Get.find();
  Post post = Post();

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
      padding: EdgeInsets.all(20),
      child: Form(
        key: controller.formKeyAddPost,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Texto: '
              ),
              onChanged: (value) => post.texto = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Favor informar texto';
                }
              }
            ),
            SizedBox(height: 40),
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
      onPressed: () {
        controller.addPost(post);
      },

      child: Text('Salvar',
        style: TextStyle(color: Colors.white),
      ),
      height: 50,
      minWidth: Get.width,
    );
  }
}
