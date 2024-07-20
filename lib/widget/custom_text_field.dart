import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      required this.label,
      required this.hint,
      this.onchage,
      this.hide = false,
      this.icon,
      this.passicon = false,
      this.onTap});
  final String label;
  final String hint;
  bool hide;
  Icon? icon;
  bool passicon;
  Function(String)? onchage;
  VoidCallback? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: TextFormField(
          showCursor: true,
          obscureText: widget.hide,
          validator: (data) {
            if (data!.isEmpty) {
              return 'Field is required';
            }
          },
          onChanged: widget.onchage,
          style: TextStyle(color: Colors.black),
          cursorColor: Colors.lightBlueAccent,
          decoration: InputDecoration(
            prefixIcon: widget.icon,
            suffixIcon: widget.hide 
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.hide = !widget.hide;
                      });
                    },
                    icon: Icon(Icons.visibility))
                :widget.passicon? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.hide = !widget.hide;
                      });
                    },
                    icon: Icon(Icons.visibility_off)):null,
            label: Text(
              widget.label,
              style: TextStyle(color: Colors.grey),
            ),
            hintText: widget.hint,
            fillColor: Colors.lightBlueAccent,
            hoverColor: Colors.lightBlueAccent,
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.lightBlueAccent), // No border
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.lightBlueAccent), // No border when focused
            ),
          )),
    );
  }
}
