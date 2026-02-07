import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:company_website/ui/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Text(
            'myStudent',
            style: AppTheme.darkTheme.textTheme.labelLarge?.copyWith(
              color: const Color(0xFF2D8CFF), // Electric Blue
              fontSize: 18,
            ),
          ).animate().fadeIn(),
          const SizedBox(height: 16),
          Text(
            'The Intelligent Core of\nModern Education',
            style: isMobile
                ? AppTheme.darkTheme.textTheme.displayMedium
                : AppTheme.darkTheme.textTheme.displayLarge?.copyWith(
                    fontSize: 56,
                    height: 1.1,
                    letterSpacing: -1.5,
                  ),
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
          const SizedBox(height: 24),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              'Education is complex; managing it shouldn\'t be. myStudent, by Prism Matrix, is an all-in-one ecosystem designed to unify students, parents, teachers, and administrators. Built on a foundation of real-time data and high-performance architecture, it turns school administration into a seamless, digital experience.',
              style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF64748B), // Slate
                fontSize: 18,
                height: 1.6,
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 60),

          // Demo Video
          _buildVideoPlaceholder(),
          
          const SizedBox(height: 80),

          // Feature Highlight Grid
          const FeatureHighlightGrid(),
          
          const SizedBox(height: 80),

          // Download Section
          _buildDownloadSection(isMobile),
        ],
      ),
    );
  }

  Widget _buildDownloadSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C), // Deep Charcoal
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Text(
            'Experience the Future Now',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Download myStudent on your preferred platform.',
            style: GoogleFonts.inter(
              color: const Color(0xFF64748B), // Slate
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildStoreButton('App Store', Icons.apple),
              _buildStoreButton('Play Store', Icons.android),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.qr_code_2, size: 80, color: Colors.black),
          ),
          const SizedBox(height: 16),
          Text(
            'Scan to Download',
            style: GoogleFonts.inter(
              color: Colors.white38,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildStoreButton(String platform, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Text(
            platform,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlaceholder() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2D8CFF).withOpacity(0.2), // Electric Blue glow
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.play_circle_fill, size: 80, color: Colors.white.withOpacity(0.9)),
            Positioned(
              bottom: 20,
              child: Text(
                'Watch Demo',
                style: GoogleFonts.inter(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.95, 0.95));
  }
}

class FeatureHighlightGrid extends StatelessWidget {
  const FeatureHighlightGrid({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;
    
    if (isMobile) {
      return Column(
        children: _buildFeatureCards(true),
      );
    }

    // Desktop: 2-column layout
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch to match heights
            children: [
              Expanded(child: _buildFeatureCard(
                'Integrated Academic Management',
                'Complete oversight of the classroom journey. From automated attendance to digital gradebooks, allowing teachers to focus on teaching.',
                Icons.school_outlined,
                index: 0,
              )),
              const SizedBox(width: 30),
              Expanded(child: _buildFeatureCard(
                'SafeRoute Transport',
                'Intelligence in motion. Live GPS tracking, automated boarding alerts, and route optimization. A total safety net integrated directly into myStudent.',
                Icons.directions_bus,
                index: 1,
                trailing: _LiveStatusIndicator(),
              )),
            ],
          ),
        ),
        const SizedBox(height: 30),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _buildFeatureCard(
                'Unified Parent-School Portal',
                'Bridging the communication gap. Instant push notifications for fee payments, exam results, and bus locations.',
                Icons.connect_without_contact,
                index: 2,
              )),
              const SizedBox(width: 30),
              Expanded(child: _buildFeatureCard(
                'Dedicated Driver Companion',
                'Specialized standalone interface for drivers that syncs instantly with the primary myStudent database.',
                Icons.drive_eta,
                index: 3,
              )),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFeatureCards(bool isMobile) {
    return [
      _buildFeatureCard(
        'Integrated Academic Management',
        'Complete oversight of the classroom journey. From automated attendance to digital gradebooks, allowing teachers to focus on teaching.',
        Icons.school_outlined,
        index: 0,
        marginBottom: 20,
      ),
      _buildFeatureCard(
        'SafeRoute Transport',
        'Intelligence in motion. Live GPS tracking, automated boarding alerts, and route optimization. A total safety net integrated directly into myStudent.',
        Icons.directions_bus,
        index: 1,
        marginBottom: 20,
        trailing: _LiveStatusIndicator(),
      ),
      _buildFeatureCard(
        'Unified Parent-School Portal',
        'Bridging the communication gap. Instant push notifications for fee payments, exam results, and bus locations.',
        Icons.connect_without_contact,
        index: 2,
        marginBottom: 20,
      ),
      _buildFeatureCard(
        'Dedicated Driver Companion',
        'Specialized standalone interface for drivers that syncs instantly with the primary myStudent database.',
        Icons.drive_eta,
        index: 3,
        marginBottom: 20,
      ),
    ];
  }

  Widget _buildFeatureCard(String title, String desc, IconData icon, {required int index, double marginBottom = 0, Widget? trailing}) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C), // Deep Charcoal
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF2D8CFF).withOpacity(0.5), // Electric Blue Border for ALL
          width: 2,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1E1E2C),
            const Color(0xFF2D8CFF).withOpacity(0.1), // Subtle gradient for ALL
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D8CFF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF2D8CFF), size: 32),
              ),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            desc,
            style: GoogleFonts.inter(
              color: const Color(0xFF64748B), // Slate
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (200 * index).ms).slideY(begin: 0.1, end: 0);
  }
}

class _LiveStatusIndicator extends StatefulWidget {
  @override
  State<_LiveStatusIndicator> createState() => _LiveStatusIndicatorState();
}

class _LiveStatusIndicatorState extends State<_LiveStatusIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 1.seconds)..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeTransition(
            opacity: _controller,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'LIVE GPS',
            style: GoogleFonts.inter(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
