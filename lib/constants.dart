import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);
const drawerBackground = Color(0xFF212332);
const hoverColor = Color(0xFFfe9f42);

const defaultPadding = 16.0;
const defaultDrawerHeadHeight = 20.0;


// SIDE BAR SVG IMAGE
const DASHBOARD_SVG = "assets/icons/menu_dashboard.svg";



//firebase firestore
var firestore = FirebaseFirestore.instance;

class Constant{
  static const COLLECTION_CATEGORY = "category";
  static const KEY_CATEGORY_ID = "categoryId";
  static const KEY_CATEGORY_NAME = "name";
  static const KEY_CATEGORY_DESC = "desc";

  static const COLLECTION_SALESMAN = "SalesMan";
  static const KEY_SALESMAN_CODE = "code";
  static const KEY_SALESMAN_NAME = "name";
  static const KEY_SALESMAN_PHONE = "phone";
  static const KEY_SALESMAN_ADDRESS = "address";
  static const KEY_SALESMAN_JOIN_DATE = "joinDate";
  static const KEY_SALESMAN_TIMESTAMP = "timestamp";

  static const KEY_STATUS = "status";
}
