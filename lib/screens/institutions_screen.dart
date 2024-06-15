import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter/routes/app_routes.dart';
import 'dart:convert';

class InstitutionsPage extends StatefulWidget {
  const InstitutionsPage({super.key, required this.title});

  final String title;

  @override
  State<InstitutionsPage> createState() => _InstitutionsPage();
}

class _InstitutionsPage extends State<InstitutionsPage> {

  void _navigateToNextScreen(BuildContext context, dynamic item, String user, String password) async {

    var response = await http.post(
      Uri.parse('https://www.php.engenius.com.co/DatabaseIE.php'),
      body: {
        'User': user,
        'Password': password,
        'option': 'sedes',
        'CodInst': item['dane'],
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> arrayData = responseData['data'] as List<dynamic>;
      if (mounted) {
        Navigator.pushNamed(
            context, AppRoutes.headquarters,
            arguments: {
              'arrayData': arrayData,
              'user': user,
              'password': password,
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final List<dynamic> data = args?['arrayData'] as List<dynamic>;
    final String user = args?['user'] as String;
    final String password = args?['password'] as String;
    List<Widget> itemList = data.map((item) {
      return GestureDetector(
        onTap: () {
          _navigateToNextScreen(context, item, user, password);
        },
        child: ListTile(
          title: Text('Nombre: ${item['nombre']}'),
          subtitle: Text('Dane: ${item['dane']}'),
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
