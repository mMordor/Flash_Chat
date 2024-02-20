import 'package:flash_chat/components/massage_model.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class MassageView extends StatelessWidget {
  const MassageView({super.key,required this.massage,required this.isme});
  final Massage massage;
  final bool isme;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  const EdgeInsets.all(8.0),
      child:  Align(
        alignment: isme ? Alignment.centerRight : Alignment.centerLeft,
        child: Material(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isme ? KBubbleradius : 0),
            topRight: const Radius.circular(KBubbleradius),
            bottomLeft: const Radius.circular(KBubbleradius),
            bottomRight: Radius.circular(isme ? 0 : KBubbleradius)
          ),
          color: isme ? Colors.blue : Colors.blueGrey[700],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
            child: Column(
              crossAxisAlignment: isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(massage.sender,style: const TextStyle(fontSize: 12,color: kChatEmailColor),),
                Text(massage.text,style: const TextStyle(fontSize: 16),),
              ],
            ),
        ),
        ),
      ),
    );
  }
}