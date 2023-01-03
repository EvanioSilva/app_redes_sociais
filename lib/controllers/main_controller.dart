import 'package:app_redes_sociais/api/api_connect.dart';
import 'package:app_redes_sociais/data/database.dart';
import 'package:app_redes_sociais/data/store.dart';
import 'package:app_redes_sociais/models/post_model.dart';
import 'package:app_redes_sociais/models/usuario_model.dart';
import 'package:app_redes_sociais/posts/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController{
  // Lista de Posts
  List<Post> posts = [];

  @override
  void onInit() {
    // inicializa o BD
    database.initializeDB();

    super.onInit();
  }

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

  /// Acesso BD
  Future<Usuario?> findUsuarioBD(int id) async {
    var store = Store();
    var result = await store.findUsuario(id);

    return result != [] ? Usuario.fromJson(result) : null;
  }

  Future<List<Post>> listaPostsBD() async {
    List<Post> lista = [];

    var store = Store();
    var result = await store.listPosts();

    lista.addAll((result as List)
        .map((item) => Post.fromJson(item))
        .toList());

    return lista;
  }

}