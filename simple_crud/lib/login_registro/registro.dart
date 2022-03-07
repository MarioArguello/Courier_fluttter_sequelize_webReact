import 'package:flutter/material.dart';
import 'package:simple_crud/login_registro/login.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class RegistroPage extends StatefulWidget {
  static String tag = 'Registro-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<RegistroPage> {
  final _formKeypassword = GlobalKey<FormState>();
  final _formKeydni = GlobalKey<FormState>();
  final _formKey2email = GlobalKey<FormState>();
  TextEditingController nombre1 = new TextEditingController();
  TextEditingController apellido1 = new TextEditingController();
  TextEditingController cedula1 = new TextEditingController();
  TextEditingController telefono1 = new TextEditingController();
  TextEditingController email1 = new TextEditingController();
  TextEditingController username1 = new TextEditingController();
  TextEditingController contrasena1 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Nombre = TextFormField(
      controller: nombre1,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Ingrese nombre',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final Apellido = TextFormField(
      controller: apellido1,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Ingrese apellido',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final Cedula = Form(
      key: _formKeydni,
      child: TextFormField(
        controller: cedula1,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Ingrese cedula',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
    final email = Form(
        key: _formKey2email,
        child: TextFormField(
          controller: email1,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Email',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        ));
    final telefono = TextFormField(
      controller: telefono1,
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Telefono',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final username = TextFormField(
      controller: username1,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = Form(
        key: _formKeypassword,
        child: TextFormField(
          controller: contrasena1,
          autofocus: false,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        ));

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Regresar', style: TextStyle(color: Colors.white)),
      ),
    );
    final registroButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          print(username1.text);
          if (_formKey2email.currentState.validate() &&
              _formKeydni.currentState.validate() &&
              _formKeypassword.currentState.validate()) {
            Registro_api(cedula1.text);
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Registro', style: TextStyle(color: Colors.white)),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 20.0),
            Text('Registro persona courier'),
            SizedBox(height: 10.0),
            Text('Nombre'),
            Nombre,
            SizedBox(height: 10.0),
            Text('Apellido'),
            Apellido,
            SizedBox(height: 10.0),
            Text('Telefono'),
            telefono,
            SizedBox(height: 10.0),
            Text('Cedula'),
            Cedula,
            SizedBox(height: 10.0),
            Text('Email'),
            email,
            Text('Username'),
            username,
            SizedBox(height: 10.0),
            Text('Contraseña'),
            password,
            SizedBox(height: 10.0),
            registroButton,
            loginButton,
          ],
        ),
      ),
    );
  }

  Registro_api(dni) async {
    var url = Uri.parse('http://192.168.68.101:3000/usuario/registro/$dni');
    print(url);
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var isUser = jsonResponse['msg'];
      var id = jsonResponse['id_dni'];
      if (id == dni) {
        Fluttertoast.showToast(
            msg: "El usuario ya esta registrado....Error..",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
        username1.clear();
        contrasena1.clear();
        apellido1.clear();
        nombre1.clear();
        telefono1.clear();
        email1.clear();
        cedula1.clear();
      } else {
        var url = Uri.parse('http://192.168.68.101:3000/proceso/create');
        print(url);
        Map data = {
          'idrol': 2,
          'username': username1.text,
          'password': contrasena1.text,
          'estado': "A",
          'nombres': nombre1.text,
          'telefono': telefono1.text,
          'correo': email1.text,
          'dni': cedula1.text,
          'estado': "A"
        };
        var body2 = convert.json.encode(data);
        var response = await http.post(url,
            headers: {"Content-Type": "application/json"}, body: body2);
        //     'codigo': codigoRegistro.text,
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "Registro con exito Felicidades..",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1);
          username1.clear();
          contrasena1.clear();
          apellido1.clear();
          nombre1.clear();
          telefono1.clear();
          email1.clear();
          cedula1.clear();
        } else {
          print('Falla al conectar al API REST: ${response.statusCode}.');
        }
      }
    } else {
      print('Falla al conectar al API REST: ${response.statusCode}.');
    }
  }

  void alertaregistro() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Registro"),
        content: Text("Usuario registrado"),
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(LoginPage.tag);
              },
              child: Text("Ok")),
        ],
      ),
    );
  }
}
