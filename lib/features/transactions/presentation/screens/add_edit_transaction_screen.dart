import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_input.dart';
import '../../../../shared/widgets/app_text.dart';

class AddEditTransactionScreen extends StatefulWidget {
  const AddEditTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddEditTransactionScreen> createState() =>
      _AddEditTransactionScreenState();
}

class _AddEditTransactionScreenState extends State<AddEditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _transactionType = 'expense';
  String _selectedCategory = 'Food';
  String _selectedAccount = 'Main Wallet';

  final List<String> _categories = [
    'Food',
    'Transport',
    'Shopping',
    'Rent',
    'Entertainment',
    'Utilities',
  ];

  final List<String> _accounts = [
    'Main Wallet',
    'Savings Account',
    'Investment Fund',
  ];

  final Map<String, IconData> _categoryIcons = {
    'Food': Icons.restaurant_rounded,
    'Transport': Icons.directions_car_rounded,
    'Shopping': Icons.shopping_bag_rounded,
    'Rent': Icons.home_rounded,
    'Entertainment': Icons.movie_rounded,
    'Utilities': Icons.electrical_services_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: Icon(Icons.close_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: AppText(
          text: 'Add Transaction',
          variant: AppTextVariant.title,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTransactionTypeSelector(),
              SizedBox(height: 24.h),
              _buildAmountField(),
              SizedBox(height: 24.h),
              _buildDateSelector(),
              SizedBox(height: 24.h),
              _buildAccountSelector(),
              SizedBox(height: 24.h),
              _buildCategorySelector(),
              SizedBox(height: 24.h),
              _buildDescriptionField(),
              SizedBox(height: 32.h),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionTypeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          Expanded(
            child: _buildTypeButton('expense', 'Expense'),
          ),
          Expanded(
            child: _buildTypeButton('income', 'Income'),
          ),
          Expanded(
            child: _buildTypeButton('transfer', 'Transfer'),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton(String type, String label) {
    final isSelected = _transactionType == type;
    return GestureDetector(
      onTap: () => setState(() => _transactionType = type),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: AppText(
            text: label,
            variant: AppTextVariant.label,
            color: isSelected ? AppColors.onPrimary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Transaction Amount',
          variant: AppTextVariant.label,
          color: AppColors.textSecondary,
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              AppText(
                text: '\$',
                variant: AppTextVariant.headline,
                color: AppColors.textPrimary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    fillColor: Colors.transparent,
                    filled: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Date',
          variant: AppTextVariant.label,
          color: AppColors.textSecondary,
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_today_rounded,
                  color: AppColors.primary, size: 20.w),
              SizedBox(width: 12.w),
              AppText(
                text: 'Today',
                variant: AppTextVariant.body,
              ),
              SizedBox(width: 8.w),
              AppText(
                text: ', Apr 4, 2026',
                variant: AppTextVariant.body,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'From Account',
          variant: AppTextVariant.label,
          color: AppColors.textSecondary,
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(Icons.account_balance_wallet_rounded,
                  color: AppColors.primary, size: 20.w),
              SizedBox(width: 12.w),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedAccount,
                    isExpanded: true,
                    icon: Icon(Icons.expand_more_rounded,
                        color: AppColors.textSecondary),
                    items: _accounts.map((account) {
                      return DropdownMenuItem(
                        value: account,
                        child: AppText(
                          text: account,
                          variant: AppTextVariant.body,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedAccount = value);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: 'Category',
              variant: AppTextVariant.label,
              color: AppColors.textSecondary,
            ),
            TextButton(
              onPressed: () {},
              child: AppText(
                text: 'View All',
                variant: AppTextVariant.label,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: _categories.map((category) {
            final isSelected = _selectedCategory == category;
            return GestureDetector(
              onTap: () => setState(() => _selectedCategory = category),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(12.r),
                  border: isSelected
                      ? Border.all(color: AppColors.primary, width: 2)
                      : null,
                ),
                child: Column(
                  children: [
                    Icon(
                      _categoryIcons[category],
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      size: 24.w,
                    ),
                    SizedBox(height: 4.h),
                    AppText(
                      text: category,
                      variant: AppTextVariant.caption,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return AppInput(
      label: 'Description (Optional)',
      hint: 'Enter description',
      controller: _descriptionController,
      maxLines: 3,
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: AppButton(
        text: 'Save Transaction',
        icon: Icons.check_circle_rounded,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.pop();
          }
        },
        isFullWidth: true,
      ),
    );
  }
}
