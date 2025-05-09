import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  
  const EditProfileScreen({
    super.key,
    required this.userData,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  late TextEditingController _locationController;
  
  // Form values
  late String _profileImage;
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    // Initialize controllers with current user data
    _nameController = TextEditingController(text: widget.userData['name']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _bioController = TextEditingController(text: widget.userData['bio']);
    _locationController = TextEditingController(text: widget.userData['location']);
    _profileImage = widget.userData['profileImage'];
  }
  
  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    final updatedUserData = {
      ...widget.userData,
      'name': _nameController.text,
      'email': _emailController.text,
      'bio': _bioController.text,
      'location': _locationController.text,
      'profileImage': _profileImage,
    };
    
    setState(() {
      _isLoading = false;
    });
    
    if (mounted) {
      Navigator.pop(context, updatedUserData);
    }
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '';
    
    final nameParts = name.split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}';
    } else if (name.length >= 2) {
      return name.substring(0, 2);
    } else {
      return name[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 0,
        title: const Text(
          'Edit Profile',
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
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(colorPrinciple),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _saveChanges,
              child: const Text(
                'Save',
                style: TextStyle(
                  color: colorPrinciple,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Inter',
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileImageEditor(),
                const SizedBox(height: 24),
                _buildInputFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImageEditor() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: colorPrinciple,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _profileImage,
                    style: const TextStyle(
                      color: colorWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: InkWell(
                  onTap: () {
                    // This would typically open a dialog to choose a photo
                    // For now, we'll just update the initials based on the name
                    setState(() {
                      _profileImage = _getInitials(_nameController.text);
                    });
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: colorPrinciple,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorWhite,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: colorWhite,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Profile Photo',
            style: TextStyle(
              fontSize: 14,
              color: colorBlack.withOpacity(0.7),
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personal Information',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colorBlack,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _nameController,
          label: 'Full Name',
          hint: 'Enter your full name',
          prefixIcon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              _profileImage = _getInitials(value);
            });
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _emailController,
          label: 'Email',
          hint: 'Enter your email address',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _locationController,
          label: 'Location',
          hint: 'Enter your location',
          prefixIcon: Icons.location_on_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your location';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        const Text(
          'About',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colorBlack,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _bioController,
          label: 'Bio',
          hint: 'Tell us about yourself',
          prefixIcon: Icons.info_outline,
          maxLines: 4,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a bio';
            }
            if (value.length < 10) {
              return 'Bio must be at least 10 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _saveChanges,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorPrinciple,
              foregroundColor: colorWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledBackgroundColor: colorPrinciple.withOpacity(0.6),
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
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData prefixIcon,
    required String? Function(String?)? validator,
    Function(String)? onChanged,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colorBlack.withOpacity(0.8),
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: colorGrey.withOpacity(0.6),
              fontFamily: 'Inter',
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: colorPrinciple,
              size: 22,
            ),
            filled: true,
            fillColor: colorGrey.withOpacity(0.05),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16, 
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorGrey.withOpacity(0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: colorPrinciple,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorTaskRed.withOpacity(0.5),
              ),
            ),
          ),
          style: const TextStyle(
            fontSize: 14,
            color: colorBlack,
            fontFamily: 'Inter',
          ),
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          maxLines: maxLines,
        ),
      ],
    );
  }
} 