import 'package:flutter/material.dart';
import 'package:flutterjumantik/src/resource.dart';
import 'package:flutterjumantik/view/home/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class FinishScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                'Berhasil',
                style: GoogleFonts.roboto(
                    fontSize: 26.0,
                    color: mainGreen,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Laporan pemantauan jentik Anda telah\nterkirim',
                style: GoogleFonts.roboto(
                    fontSize: 14.0, color: black, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Container(
            child: Image.asset('images/finish.png'),
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen())),
            child: Container(
              child: Text(
                'KEMBALI KE HALAMAN UTAMA',
                style: GoogleFonts.roboto(
                    fontSize: 18.0,
                    color: mainOrange,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
