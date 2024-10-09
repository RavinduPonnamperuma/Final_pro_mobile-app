import 'package:flutter/material.dart';
import 'dart:async'; // Import the timer package for automatic sliding

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to the profile page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                crossAxisCount: 3, // Increased number of cards per row
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                children: [
                  _buildDashboardCard(
                    'Profile',
                    Icons.person,
                    Colors.lightGreen,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    'Messages',
                    Icons.message,
                    Colors.lightGreen,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MessagesPage()),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    'Settings',
                    Icons.settings,
                    Colors.lightGreen,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    'Logout',
                    Icons.logout,
                    Colors.lightGreen,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DashboardPage()),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    'Watering',
                    Icons.water,
                    Colors.lightGreen,
                        () {
                      // Add watering logic or navigate to the watering page
                    },
                  ),
                  _buildDashboardCard(
                    'Growth',
                    Icons.energy_savings_leaf_rounded,
                    Colors.lightGreen,
                        () {
                      // Add growth logic or navigate to the growth page
                    },
                  ),
                ],
              ),
            ),
          ),
          const SensorDataSlider(
              humidity: 45.0, temperature: 22.0, moisture: 30.0),
        ],
      ),
    );
  }

  // Helper method to create a dashboard card with a tap event
  Widget _buildDashboardCard(String title, IconData icon, Color color,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // Call the provided onTap function when tapped
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SizedBox(
          height: 60,
          width: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: color), // Smaller icon size
              const SizedBox(height: 4.0),
              Text(
                title,
                textAlign: TextAlign.center, // Center the text
                style: const TextStyle(
                  fontSize: 12.0, // Smaller font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder pages for navigation
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Page')),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(child: Text('Profile Page')),
    );
  }
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: const Center(child: Text('Messages Page')),
    );
  }
}

class SensorDataSlider extends StatefulWidget {
  final double humidity;
  final double temperature;
  final double moisture;

  const SensorDataSlider({
    super.key,
    required this.humidity,
    required this.temperature,
    required this.moisture,
  });

  @override
  _SensorDataSliderState createState() => _SensorDataSliderState();
}

class _SensorDataSliderState extends State<SensorDataSlider> {
  late PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    // Set up a timer for automatic sliding
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust height as necessary
      child: PageView(
        controller: _controller,
        children: [
          _buildCard('Humidity', '${widget.humidity}%', Colors.lightGreen),
          _buildCard('Temperature', '${widget.temperature}°C', Colors.lightGreen),
          _buildCard('Moisture', '${widget.moisture}%', Colors.lightGreen),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String value, Color color) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: color,
      elevation: 4.0,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                value,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
