import 'package:flutter/material.dart';


void main() {
  runApp(const ExamApp());
}

class ExamApp extends StatelessWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006AEB),
          primary: const Color(0xFF006AEB),
          secondary: const Color(0xFF00A8E6),
          background: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF006AEB),
        foregroundColor: Colors.white,
        title: const Text('Exam App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => _showNotification(context),
            tooltip: 'Notifications',
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(),
              const SizedBox(height: 20),
              _buildQuickActions(context),
              const SizedBox(height: 20),
              _buildExamSection(context),
              const SizedBox(height: 20),
              _buildActivitySection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF006AEB), Color(0xFF00A8E6)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back,',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 4),
            const Text(
              'John Doe',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem(Icons.assignment, '12', 'Exams'),
                _buildStatItem(Icons.calendar_today, '4', 'Upcoming'),
                _buildStatItem(Icons.star, '87%', 'Score'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final colorOptions = [
      const Color(0xFF00A8E6),
      const Color(0xFF006AEB),
      const Color(0xFF0026E6),
      const Color(0xFF1C00E6),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.1,
          children: [
            _buildActionButton(
              context,
              Icons.quiz,
              'Start Exam',
              colorOptions[0],
              () => _navigateTo(context, '/exams'),
            ),
            _buildActionButton(
              context,
              Icons.history,
              'Results',
              colorOptions[1],
              () => _navigateTo(context, '/results'),
            ),
            _buildActionButton(
              context,
              Icons.schedule,
              'Schedule',
              colorOptions[2],
              () => _navigateTo(context, '/schedule'),
            ),
            _buildActionButton(
              context,
              Icons.help,
              'Help',
              colorOptions[3],
              () => _navigateTo(context, '/help'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        splashColor: color.withOpacity(0.2),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExamSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Upcoming Exams',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildExamItem('Mathematics', 'May 10', '09:00 AM'),
              const Divider(height: 1, indent: 16),
              _buildExamItem('Physics', 'May 12', '11:00 AM'),
              const Divider(height: 1, indent: 16),
              _buildExamItem('Chemistry', 'May 15', '02:00 PM'),
              InkWell(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'View all exams',
                        style: TextStyle(color: Color(0xFF006AEB)),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.chevron_right, size: 18, color: Color(0xFF006AEB)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExamItem(String subject, String date, String time) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF006AEB).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.quiz, color: Color(0xFF006AEB), size: 20),
      ),
      title: Text(
        subject,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text("$date at $time"),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: () {},
      minVerticalPadding: 0,
      dense: true,
    );
  }

  Widget _buildActivitySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Recent Activity',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildActivityItem(
                Icons.check_circle,
                'Math Exam Completed',
                'Scored 85%',
                const Color(0xFF00A8E6),
              ),
              const Divider(height: 1, indent: 16),
              _buildActivityItem(
                Icons.notifications,
                'Chemistry Reminder',
                'Exam in 3 days',
                const Color(0xFF0026E6),
              ),
              const Divider(height: 1, indent: 16),
              _buildActivityItem(
                Icons.assignment,
                'Physics Assignment',
                'Submitted yesterday',
                const Color(0xFF6100EB),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(IconData icon, String title, String subtitle, Color color) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
      ),
      minVerticalPadding: 0,
      dense: true,
    );
  }

  void _showNotification(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No new notifications'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFF006AEB),
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
  

  void _navigateTo(BuildContext context, String route, {bool isLogout = false}) {
  if (isLogout) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
      (Route<dynamic> route) => false, // Remove all routes
    );
  } else {
    Navigator.pushNamed(context, route);
  }
}
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF006AEB), Color(0xFF00A8E6)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white24,
                  backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'John Doe',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(
                  'Student ID: 123456',
                  style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.home, 'Home', () {
  Navigator.pop(context);  // Close drawer
}),
_buildDrawerItem(Icons.quiz, 'Exams', () {
  Navigator.popAndPushNamed(context, '/exams');
}),
_buildDrawerItem(Icons.assessment, 'Results', () {
  Navigator.popAndPushNamed(context, '/results');
}),
const Divider(indent: 16, endIndent: 16),
_buildDrawerItem(Icons.settings, 'Settings', () {
  Navigator.popAndPushNamed(context, '/settings');
}),
_buildDrawerItem(Icons.logout, 'Logout', () {
  Navigator.pop(context);  // First close the drawer
  Navigator.pushNamedAndRemoveUntil(
    context, 
    '/Logout',  // Your login route name
    (Route<dynamic> route) => false,  // Clear entire navigation stack
  );
}),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF006AEB)),
      title: Text(title),
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}