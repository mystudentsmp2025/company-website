import 'package:flutter/material.dart';
import 'package:company_website/ui/theme/app_theme.dart';
import 'package:company_website/ui/sections/hero_section.dart';
import 'package:company_website/ui/sections/products_section.dart';
import 'package:company_website/ui/sections/roadmap_section.dart';
import 'package:company_website/ui/sections/contact_section.dart';
import 'package:company_website/ui/pages/pricing_page.dart'; // Added import
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _productsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor.withOpacity(0.8),
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: isMobile ? 0 : 20),
          child: InkWell(
            onTap: () {
              if (_scrollController.hasClients) {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOutCubic,
                );
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg', // SVG Logo
                  height: isMobile ? 32 : 40,
                ),
                const SizedBox(width: 12),
                if (!isMobile) // Hide text on very small screens or just shrink it? keeping it for brand but maybe smaller
                  Text(
                    'Prism Matrix',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )
                else 
                   Text(
                    'Prism Matrix',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Smaller font on mobile
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
        actions: [
          if (!isMobile) _NavBarItem(title: 'Products', onTap: () => _scrollTo(_productsKey)),
          _NavBarItem(title: 'Pricing', onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PricingPage()),
            );
            if (result == 'contact') {
              // Wait for frame to ensure page is settled (though usually immediate logic works)
              // Just call scroll directly as we are back on this page
              _scrollTo(_contactKey);
            }
          }),
          _NavBarItem(title: 'Contact', onTap: () => _scrollTo(_contactKey)),
          SizedBox(width: isMobile ? 20 : 40),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(onCtaPressed: () => _scrollTo(_productsKey)),
            SizedBox(key: _productsKey, height: 80),
            const ProductsSection(),
            const SizedBox(height: 100),
            const RoadmapSection(),
            SizedBox(key: _contactKey, height: 100),
            const ContactSection(),
            const SizedBox(height: 100),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      color: Colors.black,
      width: double.infinity,
      child: Center(
        child: Text(
          '© 2026 Prism Matrix. All rights reserved.',
          style: GoogleFonts.inter(color: Colors.white38),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
