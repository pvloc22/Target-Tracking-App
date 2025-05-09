import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Settings state variables
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';
  double _textScaleFactor = 1.0;
  bool _useSystemTheme = true;
  bool _autoBackupEnabled = true;
  // bui
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorBlack,
            fontFamily: 'Inter',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorBlack),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('App Preferences'),
            _buildSettingsSection([
              _buildSwitchTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Enable push notifications',
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                subtitle: 'Use dark theme',
                value: _darkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    _darkModeEnabled = value;
                  });
                },
              ),
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.palette_outlined,
                title: 'Use System Theme',
                subtitle: 'Follow system light/dark mode',
                value: _useSystemTheme,
                onChanged: (value) {
                  setState(() {
                    _useSystemTheme = value;
                    if (value) {
                      // When using system theme, disable manual dark mode
                      _darkModeEnabled = false;
                    }
                  });
                },
              ),
            ]),
            
            _buildSectionHeader('Text & Accessibility'),
            _buildSettingsSection([
              _buildDropdownTile(
                icon: Icons.language_outlined,
                title: 'Language',
                subtitle: 'Change app language',
                value: _selectedLanguage,
                items: const ['English', 'Spanish', 'French', 'German', 'Chinese', 'Japanese'],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedLanguage = value;
                    });
                  }
                },
              ),
              _buildDivider(),
              _buildSliderTile(
                icon: Icons.text_fields_outlined,
                title: 'Text Size',
                subtitle: 'Adjust text scale factor',
                value: _textScaleFactor,
                min: 0.8,
                max: 1.4,
                divisions: 6,
                onChanged: (value) {
                  setState(() {
                    _textScaleFactor = value;
                  });
                },
              ),
            ]),
            
            _buildSectionHeader('Data & Storage'),
            _buildSettingsSection([
              _buildSwitchTile(
                icon: Icons.backup_outlined,
                title: 'Auto Backup',
                subtitle: 'Backup your data automatically',
                value: _autoBackupEnabled,
                onChanged: (value) {
                  setState(() {
                    _autoBackupEnabled = value;
                  });
                },
              ),
              _buildDivider(),
              _buildActionTile(
                icon: Icons.delete_outline,
                iconColor: colorTaskRed,
                title: 'Clear Cache',
                subtitle: 'Remove temporary files',
                onTap: () {
                  _showConfirmationDialog(
                    title: 'Clear Cache',
                    content: 'Are you sure you want to clear the app cache? This won\'t delete any of your data.',
                    onConfirm: () {
                      // TODO: Implement cache clearing
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cache cleared successfully')),
                      );
                    },
                  );
                },
              ),
              _buildDivider(),
              _buildActionTile(
                icon: Icons.storage_outlined,
                title: 'Storage Usage',
                subtitle: 'Manage app storage',
                onTap: () {
                  // TODO: Navigate to storage management screen
                },
              ),
            ]),
            
            _buildSectionHeader('Account'),
            _buildSettingsSection([
              _buildActionTile(
                icon: Icons.security_outlined,
                title: 'Privacy & Security',
                subtitle: 'Manage your privacy settings',
                onTap: () {
                  // TODO: Navigate to privacy settings
                },
              ),
              _buildDivider(),
              _buildActionTile(
                icon: Icons.person_outlined,
                title: 'Account Information',
                subtitle: 'View and edit your profile',
                onTap: () {
                  // TODO: Navigate to account info
                },
              ),
              _buildDivider(),
              _buildActionTile(
                icon: Icons.delete_forever_outlined,
                iconColor: colorTaskRed,
                title: 'Delete Account',
                subtitle: 'Permanently delete your account',
                onTap: () {
                  _showConfirmationDialog(
                    title: 'Delete Account',
                    content: 'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.',
                    confirmLabel: 'Delete',
                    isDestructive: true,
                    onConfirm: () {
                      // TODO: Implement account deletion
                    },
                  );
                },
              ),
            ]),
            
            _buildSectionHeader('About'),
            _buildSettingsSection([
              _buildActionTile(
                icon: Icons.info_outline,
                title: 'App Version',
                subtitle: 'Version 1.0.0',
                onTap: () {
                  // Maybe show a dialog with detailed version info
                },
              ),
              _buildDivider(),
              _buildActionTile(
                icon: Icons.description_outlined,
                title: 'Terms of Service',
                subtitle: 'Read our terms and conditions',
                onTap: () {
                  // TODO: Navigate to terms page or open web url
                },
              ),
              _buildDivider(),
              _buildActionTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                subtitle: 'Read our privacy policy',
                onTap: () {
                  // TODO: Navigate to privacy policy page or open web url
                },
              ),
            ]),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colorPrinciple,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildSettingsSection(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorShadow.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 56),
      child: Divider(
        height: 1,
        thickness: 1,
        color: colorGrey.withOpacity(0.1),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color? iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.only(left: 16, right: 8),
        secondary: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: (iconColor ?? colorPrinciple).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: iconColor ?? colorPrinciple,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colorBlack,
            fontFamily: 'Inter',
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: colorBlack.withOpacity(0.6),
            fontFamily: 'Inter',
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: colorPrinciple,
      ),
    );
  }

  Widget _buildDropdownTile<T>({
    required IconData icon,
    required String title,
    required String subtitle,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    Color? iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (iconColor ?? colorPrinciple).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: iconColor ?? colorPrinciple,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorBlack,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorBlack.withOpacity(0.6),
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          DropdownButton<T>(
            value: value,
            items: items.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(
                  item.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            icon: const Icon(Icons.arrow_drop_down, color: colorPrinciple),
            underline: const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
    Color? iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (iconColor ?? colorPrinciple).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? colorPrinciple,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorBlack,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorBlack.withOpacity(0.6),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                value.toStringAsFixed(1),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: colorPrinciple,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 56, right: 16, top: 8),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: colorPrinciple,
                inactiveTrackColor: colorPrinciple.withOpacity(0.2),
                thumbColor: colorPrinciple,
                overlayColor: colorPrinciple.withOpacity(0.2),
              ),
              child: Slider(
                value: value,
                min: min,
                max: max,
                divisions: divisions,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (iconColor ?? colorPrinciple).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: iconColor ?? colorPrinciple,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: iconColor ?? colorBlack,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: (iconColor ?? colorBlack).withOpacity(0.6),
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: (iconColor ?? colorBlack).withOpacity(0.5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog({
    required String title,
    required String content,
    String confirmLabel = 'Confirm',
    bool isDestructive = false,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          content: Text(
            content,
            style: const TextStyle(
              fontFamily: 'Inter',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: colorBlack.withOpacity(0.7),
                  fontFamily: 'Inter',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Text(
                confirmLabel,
                style: TextStyle(
                  color: isDestructive ? colorTaskRed : colorPrinciple,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
} 