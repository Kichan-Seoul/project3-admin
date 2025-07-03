// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../widgets/stats_card.dart';
// import '../widgets/order_list_section.dart';
//
// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final dummyOrders = [
//       {
//         'createdAt': DateTime(2025, 6, 30, 14, 30),
//         'title': '냉장식품 · 5t · 윙바디 요청',
//         'email': 'user1@example.com',
//         'matched': false,
//       },
//       {
//         'createdAt': DateTime(2025, 6, 29, 11, 10),
//         'title': '건축자재 · 10t · 카고 요청',
//         'email': 'user2@example.com',
//         'matched': true,
//       },
//       {
//         'createdAt': DateTime(2025, 6, 28, 9, 5),
//         'title': '가전제품 · 3.5t · 탑차 요청',
//         'email': 'user3@example.com',
//         'matched': false,
//       },
//     ];
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('대시보드', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 20),
//
//           // 요약 통계 카드
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: const [
//               StatsCard(
//                 title: '총 등록 화물 주문',
//                 value: '128건',
//                 icon: Icons.local_shipping,
//                 color: Colors.blue,
//               ),
//               StatsCard(
//                 title: '매칭 완료 주문',
//                 value: '87건',
//                 icon: Icons.check_circle,
//                 color: Colors.green,
//               ),
//               StatsCard(
//                 title: '총 거래 금액',
//                 value: '₩35,200,000',
//                 icon: Icons.attach_money,
//                 color: Colors.deepPurple,
//               ),
//               StatsCard(
//                 title: '금일 등록',
//                 value: '5건',
//                 icon: Icons.today,
//                 color: Colors.orange,
//               ),
//             ],
//           ),
//           OrderListSection(orders: dummyOrders),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/stats_card.dart';
import '../widgets/order_list_section.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final deliverySnapshot = await FirebaseFirestore.instance
        .collection('delivery_requests')
        .get();

    final orders = <Map<String, dynamic>>[];

    for (final doc in deliverySnapshot.docs) {
      final d = doc.data();
      final uid = d['uid'];

      // 사용자 정보 가져오기
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      final userData = userDoc.data();
      final email = userData?['email'] ?? 'unknown@email.com';
      final displayName = userData?['displayName'] ?? 'Unknown';

      orders.add({
        'createdAt': (d['createdAt'] as Timestamp).toDate(),
        'title':
        '${d['itemType'] ?? '화물'} · ${d['weight'] ?? '?'}kg · ${d['vehicleType'] ?? '차량 미지정'}',
        'user': '$displayName ($email)',
        'status': d['status'] ?? '알 수 없음',
      });
    }

    setState(() {
      this.orders = orders;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('대시보드',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
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
          const SizedBox(height: 16),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : OrderListSection(orders: orders),
        ],
      ),
    );
  }
}