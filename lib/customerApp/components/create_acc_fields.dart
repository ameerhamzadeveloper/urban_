import 'package:flutter/material.dart';

class CreateAccField extends StatelessWidget {
  CreateAccField(this.fieldName,this.hintText,this.onchanged,this.validator);
  final String fieldName;
  final String hintText;
  final FormFieldValidator<String> validator;
  final TextEditingController onchanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(fieldName),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: TextFormField(
                validator: validator,
                controller: onchanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                ),
              ),
            ),
          ],
        ),
        Divider(
          thickness: 2,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
