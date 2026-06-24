import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sky_cord/core/di/dependency_injection.dart';
import 'package:sky_cord/core/models/app_user.dart';
import 'package:sky_cord/core/theme/app_colors.dart';
import 'package:sky_cord/core/utils/validators.dart';
import 'package:sky_cord/core/widgets/custom_primary_button.dart';
import 'package:sky_cord/core/widgets/custom_text_form_field.dart';
import 'package:sky_cord/features/profile/presentation/provider/profile_provider.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final GlobalKey<FormState> _profileFormKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pfpLinkController = TextEditingController();
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final ProfileProvider _profileProvider = getIt<ProfileProvider>();

  Future<void> _getUserData() async {
    if (currentUser == null) return;

    final result = await _profileProvider.getUserData(currentUser!.uid);

    if (result.success && result.data != null) {
      setState(() {
        _userNameController.text = result.data!.username;
        _emailController.text = result.data!.email;
        _phoneController.text = result.data!.phone ?? "";
        _pfpLinkController.text = result.data!.pfp ?? "";
      });
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.message ?? "Try Again")),
      );
    }
  }

  @override
  void initState() {
    _userNameController.text = currentUser!.displayName ?? "";
    _emailController.text = currentUser!.email!;
    _phoneController.text = currentUser!.phoneNumber ?? "";
    _pfpLinkController.text = currentUser!.photoURL ?? "";
    _getUserData();
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _pfpLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _profileFormKey,
        child: Column(children: [
          CustomTextFormField(
              controller: _userNameController,
              hintText: "Username",
              validator: (value) => Validators.username(context, value)),
          SizedBox(height: 16),
          CustomTextFormField(
              controller: _emailController,
              hintText: "Email",
              validator: (value) => Validators.email(context, value)),
          SizedBox(height: 16),
          CustomTextFormField(
              controller: _phoneController,
              hintText: "Phone Number",
              validator: (value) => Validators.phone(context, value)),
          SizedBox(height: 16),
          CustomTextFormField(
              controller: _pfpLinkController,
              hintText: "Profile Picture Link",
              validator: (value) => Validators.url(context, value)),
          SizedBox(height: 16),
          CustomPrimaryButton(
              buttonText: "Update Profile",
              onPressed: () async {
                if (_profileFormKey.currentState!.validate() &&
                    currentUser != null) {
                  final messenger = ScaffoldMessenger.of(context);

                  final updatedUser = AppUser(
                    uid: currentUser!.uid,
                    username: _userNameController.text.trim(),
                    email: _emailController.text.trim(),
                    phone: _phoneController.text.trim().isEmpty
                        ? null
                        : _phoneController.text.trim(),
                    pfp: _pfpLinkController.text.trim().isEmpty
                        ? null
                        : _pfpLinkController.text.trim(),
                  );

                  final result =
                      await _profileProvider.updateProfile(updatedUser);

                  if (!mounted) return;

                  if (result.success) {
                    messenger.showSnackBar(
                      SnackBar(content: Text("Profile updated successfully")),
                    );
                  } else if (mounted) {
                    messenger.showSnackBar(
                      SnackBar(
                          content: Text(result.message ?? "Update failed"),
                          backgroundColor: AppColors.redColor),
                    );
                  }
                }
              })
        ]));
  }
}
