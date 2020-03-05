import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'generated/i18n.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading;

  bool _showPassword;

  final _loginIdController = TextEditingController();
  final _passwordController = TextEditingController();

  var _errorMessage = '';

  // cached widgets
  final _appBar = AppBar(title: const Text('Flight Logbook'));

  @override
  void initState() {
    super.initState();

    _isLoading = false;
    _showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final List form = <Widget>[
      const SizedBox(height: 24.0),
      Text(_errorMessage,
          style: const TextStyle(color: Colors.red),),
      const SizedBox(height: 24.0),
      TextFormField(
          controller: _loginIdController,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: s.loginIdLabel,
          )),
      const SizedBox(height: 24.0),
      TextFormField(
        controller: _passwordController,
        obscureText: !_showPassword,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: s.passwordLabel,
        ),
      ),
    ];

    form.addAll(<Widget>[
      const SizedBox(height: 24.0),
      CheckboxListTile(
          value: _showPassword,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (newValue) {
            setState(() {
              _showPassword = newValue;
            });
          },
          title: Text(s.showPassword)),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            child: Text(s.login),
            onPressed: () async {
              setState(() {
                _errorMessage = '';
              });
              await _withProgress(() async {
                try {
//                  final authResult = await fbAuth.signInWithEmailAndPassword(
//                      email: _loginIdController.value.text,
//                      password: _passwordController.value.text);
//                  final result =
//                  await authResult.user.getIdToken(refresh: true);
//                  await onLoggedIn(context, authResult.user, result.token);
                } on PlatformException catch (e) {
                  setState(() {
//                    _errorMessage = getAuthErrorMessage(e, s);
                  });
//                  debugPrint(getAuthErrorMessage(e, s));
                } catch (e) {
                  setState(() {
                    _errorMessage = "エラー: ${e.toString()}";
                  });
                  debugPrint(e.toString());
                }
              });
            },
          ),
        ],
      ),
    ]);

    return Scaffold(
      appBar: _appBar,
      body: Stack(children: <Widget>[
        Form(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: form,
            ),
          ),
        ),
        const Center(child: CircularProgressIndicator()),
      ],),);
  }

  Future<void> _withProgress(Function func) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await func();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
