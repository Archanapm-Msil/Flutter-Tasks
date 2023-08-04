import 'package:expense_tracker/utils/ColorTheme.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/Widgets/expenses.dart';


void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorTheme.kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
            color:  ColorTheme.kDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor:  ColorTheme.kDarkColorScheme.primaryContainer,
              foregroundColor:  ColorTheme.kDarkColorScheme.onPrimaryContainer),
        ),
      ),
      
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme:  ColorTheme.kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor:  ColorTheme.kColorScheme.onPrimaryContainer,
              foregroundColor:  ColorTheme.kColorScheme.primaryContainer),
          cardTheme: const CardTheme().copyWith(
              color:  ColorTheme.kColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor:  ColorTheme.kColorScheme.primaryContainer)),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:  ColorTheme.kColorScheme.onSecondaryContainer,
                  fontSize: 16))),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
}
