import 'package:app_redes_sociais/controllers/main_controller.dart';
import 'package:app_redes_sociais/models/post_model.dart';
import 'package:app_redes_sociais/posts/add_post_page.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'detalhes_post.dart';

class PostsPage extends StatelessWidget {

  MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      initState: (state) => {
        // Listar todos os posts
        controller.listarPosts(0)
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
                      Post post = controller.posts[index];
                      return ListTile(
                        title: Text(post.texto!),
                        trailing: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            Get.to(DetalhesPostPage(
                                titulo: post.texto!,
                                imagem : post.imagem!,
                            ));
                            post.usuarioPost!.notificacoes = post.usuarioPost!.notificacoes! -1;
                            controller.update();
                          },
                        ),
                        leading: Badge(
                          showBadge: post.usuarioPost!.notificacoes! > 0,
                          badgeContent: Text(post.usuarioPost!.notificacoes!.toString(), style: TextStyle(color: Colors.white),),
                          child: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: SvgPicture.network(post.usuarioPost!.avatar!),
                          ),
                        ),
                      );
                    }

                  ),
                );
              }
          ),

          // FAB
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Get.to(AddPostPage());
            },
          ),
          // Rodapé
        );
      }
    );
  }
}