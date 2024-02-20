import 'package:flash_chat/components/progress_loading.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flash_chat/services/authservice.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontoller = TextEditingController();
  final TextEditingController _passwordcontoller = TextEditingController();
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  bool isloading = false,iserror = false;
  String errormassage = "";

  @override
  void dispose() {
    // TODO: implement dispose
    _emailcontoller.dispose();
    _passwordcontoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressLoading(
        isloading: isloading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'Logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              Form(
                key: _keyform,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: KTextfielddecoration.copyWith(
                        hintText: 'Enter your email',
                        labelText: 'Email'
                      ),
                      controller: _emailcontoller,
                      onChanged: (value) {
                        //Do something with the user input
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (valu){
                        if(valu != null && EmailValidator.validate(valu)){
                          return null;
                        }
                        return  'Plrase enter valid email';
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: KTextfielddecoration.copyWith(
                        hintText: 'Enter your password',
                        labelText: "Password",
                      ),
                      controller: _passwordcontoller,
                      onChanged: (value) {
                        //Do something with the user input
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (valu){
                        if(valu != null && valu.length > 6){
                          return null;
                        }
                        return  'Password must be more than 6 characters';
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),Visibility(
                visible: iserror,
                child: Text(
                  errormassage,
                  style: const TextStyle(color:  Color.fromARGB(255, 180, 44, 41),fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CustomeElevatedButton(
                  text: 'Log In',
                  color: kLoginButtonColor,
                  onpressd: ()async{
                      if(_keyform.currentState!.validate()){
                        try{
                          setState(() {
                            isloading = true;
                            iserror = false;
                          });
                          await AuthService().signInUserWithPassword(
                            email: _emailcontoller.text,
                            password: _passwordcontoller.text
                          ).then((value) {
                            Navigator.pop(context);
                            Navigator.popAndPushNamed(context,"Chat");
                          });
                          setState(() {
                            isloading = false;
                          });  
                        }on AuthException catch(e){
                          setState(() {
                            isloading = false;
                            iserror = true;
                            print(e.toString());
                            errormassage = e.message;
                          });
                        }
                      }else{
                        setState(() { 
                        iserror = true;        
                        errormassage = "Please complete the form correctly ";                      
                        });
                      }
                    }
                ),
              ),
              const SizedBox(height: 12),
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
