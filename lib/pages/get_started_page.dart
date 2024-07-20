import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:flutter/material.dart';


class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});
  static String id = 'GetStartedPage';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 16),
                 child: Text(
                      'Get Started...',
                      style: TextStyle(fontSize: 25),
                    ),
               ),
             
          
          
          CircleAvatar(
                  radius: 120, // Adjust the radius as needed
                  backgroundImage: AssetImage('assets/images/1.png'),
                ),
          
          
          
          
          
          
               
               
              SizedBox(height: size.height*.08,),
              Container(
                child: Column(
                  children: [
                    CustomButton(
                        buttonName: 'Login',
                        txtcolor: Colors.white,
                        color: Colors.lightBlueAccent,
                        width: size.width * .4,
                        onTap: () {
                          Navigator.pushNamed(context,LoginPage.id);
                        }),
                    SizedBox(
                      height: size.height * .04,
                    ),
                    CustomButton(
                      buttonName: 'Register',
                      color: Colors.white,
                      width: size.width * .4,
                      border: true,
                      onTap: () {
                         Navigator.pushNamed(context, RegisterPage.id);
                            
                      },
                    ),
                 
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
