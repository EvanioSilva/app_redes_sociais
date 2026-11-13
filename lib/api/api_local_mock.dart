import 'package:app_redes_sociais/models/post_model.dart';
import 'package:app_redes_sociais/models/usuario_model.dart';

/// ============================================================
///  CAIXA PRETA: API LOCAL DE TESTE (PLANO B)
/// ============================================================
///
///  Quando [apiTesteLocal] for `true`, o [ApiConnect] NAO acessa a
///  internet: ele devolve os dados deste arquivo (em memoria).
///
///  Para DESATIVAR e voltar a usar a API real, basta trocar para `false`.
///
///  Este arquivo e totalmente isolado: so o ApiConnect o utiliza, e para
///  remover o plano B do projeto basta apagar este arquivo e os 3 `if
///  (apiTesteLocal)` do ApiConnect.
///
///  Credenciais de teste:  login: teste   senha: 123
const bool apiTesteLocal = false;

class ApiLocalMock {
  ApiLocalMock._();

  /// Credenciais aceitas pela API local
  static const String loginTeste = 'teste';
  static const String senhaTeste = '123';

  /// Simula a demora da rede (permite ver o isWaiting funcionando)
  static const Duration _latencia = Duration(milliseconds: 700);

  /// Imagens locais (assets do app). Nao precisam de internet.
  static const String _pasta = 'assets/images';
  static const String _avatarTeste = '$_pasta/rosto-jovem.svg';
  static const String _avatarAna = '$_pasta/rosto-mulher.svg';
  static const String _avatarBruno = '$_pasta/rosto-homem.svg';

  static const List<String> _imagensPosts = [
    '$_pasta/praia.svg',
    '$_pasta/camisa.svg',
    '$_pasta/insta.svg',
    '$_pasta/feliz.svg',
  ];

  /// Escolhe uma imagem de post de forma alternada pelo id
  static String _imagem(int idPost) =>
      _imagensPosts[idPost % _imagensPosts.length];

  // ---------------------------------------------------------
  // Dados em memoria
  // ---------------------------------------------------------

  static final List<Usuario> _usuarios = [
    Usuario(
        id: 1,
        login: loginTeste,
        senha: senhaTeste,
        nome: 'Teste',
        avatar: _avatarTeste,
        notificacoes: 3),
    Usuario(
        id: 2,
        login: 'ana',
        senha: '123',
        nome: 'Ana',
        avatar: _avatarAna,
        notificacoes: 2),
    Usuario(
        id: 3,
        login: 'bruno',
        senha: '123',
        nome: 'Bruno',
        avatar: _avatarBruno,
        notificacoes: 0),
  ];

  static final List<Post> _posts = [
    _novoPost(1, 'Primeiro dia de treinamento de Flutter!', 1,
        '2026-11-12 08:00'),
    _novoPost(2, 'Hoje a praia estava linda.', 2, '2026-11-12 08:30'),
    _novoPost(3, 'Aprendendo GetX com o pessoal.', 3, '2026-11-12 09:00'),
    _novoPost(4, 'Quem mais gosta de Dart?', 2, '2026-11-12 09:30'),
    _novoPost(5, 'SQLite funcionando offline, que legal!', 1,
        '2026-11-12 10:00'),
  ];

  static Post _novoPost(int id, String texto, int idUsuario, String data) {
    return Post(
      id: id,
      texto: texto,
      idUsuario: idUsuario,
      data: data,
      imagem: _imagem(id),
      usuarioPost: _buscarUsuario(idUsuario),
    );
  }

  static Usuario _buscarUsuario(int id) =>
      _usuarios.firstWhere((u) => u.id == id);

  /// Devolve uma copia (via JSON), como se tivesse vindo da rede
  static Usuario _copiaUsuario(Usuario u) => Usuario.fromJson(u.toJson());

  static Post _copiaPost(Post p) => Post.fromJson(p.toJson());

  // ---------------------------------------------------------
  // Metodos equivalentes aos da API real
  // ---------------------------------------------------------

  /// Equivalente a POST /usuario/autenticar
  /// Devolve `null` quando login/senha estao incorretos.
  static Future<Usuario?> autenticar(String login, String senha) async {
    print('[apiTesteLocal] autenticar($login) -> API LOCAL, sem rede');
    await Future.delayed(_latencia);

    for (final usuario in _usuarios) {
      if (usuario.login == login && usuario.senha == senha) {
        return _copiaUsuario(usuario);
      }
    }
    return null;
  }

  /// Equivalente a GET /posts/listar/{id}
  /// id == 0 lista todos os posts; senao, apenas os do usuario informado.
  static Future<List<Post>> listarPosts(int id) async {
    print('[apiTesteLocal] listarPosts($id) -> API LOCAL, sem rede');
    await Future.delayed(_latencia);

    return _posts
        .where((p) => id == 0 || p.idUsuario == id)
        .map(_copiaPost)
        .toList();
  }

  /// Equivalente a POST /post/add
  /// O post e criado em nome do usuario de teste (id 1).
  static Future<Post?> addPost(Post postAdd) async {
    print('[apiTesteLocal] addPost -> API LOCAL, sem rede');
    await Future.delayed(_latencia);

    final int novoId =
        _posts.fold<int>(0, (maior, p) => p.id! > maior ? p.id! : maior) + 1;

    final int idUsuario = postAdd.idUsuario ?? 1;

    final Post novo = _novoPost(
      novoId,
      postAdd.texto ?? '',
      idUsuario,
      _agora(),
    );

    _posts.add(novo);
    return _copiaPost(novo);
  }

  /// Data atual no formato yyyy-MM-dd HH:mm (ordena corretamente como texto)
  static String _agora() {
    final d = DateTime.now();
    String dois(int n) => n.toString().padLeft(2, '0');
    return '${d.year}-${dois(d.month)}-${dois(d.day)} '
        '${dois(d.hour)}:${dois(d.minute)}';
  }
}
