import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_finance_companion_mobile_app/core/theme/app_colors.dart';
import 'package:personal_finance_companion_mobile_app/shared/widgets/app_card.dart';
import 'package:personal_finance_companion_mobile_app/shared/widgets/app_text.dart';
import '../cubit/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              _buildSectionTitle('Appearance'),
              SizedBox(height: 12.h),
              _buildThemeSection(context, state),
              SizedBox(height: 24.h),
              _buildSectionTitle('About'),
              SizedBox(height: 12.h),
              _buildAboutSection(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return AppText(
      text: title.toUpperCase(),
      variant: AppTextVariant.caption,
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.5,
    );
  }

  Widget _buildThemeSection(BuildContext context, ThemeState state) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              state.themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: AppColors.primary,
            ),
            title: const Text('Dark Mode'),
            subtitle: Text(
              state.themeMode == ThemeMode.dark ? 'Enabled' : 'Disabled',
            ),
            trailing: Switch(
              value: state.themeMode == ThemeMode.dark,
              onChanged: (value) {
                context.read<ThemeCubit>().toggleTheme();
              },
              activeColor: AppColors.primary,
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: Icon(
              Icons.settings_brightness,
              color: AppColors.primary,
            ),
            title: const Text('System Theme'),
            subtitle: Text(
              state.systemThemeEnabled ? 'Following device' : 'Manual',
            ),
            trailing: Switch(
              value: state.systemThemeEnabled,
              onChanged: (value) {
                context.read<ThemeCubit>().setSystemTheme(value);
              },
              activeColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Personal Finance Companion',
            variant: AppTextVariant.title,
          ),
          SizedBox(height: 8.h),
          AppText(
            text: 'Version 1.0.0',
            variant: AppTextVariant.body,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}