import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) onChanged;
  final VoidCallback onTap;

  const CustomTextField({Key key, this.onChanged, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
        ),
        suffixIcon: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: onTap,
          child: Icon(
            Icons.close,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            width: 1,
            color: greyColor,
          ),
        ),
        isDense: true,
      ),
    );
  }
}
