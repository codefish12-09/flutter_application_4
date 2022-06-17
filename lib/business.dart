//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
class ThirdPage extends StatefulWidget{
  const ThirdPage({Key?key}):super(key:key);
  @override
  State<ThirdPage> createState()=> _ThirdPageState();
}
class _ThirdPageState extends State<ThirdPage> with TickerProviderStateMixin{
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  _playAnimation() async {
    try {
      //先正向执行动画
      await _controller.forward().orCancel;
      //再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text('jump cartoon'),),
      body:Container(
       width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://gd-hbimg.huaban.com/27a11f1041667d666beeb4222cf1e8d6213e861e1a7575-VsDnkV_fw658/format/webp"),
            fit: BoxFit.cover,
          ),
        ),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => _playAnimation(),
            child: Text("start animation"),
          ),
          Container(
            width: 600.0,
            height: 600.0,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            //调用我们定义的交错动画Widget
            child: StaggerAnimation(controller: _controller),
          ),
        ],
      ),
    ),);
  }
}
class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({
    Key? key,
    required this.controller,
  }) : super(key: key) {
    //高度动画
    height = Tween<double>(
      begin: .0,
      end: 600.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0, 0.6, //间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    color = ColorTween(
      begin: Colors.white,
      end: Colors.white,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0, 0.6, //间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    padding = Tween<EdgeInsets>(
      begin: const EdgeInsets.only(left: .0),
      end: const EdgeInsets.only(left: 100.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.6, 1.0, //间隔，后40%的动画时间
          curve: Curves.ease,
        ),
      ),
    );
  }

  late final Animation<double> controller;
  late final Animation<double> height;
  late final Animation<EdgeInsets> padding;
  late final Animation<Color?> color;

  Widget _buildAnimation(BuildContext context, child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}