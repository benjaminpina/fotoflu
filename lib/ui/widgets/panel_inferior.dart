import 'package:flutter/material.dart';
import 'package:fotoflu/controllers/panel_inferior_controller.dart';
import 'package:get/state_manager.dart';

class PanelInferior extends GetView<PanelInferiorController> {
  const PanelInferior({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Placeholder(child: const Text('Panel Inferior')),
    );
  }
}
