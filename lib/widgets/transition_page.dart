import 'package:flutter/material.dart';

class PageCore {
  final double radius;
  final Color color;

  PageCore({
    this.radius = 10.0,
    this.color = Colors.blue,
  });

  PageCore copy({
    required double radius,
    required Color color,
  }) =>
      PageCore(
        radius: radius,
        color: color,
      );

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

typedef OnPageChange = void Function(PageCore core);

class TransitionPage extends StatefulWidget {
  final List<Widget> children;
  final OnPageChange onPageChange;
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
  PageCore state = PageCore();
  void setColor(Color color) {
    final newState = state.copy(
      color: color,
      radius: state.radius,
    );
    setState(() => state = newState);
  }

  @override
  Widget build(BuildContext context) => TransitionSate(
        child: TransitionPageView(
          animation: widget.animation,
        ),
        stateWidget: this,
        state: state,
      );
}

class TransitionPageView extends AnimatedWidget {
  final Widget? child;
  final Animation animation;

  TransitionPageView({
    Key? key,
    this.child,
    required this.animation,
  }) : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    final provider = TransitionSate.of(context);
    return GestureDetector(
      onTap: () {
        provider.setColor(Colors.red);
      },
      child: Container(
        color: provider.state.color,
      ),
    );
  }
}
