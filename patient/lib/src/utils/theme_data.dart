import 'package:flutter/material.dart';
import 'package:medi_connect/src/utils/theme.dart';


ThemeData darkTheme=ThemeData.dark().copyWith(
  colorScheme: kDarkColorScheme,
  appBarTheme: ThemeData.dark().appBarTheme.copyWith(
    foregroundColor: kDarkColorScheme.onPrimaryContainer,
    backgroundColor: kDarkColorScheme.primaryContainer,
  ),
  cardTheme: ThemeData.dark().cardTheme.copyWith(
    color: kDarkColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
  ),
  iconTheme: ThemeData.dark().iconTheme.copyWith(
    color: kDarkColorScheme.onPrimaryContainer,
  ),
  dropdownMenuTheme: ThemeData.dark().dropdownMenuTheme.copyWith(
    textStyle: ThemeData.dark().textTheme.bodyMedium,
  ),
);
ThemeData lightTheme=ThemeData().copyWith(
  colorScheme: kColorScheme,
  appBarTheme: ThemeData().appBarTheme.copyWith(
    foregroundColor: kColorScheme.onPrimaryContainer,
    backgroundColor: kColorScheme.primaryContainer,
  ),
  cardTheme: ThemeData().cardTheme.copyWith(
    color: kColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
  ),
  iconTheme: ThemeData().iconTheme.copyWith(
    color: kColorScheme.onPrimaryContainer,
  ),
  dropdownMenuTheme: ThemeData().dropdownMenuTheme.copyWith(
    textStyle: ThemeData().textTheme.bodyMedium,
  ),
);