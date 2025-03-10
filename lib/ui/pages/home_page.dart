import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fotoflu/controllers/home_controller.dart';
import 'package:fotoflu/controllers/panel_lateral_controller.dart';
import 'package:fotoflu/ui/widgets/galeria.dart';
import 'package:fotoflu/ui/widgets/panel_inferior.dart';
import 'package:fotoflu/ui/widgets/panel_lateral.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  final panelLateralController = Get.find<PanelLateralController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Row(
            children: [
              const Text('FotoFlu'),
              SizedBox(width: 20),
              Text(
                panelLateralController.dir.value,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(child: Galeria()),
                SizedBox(height: 100, child: PanelInferior()),
              ],
            ),
          ),
          SizedBox(width: 300, height: double.infinity, child: PanelLateral()),
        ],
      ),
    );
  }
}
