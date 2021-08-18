import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserRow extends StatelessWidget {
  final size;
  final IconData iconData;
  final String name;
  UserRow({required this.size, required this.name, required this.iconData});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            iconData,
            size: size.width / 22,
            color: Colors.grey,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            name,
            style: GoogleFonts.roboto().copyWith(
              fontSize: size.width / 26,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
