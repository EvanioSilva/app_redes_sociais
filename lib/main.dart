import 'package:app_redes_sociais/posts/detalhes_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Redes Sociais',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        child: ListView(
          children: [
            // Primeiro Item
            ListTile(
              title: Text('Vejam minha nova coleção inverno'),
              trailing: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return DetalhesPostPage(
                        titulo: 'Vejam minha nova coleção inverno',
                        imagem : 'camisa.svg'
                    );
                  }));
                },
              ),
              leading:  CircleAvatar(
                backgroundColor: Colors.teal,
                child: SvgPicture.asset('assets/images/rosto-homem.svg'),
              ),
            ),
            // Segundo Item
            ListTile(
              title: Text('Passeio no final de semana'),
              trailing: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return DetalhesPostPage(
                        titulo: 'Passeio no final de semana',
                        imagem : 'praia.svg'
                    );
                  }));
                },
              ),
              leading:  CircleAvatar(
                backgroundColor: Colors.teal,
                child: SvgPicture.asset('assets/images/rosto-mulher.svg'),
              ),
            ),
            // Terceiro Item
            ListTile(
              title: Text('Siga-nos no insta...'),
              trailing: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return DetalhesPostPage(
                        titulo: 'Siga-nos no insta...',
                        imagem : 'insta.svg'
                    );
                  }));
                },
              ),
              leading:  CircleAvatar(
                backgroundColor: Colors.teal,
                child: SvgPicture.asset('assets/images/rosto-jovem.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

