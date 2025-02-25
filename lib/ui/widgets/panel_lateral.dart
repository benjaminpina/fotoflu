import 'package:flutter/material.dart';
import 'package:fotoflu/controllers/panel_lateral_controller.dart';
import 'package:get/get.dart';

class PanelLateral extends GetView<PanelLateralController> {
  const PanelLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Placeholder(child: const Text('Panel Lateral')),
    );
  }
}
