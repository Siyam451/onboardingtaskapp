import 'package:flutter/material.dart';
import '../../common-widgets/app_gradient_bacground_widget.dart';
import '../location/location_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  Widget buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages.length,
            (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: index == i ? 12 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: index == i
                ? const Color(0xFF7B1FA2) // Active (Purple)
                : Colors.white38,        // Inactive (Gray)
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  final PageController controller = PageController();
  int index = 0;

  final List<Map<String, String>> pages = [
    {
      'image': 'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?auto=format&fit=crop&w=800&q=80',
      'title': 'Discover the world, one journey at a time.',
      'desc': 'From hidden gems to iconic destinations.'
    },
    {
      'image':
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
      'title': 'Explore new horizons, one step at a time.',
      'desc': 'Every trip holds a story.'
    },
    {
      'image':
      'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
      'title': 'See the beauty, one journey at a time.',
      'desc': 'Travel made simple.'
    },
  ];


  void next() {
    if (index < 2) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LocationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: next,
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: pages.length,
                  onPageChanged: (i) => setState(() => index = i),
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [

                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child:Image.network(
                              pages[i]['image']!,
                              height: 320,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return const CircularProgressIndicator();
                              },
                            ),

                          ),

                          const SizedBox(height: 24),

                          Text(
                            pages[i]['title']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            pages[i]['desc']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white70),
                          ),

                          const Spacer(),
                          const SizedBox(height: 20),

                          buildIndicator(), // 3 dots which will change according to the sliding the pages

                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: next,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2196F3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text('Next'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
