import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_text.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({Key? key}) : super(key: key);

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: AppText(
          text: 'Spending Insights',
          variant: AppTextVariant.title,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMonthlyOverview(),
            SizedBox(height: 24.h),
            _buildCategoryBreakdown(),
            SizedBox(height: 24.h),
            _buildSpendingTrend(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildMonthlyOverview() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'This Month',
            variant: AppTextVariant.label,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 8.h),
          AppText(
            text: '\$2,810.20',
            variant: AppTextVariant.headline,
            color: AppColors.expense,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildOverviewItem('Income', '\$5,240.00', AppColors.income),
              SizedBox(width: 24.w),
              _buildOverviewItem('Saved', '\$2,429.80', AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(String label, String amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: label,
          variant: AppTextVariant.caption,
          color: AppColors.textSecondary,
        ),
        SizedBox(height: 4.h),
        AppText(
          text: amount,
          variant: AppTextVariant.body,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  Widget _buildCategoryBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Spending by Category',
          variant: AppTextVariant.title,
        ),
        SizedBox(height: 16.h),
        _buildCategoryItem(
            'Food & Dining', '\$850.00', 0.35, AppColors.primary),
        _buildCategoryItem('Transport', '\$420.00', 0.15, AppColors.secondary),
        _buildCategoryItem(
            'Shopping', '\$680.00', 0.24, const Color(0xFF9C27B0)),
        _buildCategoryItem('Rent', '\$1,800.00', 0.64, AppColors.error),
        _buildCategoryItem('Entertainment', '\$260.00', 0.09, Colors.purple),
      ],
    );
  }

  Widget _buildCategoryItem(
      String category, String amount, double percentage, Color color) {
    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Text(
                '${(percentage * 100).toInt()}%',
                style: TextStyle(
                  color: color,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: category,
                  variant: AppTextVariant.body,
                ),
                SizedBox(height: 4.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: LinearProgressIndicator(
                    value: percentage,
                    minHeight: 6.h,
                    backgroundColor: AppColors.surfaceContainer,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          AppText(
            text: amount,
            variant: AppTextVariant.body,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingTrend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Spending Trend',
          variant: AppTextVariant.title,
        ),
        SizedBox(height: 16.h),
        Container(
          height: 200.h,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: CustomPaint(
            size: Size(double.infinity, 168.h),
            painter: _TrendChartPainter(),
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTrendDay('Mon', 320),
            _buildTrendDay('Tue', 450),
            _buildTrendDay('Wed', 280),
            _buildTrendDay('Thu', 520),
            _buildTrendDay('Fri', 380),
            _buildTrendDay('Sat', 620),
            _buildTrendDay('Sun', 240),
          ],
        ),
      ],
    );
  }

  Widget _buildTrendDay(String day, int amount) {
    return Column(
      children: [
        Container(
          width: 32.w,
          height: (amount / 620 * 100).h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(height: 8.h),
        AppText(
          text: day,
          variant: AppTextVariant.caption,
          color: AppColors.textSecondary,
        ),
      ],
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
          currentIndex: 3,
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
                context.push('/transactions');
                break;
              case 2:
                context.push('/goals');
                break;
              case 3:
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

class _TrendChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.15, size.height * 0.3,
        size.width * 0.25, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.9,
        size.width * 0.5, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.65, size.height * 0.1,
        size.width * 0.75, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.9, size.width, size.height * 0.7);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
