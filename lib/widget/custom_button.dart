import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key,this.onTap,required this.buttonName,this.color,this.txtcolor,this.width,this.border=false});
  final String buttonName;
  VoidCallback? onTap;
  Color? color;
  Color? txtcolor;
  double? width;
  bool border;
  @override
  Widget build(BuildContext context) {
    return  
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            
            width:width ?? double.infinity,
            //color: Colors.white,
            decoration: BoxDecoration(
              border:border? Border.all(width: .1):null,
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextButton(
              onPressed: onTap,
              child: Text(buttonName,style: TextStyle(color: txtcolor),),
            ),
          ),
        )
        ;
  }
}