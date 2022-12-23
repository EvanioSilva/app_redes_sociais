import 'usuario.dart';

class PostModel {
  int? id;
  String? texto;
  int? idUsuario;
  String? data;
  String? imagem;
  Usuario? usuarioPost;

  PostModel(
      {this.id,
        this.texto,
        this.idUsuario,
        this.data,
        this.imagem,
        this.usuarioPost});

  PostModel.fromJson(Map<String, dynamic> json) {
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
}
