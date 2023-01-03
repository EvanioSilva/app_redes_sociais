import 'package:app_redes_sociais/data/database.dart';

class Store {

  Future<dynamic> findUsuario(int id) async {
    var conn = await database.db;
    var results = await conn.rawQuery(
      'select * from usuario where id = ?',
      [id]
    );

    return results.length > 0 ? results[0] : [];
  }

  Future<dynamic> listPosts() async {
    var conn = await database.db;
    var results = await conn.rawQuery(
      'select * from post order by data desc',
    );

    return results;
  }


}