import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 24.h),
                _buildHeader(),
                SizedBox(height: 32.h),
                _buildFormCard(),
                SizedBox(height: 24.h),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Icon(
            Icons.nature_rounded,
            color: AppColors.onPrimary,
            size: 40.w,
          ),
        ),
        SizedBox(height: 24.h),
        AppText(
          text: 'Begin Your',
          variant: AppTextVariant.headline,
          fontWeight: FontWeight.w800,
          textAlign: TextAlign.center,
        ),
        AppText(
          text: 'Growth Legacy',
          variant: AppTextVariant.headline,
          fontWeight: FontWeight.w800,
          color: AppColors.onSurfaceVariant,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        AppText(
          text:
              'Step into a world where financial precision meets absolute privacy.',
          variant: AppTextVariant.body,
          color: AppColors.onSurfaceVariant,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.onSurface.withValues(alpha: 0.04),
            blurRadius: 64,
            offset: const Offset(0, 32),
          ),
        ],
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNameField(),
          SizedBox(height: 20.h),
          _buildEmailField(),
          SizedBox(height: 20.h),
          _buildPasswordField(),
          SizedBox(height: 20.h),
          _buildTermsCheckbox(),
          SizedBox(height: 24.h),
          _buildRegisterButton(),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Full Name',
          variant: AppTextVariant.label,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurfaceVariant,
        ),
        SizedBox(height: 8.h),
        _buildStyledInput(
          controller: _nameController,
          hint: "John Doe",
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.person_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: "Email Address",
          variant: AppTextVariant.label,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurfaceVariant,
        ),
        SizedBox(height: 8.h),
        _buildStyledInput(
          controller: _emailController,
          hint: 'Enter your email address',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.mail_outlined,
          validator: (value) {
            return Validators.validateEmail(value);
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Secure Password',
          variant: AppTextVariant.label,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurfaceVariant,
        ),
        SizedBox(height: 8.h),
        _buildStyledInput(
          controller: _passwordController,
          hint: '••••••••••••',
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.done,
          prefixIcon: Icons.lock_outlined,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.onSurfaceVariant,
              size: 20.w,
            ),
            onPressed: () =>
                setState(() => _obscurePassword = !_obscurePassword),
          ),
          validator: (value) {
            return Validators.validatePassword(value);
          },
        ),
      ],
    );
  }

  Widget _buildStyledInput({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    required IconData prefixIcon,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHighHighest,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        validator: validator,
        style: TextStyle(color: AppColors.onSurface, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.outline),
          prefixIcon: Icon(
            prefixIcon,
            color: AppColors.onSurfaceVariant,
            size: 20.w,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return GestureDetector(
      onTap: () => setState(() => _acceptTerms = !_acceptTerms),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: _acceptTerms ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: _acceptTerms ? AppColors.primary : AppColors.outline,
                width: 2,
              ),
            ),
            child: _acceptTerms
                ? Icon(Icons.check, color: AppColors.onPrimary, size: 16.w)
                : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: AppText(
              text: 'I agree to the Terms of Service and Privacy Policy',
              variant: AppTextVariant.caption,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/dashboard');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return AppButton(
          text: 'Create Account',
          icon: Icons.arrow_forward_rounded,
          isFullWidth: true,
          isLoading: isLoading,
          onPressed: _acceptTerms
              ? () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthCubit>().signUp(
                      _emailController.text.trim(),
                      _passwordController.text,
                      displayName: _nameController.text.trim(),
                    );
                  }
                }
              : null,
        );
      },
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: 'Already have an account?',
              variant: AppTextVariant.body,
              color: AppColors.onSurfaceVariant,
            ),
            GestureDetector(
              onTap: () => context.pop(),
              child: AppText(
                text: 'Login',
                variant: AppTextVariant.body,
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        _buildSecurityBadges(),
      ],
    );
  }

  Widget _buildSecurityBadges() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBadge(Icons.verified_user_outlined, 'Secure & Encrypted'),
        SizedBox(width: 24.w),
        _buildBadge(Icons.shield_outlined, 'FCA Regulated'),
      ],
    );
  }

  Widget _buildBadge(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
          size: 14.w,
        ),
        SizedBox(width: 4.w),
        AppText(
          text: text,
          variant: AppTextVariant.label,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
        ),
      ],
    );
  }
}
