import 'package:app_redes_sociais/api/api_local_mock.dart';
import 'package:app_redes_sociais/models/post_model.dart';
import 'package:app_redes_sociais/models/usuario_model.dart';
import 'package:get/get.dart';

class ApiConnect extends GetConnect{

  /// url default da api (HelioHost)
  String defaultUrl = 'https://visiontisolucoes.helioho.st/curso';

  /// Método Autenticação Usuário
  Future<Usuario?> autenticar (String login, String senha) async {
    // Plano B: API local de teste (ver api_local_mock.dart)
    if (apiTesteLocal) return ApiLocalMock.autenticar(login, senha);

    var usuario = null;

    Map body = {"login": login, "senha": senha};

    String url = '$defaultUrl/usuario/autenticar.php';

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
    // Plano B: API local de teste (ver api_local_mock.dart)
    if (apiTesteLocal) return ApiLocalMock.listarPosts(id);

    String url = '$defaultUrl/posts/listar.php?id=$id';
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
    // Plano B: API local de teste (ver api_local_mock.dart)
    if (apiTesteLocal) return ApiLocalMock.addPost(postAdd);

    String url = '$defaultUrl/post/add.php';
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

    return postOut;
  }

}