import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/authservice.dart';

class Redirector extends StatefulWidget {
  const Redirector({super.key});

  @override
  State<Redirector> createState() => _RedirectorState();
}

class _RedirectorState extends State<Redirector> {
  User? _user ; 
   @override
  void initState() {
    super.initState();
    _redirect();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    AuthService().dispose();
    super.dispose();
  }

  void _redirect() async {
    setState(() {
      _user = AuthService().getuser;
    });

    AuthService().getauthstream.listen((event) {
      setState(() {
      _user = event.session?.user;
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _user == null ? WelcomeScreen():ChatScreen();
  }

}