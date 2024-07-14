import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key,this.onTap,required this.buttonName,});
  final String buttonName;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return  
        Container(
          width: double.infinity,
          //color: Colors.white,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextButton(
            onPressed: onTap,
            child: Text(buttonName,),
          ),
        )
        ;
  }
}