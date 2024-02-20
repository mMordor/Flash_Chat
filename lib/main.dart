import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/splash_screen.dart';
import 'package:flash_chat/services/authservice.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import '/screens/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String url = "https://coxqvurjzlmtcjydxpbj.supabase.co";
  String key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNveHF2dXJqemxtdGNqeWR4cGJqIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTA2NjY1ODksImV4cCI6MjAwNjI0MjU4OX0.FNY0f1OOI2hbmOwFtbkSXC5vcVOodDJ5L0LGik72QDQ";
  await Supabase.initialize(
    url: url,
    anonKey: key
  );
  runApp(FlashChat());

}

class FlashChat extends StatefulWidget {
  FlashChat({super.key});

  @override
  State<FlashChat> createState() => _FlashChatState();
}

class _FlashChatState extends State<FlashChat> {
  @override
  void dispose() {
    // TODO: implement dispose
    AuthService().dispose();
    super.dispose();
    
  }

  
  @override
  Widget build(BuildContext context) {        
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      routes: {
        "/":(context) => const Redirector(),
        "Welcome":(context) => WelcomeScreen(),
        "Login" :(context) => LoginScreen(),
        "Registr" :(context) => RegistrationScreen(),
        "Chat":(context) => ChatScreen()
      },
      initialRoute: "/",
    );
  }
}
