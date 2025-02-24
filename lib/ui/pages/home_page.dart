import 'package:flutter/material.dart';
import 'package:fotoflu/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FotoFlu')),
      body: Placeholder(),
    );
  }
}
