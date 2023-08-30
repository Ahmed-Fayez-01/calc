import 'package:flutter/material.dart';

Future showExitPopup({
  context,
  required String title,
  required String content,
  required String buttonText1,
  required String buttonText2,
  final void Function()? onPress,
  // required Function onButton1,
})  async{
  return await showDialog(
    context: context,
    builder: (context) => Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title:  Text(title),
        content:  Text(content,style: const TextStyle(
          fontSize: 15,
        ),),
        actions:[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onPress,
                child: Text(buttonText1),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF2B3396)),
                ),
              ),
              const SizedBox(width: 12,),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(buttonText2),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xfffa417a)),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  )??false; //if showDialouge had returned null, then return false
}

