import 'package:app_redes_sociais/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {

  String login = '';
  String senha = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'),),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                login = value;
              },
              decoration: InputDecoration(
                labelText: 'Login'
              ),
            ),
            TextFormField(
              onChanged: (value) {
                senha = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha'
              ),
            ),
          ],
        )
      ),
      bottomSheet: MaterialButton(
        onPressed: () {
          MainController controller = Get.find();
          controller.autenticar(login, senha);
        },
        color: Colors.blue,
        height: 50,
        minWidth: 400,
        child: Text('Login',
            style: TextStyle(color: Colors.white),
          ),
      ),
    );

  }
}
