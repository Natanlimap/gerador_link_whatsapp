import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerador_link_wpp_web/controller.dart';

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
  FormController formController = FormController();
  String link = "";
  gerarLink() {
    return "https://api.whatsapp.com/send?phone=" +
        formController.telefone +
        "&text=" +
        converterMensagem();
  }

  converterMensagem() {
    String mensagemConvertida;
    mensagemConvertida = formController.mensagem.replaceAll(" ", "%20");
    return mensagemConvertida;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [
      Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 500,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        width: 480,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value) => formController.telefone = value,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  labelText: "Digite o numero de telefone"),
            ),
            SizedBox(height: 20),
            TextFormField(
              onChanged: (value) => formController.mensagem = value,
              minLines: 4,
              maxLines: 4,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: "Digite a sua mensagem"),
            ),
            SizedBox(height: 20),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text(
                "Gerar link",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  link = gerarLink();
                });
                FlutterClipboard.copy(link).then((value) => print(""));
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "SEU LINK FOI GERADO, COPIE E COLE ONDE DESEJAR",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SelectableText(link),
          ],
        ),
      ),

      //CELULAR

      //fundo
      Observer(builder: (_) {
        return Container(
          width: 400,
          height: 800,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.black),
          //TELA
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    width: 380,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              formController.telefone,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    width: 380,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        formController.mensagem,
                      ),
                    ),
                  ),
                ],
              )),
        );
      })
    ];
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blue,
        body: ListView(
          children: [
            size.width > 1000
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: content)
                : Column(children: content)
          ],
        ));
  }
}
