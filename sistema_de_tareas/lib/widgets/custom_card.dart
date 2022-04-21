import 'package:flutter/material.dart';
import 'package:sistema_de_tareas/theme/app_themes.dart';

class CustomCard extends StatelessWidget {
  final Color? color;
  final Color? shadowColor;
  final double? elevation;
  final ShapeBorder? shape;
  final bool borderOnForeground = true;
  final EdgeInsetsGeometry? margin;
  final Clip? clipBehavior;
  final Widget? child;
  final bool semanticContainer = true;

  const CustomCard({
    Key? key,
    this.color,
    this.shadowColor,
    this.elevation,
    this.shape,
    this.margin,
    this.clipBehavior,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppThemes.primary,
      shadowColor: shadowColor,
      elevation: elevation,
      shape: shape,
      margin: margin,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}
