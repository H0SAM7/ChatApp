import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
 CustomTextField({super.key,required this.label,required this.hint,this.onchage,this.hide=false});
  final String label;
  final String hint;
  final bool hide;

  Function(String)? onchage;
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
          child: TextFormField(
            
            showCursor: true,
            obscureText: hide,
            
            validator: (data){
              if(data!.isEmpty){
                return 'Field is required';
                
              }
              
            },
            onChanged: onchage,
          style: TextStyle(color:Colors.white),
           decoration: InputDecoration( 
           
            label: Text(label,style: TextStyle(color: Colors.white),),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:BorderSide(color:  Colors.blue),),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
           )
           
          ),
        );
  }
}