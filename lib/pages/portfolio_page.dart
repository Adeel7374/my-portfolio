import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
import '../widgets/section_header.dart';
import '../widgets/stat_card.dart';
import '../widgets/project_card.dart';
import '../widgets/skills_bar.dart';
import '../widgets/hover_scale.dart';
import 'package:http/http.dart' as http;
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final aboutKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? const [Color(0xFF0f0f23), Color(0xFF13132b)]
                : const [Color(0xFFFFFFFF), Color(0xFFF6F7FB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              floating: true,
              title: const Text('Muhammad Adeel'),
              actions: [
                Builder(
                  builder: (context) {
                    final isDark = Theme.of(context).brightness == Brightness.dark;
                    return IconButton(
                      tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
                      onPressed: () => Provider.of<ThemeProvider>(context, listen: false).toggle(),
                      icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                    );
                  },
                ),
                IconButton(
                  tooltip: 'GitHub',
                  onPressed: () => _launch('https://github.com/Adeel7374'),
                  icon: const Icon(Icons.code),
                ),
                IconButton(
                  tooltip: 'LinkedIn',
                  onPressed: () => _launch('https://www.linkedin.com/in/'),
                  icon: const Icon(Icons.business_center_outlined),
                ),
                IconButton(
                  tooltip: 'Email',
                  onPressed: () => _launch('mailto:mianadee25@gmail.com'),
                  icon: const Icon(Icons.mail_outline),
                ),
                const SizedBox(width: 8),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeroSection(
                    onViewWork: () => _scrollTo(projectsKey),
                    onContact: () => _scrollTo(contactKey),
                  ),
                  SizedBox(height: 48),
                  KeyedSubtree(key: aboutKey, child: const _AboutSection()),
                  SizedBox(height: 48),
                  KeyedSubtree(key: projectsKey, child: const _ProjectsSection()),
                  SizedBox(height: 48),
                  const _ExpertiseSection(),
                  SizedBox(height: 48),
                  const _InteractiveSection(),
                  SizedBox(height: 48),
                  KeyedSubtree(key: contactKey, child: const _ContactSection()),
                  const SizedBox(height: 24),
                  const _Footer(),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      // ignore: avoid_print
      print('Could not launch $url');
    }
  }
}

class _HeroSection extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;
  const _HeroSection({required this.onViewWork, required this.onContact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 64,
            backgroundColor: AppTheme.accentBlue.withValues(alpha: 0.2),
            child: const CircleAvatar(radius: 58, backgroundColor: Colors.white24,
            backgroundImage: AssetImage('assets/images/my_pic.jpg'),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 32,
            child: AnimatedTextKit(
              repeatForever: true,
              
              animatedTexts: [
                TypewriterAnimatedText('Flutter Developer • Mobile Architect • Problem Solver',
                textStyle: TextStyle(
                  fontSize: 20.0,fontWeight: FontWeight.bold
                ),
                // textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                //   color: Theme.of(context).colorScheme.onBackground,
                //   fontWeight: FontWeight.bold,
                // ) ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    speed: Duration(milliseconds: 70)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _cta('View Work', Icons.work_outline, onViewWork),
              _cta('Contact Me', Icons.send, onContact),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cta(String label, IconData icon, VoidCallback onTap) {
    return HoverScale(
      onTap: onTap,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          backgroundColor: AppTheme.accentBlue,
          foregroundColor: Colors.white,
        ),
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'About Me'),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: const [
              StatCard(title: 'Years Experience', value: '3+'),
              StatCard(title: 'Apps Delivered', value: '30+'),
              StatCard(title: 'Client Satisfaction', value: '99%'),
              StatCard(title: 'Play Store Ratings', value: '5★'),
            ],
          ),
          const SizedBox(height: 24),
          const SkillsBar(label: 'Flutter', percent: 0.95),
          const SkillsBar(label: 'Firebase', percent: 0.95),
          const SkillsBar(label: 'REST APIs', percent: 0.95),
          const SkillsBar(label: 'Animations', percent: 0.9),
        ],
      ),
    );
  }
}

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection();

  @override
  Widget build(BuildContext context) {
    final projects = [
      ('PDF Converter Suite', '1M+ downloads', 'https://play.google.com/store/apps/details?id=com.pdf.converter.editor.jpgtopdf.maker&pcampaignid=web_share'),
      (
        'Text Scanner OCR',
        'Advanced text recognition',
        'https://play.google.com/store/apps/details?id=et.image.text.converter.doc.ocr.scanner.pdf&pcampaignid=web_share',
      ),
      ('Face scanner: age Detector', '100k+ downloads', 'https://play.google.com/store/apps/details?id=com.face.scanner.age.calculator.detector&pcampaignid=web_share'),
      ('E-Commerce Solutions', '20% transaction improvement', 'https://play.google.com/store/apps/details?id=com.yourstore.io&pcampaignid=web_share'),
      ('Pregnancy Calculator', '1M+ downloads', 'https://play.google.com/store/apps/details?id=com.pregnancy.due.date.calculator.tracker&pcampaignid=web_share'),
      ('Weather Forecast App', 'OpenWeather API integration', 'https://play.google.com/store/apps/details?id=com.wftab.weather.forecast&pcampaignid=web_share'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Featured Projects'),
          const SizedBox(height: 16),
          AnimationLimiter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                int crossAxisCount = 3;
                if (width < 600) {
                  crossAxisCount = 1;
                } else if (width < 1000) {
                  crossAxisCount = 2;
                }
                return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.4,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final p = projects[index];
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  columnCount: crossAxisCount,
                  child: SlideAnimation(
                    horizontalOffset: 40,
                    child: FadeInAnimation(
                      child: ProjectCard(title: p.$1, subtitle: p.$2, url: p.$3),
                    ),
                  ),
                );
              },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpertiseSection extends StatelessWidget {
  const _ExpertiseSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Technical Expertise'),
          const SizedBox(height: 12),
          Text('Frontend',style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),),
          const SizedBox(height: 8),
          const _HoverChips(labels: ['Flutter','Dart','Responsive Design','RiverPod','Provider','Getx','Flutter Web','Flutter Desktop','Flutter Mobile',]),
          const SizedBox(height: 16),
          Text('Backend & Integration',style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),),
          const SizedBox(height: 8),
          const _HoverChips(labels: ['WebSocket','WebHooks','RESTful APIs','Firebase','SQLite','Push Notifications','Stripe','In-app Purchases']),
          const SizedBox(height: 16),
          Text('additional Skills',style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),),
          const SizedBox(height: 8),
          const _HoverChips(labels: ['Google Play Console', 'AppStore']),
        ],
      ),
    );
  }
}

class _HoverChips extends StatefulWidget {
  final List<String> labels;
  const _HoverChips({required this.labels});

  @override
  State<_HoverChips> createState() => _HoverChipsState();
}

class _HoverChipsState extends State<_HoverChips> {
  int? _hoverIndex;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (int i = 0; i < widget.labels.length; i++)
          MouseRegion(
            onEnter: (_) => setState(() => _hoverIndex = i),
            onExit: (_) => setState(() => _hoverIndex = null),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: _hoverIndex == i
                    ? AppTheme.successGradient
                    : AppTheme.primaryGradient,
              ),
              child: Text(
                widget.labels[i],
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}

class _InteractiveSection extends StatelessWidget {
  const _InteractiveSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Interactive Elements'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              StatCard(title: 'Apps Published', value: '30+'),
              StatCard(title: 'Avg Rating', value: '4.8/5'),
              StatCard(title: 'Total Downloads', value: '1M+'),
              StatCard(title: 'Client Projects', value: '20+'),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Contact'),
          const SizedBox(height: 8),
          Text(
            'Faisalabad, Punjab, Pakistan · Open for opportunities in US/UK',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppTheme.textPrimary),
          ),
          const SizedBox(height: 16),
          const _ContactForm(),
        ],
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;

  if (mounted) {
    setState(() => _sending = true);
  }

  // EmailJS configuration
  const String serviceId = 'service_1f45h99'; // Your Gmail service ID
  const String templateId = 'template_1baz02p'; // Replace with your NEW Contact Form Template ID
  const String publicKey = 'vpo-0tczmQrmmrE8Q'; // Replace with your EmailJS Public Key

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': publicKey, // This was missing!
        'template_params': {
          'name': _name.text.trim(),
          'email': _email.text.trim(),
          'message': _message.text.trim(),
          'title': 'Portfolio Contact from ${_name.text.trim()}',
        },
      }),
    );

    if (mounted) {
      setState(() => _sending = false);
    }

    if (response.statusCode == 200 && mounted) {
      _name.clear();
      _email.clear();
      _message.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message sent successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else if (mounted) {
      print('Error response: ${response.body}'); // Debug print
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send message. Status: ${response.statusCode}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    if (mounted) {
      setState(() => _sending = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error sending message. Please try again or email directly.'),
          backgroundColor: Colors.red,
        ),
      );
    }
    print('Error sending email: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: 320,
                child: TextFormField(
                  controller: _name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Required';
                    if (v.contains(RegExp(r'[<>]'))) return 'Invalid characters';
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 320,
                child: TextFormField(
                  controller: _email,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Required';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 656,
            child: TextFormField(
              controller: _message,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              minLines: 4,
              maxLines: 8,
              maxLength: 1000, // Limit for EmailJS free tier
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                if (v.contains(RegExp(r'[<>]'))) return 'Invalid characters';
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          HoverScale(
            onTap: _sending ? null : _submit,
            child: ElevatedButton.icon(
              onPressed: _sending ? null : _submit,
              icon: _sending
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              label: Text(_sending ? 'Sending...' : 'Send Message'),
            ),
          ),
        ],
      ),
    );
  }
}
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: AppTheme.primaryGradient,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '© ${DateTime.now().year} Muhammad Adeel',
              style: const TextStyle(color: Colors.white70),
            ),
            Wrap(
              spacing: 12,
              children: [
                IconButton(
                  tooltip: 'GitHub',
                  onPressed: () => launchExternal('https://github.com/Adeel7374'),
                  icon: const Icon(Icons.code, color: Colors.white),
                ),
                IconButton(
                  tooltip: 'LinkedIn',
                  onPressed: () => launchExternal('https://www.linkedin.com/in/muhammad-adeel-b99181186'),
                  icon: const Icon(Icons.business_center_outlined, color: Colors.white),
                ),
                IconButton(
                  tooltip: 'Email',
                  onPressed: () => launchExternal('mailto:mianadee25@gmail.com'),
                  icon: const Icon(Icons.mail_outline, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> launchExternal(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.platformDefault);
}


