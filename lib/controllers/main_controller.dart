import 'package:app_redes_sociais/api/api_connect.dart';
import 'package:app_redes_sociais/data/db_service.dart';
import 'package:app_redes_sociais/data/store.dart';
import 'package:app_redes_sociais/models/post_model.dart';
import 'package:app_redes_sociais/models/usuario_model.dart';
import 'package:app_redes_sociais/posts/posts_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class MainController extends GetxController{
  /// A referência ao objeto de da conexão com o banco de dados
  late Database database;

  /// Lista de Posts
  List<Post> posts = [];

  @override
  void onInit() async {
    // inicializa o BD
    database = await DBService().database;

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

    List<Post> auxPosts = [];

    // Api
    if (await conexaoWebOK()) {
      ApiConnect apiConnect = ApiConnect();
      auxPosts = await apiConnect.listarPosts(id);
    }

    // BD
    var store = Store();
    await Future.forEach(auxPosts, (Post post) {
      // Insere Post se n existir
      if (store.findPost(post.id!) == null)
        store.insertPost(post);

      // Insere Usuário se n existir
      if (store.findUsuario(post.idUsuario!) == null)
        store.insertUsuario(post.usuarioPost!);
      }

    );

    // Buscar do BD
    posts = await store.listPosts();

    // Refresh UI
    update();
  }

  /// Verifica se existe conexâo com a internet
  Future<bool> conexaoWebOK() async {
    var result = await Connectivity().checkConnectivity();

    return result != ConnectivityResult.none;
  }

}