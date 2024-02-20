import 'package:flash_chat/components/massage_model.dart';
import 'package:flash_chat/components/massage_view_model.dart';
import 'package:flash_chat/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Implement logout functionality
              AuthService().signOut();
              Navigator.popAndPushNamed(context, "/");
              }),
        ],
        title: const Text('⚡ ️Chat'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FutureBuilder(
              future: AuthService().getdatastream,
              builder: (context,snapshot){
                if(snapshot.hasData){
                  Iterable _itrable = snapshot.data;
                  print(_itrable);
                  var list = _itrable.map((e) => Massage.fromjson(e)).toList();                  
                  return Expanded(
                    child: ListView.builder(
                      itemCount: _itrable.length,
                      reverse: true,
                      itemBuilder:(context,index){
                        return MassageView(
                          massage: list[index],
                          isme: AuthService().getuser!.email == list[index].sender
                        );
                      } 
                    ),
                  );
                }else if(snapshot.hasError){
                  return Center(
                    child: Text("Error :${snapshot.error}"),
                  );
                }else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality
                      setState(() {
                        AuthService().sendData(text: _controller.text);
                      });
                      _controller.clear();
                    },
                    child: const Icon(Icons.send,
                        size: 30, color: kSendButtonColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
