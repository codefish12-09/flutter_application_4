// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
class SecondPage extends StatefulWidget{
  const SecondPage({Key?key}):super(key:key);
  @override
  State<SecondPage> createState()=> _SecondPageState();
}
class _SecondPageState extends State<SecondPage> with TickerProviderStateMixin{
  int _count = 0;

   @override
   Widget build(BuildContext context) {
     return Scaffold(
      appBar:AppBar(title: Text('counter cartoon'),),
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
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Text("counter cartoon",
              textAlign: TextAlign.left,
              style: TextStyle(
              color: Colors.white,
              fontSize:30,
              height: 2,  
              fontFamily: "Courier",
              background: Paint()..color=Color.fromARGB(255, 217, 120, 152),
              decoration:TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed
            ),
            ),
           AnimatedSwitcher(
             duration: const Duration(milliseconds: 500),
             transitionBuilder: (Widget child, Animation<double> animation) {
               //执行缩放动画
               return ScaleTransition(child: child, scale: animation);
             },
             child: Text(
               '$_count',
               //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
               key: ValueKey<int>(_count),
               style: Theme.of(context).textTheme.headline4,
             ),
           ),
           ElevatedButton(
            style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 50),),
             child: const Text('+1',),
             onPressed: () {
               setState(() {
                 _count += 1;
               });
             },
           ),
           
         ],
       ),
     ));
   }
 }
