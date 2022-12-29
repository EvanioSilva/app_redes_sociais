class UsuarioModel {
  int? id;
  String? login;
  String? senha;
  String? nome;
  String? avatar;
  int notificacoes = 1;

  UsuarioModel({this.id, this.login, this.senha, this.nome, this.avatar});

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    senha = json['senha'];
    nome = json['nome'];
    avatar = json['avatar'];
    notificacoes = json['notificacoes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['senha'] = this.senha;
    data['nome'] = this.nome;
    data['avatar'] = this.avatar;
    data['notificacoes'] = this.notificacoes;
    return data;
  }
}
