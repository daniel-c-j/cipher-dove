// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FakePlatform {
  const FakePlatform({
    required this.name,
    required this.route,
    required this.logoUrl,
    required this.logoUrlBg,
    required this.logoUrlBgColor,
    this.status = true,
    this.pinned = false,
  });

  final String name;
  final String route;
  final String logoUrl;
  final String logoUrlBg;
  final Color logoUrlBgColor;
  final bool status;
  final bool pinned;
}
