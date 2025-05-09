import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  // Privacy settings state
  bool _locationTrackingEnabled = false;
  bool _analyticsEnabled = true;
  bool _personalizationEnabled = true;
  bool _shareDataEnabled = false;
  String _selectedDataRetention = '6 months';
  bool _deleteAccountConfirmation = false;
  bool _isLoading = false;
  
  final List<String> _dataRetentionOptions = [
    '1 month',
    '3 months',
    '6 months',
    '1 year',
    '2 years',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 0,
        title: const Text(
          'Privacy Settings',
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPrivacyInfoCard(),
              const SizedBox(height: 24),
              
              _buildHeader('App Permissions'),
              const SizedBox(height: 8),
              _buildPermissionsSettings(),
              
              const SizedBox(height: 24),
              _buildHeader('Data & Personalization'),
              const SizedBox(height: 8),
              _buildDataSettings(),
              
              const SizedBox(height: 24),
              _buildHeader('Account Data'),
              const SizedBox(height: 8),
              _buildAccountDataSettings(),
              
              const SizedBox(height: 28),
              _buildSaveButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacyInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorPrinciple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorPrinciple.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorPrinciple.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.privacy_tip_outlined,
              color: colorPrinciple,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Privacy Matters',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorBlack,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Control how your data is used and what information is shared. Update these settings at any time.',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorBlack.withOpacity(0.7),
                    fontFamily: 'Inter',
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: colorBlack,
        fontFamily: 'Inter',
      ),
    );
  }

  Widget _buildPermissionsSettings() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            title: 'Location',
            subtitle: 'Allow app to access your location',
            value: _locationTrackingEnabled,
            onChanged: (value) {
              setState(() {
                _locationTrackingEnabled = value;
              });
            },
            leadingIcon: Icons.location_on_outlined,
          ),
          const Divider(height: 1),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorPrinciple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.perm_device_info,
                color: colorPrinciple,
                size: 20,
              ),
            ),
            title: const Text(
              'Manage App Permissions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: colorBlack,
                fontFamily: 'Inter',
              ),
            ),
            subtitle: Text(
              'Control what this app can access on your device',
              style: TextStyle(
                fontSize: 12,
                color: colorBlack.withOpacity(0.6),
                fontFamily: 'Inter',
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: colorGrey,
              size: 16,
            ),
            onTap: () {
              // This would typically navigate to device app permissions
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('This would open device settings'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDataSettings() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            title: 'Analytics',
            subtitle: 'Allow us to collect anonymous usage data',
            value: _analyticsEnabled,
            onChanged: (value) {
              setState(() {
                _analyticsEnabled = value;
              });
            },
            leadingIcon: Icons.analytics_outlined,
          ),
          const Divider(height: 1),
          _buildSwitchTile(
            title: 'Personalization',
            subtitle: 'Customize your experience based on your activity',
            value: _personalizationEnabled,
            onChanged: (value) {
              setState(() {
                _personalizationEnabled = value;
              });
            },
            leadingIcon: Icons.person_outline,
          ),
          const Divider(height: 1),
          _buildSwitchTile(
            title: 'Share Data with Partners',
            subtitle: 'Share your data with our trusted partners',
            value: _shareDataEnabled,
            onChanged: (value) {
              setState(() {
                _shareDataEnabled = value;
              });
            },
            leadingIcon: Icons.share_outlined,
          ),
          const Divider(height: 1),
          _buildDropdownTile(
            title: 'Data Retention',
            subtitle: 'How long we keep your activity data',
            value: _selectedDataRetention,
            options: _dataRetentionOptions,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedDataRetention = value;
                });
              }
            },
            leadingIcon: Icons.access_time,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountDataSettings() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorPrinciple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.download_outlined,
                color: colorPrinciple,
                size: 20,
              ),
            ),
            title: const Text(
              'Download Your Data',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: colorBlack,
                fontFamily: 'Inter',
              ),
            ),
            subtitle: Text(
              'Get a copy of your personal data',
              style: TextStyle(
                fontSize: 12,
                color: colorBlack.withOpacity(0.6),
                fontFamily: 'Inter',
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: colorGrey,
              size: 16,
            ),
            onTap: () {
              _showDownloadDataDialog();
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorTaskRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.delete_forever_outlined,
                color: colorTaskRed,
                size: 20,
              ),
            ),
            title: const Text(
              'Delete Account Data',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: colorBlack,
                fontFamily: 'Inter',
              ),
            ),
            subtitle: Text(
              'Permanently delete all your data',
              style: TextStyle(
                fontSize: 12,
                color: colorBlack.withOpacity(0.6),
                fontFamily: 'Inter',
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: colorGrey,
              size: 16,
            ),
            onTap: () {
              _showDeleteDataDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData leadingIcon,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
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
      secondary: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorPrinciple.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          leadingIcon,
          color: colorPrinciple,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String subtitle,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
    required IconData leadingIcon,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorPrinciple.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          leadingIcon,
          color: colorPrinciple,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
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
      trailing: DropdownButton<String>(
        value: value,
        icon: const Icon(Icons.arrow_drop_down, color: colorGrey),
        underline: const SizedBox(),
        onChanged: onChanged,
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: colorBlack,
                fontFamily: 'Inter',
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showDownloadDataDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Download Your Data',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          content: const Text(
            'We will prepare a download package with all your personal data. This process may take some time. You will receive an email with a download link when it\'s ready.',
            style: TextStyle(
              fontFamily: 'Inter',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: colorBlack.withOpacity(0.7),
                  fontFamily: 'Inter',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Your download request has been submitted'),
                  ),
                );
              },
              child: const Text(
                'Request Data',
                style: TextStyle(
                  color: colorPrinciple,
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

  void _showDeleteDataDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Delete Account Data',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorTaskRed,
              fontFamily: 'Inter',
            ),
          ),
          content: const Text(
            'This action will permanently delete all your data and cannot be undone. Are you sure you want to proceed?',
            style: TextStyle(
              fontFamily: 'Inter',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: colorBlack.withOpacity(0.7),
                  fontFamily: 'Inter',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showDeleteConfirmationDialog();
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: colorTaskRed,
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

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Confirm Deletion',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorTaskRed,
                  fontFamily: 'Inter',
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'To confirm deletion, please type "DELETE" in the field below:',
                    style: TextStyle(
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Type DELETE here',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _deleteAccountConfirmation = value == 'DELETE';
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: colorBlack.withOpacity(0.7),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _deleteAccountConfirmation
                      ? () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Account data deleted'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      : null,
                  style: TextButton.styleFrom(
                    foregroundColor: _deleteAccountConfirmation ? colorTaskRed : colorGrey,
                  ),
                  child: const Text(
                    'Confirm Deletion',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                
                // Simulate saving
                Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    _isLoading = false;
                  });
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Privacy settings saved'),
                      backgroundColor: Color(0xFF4CAF50),
                    ),
                  );
                  
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  });
                });
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrinciple,
          foregroundColor: colorWhite,
          disabledBackgroundColor: colorPrinciple.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(colorWhite),
                ),
              )
            : const Text(
                'Save Settings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
      ),
    );
  }
} 