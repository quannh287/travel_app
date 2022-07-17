import 'package:flutter/material.dart';
import 'package:meditation/extensions/app_extensions.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({Key? key, required this.landscape, required this.portrait}) : super(key: key);
  final Widget portrait;
  final Widget landscape;

  @override
  Widget build(BuildContext context) {
    return context.orientation == Orientation.portrait ? portrait : landscape;
  }
}
