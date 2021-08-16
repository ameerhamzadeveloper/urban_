import 'package:flutter/material.dart';

class AccSettingsField extends StatelessWidget {
  AccSettingsField(this.fieldName,this.onchanged);
  final String fieldName;
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
              child: TextField(
                controller: onchanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        Divider(
          thickness: 2,
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
