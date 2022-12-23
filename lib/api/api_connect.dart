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

    print(url);

    Response response = await post(url, body,
        ).catchError(
      (error) {
        print(error);
      },
    );

    print(response.body.toString());

    if (response.status == 200) {
      usuario = Usuario.fromJson(response.body);
      print(usuario);
    }

    return usuario;
  }

  Future<List<PostModel>> listarPosts(int id) async {
    String url = '$defaultUrl/posts/listar/${id}';
    print(url);

    Response response = await get(url).catchError(
      (error) {},
    );

    List<PostModel> lista = [];
    lista.addAll((response.body as List)
        .map((item) => PostModel.fromJson(item))
        .toList());

    return lista;
  }
}
