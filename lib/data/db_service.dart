import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DBService {
  // Padrão Singleton
  static final DBService _databaseService = DBService._internal();
  factory DBService() => _databaseService;
  DBService._internal();

  // Instância do BD
  static Database? _database;

  // Controle da versão do BD
  static int versaoBD = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Inicializa  DB primeira vez que for acessado
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Seta o caminho do BD
    final caminho = await getDatabasesPath() + "/rede_social.db";

    // Abre o DB permitindo scripts de criação/atualização das tabelas
    return await openDatabase(caminho, onCreate: _onCreate,
      onUpgrade: _onUpgrade, version: versaoBD);
  }

  /// Script de criação das tabelas
  FutureOr<void> _onCreate(Database db, int version) {
    // usuário
    db.execute(
      'CREATE TABLE usuario(id INTEGER PRIMARY KEY, login TEXT, senha TEXT, '
          'nome TEXT, avatar TEXT, notificacoes INTEGER)',
    );
    // post
    db.execute(
      'CREATE TABLE post(id INTEGER PRIMARY KEY, texto TEXT, id_usuario INTEGER, '
          'data TEXT, imagem TEXT)',
    );
  }

  /// Script de atualização das tabelas
  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
  }

}
