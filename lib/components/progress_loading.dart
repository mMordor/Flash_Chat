import 'package:flutter/material.dart';

class ProgressLoading extends StatelessWidget {
  const ProgressLoading({super.key,required this.isloading,required this.child});
  final bool isloading ;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child
        ,
        if(isloading)
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.67)
            )
          )
        ,
        
        if(isloading)
          const Center(child: CircularProgressIndicator()),
        
      ],
    );
  }
}