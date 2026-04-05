import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../domain/entities/transaction.dart';
import '../cubits/transactions_state.dart';

class TransactionFilterSheet extends StatefulWidget {
  final TransactionFilter? currentFilter;
  final Function(TransactionFilter) onApply;

  const TransactionFilterSheet({
    super.key,
    this.currentFilter,
    required this.onApply,
  });

  @override
  State<TransactionFilterSheet> createState() => _TransactionFilterSheetState();
}

class _TransactionFilterSheetState extends State<TransactionFilterSheet> {
  TransactionType? _selectedType;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    if (widget.currentFilter != null) {
      _selectedType = widget.currentFilter!.type;
      _startDate = widget.currentFilter!.startDate;
      _endDate = widget.currentFilter!.endDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Filter Transactions',
                variant: AppTextVariant.title,
              ),
              IconButton(
                icon: Icon(Icons.close_rounded, color: AppColors.textSecondary),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          AppText(
            text: 'Transaction Type',
            variant: AppTextVariant.label,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 12.w,
            children: [
              _buildTypeChip(null, 'All'),
              _buildTypeChip(TransactionType.expense, 'Expense'),
              _buildTypeChip(TransactionType.income, 'Income'),
            ],
          ),
          SizedBox(height: 20.h),
          AppText(
            text: 'Date Range',
            variant: AppTextVariant.label,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: _buildDateField(
                  label: 'Start Date',
                  date: _startDate,
                  onTap: () => _selectDate(context, true),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildDateField(
                  label: 'End Date',
                  date: _endDate,
                  onTap: () => _selectDate(context, false),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Clear',
                  variant: AppButtonVariant.secondary,
                  onPressed: () {
                    setState(() {
                      _selectedType = null;
                      _startDate = null;
                      _endDate = null;
                    });
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AppButton(
                  text: 'Apply',
                  onPressed: () {
                    final filter = TransactionFilter(
                      type: _selectedType,
                      startDate: _startDate,
                      endDate: _endDate,
                    );
                    widget.onApply(filter);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  Widget _buildTypeChip(TransactionType? type, String label) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AppText(
          text: label,
          variant: AppTextVariant.caption,
          color: isSelected ? AppColors.onPrimary : AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: label,
              variant: AppTextVariant.caption,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 4.h),
            AppText(
              text: date != null
                  ? '${date.day}/${date.month}/${date.year}'
                  : 'Select date',
              variant: AppTextVariant.body,
              color: date != null ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final date = await showDatePicker(
      context: context,
      initialDate: isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        if (isStart) {
          _startDate = date;
        } else {
          _endDate = date;
        }
      });
    }
  }
}