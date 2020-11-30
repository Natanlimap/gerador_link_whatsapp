import 'dart:html';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController numeroDeCelular = TextEditingController();
  TextEditingController mensagem = TextEditingController();
  gerarLink() {
    return "https://api.whatsapp.com/send?phone=" +
        numeroDeCelular.text +
        "&text=" +
        converterMensagem();
  }

  converterMensagem() {
    String mensagemConvertida;
    mensagemConvertida = mensagem.text.replaceAll(" ", "%20");
    return mensagemConvertida;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
            child: Container(
          width: size.width * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: numeroDeCelular,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: "Digite o numero de telefone"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: mensagem,
                minLines: 4,
                maxLines: 4,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: "Digite a sua mensagem"),
              ),
              SizedBox(height: 20),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                color: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  "Gerar link",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  FlutterClipboard.copy(gerarLink())
                      .then((value) => print("copiei"));
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "SEU LINK FOI GERADO, COLAR ONDE DESEJAR",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        )));
  }
}
