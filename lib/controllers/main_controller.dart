import 'package:app_redes_sociais/api/api_connect.dart';
import 'package:app_redes_sociais/models/post.dart';
import 'package:app_redes_sociais/models/usuario.dart';
import 'package:app_redes_sociais/posts/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController{
  int notificacoes = 1;
  List<Post> posts = [];

  Future<void> autenticar(String login, String senha) async {
    Usuario? usuario;

    // Instância Api
    ApiConnect api = ApiConnect();
    usuario = await api.autenticar(login, senha);

    if (usuario == null) {
      Get.snackbar('Erro', 'Falha na autenticação', backgroundColor: Colors.red);
    }
    else {
      // Navega para pág. Principal
      Get.snackbar('Bem vindo', 'Seja bem vindo ${usuario.nome}', backgroundColor: Colors.cyan);
      Get.offAll(PostsPage());
    }
  }

  Future<void> listarPosts(int parametro) async {
    ApiConnect api = ApiConnect();
    posts = await api.listarPosts(parametro);

    if (posts == null) {
      Get.snackbar('Erro', 'Falha na listagem de posts', backgroundColor: Colors.red);
    }
  }

  void onPageBuilder() async {
    await listarPosts(0);
    update();
  }

}