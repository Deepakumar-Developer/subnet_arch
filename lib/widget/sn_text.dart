import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SnTitle extends StatelessWidget {
  final String text;
  const SnTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.afacad(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: Theme.of(context).colorScheme.primary,
        letterSpacing: 1,
      ),
    );
  }
}

class SnSubTitle extends StatelessWidget {
  final String text;
  const SnSubTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.afacad(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.tertiary,
        letterSpacing: -0.5,
      ),
    );
  }
}

class SnBodyText extends StatelessWidget {
  final String text;
  const SnBodyText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.afacad(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}

class SnIP extends StatelessWidget {
  final String text;
  final double size;
  const SnIP(this.text, {super.key, this.size = 14});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.robotoMono(
        fontSize: size,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}


