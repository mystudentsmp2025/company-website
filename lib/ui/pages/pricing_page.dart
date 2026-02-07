import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:company_website/ui/theme/app_theme.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text('Pricing', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _PricingHero(),
            SizedBox(height: 60),
            _PricingTable(),
            SizedBox(height: 80),
            _FeatureComparison(),
            SizedBox(height: 80),
            _FAQSection(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _PricingHero extends StatelessWidget {
  const _PricingHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        children: [
          Text(
            "Intelligence, Integrated:\nStart Your Digital Transformation Today.",
            textAlign: TextAlign.center,
            style: AppTheme.darkTheme.textTheme.displayLarge?.copyWith(
              fontSize: 32, // Adjusted for responsiveness
              height: 1.2,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Experience the full power of myStudent with a risk-free 5-month pilot.\nNo credit card required to start.",
            textAlign: TextAlign.center,
            style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.textColor.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop('contact');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: const Text("Apply for Pilot Program"),
          ),
        ],
      ),
    );
  }
}

class _PricingTable extends StatefulWidget {
  const _PricingTable();

  @override
  State<_PricingTable> createState() => _PricingTableState();
}

class _PricingTableState extends State<_PricingTable> {
  int _selectedIndex = 0; // 0: Pilot, 1: Model A, 2: Model B

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Switch to column layout on smaller screens
        if (constraints.maxWidth < 900) {
          return Column(
            children: [
               _PricingCard(
                title: "The Pilot",
                price: "₹0",
                duration: "/ first 5 Months",
                features: const [
                  "Unlimited student/staff records",
                  "All core modules (Finance, Attendance)",
                  "Personalized staff training",
                ],
                isHighlight: _selectedIndex == 0,
                onTap: () => setState(() => _selectedIndex = 0),
                buttonText: "Start Free Pilot",
              ),
              const SizedBox(height: 24),
              _PricingCard(
                title: "Flexible Growth",
                subtitle: "(Model A - PSPM)",
                price: "Custom",
                duration: "₹ / Student / Month",
                features: const [
                  "Pay-as-you-grow model",
                  "Monthly billing based on live counts",
                  "Zero wasted costs during holidays",
                ],
                isHighlight: _selectedIndex == 1,
                onTap: () => setState(() => _selectedIndex = 1),
                buttonText: "Contact Sales",
              ),
              const SizedBox(height: 24),
              _PricingCard(
                title: "Institutional Stability",
                subtitle: "(Model B - Annual)",
                price: "Fixed",
                duration: "Annual Subscription",
                features: const [
                  "Predictable yearly budgets",
                  "Fixed budgets friendly",
                  "Quarterly Payment split available",
                ],
                isHighlight: _selectedIndex == 2,
                onTap: () => setState(() => _selectedIndex = 2),
                buttonText: "Contact Sales",
              ),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _PricingCard(
                  title: "The Pilot",
                  price: "₹0",
                  duration: "/ first 5 Months",
                  features: const [
                    "Unlimited student records",
                    "All core modules",
                    "Personalized training",
                  ],
                  isHighlight: _selectedIndex == 0,
                  onTap: () => setState(() => _selectedIndex = 0),
                  buttonText: "Start Free Pilot",
                ),
              ),
              Expanded(
                child: _PricingCard(
                  title: "Flexible Growth",
                  subtitle: "(Model A - PSPM)",
                  price: "Custom",
                  duration: "₹ / Student / Month",
                  features: const [
                    "Pay-as-you-grow",
                    "Monthly billing",
                    "No holiday costs",
                  ],
                  isHighlight: _selectedIndex == 1,
                  onTap: () => setState(() => _selectedIndex = 1),
                  buttonText: "Contact Sales",
                ),
              ),
              Expanded(
                child: _PricingCard(
                  title: "Institutional Stability",
                  subtitle: "(Model B - Annual)",
                  price: "Fixed",
                  duration: "Annual Subscription",
                  features: const [
                    "Predictable yearly cost",
                    "Quarterly splits",
                    "Budget friendly",
                  ],
                  isHighlight: _selectedIndex == 2,
                  onTap: () => setState(() => _selectedIndex = 2),
                  buttonText: "Contact Sales",
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class _PricingCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String price;
  final String duration;
  final List<String> features;
  final bool isHighlight;
  final String buttonText;
  final VoidCallback onTap; // To handle tap selection

  const _PricingCard({
    required this.title,
    this.subtitle,
    required this.price,
    required this.duration,
    required this.features,
    this.isHighlight = false,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Using GestureDetector for the whole card tap
      onTap: onTap,
      child: AnimatedContainer( // AnimatedContainer for smooth transition
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: isHighlight ? AppTheme.primaryColor.withOpacity(0.1) : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isHighlight ? AppTheme.primaryColor : Colors.white10,
            width: isHighlight ? 2 : 1,
          ),
          boxShadow: isHighlight ? [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ] : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isHighlight)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "SELECTED", // Changed from MOST POPULAR to reflect selection, or keep as popular/selected
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              )
            else
               // Placeholder to prevent layout shift if needed, or just let it shift.
               // For better UX, let's keep height consistent or leave empty
               const SizedBox(height: 38), // Approximation of badge height + margin

            Text(title, style: AppTheme.darkTheme.textTheme.titleLarge),
            if (subtitle != null)
               Text(subtitle!, style: GoogleFonts.inter(fontSize: 14, color: Colors.white54)),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(price, style: GoogleFonts.poppins(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(duration, style: GoogleFonts.inter(fontSize: 14, color: Colors.white70)),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ...features.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: isHighlight ? AppTheme.accentColor : Colors.white24, size: 20),
                      const SizedBox(width: 12),
                      Expanded(child: Text(f, style: GoogleFonts.inter(color: Colors.white70))),
                    ],
                  ),
                )),
            const SizedBox(height: 32),
              SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop('contact');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isHighlight ? AppTheme.primaryColor : Colors.white10,
                  foregroundColor: Colors.white,
                ),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureComparison extends StatelessWidget {
  const _FeatureComparison();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text("What’s Included", style: AppTheme.darkTheme.textTheme.displayMedium),
          const SizedBox(height: 16),
          Text(
            "Everything you need to run a modern educational institution.",
            textAlign: TextAlign.center,
            style: AppTheme.darkTheme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 60),
          // We can use a layout that wraps intelligently
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _FeatureCategory(
                title: "Unified School Management",
                icon: Icons.school_outlined,
                features: [
                  _FeatureItem("Role-Based Dashboards", "Tailored views for Admins, Teachers, Parents."),
                  _FeatureItem("Student Profiles", "Centralized digital records."),
                  _FeatureItem("Staff Directory", "Detailed employee records."),
                  _FeatureItem("Academic Management", "Flexible scheduling & terms."),
                  _FeatureItem("One-Click Promotion", "Seamless grade transitions."),
                  _FeatureItem("Year Rollover", "Clone settings for new years."),
                ],
              ),
              _FeatureCategory(
                title: "Financial Operations",
                icon: Icons.attach_money_outlined,
                features: [
                  _FeatureItem("Smart Fee Management", "Automated tracking & structures."),
                  _FeatureItem("Partial Payments", "Flexible installment support."),
                  _FeatureItem("Digital Receipts", "Instant proofs & audit trails."),
                ],
              ),
              _FeatureCategory(
                title: "Transport & Safety",
                icon: Icons.directions_bus_outlined,
                features: [
                  _FeatureItem("Real-Time Bus Tracking", "Live location map."),
                  _FeatureItem("Proximity Alerts", "Notifications on arrival."),
                ],
              ),
              _FeatureCategory(
                title: "Planning & Schedules",
                icon: Icons.calendar_today_outlined,
                features: [
                  _FeatureItem("Smart Timetable", "Conflict-free scheduling."),
                  _FeatureItem("Event Calendar", "Exams, holidays, and closures."),
                ],
              ),
               _FeatureCategory(
                title: "Communication",
                icon: Icons.chat_bubble_outline,
                features: [
                  _FeatureItem("Global Push Alerts", "Broadcast critical updates."),
                  _FeatureItem("System Notifications", "High visibility alerts."),
                  _FeatureItem("Verified Chat", "Secure professional messaging (Soon)."),
                ],
              ),
              _FeatureCategory(
                title: "Analytics & Insights",
                icon: Icons.insights_outlined,
                features: [
                  _FeatureItem("Detailed Reports", "Attendance, fees, and performance."),
                  _FeatureItem("Auto Attendance", "Digital marking & absence reports."),
                ],
              ),
               _FeatureCategory(
                title: "Security & Access",
                icon: Icons.security_outlined,
                features: [
                  _FeatureItem("Multi-Schema DB", "Enterprise-grade data isolation."),
                  _FeatureItem("RBAC", "Strict role-based editing rights."),
                  _FeatureItem("Device Auth", "Secure session binding."),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureItem {
  final String title;
  final String desc;
  _FeatureItem(this.title, this.desc);
}

class _FeatureCategory extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<_FeatureItem> features;

  const _FeatureCategory({required this.title, required this.icon, required this.features});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.primaryColor, size: 28),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(fontSize: 20))),
            ],
          ),
          const SizedBox(height: 20),
          ...features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(f.title, style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(f.desc, style: GoogleFonts.inter(fontSize: 14, color: Colors.white60)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _FAQSection extends StatelessWidget {
  const _FAQSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: [
          Text("Frequently Asked Questions", style: AppTheme.darkTheme.textTheme.displayMedium),
          const SizedBox(height: 40),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                _FAQItem(
                  question: "What happens after the 5-month trial?",
                  answer: "You can choose between Model A (Pay-as-you-grow) or Model B (Annual Fixed Subscription) based on what fits your school best.",
                ),
                _FAQItem(
                  question: "Can we switch plans later?",
                  answer: "Yes, you can switch between billing models at the start of any new academic term.",
                ),
                _FAQItem(
                  question: "Is our data secure?",
                  answer: "Absolutely. We use a multi-schema database architecture powered by Supabase with bank-level security and strict role-based access controls.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.surfaceColor,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(question, style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        collapsedIconColor: Colors.white70,
        iconColor: AppTheme.primaryColor,
        children: [
          Text(answer, style: AppTheme.darkTheme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
