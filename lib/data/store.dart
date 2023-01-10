import 'package:app_redes_sociais/models/post_model.dart';
import 'package:app_redes_sociais/models/usuario_model.dart';
import 'db_service.dart';

class Store {
  /// Instância Servico do BD
  final DBService _dbService = DBService();

  /// Insere um usuário na tabela
  Future<void> insertUsuario(Usuario usuario) async {
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

  /// Busca usuário por id
  Future<Usuario?> findUsuario(int id) async {
    var conn = await _dbService.database;
    var results = await conn.rawQuery(
        'select * from usuario where id = ?',
        [id]
    );

    return results.length > 0 ?
      Usuario.fromMap(results[0]) : null;
  }

  /// Busca post por id
  Future<Post?> findPost(int id) async {
    var conn = await _dbService.database;
    var results = await conn.rawQuery(
        'select * from post where id = ?',
        [id]
    );

    var post = results.length > 0 ?
      Post.fromMap(results[0]) : null;

    if (post != null) {
      post.usuarioPost = await findUsuario(post.idUsuario!);
    }

    return post;
  }

  /// Listar posts
  Future<List<Post>> listPosts() async {
    var conn = await _dbService.database;
    List<Post> lista = [];
    var results = await conn.rawQuery(
      'select * from post order by data desc',
    );

    lista = List.generate(
      results.length,
          (i) {
        return Post.fromMap(results[i]);
      },
    );

    // Seta instância do usuário para cada post
    await Future.forEach(lista, (Post post) async =>
      post.usuarioPost = await findUsuario(post.idUsuario!)
    );
    // Finalmente retorna a lista
    return lista;
  }
}