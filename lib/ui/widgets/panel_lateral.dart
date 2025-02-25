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
      child: Placeholder(
        child: const Column(
          children: [
            Expanded(child: _Directorio()),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: _Selecciones(),
            ),
            SizedBox(width: double.infinity, height: 200, child: _Acciones()),
            SizedBox(width: double.infinity, height: 100, child: _Botones()),
          ],
        ),
      ),
    );
  }
}

class _Botones extends StatelessWidget {
  const _Botones();

  @override
  Widget build(BuildContext context) {
    return Placeholder(child: Text('Botones'));
  }
}

class _Acciones extends StatelessWidget {
  const _Acciones();

  @override
  Widget build(BuildContext context) {
    return Placeholder(child: Text('Acciones'));
  }
}

class _Selecciones extends StatelessWidget {
  const _Selecciones();

  @override
  Widget build(BuildContext context) {
    return Placeholder(child: Text('Selecciones'));
  }
}

class _Directorio extends StatelessWidget {
  const _Directorio();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Placeholder(child: Text('Directorio')),
    );
  }
}
