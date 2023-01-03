import 'package:sqflite/sqflite.dart';

class database {
  static int versao = 1;
  static late Database db;

  static void initializeDB() async {
    String caminho = await getDatabasesPath() + "/rede_social.db";

    var db = await openDatabase(caminho, version: versao);

    var existeTabela = await db.rawQuery("SELECT 1 FROM sqlite_master WHERE type='table' AND name='usuario'");
    if (existeTabela.length > 0) {
      // usuário
      db.execute(
        'CREATE TABLE usuario(id INTEGER PRIMARY KEY, login TEXT, senha TEXT, '
            'nome TEXT, avatar TEXT, notificacoes INTEGER)',
      );
    }
    existeTabela = await db.rawQuery("SELECT 1 FROM sqlite_master WHERE type='table' AND name='post'");
    if (existeTabela.length > 0) {
      // posts
      db.execute(
        'CREATE TABLE post(id INTEGER PRIMARY KEY, texto TEXT, id_usuario_post INTEGER, '
            'data TEXT, imagem TEXT)',
      );
    }
  }
}