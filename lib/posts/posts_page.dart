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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: ListView.separated(
                      itemCount: controller.posts.length,
                      itemBuilder: (context, index) {
                        Post post = controller.posts[index];
                        return ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(post.texto!,
                                  ),),
                              Expanded(child: Text(post.data!,
                                style: TextStyle(fontSize: 10),)),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              Get.to(DetalhesPostPage(
                                  post: post
                              ));
                              post.usuarioPost!.notificacoes = post.usuarioPost!.notificacoes! -1;
                              controller.update();
                            },
                          ),
                          leading: Column(
                            children: [
                              Badge(
                                showBadge: post.usuarioPost!.notificacoes! > 0,
                                badgeContent: Text(post.usuarioPost!.notificacoes!.toString(), style: TextStyle(color: Colors.white),),
                                child: CircleAvatar(
                                  backgroundColor: Colors.teal,
                                  child: SvgPicture.network(post.usuarioPost!.avatar!),
                                ),
                              ),
                              Text(post.usuarioPost!.nome!)
                            ],
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                    },

                    ),
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