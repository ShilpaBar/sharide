import 'package:flutter/material.dart';

class CustomTextfeild extends StatefulWidget {
  final String? labelText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? hintText;
  final TextEditingController? textEditingController;
  final bool readOnly;
  final String? Function(String?)? validator;

  const CustomTextfeild(
      {super.key,
      this.labelText,
      this.prefixIcon = Icons.email,
      this.keyboardType,
      this.isPassword = false,
      this.hintText,
      this.textEditingController,
      this.readOnly = false,
      this.validator});

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
      padding: EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        controller: widget.textEditingController,
        obscureText: isObscure,
        readOnly: widget.readOnly,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF009963), width: 2),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Color(0xFFAFA8A8),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 16,
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
