import 'package:flutter/material.dart';
import 'package:flutter_custom_view_transition/widgets/transition_page.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation animation;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = CurvedAnimation(
      curve: Interval(0.0, 1.0),
      parent: controller,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _screens = <Widget>[
    Scaffold(backgroundColor: Colors.red),
    Scaffold(backgroundColor: Colors.blue),
    Scaffold(backgroundColor: Colors.yellow),
    Scaffold(backgroundColor: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          TransitionPage(
            onPageChange: (page) {
              print('${page.color}');
            },
            children: _screens,
            animation: animation,
          )
        ],
      ),
    );
  }
}
