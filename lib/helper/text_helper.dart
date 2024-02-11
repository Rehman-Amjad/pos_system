
import 'package:flutter/material.dart';
import 'package:pos_system/responsive.dart';

class TextHelper{

  Text mNormalText({required text,required color,required size}){
    return Text(
      text,
      style: mNormalTextStyle(color: color,size: size)
    );
  }

  TextStyle mNormalTextStyle({required color,required size}){
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.bold,
    );
  }

}