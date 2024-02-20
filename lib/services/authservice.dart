import 'package:supabase_flutter/supabase_flutter.dart';


class AuthService{
  
  final supabase = Supabase.instance.client;

  User? get getuser => supabase.auth.currentUser;
  Stream<AuthState> get getauthstream => supabase.auth.onAuthStateChange;
  Future<dynamic> get getdatastream => supabase.from("messages").select().order("date",ascending: false);

  Future signInUserWithPassword({required String email,required String password}){
    
    return supabase.auth.signInWithPassword(
      email: email,
      password: password
    );
  }

  Future signUpUserWithPassword({required String email,required String password}){
    return supabase.auth.signUp(
      email: email,
      password: password
    );
  }

  Future<void> signOut()async{
    await supabase.auth.signOut(); 
  }

  void sendData({required String text})async{
    await supabase.from('messages').insert(
      {
        'text' :  text,
        'sender' : AuthService().getuser!.email,
        'date' : DateTime.now().millisecondsSinceEpoch
      }
    );
  }

  void dispose(){
    supabase.dispose();
  }
}