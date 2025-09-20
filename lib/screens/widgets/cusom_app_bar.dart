import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CusomAppBar extends StatelessWidget {
  const CusomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/blackLogo.png',
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 5),
        Text(
          'News Snap',
          style: GoogleFonts.raleway(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color(0xffe1e2e1),
          ),
        ),
        Spacer(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.transparent,
            child: IconButton(
              onPressed: () {
                //this to open the drawer whereever its placed 
                //the paramter is endDrawer so it will open the end drawer
                //the enddrawer must be defined in the scaffold
                Scaffold.of(context).openEndDrawer();
              },
              icon: Image.asset('assets/images/settings_logo.png'),
            ),
          ),
        ),
      ],
    );
  }
}
