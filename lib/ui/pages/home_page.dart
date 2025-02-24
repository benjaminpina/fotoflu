import 'package:flutter/material.dart';
import 'package:fotoflu/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FotoFlu')),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(child: Placeholder(child: const Text('Galería'))),
                SizedBox(
                  height: 50,
                  child: Placeholder(
                    child: const Text('Controles navegación selección'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 300,
            height: double.infinity,
            child: Placeholder(child: const Text('Controles de flujo')),
          ),
        ],
      ),
    );
  }
}
