// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'package:flutter/material.dart';

import '../../util/context_shortcut.dart';

// Light theme
const Color PRIMARY_COLOR_L0 = Color(0xFF157bdf); // Denim
const Color PRIMARY_COLOR_L1 = Color(0xFF3d91e3); // Picton Blue
const Color PRIMARY_COLOR_L2 = Color(0xFF46aaff); // Dodger Blue
const Color SURFACE_COLOR_L0 = Color(0xFFFFFFFF); // White
const Color SURFACE_COLOR_L1 = Color(0xFF333333); // Dark grey
const Color SURFACE_DIM_COLOR_L = Color.fromARGB(255, 240, 240, 240); // Mercury
const Color TEXT_COLOR_L = Color(0xFF333333); // Dark grey

// Dark theme
const Color PRIMARY_COLOR_D0 = Color(0xFF1a5fa3); // Fun Blue
const Color PRIMARY_COLOR_D1 = Color(0xFF235385); // Bay of Many
const Color PRIMARY_COLOR_D2 = Color(0xFF15467a); // Chathams Blue
const Color SURFACE_COLOR_D0 = Color(0xFF3f3f3f); // Mine Shaft
const Color SURFACE_COLOR_D1 = Color(0xFFFFFFFF); // White
const Color SURFACE_DIM_COLOR_D = Color(0xFF5b5b5b); // Scorpion
const Color TEXT_COLOR_D = Color(0xFFFFFFFF); // White

// Neutral
const Color SECONDARY_COLOR_V0 = Color(0xFFf20505); // Red
const Color SECONDARY_COLOR_V1 = Color(0xFFECC440); // Gold
const Color SECONDARY_COLOR_V2 = Color(0xFFFFFA8A); // Gold Light
const Color SECONDARY_COLOR_V3 = Color.fromARGB(255, 170, 20, 220); // Dark Purplish
const Color SECONDARY_COLOR_V4 = Color.fromARGB(255, 210, 10, 255); // Light Purplish

// Gradients
Gradient kGradientV0(BuildContext context) => LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [kColor(context).surface.withAlpha(200), PRIMARY_COLOR_L1.withAlpha(220), SECONDARY_COLOR_V0],
    );
