import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
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
            Icons.eco_rounded,
            color: AppColors.primary,
            size: 32.w,
          ),
        ),
        SizedBox(height: 24.h),
        AppText(
          text: 'Welcome Back',
          variant: AppTextVariant.headline,
          fontWeight: FontWeight.w800,
        ),
        SizedBox(height: 8.h),
        AppText(
          text: 'Sign in to continue managing your finances',
          variant: AppTextVariant.body,
          color: AppColors.onSurfaceVariant,
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
          SizedBox(height: 20.h),
          _buildPasswordField(),
          SizedBox(height: 16.h),
          _buildForgotPassword(),
          SizedBox(height: 24.h),
          _buildLoginButton(),
          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),
          _buildSocialLogin(),
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
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.mail_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
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
          text: 'Password',
          variant: AppTextVariant.label,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurfaceVariant,
        ),
        SizedBox(height: 8.h),
        _buildStyledInput(
          controller: _passwordController,
          hint: '••••••••',
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
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
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
        style: TextStyle(
          color: AppColors.onSurface,
          fontSize: 16.sp,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.outline),
          prefixIcon:
              Icon(prefixIcon, color: AppColors.onSurfaceVariant, size: 20.w),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {},
        child: AppText(
          text: 'Forgot Password?',
          variant: AppTextVariant.label,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return AppButton(
      text: 'Sign In',
      icon: Icons.arrow_forward_rounded,
      isFullWidth: true,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          context.go('/');
        }
      },
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.surfaceContainer)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AppText(
            text: 'or',
            variant: AppTextVariant.label,
            fontWeight: FontWeight.w700,
            color: AppColors.outline,
          ),
        ),
        Expanded(child: Divider(color: AppColors.surfaceContainer)),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        AppButton(
          text: 'Google',
          icon: Icons.g_mobiledata_rounded,
          variant: AppButtonVariant.outlined,
          isFullWidth: true,
          onPressed: () {},
        ),
        SizedBox(height: 12.h),
        AppButton(
          text: 'Apple',
          icon: Icons.apple_rounded,
          variant: AppButtonVariant.outlined,
          isFullWidth: true,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: "Don't have an account?",
          variant: AppTextVariant.body,
          color: AppColors.onSurfaceVariant,
        ),
        GestureDetector(
          onTap: () => context.push('/register'),
          child: AppText(
            text: 'Sign Up',
            variant: AppTextVariant.body,
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
