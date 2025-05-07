import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Language selection
  String _selectedLanguage = 'English';
  final List<String> _languages = ['English', 'French'];
  
  // Theme selection
  bool _isDarkMode = false;

  // Notification settings
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF006AEB),
        foregroundColor: Colors.white,
        title: const Text('Settings'),
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(context, 'Account Settings'),
              _buildAccountSettings(),
              const SizedBox(height: 24),
              
              _buildSectionHeader(context, 'App Settings'),
              _buildAppSettings(),
              const SizedBox(height: 24),
              
              _buildSectionHeader(context, 'Notifications'),
              _buildNotificationSettings(),
              const SizedBox(height: 24),
              
              _buildSectionHeader(context, 'Danger Zone'),
              _buildDangerZone(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF006AEB),
        ),
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Color(0xFF006AEB)),
            title: const Text('Edit Profile'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showEditProfileDialog(),
          ),
          const Divider(height: 1, indent: 16),
          ListTile(
            leading: const Icon(Icons.lock, color: Color(0xFF006AEB)),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showChangePasswordDialog(),
          ),
          const Divider(height: 1, indent: 16),
          ListTile(
            leading: const Icon(Icons.email, color: Color(0xFF006AEB)),
            title: const Text('Change Email'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAppSettings() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.language, color: Color(0xFF006AEB)),
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              underline: Container(),
              items: _languages.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLanguage = newValue;
                    _showLanguageChangeSnackbar(newValue);
                  });
                }
              },
            ),
          ),
          const Divider(height: 1, indent: 16),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode, color: Color(0xFF006AEB)),
            title: const Text('Dark Mode'),
            value: _isDarkMode,
            activeColor: const Color(0xFF006AEB),
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
          const Divider(height: 1, indent: 16),
          ListTile(
            leading: const Icon(Icons.help, color: Color(0xFF006AEB)),
            title: const Text('Help & Support'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1, indent: 16),
          ListTile(
            leading: const Icon(Icons.info, color: Color(0xFF006AEB)),
            title: const Text('About'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.notifications, color: Color(0xFF006AEB)),
            title: const Text('Push Notifications'),
            value: _notificationsEnabled,
            activeColor: const Color(0xFF006AEB),
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          const Divider(height: 1, indent: 16),
          SwitchListTile(
            secondary: const Icon(Icons.email, color: Color(0xFF006AEB)),
            title: const Text('Email Notifications'),
            value: _emailNotifications,
            activeColor: const Color(0xFF006AEB),
            onChanged: (bool value) {
              setState(() {
                _emailNotifications = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDangerZone(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.red, width: 1),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text(
              'Delete Account',
              style: TextStyle(color: Colors.red),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.red),
            onTap: () => _showDeleteAccountDialog(context),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: 'John Doe'),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Student ID',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: '123456'),
                  enabled: false,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated successfully'),
                    backgroundColor: Color(0xFF006AEB),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF006AEB),
                foregroundColor: Colors.white,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog() {
    final _currentPasswordController = TextEditingController();
    final _newPasswordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _currentPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Current Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _newPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm New Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Here you would add validation and API call
                if (_newPasswordController.text == _confirmPasswordController.text) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password changed successfully'),
                      backgroundColor: Color(0xFF006AEB),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Passwords do not match'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF006AEB),
                foregroundColor: Colors.white,
              ),
              child: const Text('Change Password'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final _passwordController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Warning: This action cannot be undone. All your data will be permanently deleted.',
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Enter your password to confirm',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Here you would verify password and delete account
                Navigator.of(context).pop();
                _showFinalDeleteConfirmation(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete Account'),
            ),
          ],
        );
      },
    );
  }

  void _showFinalDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Final Confirmation'),
          content: const Text(
            'Are you absolutely sure you want to delete your account? This cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No, Keep My Account'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Here you would call API to delete account
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Account deleted successfully'),
                    backgroundColor: Colors.red,
                  ),
                );
                // Navigate to login screen
                Navigator.pushNamedAndRemoveUntil(
                  context, 
                  '../auth_screens/login.dart',
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Yes, Delete My Account'),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageChangeSnackbar(String language) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(language == 'English' 
            ? 'Language changed to English' 
            : 'Langue changée en Français'),
        backgroundColor: const Color(0xFF006AEB),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
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
            Navigator.pushReplacementNamed(context, '/');
          }),
          _buildDrawerItem(Icons.quiz, 'Exams', () {
            Navigator.pushReplacementNamed(context, '/exams');
          }),
          _buildDrawerItem(Icons.assessment, 'Results', () {
            Navigator.pushReplacementNamed(context, '/results');
          }),
          const Divider(indent: 16, endIndent: 16),
          _buildDrawerItem(Icons.settings, 'Settings', () {
            Navigator.pop(context); // Close drawer since we're already on settings
          }, isSelected: true),
          _buildDrawerItem(Icons.logout, 'Logout', () {
            Navigator.pop(context); // First close the drawer
            Navigator.pushNamedAndRemoveUntil(
              context,
              '../auth_screens/login.dart', // Your login route name
              (Route<dynamic> route) => false, // Clear entire navigation stack
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {bool isSelected = false}) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? const Color(0xFF00A8E6) : const Color(0xFF006AEB)),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? const Color(0xFF00A8E6) : null,
        ),
      ),
      tileColor: isSelected ? const Color(0xFF006AEB).withOpacity(0.1) : null,
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}