import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'cart_counter.dart';

class CounterWithFavBtn extends StatefulWidget {

 Color color;

 CounterWithFavBtn({required this.color});

  @override
  _CounterWithFavBtnState createState() => _CounterWithFavBtnState();
}

class _CounterWithFavBtnState extends State<CounterWithFavBtn> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CartCounter(),
        IconButton(onPressed: (){
          if(widget.color==Colors.red){
            setState(() {
              widget.color==Colors.white;
            });
          }else if(widget.color==Colors.white){
            setState(() {
              widget.color==Colors.red;
            });
          }
        }, icon: Icon(Icons.favorite,color: widget.color,),),
      ],
    );
  }
}