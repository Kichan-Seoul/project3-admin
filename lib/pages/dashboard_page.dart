import 'package:flutter/material.dart';
import '../widgets/stats_card.dart';
import '../widgets/order_list_section.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyOrders = [
      {
        'createdAt': DateTime(2025, 6, 30, 14, 30),
        'title': '냉장식품 · 5t · 윙바디 요청',
        'email': 'user1@example.com',
        'matched': false,
      },
      {
        'createdAt': DateTime(2025, 6, 29, 11, 10),
        'title': '건축자재 · 10t · 카고 요청',
        'email': 'user2@example.com',
        'matched': true,
      },
      {
        'createdAt': DateTime(2025, 6, 28, 9, 5),
        'title': '가전제품 · 3.5t · 탑차 요청',
        'email': 'user3@example.com',
        'matched': false,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('대시보드', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // 요약 통계 카드
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              StatsCard(
                title: '총 등록 화물 주문',
                value: '128건',
                icon: Icons.local_shipping,
                color: Colors.blue,
              ),
              StatsCard(
                title: '매칭 완료 주문',
                value: '87건',
                icon: Icons.check_circle,
                color: Colors.green,
              ),
              StatsCard(
                title: '총 거래 금액',
                value: '₩35,200,000',
                icon: Icons.attach_money,
                color: Colors.deepPurple,
              ),
              StatsCard(
                title: '금일 등록',
                value: '5건',
                icon: Icons.today,
                color: Colors.orange,
              ),
            ],
          ),
          OrderListSection(orders: dummyOrders),
        ],
      ),
    );
  }
}