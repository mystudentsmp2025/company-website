import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:company_website/ui/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onCtaPressed;

  const HeroSection({super.key, required this.onCtaPressed});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100, vertical: 100),
      constraints: const BoxConstraints(minHeight: 600),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.backgroundColor,
            AppTheme.primaryColor.withOpacity(0.1),
            AppTheme.backgroundColor,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'We Craft Digital\nExperiences.',
            style: isMobile
                ? AppTheme.darkTheme.textTheme.displayMedium
                : AppTheme.darkTheme.textTheme.displayLarge?.copyWith(fontSize: 72),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 24),
          Text(
            'Building the future of school management and beyond.\nSleek. Powerful. Connected.',
            style: AppTheme.darkTheme.textTheme.bodyLarge,
          ).animate().fadeIn(delay: 200.ms, duration: 800.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 48),
          HoverButton(
            onPressed: onCtaPressed,
            text: 'View Products',
          ).animate().fadeIn(delay: 400.ms, duration: 800.ms),
        ],
      ),
    );
  }
}

class HoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const HoverButton({super.key, required this.onPressed, required this.text});

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
          decoration: BoxDecoration(
            color: _isHovering ? AppTheme.accentColor : AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: AppTheme.accentColor.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    )
                  ]
                : [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
          ),
          child: Text(
            widget.text,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
