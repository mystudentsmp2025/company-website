import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:company_website/ui/theme/app_theme.dart';
import 'package:company_website/core/services/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _countryCodeController = TextEditingController(text: '+91'); // Default
  final _messageController = TextEditingController();
  bool _isSubmitting = false;
  bool _submitted = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      await SupabaseService.submitLead(
        name: _nameController.text,
        email: _emailController.text,
        message: _messageController.text,
        mobile: '${_countryCodeController.text} ${_mobileController.text}',
      );

      if (mounted) {
        setState(() {
          _submitted = true;
          _isSubmitting = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Message sent successfully!'),
            backgroundColor: AppTheme.accentColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100, vertical: 100),
      child: isMobile
          ? Column(children: [_buildText(), const SizedBox(height: 40), _buildForm()])
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildText()),
                const SizedBox(width: 80),
                Expanded(child: _buildForm()),
              ],
            ),
    );
  }

  Widget _buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get in Touch',
          style: AppTheme.darkTheme.textTheme.displayMedium,
        ).animate().fadeIn(),
        const SizedBox(height: 20),
        Text(
          'Have a project in mind? Let’s build something extraordinary together. Reach out for inquiries, partnerships, or just to say hello.',
          style: AppTheme.darkTheme.textTheme.bodyLarge,
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 40),
        _buildContactInfo(Icons.email_outlined, 'hello@prismmatrix.co'),
        const SizedBox(height: 16),
        _buildContactInfo(Icons.location_on_outlined, 'San Francisco, CA'),
      ],
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.accentColor),
        const SizedBox(width: 16),
        Text(
          text,
          style: GoogleFonts.inter(fontSize: 16, color: Colors.white70),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildForm() {
    if (_submitted) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle_outline, size: 80, color: AppTheme.accentColor)
                  .animate().scale(),
              const SizedBox(height: 20),
              Text(
                'Thank You!',
                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                'We will get back to you shortly.',
                style: GoogleFonts.inter(color: Colors.white70),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction, // Enable live feedback
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Your Name'),
              style: const TextStyle(color: Colors.white),
              validator: (v) => v?.isEmpty ?? true ? 'Name is required' : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: 'Email Address'),
              style: const TextStyle(color: Colors.white),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email is required';
                final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                if (!emailRegex.hasMatch(v)) return 'Enter a valid email address';
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    controller: _countryCodeController,
                    decoration: const InputDecoration(hintText: '+1'),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _mobileController,
                    decoration: const InputDecoration(
                      hintText: 'Mobile Number',
                      counterText: "", // Hide the default counter
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (v) {
                       if (v == null || v.isEmpty) return 'Mobile is required';
                       if (v.length != 10) return 'Enter a valid 10-digit number';
                       return null;
                     },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: const InputDecoration(hintText: 'Tell us about your project'),
              style: const TextStyle(color: Colors.white),
              validator: (v) => v?.isEmpty ?? true ? 'Message is required' : null,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Send Message'),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0);
  }
}
