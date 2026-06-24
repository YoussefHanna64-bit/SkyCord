import 'package:flutter/material.dart';
import 'package:sky_cord/core/di/dependency_injection.dart';
import 'package:sky_cord/core/theme/app_colors.dart';
import 'package:sky_cord/core/theme/app_text_styles.dart';
import 'package:sky_cord/core/utils/result.dart';
import 'package:sky_cord/core/widgets/custom_primary_button.dart';
import 'package:sky_cord/features/auth/presentation/views/login_view.dart';
import 'package:sky_cord/features/profile/presentation/provider/profile_provider.dart';
import 'package:sky_cord/features/profile/presentation/widgets/profile_form.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
            style: AppTextStyles.bold20Grey.copyWith(color: onSurface)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProfileForm(),
                const SizedBox(height: 40),
                CustomPrimaryButton(
                    buttonText: "Logout",
                    fillColor: AppColors.redColor,
                    onPressed: () async {
                      Result<void> logoutState =
                          await getIt<ProfileProvider>().logout();
                      if (!context.mounted) return;
                      if (logoutState.success) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(logoutState.message ??
                                "Something went wrong, Try again"),
                            backgroundColor: AppColors.redColor,
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
