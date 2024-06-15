import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter/routes/app_routes.dart';
import 'dart:convert';

class InfoGroupsPage extends StatefulWidget {
  const InfoGroupsPage({super.key, required this.title});

  final String title;

  @override
  State<InfoGroupsPage> createState() => _InfoGroupsPage();
}

class _InfoGroupsPage extends State<InfoGroupsPage> {

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final List<dynamic> data = args?['arrayData'] as List<dynamic>;
    print(data);
    List<Widget> itemList = data.map((item) {
      return ListTile(
        title: Text('Nombre: ${item['nombre']}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sede: ${item['sede']}'),
            Text('Institución: ${item['institución']}'),
            Text('Municipio: ${item['municipio']}'),
            Text('Número de Grupo: ${item['numGrupo']}'),
            Text('Id: ${item['id']}'),
          ],
        ),
      );
    }).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.9,
          child: ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.only(bottom: 10.0),
                child: Card(
                  elevation: 5,
                  child: itemList[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
