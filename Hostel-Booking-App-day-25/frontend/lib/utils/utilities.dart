import 'package:flutter/material.dart';

int createUniqueId()
{
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}