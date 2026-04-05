import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_input.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../domain/entities/transaction.dart';
import '../cubits/transactions_cubit.dart';
import '../cubits/transactions_state.dart';

class AddEditTransactionScreen extends StatefulWidget {
  final Transaction? transaction;

  const AddEditTransactionScreen({Key? key, this.transaction})
      : super(key: key);

  @override
  State<AddEditTransactionScreen> createState() =>
      _AddEditTransactionScreenState();
}

class _AddEditTransactionScreenState extends State<AddEditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _amountController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _descriptionController = TextEditingController();

    final cubit = context.read<TransactionsCubit>();

    if (widget.transaction != null) {
      _amountController.text = widget.transaction!.amount.toString();
      _descriptionController.text = widget.transaction!.note ?? '';
      cubit.setTransactionType(widget.transaction!.type);
      cubit.setCategory(widget.transaction!.category);
      cubit.setDate(widget.transaction!.date);
    } else {
      cubit.resetForm();
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTransaction(BuildContext context, TransactionFormState formState) {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      final cubit = context.read<TransactionsCubit>();

      if (widget.transaction != null) {
        final updated = widget.transaction!.copyWith(
          amount: amount,
          type: formState.type,
          category: formState.category,
          date: formState.date,
          note: _descriptionController.text.isNotEmpty
              ? _descriptionController.text
              : null,
        );
        cubit.updateTransaction(updated);
      } else {
        cubit.addTransaction(
          amount: amount,
          type: formState.type,
          category: formState.category,
          date: formState.date,
          note: _descriptionController.text.isNotEmpty
              ? _descriptionController.text
              : null,
        );
      }
    }
  }

  List<String> _getCategories(TransactionType type) {
    return TransactionCategories.getByType(type);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build");
    return BlocConsumer<TransactionsCubit, TransactionsState>(
      listener: (context, state) {
        if (state is TransactionAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transaction added successfully')),
          );
          context.read<TransactionsCubit>().resetForm();
          context.pop();
        } else if (state is TransactionUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transaction updated successfully')),
          );
          context.read<TransactionsCubit>().resetForm();
          context.pop();
        } else if (state is TransactionsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      listenWhen: (previous, current) {
        return current is TransactionAdded ||
            current is TransactionUpdated ||
            current is TransactionsError;
      },
      builder: (context, state) {
        final isLoading = state is TransactionsLoading;

        TransactionFormState formState;
        if (state is TransactionFormState) {
          formState = state;
        } else {
          formState = TransactionFormState.initial();
        }

        final categories = _getCategories(formState.type);

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.surface,
            leading: IconButton(
              icon: Icon(Icons.close_rounded, color: AppColors.textPrimary),
              onPressed: () {
                context.read<TransactionsCubit>().resetForm();
                context.pop();
              },
            ),
            title: AppText(
              text: widget.transaction != null
                  ? 'Edit Transaction'
                  : 'Add Transaction',
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
                  _buildTransactionTypeSelector(context, formState.type),
                  SizedBox(height: 24.h),
                  _buildAmountField(),
                  SizedBox(height: 24.h),
                  _buildDateSelector(context, formState.date),
                  SizedBox(height: 24.h),
                  _buildCategorySelector(
                    context,
                    formState.category,
                    categories,
                  ),
                  SizedBox(height: 24.h),
                  _buildDescriptionField(),
                  SizedBox(height: 32.h),
                  _buildSaveButton(context, formState, isLoading),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTransactionTypeSelector(
    BuildContext context,
    TransactionType currentType,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          Expanded(
            child: _buildTypeButton(
              context,
              TransactionType.expense,
              'Expense',
              currentType == TransactionType.expense,
            ),
          ),
          Expanded(
            child: _buildTypeButton(
              context,
              TransactionType.income,
              'Income',
              currentType == TransactionType.income,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton(
    BuildContext context,
    TransactionType type,
    String label,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () => context.read<TransactionsCubit>().setTransactionType(type),
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
                child: TextFormField(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Amount is required';
                    }
                    final amount = double.tryParse(value);
                    if (amount == null) {
                      return 'Please enter a valid number';
                    }
                    if (amount <= 0) {
                      return 'Amount must be greater than zero';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector(BuildContext context, DateTime currentDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Date',
          variant: AppTextVariant.label,
          color: AppColors.textSecondary,
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: currentDate,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              context.read<TransactionsCubit>().setDate(date);
            }
          },
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.primary,
                  size: 20.w,
                ),
                SizedBox(width: 12.w),
                AppText(
                  text:
                      '${currentDate.day}/${currentDate.month}/${currentDate.year}',
                  variant: AppTextVariant.body,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelector(
    BuildContext context,
    String currentCategory,
    List<String> categories,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Category',
          variant: AppTextVariant.label,
          color: AppColors.textSecondary,
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: categories.map((category) {
            final isSelected = currentCategory == category;
            return GestureDetector(
              onTap: () =>
                  context.read<TransactionsCubit>().setCategory(category),
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
                child: AppText(
                  text: category,
                  variant: AppTextVariant.caption,
                  color:
                      isSelected ? AppColors.primary : AppColors.textSecondary,
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

  Widget _buildSaveButton(
    BuildContext context,
    TransactionFormState formState,
    bool isLoading,
  ) {
    return SizedBox(
      width: double.infinity,
      child: AppButton(
        text: isLoading ? 'Saving...' : 'Save Transaction',
        icon: Icons.check_circle_rounded,
        onPressed: () => _saveTransaction(context, formState),
        isFullWidth: true,
        isLoading: isLoading,
      ),
    );
  }
}
