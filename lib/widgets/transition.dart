import 'package:flutter/material.dart';

enum TransitionType {
  /// [TransitionType]
  SlideTransition,
  ShaderTransition,
  none,
}

abstract class TransitionDelegate {
  /// [TransitionDelegate]
  TransitionDelegate();
  int get pageCount;

  /// [Widget]
  Widget buildTransition(
      BuildContext context, int index, Animation animation, Tween tween);
}

typedef TransitionPageBuilder = Widget Function(
    BuildContext context, int index, Animation animation, Tween tween);

class TransitionBuilderDelegate extends TransitionDelegate {
  final TransitionPageBuilder builder;

  TransitionBuilderDelegate({
    @required this.builder,
    @required this.pageCount,
  }) : assert(pageCount > 0);

  @override
  Widget buildTransition(
          BuildContext context, int index, Animation animation, Tween tween) =>
      builder(context, index, animation, tween);

  ///[pageCount]
  @override
  final int pageCount;
}

class TransitionPageListDelegate extends TransitionDelegate {
  TransitionPageListDelegate({
    @required this.children,
  });

  /// [children]
  final List<Widget> children;
  @override
  Widget buildTransition(
          BuildContext context, int index, Animation animation, Tween tween) =>
      children[index];

  @override
  int get pageCount => children.length ?? 0;
}
