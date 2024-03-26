import 'package:flutter/material.dart';

class CustomTextfeild extends StatefulWidget {
  final String? labelText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool isPassword;

  const CustomTextfeild(
      {super.key,
      this.labelText,
      this.prefixIcon = Icons.email,
      this.keyboardType,
      this.isPassword = false});

  @override
  State<CustomTextfeild> createState() => _CustomTextfeildState();
}

class _CustomTextfeildState extends State<CustomTextfeild> {
  bool isObscure = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: TextFormField(
        obscureText: isObscure,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF009963), width: 2),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Color(0xFFAFA8A8),
          ),
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    isObscure = !isObscure;
                    setState(() {});
                  },
                  icon:
                      Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                )
              : null,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
