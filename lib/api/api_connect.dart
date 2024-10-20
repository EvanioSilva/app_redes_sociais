import 'package:app_redes_sociais/models/post_model.dart';
import 'package:app_redes_sociais/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiConnect extends GetConnect{

  /// url default da api
  String defaultUrl = 'http://pray4ever.net/curso';

  /// Método Autenticação Usuário
  Future<Usuario?> autenticar (String login, String senha) async {
    var usuario = null;

    Map body = {"login": login, "senha": senha};

    String url = '$defaultUrl/usuario/autenticar';

    Response response = await post(url, body,
    ).catchError(
          (error) {
        print(error);
      },
    );

    // Resultado OK
    if (response.status.code == 200) {
      usuario = Usuario.fromJson(response.body);
    }

    return usuario;
  }

  /// Método Listar Posts
  Future<List<Post>> listarPosts (int id) async {
    String url = '$defaultUrl/posts/listar/${id}';
    List<Post> lista = [];

    Response response = await get(url).catchError(
          (error) {},
    );

    // OK
    if (response.status.code == 200) {
      lista.addAll((response.body as List)
          .map((item) => Post.fromJson(item))
          .toList());
    }

    return lista;
  }

  /// Método Adicionar Post
  Future<Post?> addPost (Post postAdd) async {
    String url = '$defaultUrl/post/add';
    Post? postOut;

    Map body = postAdd.toJson();

    Response response = await post(url, body,
    ).catchError(
          (error) {
        print(error);
      },
    );

    // Resultado OK
    if (response.status.code == 200) {
      postOut = Post.fromJson(response.body);
    }

    // Finalmente
    return postOut;

  }

}