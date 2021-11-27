import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController txtController;
  final IconData txtIcon;
  final String txtText;
  final bool? isObscure;
  final String?Function(String?)? validate;
  final TextInputType? kbdType;
  final bool? maxLines;

  const CustomTextField(
      {Key? key,
      required this.txtController,
      required this.txtIcon,
      required this.txtText,
      this.kbdType,
      this.maxLines,
      this.validate,
      this.isObscure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          margin: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: TextFormField(
              maxLines: maxLines == true ? 1 : null,
              keyboardType: kbdType,
              obscureText: isObscure ?? false,
              controller: txtController,
              validator: validate,
              decoration: InputDecoration(
                  icon: Icon(txtIcon, color: Colors.black),
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: txtText, hintStyle: const TextStyle(color: Colors.black)),
            ),
          ),
        ),
      ],
    );
  }
}
