import 'package:app_redes_sociais/models/post_model.dart';
import 'package:app_redes_sociais/models/usuario_model.dart';
import 'db_service.dart';

class Store {

  /// Instância Servico do BD
  final DBService _dbService = DBService();

  Future<Usuario?> findUsuario(int id) async {
    var conn = await _dbService.database;
    var results = await conn.rawQuery(
      'select * from usuario where id = ?',
      [id]
    );

    return results.length > 0 ?
      Usuario.fromJson(results[0]) : null;
  }

  Future<List<Post>> listPosts() async {
    List<Post> lista = [];
    var conn = await _dbService.database;
    var results = await conn.rawQuery(
      'select * from post order by data desc',
    );

    lista = List.generate(
      results.length,
          (i) {
        return Post.fromMap(results[i]);
      },
    );

    await Future.forEach(
        lista, (Post post) async =>
      post.usuarioPost = await findUsuario(post.idUsuario!)
    );

    return lista;
  }

  /// Insere um usuário na tabela
  Future<int?> insertUsuario(Usuario usuario) async {
    var conn = await _dbService.database;

    try {
      await conn.insert(
        'usuario',
        usuario.toMap(),
      );
    } catch (e) {
      return null;
    }
  }

  Future<Post?> findPost(int id) async {
    var conn = await _dbService.database;
    var results = await conn.rawQuery(
        'select * from post where id = ?',
        [id]
    );

    return results.length > 0 ? Post.fromJson(results[0]) : null;
  }

  /// Insere um post na tabela
  Future<void> insertPost(Post post) async {
    var conn = await _dbService.database;

    try {
      await conn.insert(
        'post',
        post.toMap(),
      );
    } catch (e) {
      return null;
    }
  }

}