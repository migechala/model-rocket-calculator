import 'package:flutter/material.dart';

class GetInfo extends StatelessWidget {
  const GetInfo({Key? key, required this.controller, required this.hintText})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(top: 10, bottom: 5),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
        ),
        controller: controller,
      ),
    );
  }
}
