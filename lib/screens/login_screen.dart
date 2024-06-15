import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../routes/app_routes.dart';

class UserLoginInfo {
  String username = '';
  String password = '';
  String dropdownValue = 'instituciones';
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final UserLoginInfo _userInfo = UserLoginInfo();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      final Map<String, dynamic> data = {
        'User': _userInfo.username,
        'Password': _userInfo.password,
        'option': _userInfo.dropdownValue,
      };

      final response = await http.post(
        Uri.parse('https://www.php.engenius.com.co/DatabaseIE.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String loginStatus = responseData['login'];
        List<dynamic> arrayData = responseData['data'] as List<dynamic>;
        if (mounted && loginStatus == 'Fail') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error en la solicitud'),
                content: const Text('Ingrese las credenciales correctas'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cerrar'),
                  ),
                ],
              );
            },
          );
        }else if(loginStatus == 'Success') {
          if (mounted) {
            Navigator.pushNamed(
                context, AppRoutes.municipalities,
                arguments: {
                  'arrayData': arrayData,
                  'user': data['User'],
                  'password': data['Password'],
                });
          }
        }
      } else {
        // Aquí puedes manejar errores, por ejemplo, mostrar un diálogo de error
        print('Error en la solicitud: ${response.statusCode}');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children:[
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Usuario',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa un usuario';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userInfo.username = value!;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa una contraseña';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userInfo.password = value!;
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _userInfo.dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            _userInfo.dropdownValue = newValue!;
                          });
                        },
                        items: <String>[
                          'Seleccionar',
                          'instituciones',
                          'institucion',
                          'municipios'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(value)),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          border: InputBorder.none,
                        ),
                        onSaved: (value) {
                          _userInfo.dropdownValue = value!;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: _isLoading
                            ?
                        const SizedBox (
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              strokeWidth: 1,
                            )
                        )   : const Text(
                          'Iniciar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
          )
      ),
    );
  }
}
