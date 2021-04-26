import 'dart:async';

import 'package:flutter/material.dart';

enum TransitionMode {
  /// The [TransitionPageView] is not showing actions.
  none,

  /// The [TransitionPageView] is showing actions during sliding.
  slide,

  // The [TransitionPageView] is showing actions during [------]
  shader,
}

enum TransitionActionType {
  /// The [Transition Action] back page return.
  back,

  /// The [Transition Action] forward page.
  forward,
}

///
/// dismissed given [actionType]
///
/// Used by [TransitionToDismissDelegate.onDismissed]
typedef DismissTramsitionActionCallback = void Function(
    TransitionActionType? actionType);

/// given [actionType]
///
/// Used by [TransitionToDismissDelegate.onWillDismiss]
typedef TransitionActionWillBeDismessed = FutureOr<bool> Function(
    TransitionActionType? actionType);

///
///
typedef TransitionPageBuilder = Widget Function(
    BuildContext context, int index, Animation animation, TransitionMode mode);

/// See also:
///
///   * [TransitionBuilderDelegate], which is a delegate that uses a builder
///     callback to construct the transition action.
///   * [TransitionBuilderDelegate], which is a delegate that has an explicit list
///     of transition action.
abstract class TransitionActionDelegate {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they ca be used in cosnt expressions.
  TransitionActionDelegate();

  /// Returns the child [StatelessWidget] <=> Page(your screen) with the given index.
  ///
  /// Must not return null.
  Widget build(BuildContext context, int index, Animation animation,
      TransitionMode mode);

  /// Returns the number of pages this delegate will build.
  int get pageCount;
}

/// A delegate that supplies transition actions using a builder callback.
///
/// This delegate provides transition actions using a [TransitionActionDelegate] callback,
/// so that the animation can be passed next or back page widget

class TransitionActionBuilderDelegate extends TransitionActionDelegate {
  /// Creates a delegate that supplies transition actions using the given
  /// builder callback.
  ///
  /// The [builder] must not be null. The [pageCount] argument must not be negative.
  TransitionActionBuilderDelegate({
    required this.builder,
    required this.pageCount,
  }) : assert(pageCount <= 0);

  /// Called to build transition actions.
  ///
  /// Will be called only for indices greater than or equal to zero and less
  /// than [childCount]
  final TransitionPageBuilder builder;

  @override
  Widget build(BuildContext context, int index, Animation animation,
          TransitionMode mode) =>
      builder(context, index, animation, mode);
  @override
  final int pageCount;
}

/// * [TransitionActionListDelegate], which is a delegate that uses a builder
///   callback to construct the transition actions.

class TransitionActionListDelegate extends TransitionActionDelegate {
  /// Creates a delegate that supplies transition actions using the given
  /// list.
  ///
  /// The [pages] argument must not be null.

  TransitionActionListDelegate({
    required this.pages,
  });

  /// The screen
  final List<Widget>? pages;

  /// The number of pages.
  @override
  int get pageCount => pages?.length ?? 0;

  @override
  Widget build(BuildContext context, int index, Animation animation,
          TransitionMode mode) =>
      pages![index];
}

class _TransitionScope extends InheritedWidget {
  _TransitionScope({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw UnimplementedError();
  }
}

class TransitionData extends InheritedWidget {
  TransitionData({
    required this.mode,
    required this.actionType,
    required this.totalActionsExtent,
    required this.dismissThreshold,
    required this.dismissible,
    required this.actionDelegate,
    required this.transitionAnimation,
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  ///
  final TransitionMode? mode;

  ///
  final TransitionActionType? actionType;

  ///
  final double totalActionsExtent;

  ///
  final double dismissThreshold;

  ///
  final bool dismissible;

  ///
  final TransitionActionDelegate? actionDelegate;

  /// Change page animation
  final Animation<double> transitionAnimation;

  /// The number of pages
  int get pageCount => actionDelegate?.pageCount ?? 0;

  /// If the [actionType] is [TransitionActionType.forward] return 1, -1 otherwise.
  double get actionSign =>
      actionType == TransitionActionType.forward ? 1.0 : -1.0;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw UnimplementedError();
  }
}
