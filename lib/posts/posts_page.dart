import 'package:app_redes_sociais/controllers/main_controller.dart';
import 'package:app_redes_sociais/models/post.dart';
import 'package:app_redes_sociais/models/usuario.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'detalhes_post.dart';

class PostsPage extends StatelessWidget {

  MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(

      initState: (state) {
        // Inicialização
        controller.onPageBuilder();
      },

      builder: (context) {
        return Scaffold(
          // Cabeçalho
          appBar: AppBar(
              title:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/feliz.svg',
                    color: Colors.white,
                  ),
                  Text('App de Redes Socias'),
                ],
              )

          ),

          // Corpo
          body: GetBuilder<MainController>(
              builder: (context) {
                return Container(
                  child: ListView.builder(
                    itemCount: controller.posts.length,
                    itemBuilder: (context, index) {
                      PostModel post = controller.posts[index];
                      UsuarioModel usuario = post.usuarioPost!;
                      return ListTile(
                        title: Text(post.texto!),
                        trailing: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            Get.to(DetalhesPostPage(
                                titulo: post.texto!,
                                imagem: post.imagem,
                            ));
                            usuario.notificacoes --;
                            controller.update();
                          },
                        ),
                        leading: Badge(
                          showBadge: usuario.notificacoes > 0,
                          badgeContent: Text(usuario.notificacoes.toString(),
                            style: TextStyle(color: Colors.white),),
                          child: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: SvgPicture.network(usuario.avatar!),
                          ),
                        ),
                      );
                    })
                );
              }
          ),
        );
      }
    );
  }
}