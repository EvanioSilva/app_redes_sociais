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
  // Lista de Posts
  List<Post> posts = [];

  /// A referência ao objeto da conexão com o banco de dados
  Database? database;

  /// Instância Key do Form AddPostPage
  var frmKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    // inicializa o BD
    database = await DBService().database;
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

    // Aux Api
    List<Post> postsApi = [];

    // Api
    if (await conexaoWebOK()) {
      ApiConnect apiConnect = ApiConnect();
      postsApi = await apiConnect.listarPosts(id);
    }

    // Store BD
    var store = Store();
    await Future.forEach(postsApi, (Post post) async {
      // Insere Usuário se n existir
      if (await store.findUsuario(post.idUsuario!) == null)
        await store.insertUsuario(post.usuarioPost!);

      // Insere Post se n existir
      if (await store.findPost(post.id!) == null)
        await store.insertPost(post);

    });

    // Buscar lista de post do BD
    posts = await store.listPosts();

    // Refresh UI
    update();
  }

  /// Verifica se existe conexâo com a internet
  Future<bool> conexaoWebOK() async {
    var result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  /// Adicionad Post
  Future<void> addPost(Post post) async {
    Post? postOut;

    // Validar Campos
    if (!frmKey.currentState!.validate()) {
      return;
    }

    ApiConnect apiConnect = ApiConnect();
    postOut = await apiConnect.addPost(post);

    if (postOut == null) {
      Get.snackbar('Erro', 'Falha adicionando Post');
    }
    else { //Tudo OK
      // armazenar no BD :  Store BD
      var store = Store();

      await store.insertPost(postOut);

      Get.snackbar('Sucesso', 'Post adicionado com sucesso',
        backgroundColor: Colors.cyanAccent,
      );

      Get.offAll(PostsPage());

    }

  }
}