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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
                SizedBox(height: 40.h),
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
          width: 64.w,
          height: 64.h,
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(
            Icons.lock_reset_rounded,
            color: AppColors.primary,
            size: 32.w,
          ),
        ),
        SizedBox(height: 24.h),
        AppText(
          text: 'Reset Password',
          variant: AppTextVariant.headline,
          fontWeight: FontWeight.w800,
        ),
        SizedBox(height: 8.h),
        AppText(
          text: 'Enter your email to receive a password reset link',
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
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.onSurface.withValues(alpha: 0.06),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildEmailField(),
          SizedBox(height: 24.h),
          _buildResetButton(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Email Address',
          variant: AppTextVariant.label,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurfaceVariant,
        ),
        SizedBox(height: 8.h),
        _buildStyledInput(
          controller: _emailController,
          hint: 'name@example.com',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          prefixIcon: Icons.mail_outlined,
          validator: (value) {
            return Validators.validateEmail(value);
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
        color: AppColors.surfaceContainerHigh,
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

  Widget _buildResetButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthPasswordResetSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password reset link sent to your email'),
              backgroundColor: AppColors.primary,
            ),
          );
          context.go('/login');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return AppButton(
          text: 'Send Reset Link',
          icon: Icons.send_rounded,
          isFullWidth: true,
          isLoading: isLoading,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthCubit>().resetPassword(
                    _emailController.text.trim(),
                  );
            }
          },
        );
      },
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: 'Remember your password?',
          variant: AppTextVariant.body,
          color: AppColors.onSurfaceVariant,
        ),
        GestureDetector(
          onTap: () => context.go('/login'),
          child: AppText(
            text: 'Login',
            variant: AppTextVariant.body,
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
