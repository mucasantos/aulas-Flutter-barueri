// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController cepController = TextEditingController();
  // int _counter = 0;

  String logradouro = '';
  String bairro = '';
  String localidade = '';
  String estado = '';

  void _incrementCounter() {
    //Renderizar a tela novamente ---> montar a tela novamente
    setState(() {
      //   _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: cepController,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black),
                labelStyle: TextStyle(color: Colors.black),
                labelText: 'CEP',
                filled: true,
                fillColor: Color(0xff321F8A),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                hoverColor: Colors.white,
                suffixIconColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                child: const Text('Consultar Endereço'),
                onPressed: () async {
                  var cepDigitado = cepController.text;

                  var url = Uri.https('viacep.com.br', '/ws/$cepDigitado/json/',
                      {'q': '{http}'});

                  var response = await http.get(url);
                  if (response.statusCode == 200) {
                    var jsonResponse = convert.jsonDecode(response.body)
                        as Map<String, dynamic>;

                    setState(() {
                      logradouro = jsonResponse['logradouro'];
                      bairro = jsonResponse['bairro'];
                      localidade = jsonResponse['localidade'];
                      estado = jsonResponse['uf'];
                    });

                    print(jsonResponse);
                  } else {
                    print(
                        'Request failed with status: ${response.statusCode}.');
                  }
                }),
            Column(children: [
              Text(logradouro),
              Text(bairro),
              Text(localidade),
              Text(estado),
            ])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}


/*
 Atividade M1
 A partir deste código, criar um cadastro de clientes.
  Como?
  
  OS campos: 
  
  Nome: 
  Endereço: --> pegar os dados da API
  Telefone:
  email:
  
  Salvar em um Array/Lista (Classe)
  
  
 * */
