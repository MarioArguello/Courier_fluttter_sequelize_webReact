import 'package:flutter/material.dart';
import 'package:simple_crud/login_registro/registro.dart';
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var user;
var passw;

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  TextEditingController UsernameLogin = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController PasswordLogin = new TextEditingController();
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    this.obtenerPreferencias();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'courier_logo',
      child: CircleAvatar(
        backgroundColor: Colors.amber,
        radius: 60.0,
        child: Image.asset('assets/delivery-courier.png'),
      ),
    );
    final email = Form(
      key: _formKey2,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Username',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.black,
          ),
        ),
        controller: UsernameLogin,
        validator: (value) {
          if (value.isEmpty) {
            return 'Por favor ingrese cedula';
          }
          return null;
        },
      ),
    );
    final password = Form(
      key: _formKey,
      child: TextFormField(
        obscureText: true,
        style: TextStyle(
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black,
          ),
          hintText: 'Ingrese contraseña',
        ),
        controller: PasswordLogin,
        enabled: !isLoggedIn,
        validator: (value) {
          if (value.isEmpty) {
            return 'Por favor ingrese Contraseña';
          }
          return null;
        },
      ),
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if (_formKey.currentState.validate() &&
              _formKey2.currentState.validate()) {
            print("Password :" +
                PasswordLogin.text +
                " username :" +
                UsernameLogin.text);
            user = UsernameLogin.text;
            passw = PasswordLogin.text;
            login_api(user, passw);
          } else {
            print("ingrese datos");
          }
          // Navigator.of(context).pushNamed('/home');
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final registroButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(RegistroPage.tag);
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
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            registroButton
          ],
        ),
      ),
    );
  }

  login_api(user, passw) async {
    var url =
        Uri.parse('http://192.168.68.101:3000/usuario/login/$user/$passw');
    print(url);
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var isUser = jsonResponse['msg'];

      var id = jsonResponse['id_person'];

      if (isUser == '1') {
        this.guardarPreferencias(user, passw, id);
        print("Login correcto " + id.toString());
        Fluttertoast.showToast(
            msg: "Login correcto " + user,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
        Navigator.pushReplacementNamed(context, '/home',
            arguments: {'idusuario': id});
        /* Navigator.pushReplacementNamed(context, '/restaurante', arguments: {
          'idusuario': id
        });*/
        UsernameLogin.clear();
        PasswordLogin.clear();
      } else {
        print("Revise su usuario y contrasena");
        Fluttertoast.showToast(
            msg: "Revise su usuario y contrasena",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
        UsernameLogin.clear();
        PasswordLogin.clear();
      }
    } else {
      print('Falla al conectar al API REST: ${response.statusCode}.');
    }
  }

  void guardarPreferencias(username, password, idusuario_preferencia) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("username2", username);
    preferences.setString("password", password);
    preferences.setInt("id_usuariopref", idusuario_preferencia);
    preferences.setBool("session", true);
  }

  String username2 = '';
  String password2 = '';
  int idusuario_2;

  Future obtenerPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username2 = preferences.getString("username2") ?? "";
      password2 = preferences.getString("passw") ?? "";
      idusuario_2 = preferences.getInt("id_usuariopref") ?? 0;
      bool session = preferences.get("session");
      if (session == true) {
        /*  Navigator.of(context).pushNamedAndRemoveUntil(
          '/MemberPage', (Route<dynamic> route) => false);*/
        setState(() {
          user = username2;
          passw = password2;
        });
        Navigator.pushReplacementNamed(context, '/home',
            arguments: {'idusuario': idusuario_2});
        /*Navigator.pushReplacementNamed(context, '/restaurante', arguments: {
          'idusuario': idusuario_2,
        });*/
        print("Usuario logeado" +
            username2 +
            " Id usuario" +
            idusuario_2.toString());
      } else {
        print("Usuario sin login");
      }
    });
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    UsernameLogin.dispose();
    PasswordLogin.dispose();
  }
}
