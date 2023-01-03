import 'package:app_redes_sociais/api/api_connect.dart';
import 'package:app_redes_sociais/models/post_model.dart';
import 'package:app_redes_sociais/models/usuario_model.dart';
import 'package:app_redes_sociais/posts/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController{
  // Lista de Posts
  List<Post> posts = [];

  Future<void> autenticar(String login, String senha) async {
    Usuario? usuario;

    ApiConnect apiConnect = ApiConnect();
    usuario = await apiConnect.autenticar(login, senha);

    if (usuario == null) {
      Get.snackbar('Erro', 'Falha na autenticação');
    }
    // Tudo OK
    else{
      Get.snackbar('Sucesso', 'Seja bem vindo usuário ${usuario.nome}',
        backgroundColor: Colors.cyanAccent,
      );
      Get.offAll(PostsPage());
    }
  }

  Future<void> listarPosts(int id) async {
    ApiConnect apiConnect = ApiConnect();
    posts = await apiConnect.listarPosts(id);

    // Refresh UI
    update();
  }

}