import 'package:flutter/material.dart';

class PageCore {
  final double radius;
  final Color color;

  PageCore({
    this.radius = 10.0,
    this.color = Colors.red,
  });

  @override
  int get hashCode => radius.hashCode ^ color.hashCode;
  @override
  bool operator ==(covariant PageCore other) =>
      radius == other.radius && color == other.color;
}

class TransitionSate extends InheritedWidget {
  final _TransitionPageState stateWidget;
  final PageCore state;
  TransitionSate({
    Key? key,
    required Widget child,
    required this.stateWidget,
    required this.state,
  }) : super(key: key, child: child);

  static _TransitionPageState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TransitionSate>()!.stateWidget;

  @override
  bool updateShouldNotify(covariant TransitionSate oldWidget) =>
      state != oldWidget.state;
}

class TransitionPage extends StatefulWidget {
  final List<Widget> children;
  final Function(int) onPageChange;
  final Animation animation;

  TransitionPage({
    Key? key,
    required this.onPageChange,
    required this.children,
    required this.animation,
  }) : super(key: key);
  @override
  _TransitionPageState createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage> {
  final PageCore state = PageCore();
  @override
  Widget build(BuildContext context) => TransitionSate(
        child: _TransitionPageView(animation: widget.animation),
        stateWidget: this,
        state: state,
      );
}

class _TransitionPageView extends AnimatedWidget {
  final Widget? child;
  final Animation animation;
  _TransitionPageView({
    Key? key,
    this.child,
    required this.animation,
  }) : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) => Container();
}
