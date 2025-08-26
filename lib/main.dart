import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'pages/portfolio_page.dart';
import 'providers/theme_provider.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Muhammad Adeel · Flutter Developer',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.buildTheme(Brightness.light,
                textTheme: GoogleFonts.poppinsTextTheme()),
            darkTheme: AppTheme.buildTheme(Brightness.dark,
                textTheme: GoogleFonts.poppinsTextTheme()),
            themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const PortfolioPage(),
          );
        },
      ),
    );
  }
}
