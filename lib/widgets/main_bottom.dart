import 'package:flutter/material.dart';

class MainBottom extends StatelessWidget {
  MainBottom({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 114, 7, 133),
        ),
      ),
    );
  }
}
