import 'package:app_redes_sociais/main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'),),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Login'
              ),
            ),
            TextFormField(
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
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
            return HomePage();
          }));
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
