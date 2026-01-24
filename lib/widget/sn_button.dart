import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subnet_arch/widget/sn_text.dart';

class SnButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const SnButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.surface,
          elevation: 4,
          shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.surface,
                letterSpacing:0.5,
              ),
            ),
            const SizedBox(width: 8),
            Icon(icon, color: Theme.of(context).colorScheme.surface, size: 24),
          ],
        ),
      ),
    );
  }
}

class SnTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SnTextButton(this.text, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        spacing: 4,
        children: [
          Text(
            text,
            style: GoogleFonts.afacad(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Icon(
            Icons.open_in_new,
            color: Theme.of(context).colorScheme.secondary,
            size: 16,
          ),
        ],
      ),
    );
  }
}
