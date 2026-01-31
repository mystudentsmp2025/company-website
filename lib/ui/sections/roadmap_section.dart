import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:company_website/ui/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class RoadmapSection extends StatelessWidget {
  const RoadmapSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Future Roadmap',
            style: AppTheme.darkTheme.textTheme.displayMedium,
          ).animate().fadeIn(),
          const SizedBox(height: 16),
          Text(
            'Innovating for tomorrow. Here is what we are building next.',
            style: AppTheme.darkTheme.textTheme.bodyMedium,
          ).animate().fadeIn(),
          const SizedBox(height: 60),
          
          isMobile
              ? Column(
                  children: [
                    _buildCard('Transportation App', 'Smart fleet management and tracking.', Icons.directions_bus, 0),
                    const SizedBox(height: 20),
                    _buildCard('Expense Splitter', 'Seamlessly share costs with friends.', Icons.attach_money, 1),
                    const SizedBox(height: 20),
                    _buildCard('Auto-Industry App', 'Next-gen automotive solutions.', Icons.directions_car, 2),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: _buildCard('Transportation App', 'Smart fleet management and tracking.', Icons.directions_bus, 0)),
                    const SizedBox(width: 30),
                    Expanded(child: _buildCard('Expense Splitter', 'Seamlessly share costs with friends.', Icons.attach_money, 1)),
                    const SizedBox(width: 30),
                    Expanded(child: _buildCard('Auto-Industry App', 'Next-gen automotive solutions.', Icons.directions_car, 2)),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String description, IconData icon, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.02),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppTheme.primaryColor, size: 30),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: GoogleFonts.inter(color: Colors.white54, height: 1.5),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.accentColor.withOpacity(0.5)),
                ),
                child: Text(
                  'Coming Soon',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (200 * index).ms).slideY(begin: 0.2, end: 0);
  }
}
