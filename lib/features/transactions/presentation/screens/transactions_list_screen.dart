import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../domain/entities/transaction.dart';
import '../cubits/transactions_cubit.dart';
import '../cubits/transactions_state.dart';
import '../widgets/transaction_filter_sheet.dart';

class TransactionsListScreen extends StatefulWidget {
  const TransactionsListScreen({super.key});

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TransactionsCubit>().loadTransactions();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransactionsCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: SizedBox.shrink(),
        backgroundColor: AppColors.surface,
        title: AppText(text: 'Transactions', variant: AppTextVariant.title),
        actions: [
          BlocBuilder<TransactionsCubit, TransactionsState>(
            builder: (context, state) {
              final hasFilter =
                  state is TransactionsLoaded &&
                  state.activeFilter != null &&
                  !state.activeFilter!.isEmpty;
              return IconButton(
                icon: Icon(
                  Icons.filter_list_rounded,
                  color: hasFilter
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
                onPressed: () => _showFilterSheet(context),
              );
            },
          ),
        ],
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),

              decoration: InputDecoration(
                hintText: 'Search transactions...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.surfaceContainer,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  cubit.clearFilter();
                } else {
                  cubit.filterTransactions(
                    TransactionFilter(searchQuery: value),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<TransactionsCubit, TransactionsState>(
              builder: (context, state) {
                if (state is TransactionsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is TransactionsError) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 64.w,
                            color: Colors.red[400],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Something went wrong',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            state.message,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[500],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          TextButton(
                            onPressed: () {
                              context.read<TransactionsCubit>().loadTransactions();
                            },
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                List<Transaction> transactions = [];

                if (state is TransactionsLoaded) {
                  transactions = state.transactions;
                }

                if (transactions.isEmpty) {
                  return _buildEmptyState();
                }

                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTransactionList(transactions),
                    _buildTransactionList(
                      transactions
                          .where((t) => t.type == TransactionType.income)
                          .toList(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context
            .push('/transactions/add')
            .then(
              (value) => context.read<TransactionsCubit>().loadTransactions(),
            ),
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add_rounded, color: AppColors.onPrimary),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  void _showDeleteConfirmation(BuildContext ctx, Transaction transaction) {
    showDialog(
      context: ctx,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: Text(
          'Are you sure you want to delete this ${transaction.type == TransactionType.income ? 'income' : 'expense'} of \$${transaction.amount.toStringAsFixed(2)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              ctx.read<TransactionsCubit>().deleteTransaction(transaction.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext ctx) {
    final cubit = ctx.read<TransactionsCubit>();
    TransactionFilter? currentFilter;
    final state = cubit.state;
    if (state is TransactionsLoaded) {
      currentFilter = state.activeFilter;
    }

    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => TransactionFilterSheet(
        currentFilter: currentFilter,
        onApply: (filter) {
          if (filter.isEmpty) {
            cubit.clearFilter();
          } else {
            cubit.filterTransactions(filter);
          }
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyStateWidget(
      icon: Icons.receipt_long_rounded,
      title: 'No Transactions Yet',
      message: 'Start tracking your finances by adding your first transaction.',
      actionLabel: 'Add Transaction',
      onAction: () => context.push('/transactions/add'),
    );
  }

  Widget _buildTransactionList(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          'No transactions in this category',
          style: TextStyle(color: Colors.grey[600]),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final isExpense = transaction.type == TransactionType.expense;
        final amountColor = isExpense ? AppColors.expense : AppColors.income;
        final amountPrefix = isExpense ? '-' : '+';

        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: AppCard(
            padding: EdgeInsets.all(16.w),
            onTap: () => context.push('/transactions/add', extra: transaction),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: amountColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    isExpense
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    color: amountColor,
                    size: 24.w,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: transaction.category,
                        variant: AppTextVariant.body,
                      ),
                      SizedBox(height: 4.h),
                      AppText(
                        text: _formatDate(transaction.date),
                        variant: AppTextVariant.caption,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _showDeleteConfirmation(context, transaction),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.textSecondary,
                    size: 20.w,
                  ),
                ),
                SizedBox(width: 8.w),
                AppText(
                  text:
                      '$amountPrefix\$${transaction.amount.toStringAsFixed(2)}',
                  variant: AppTextVariant.body,
                  color: amountColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return 'Today';
    } else if (transactionDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
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
                context.go('/dashboard');
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
