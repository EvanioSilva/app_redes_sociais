import 'usuario_model.dart';

class Post {
  int? id;
  String? texto;
  int? idUsuario;
  String? data;
  String? imagem;
  Usuario? usuarioPost;

  Post(
      {this.id,
        this.texto,
        this.idUsuario,
        this.data,
        this.imagem,
        this.usuarioPost});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    texto = json['texto'];
    idUsuario = json['idUsuario'];
    data = json['data'];
    imagem = json['imagem'];
    usuarioPost = json['usuarioPost'] != null
        ? new Usuario.fromJson(json['usuarioPost'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['texto'] = this.texto;
    data['idUsuario'] = this.idUsuario;
    data['data'] = this.data;
    data['imagem'] = this.imagem;
    if (this.usuarioPost != null) {
      data['usuarioPost'] = this.usuarioPost!.toJson();
    }
    return data;
  }

  Post.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    texto = map['texto'];
    idUsuario = map['id_usuario'];
    data = map['data'];
    imagem = map['imagem'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['texto'] = this.texto;
    data['id_usuario'] = this.idUsuario;
    data['data'] = this.data;
    data['imagem'] = this.imagem;

    return data;
  }
}


