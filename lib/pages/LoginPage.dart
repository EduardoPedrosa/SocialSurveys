import 'package:flutter/material.dart';
import '../services/Auth.dart';

class LoginPage extends StatefulWidget {
  final Auth auth;
  final Function login;

  LoginPage({this.auth, this.login});

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();

  String email;
  String password;
  String name;
  String error;

  bool isLogin; // marca se o formulário é de criar conta ou login
  bool isLoading;

  bool validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    setState(() {
      isLoading = false;
    });
    return false;
  }

  void submitForm() async {
    setState(() {
      error = "";
      isLoading = true;
    });
    if (validateForm()) {
      String userId = "";
      try {
        if (isLogin) {
          userId = await widget.auth.signin(email, password);
        } else {
          userId = await widget.auth.createUser(name, email, password);
        }

        setState(() {
          isLoading = false;
        });

        if (userId.length > 0 && userId != null) {
          widget.login();
        }
      } catch (e) {
        setState(() {
          isLoading = false;
          error = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    error = "";
    isLoading = false;
    isLogin = true;
    super.initState();
  }

  void changeFormType() {
    _formKey.currentState.reset();
    error = "";
    setState(() {
      isLogin = !isLogin;
    });
  }

  Widget showLoadingIndicator() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget showError() {
    if (error.length > 0 && error != null) {
      return new Text(
        error,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 60.0),
      child: new Hero(
        tag: 'SocialSurvey',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: Image(image: AssetImage('assets/icons/survey.png')),
        ),
      ),
    );
  }

  Widget showNameField() {
      return isLogin ? 
        new Container(
          height: 0.0,
          width: 0.0,
        ) :
        new TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.name,
          autofocus: false,
          decoration: new InputDecoration(
              hintText: 'Nome',
              icon: new Icon(
                Icons.person,
                color: Colors.grey,
              )),
          validator: (value) => value.isEmpty ? 'Preencha com seu nome' : null,
          onSaved: (value) => name = value.trim(),
        );
  }

  Widget showEmailField() {
    return new TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: new InputDecoration(
          hintText: 'Email',
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          )),
      validator: (value) => value.isEmpty ? 'Preencha com um E-Mail' : null,
      onSaved: (value) => email = value.trim(),
    );
  }

  Widget showPasswordField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Senha',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Preencha com uma senha' : null,
        onSaved: (value) => password = value.trim(),
      ),
    );
  }

  Widget showSecundaryButton() {
    return new FlatButton(
        child: new Text(
            isLogin ? 'Criar conta' : 'Já possui uma conta? Faça login',
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: changeFormType);
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 1.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(2.0)),
            color: Colors.purple[700],
            child: new Text(isLogin ? 'Fazer Login' : 'Criar conta',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: submitForm,
          ),
        ));
  }

  Widget showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showLogo(),
              showError(),
              showNameField(),
              showEmailField(),
              showPasswordField(),
              showPrimaryButton(),
              showSecundaryButton(),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text('SocialSurveys'),
        ),
        body: Stack(
          children: <Widget>[
            showForm(),
            showLoadingIndicator(),
          ],
        ));
  }
}
