import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_text.dart';

class TransactionsListScreen extends StatefulWidget {
  const TransactionsListScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsListScreen> createState() => _TransactionsListScreenState();
}

class _TransactionsListScreenState extends State<TransactionsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: AppText(
          text: 'Transactions',
          variant: AppTextVariant.title,
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Income'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTransactionList(),
          _buildTransactionList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/transactions/add'),
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add_rounded, color: AppColors.onPrimary),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildTransactionList() {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        _buildTransactionItem(
          icon: Icons.shopping_cart_rounded,
          iconColor: AppColors.primary,
          title: 'Grocery Store',
          date: 'Today, 10:24 AM',
          amount: '-\$142.50',
          isExpense: true,
        ),
        _buildTransactionItem(
          icon: Icons.payments_rounded,
          iconColor: AppColors.income,
          title: 'Monthly Salary',
          date: 'Yesterday',
          amount: '+\$5,240.00',
          isExpense: false,
        ),
        _buildTransactionItem(
          icon: Icons.coffee_rounded,
          iconColor: AppColors.secondary,
          title: 'Coffee Shop',
          date: 'Yesterday, 08:15 AM',
          amount: '-\$4.80',
          isExpense: true,
        ),
        _buildTransactionItem(
          icon: Icons.home_rounded,
          iconColor: AppColors.error,
          title: 'Rent Payment',
          date: 'Jan 1, 2024',
          amount: '-\$1,800.00',
          isExpense: true,
        ),
      ],
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String date,
    required String amount,
    required bool isExpense,
  }) {
    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: iconColor, size: 24.w),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: title,
                  variant: AppTextVariant.body,
                ),
                SizedBox(height: 4.h),
                AppText(
                  text: date,
                  variant: AppTextVariant.caption,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          AppText(
            text: amount,
            variant: AppTextVariant.body,
            color: isExpense ? AppColors.expense : AppColors.income,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withValues(alpha: 0.85),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        child: BottomNavigationBar(
          currentIndex: 1,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          elevation: 0,
          onTap: (index) {
            switch (index) {
              case 0:
                context.go('/');
                break;
              case 1:
                break;
              case 2:
                context.push('/goals');
                break;
              case 3:
                context.push('/insights');
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.receipt_long_rounded),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.flag_rounded),
              label: 'Goals',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.insights_rounded),
              label: 'Insights',
            ),
          ],
        ),
      ),
    );
  }
}
