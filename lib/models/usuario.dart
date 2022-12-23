class Usuario {
  int? id;
  Null? login;
  Null? senha;
  String? nome;
  String? avatar;

  Usuario({this.id, this.login, this.senha, this.nome, this.avatar});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    senha = json['senha'];
    nome = json['nome'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['senha'] = this.senha;
    data['nome'] = this.nome;
    data['avatar'] = this.avatar;
    return data;
  }
}
