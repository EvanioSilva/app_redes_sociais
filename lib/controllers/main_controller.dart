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

    List<Post> postsApi = [];

    // Api
    if (await conexaoWebOK()) {
      ApiConnect apiConnect = ApiConnect();
      postsApi = await apiConnect.listarPosts(id);
    }

    // BD
    var store = Store();
    await Future.forEach(postsApi, (Post post) async {
      // Insere Usuário se n existir
      if (await store.findUsuario(post.idUsuario!) == null)
        await store.insertUsuario(post.usuarioPost!);

      // Insere Post se n existir
      if (await store.findPost(post.id!) == null)
        await store.insertPost(post);
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