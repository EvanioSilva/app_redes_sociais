import 'package:app_redes_sociais/models/post.dart';
import 'package:app_redes_sociais/models/usuario.dart';
import 'package:get/get.dart';

class ApiConnect extends GetConnect {

  /// url default da api
  String defaultUrl = 'https://pray4ever.com/curso';

  Future<Usuario?> autenticar(String login, String senha) async {
    var usuario = null;

    Map body = {"login": login, "senha": senha};

    String url = '$defaultUrl/usuario/autenticar';

    Response response = await post(url, body,
        ).catchError(
      (error) {
        print(error);
      },
    );

    if (response.status.code == 200) {
      usuario = Usuario.fromJson(response.body);
    }

    return usuario;
  }

  Future<List<Post>> listarPosts(int id) async {
    String url = '$defaultUrl/posts/listar/${id}';

    Response response = await get(url).catchError(
      (error) {},
    );

    List<Post> lista = [];
    lista.addAll((response.body as List)
        .map((item) => Post.fromJson(item))
        .toList());

    return lista;
  }
}
