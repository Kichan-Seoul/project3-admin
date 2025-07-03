import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderListSection extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const OrderListSection({super.key, required this.orders});

  Future<void> settlePayment({
    required String requestId,
    required String driverUid,
    required int price,
  }) async {
    final firestore = FirebaseFirestore.instance;

    // 1. 거래 상태 업데이트
    await firestore.collection('delivery_requests').doc(requestId).update({
      'status': '대금 지불 완료',
      'updatedAt': Timestamp.now(),
    });

    // 2. 사용자 balance 업데이트
    final userRef = firestore.collection('users').doc(driverUid);
    final userDoc = await userRef.get();
    final data = userDoc.data() ?? {};

    final currentBalance = data['balance'] ?? 0;
    final updatedBalance = currentBalance + price;

    await userRef.update({
      'balance': updatedBalance,
    });
  }

  @override
  Widget build(BuildContext context) {
    final sortedOrders = [...orders]
      ..sort((a, b) => b['createdAt'].compareTo(a['createdAt']));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        const Text('주문 목록',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        DataTable(
          columns: const [
            DataColumn(label: Text('주문일')),
            DataColumn(label: Text('주문내용')),
            DataColumn(label: Text('주문자')),
            DataColumn(label: Text('상태')),
            DataColumn(label: Text('정산')),
          ],
          rows: sortedOrders.map((order) {
            final status = order['status'];
            final isSettled = status == '대금 지불 완료';

            return DataRow(cells: [
              DataCell(Text(DateFormat('yyyy-MM-dd HH:mm').format(order['createdAt']))),
              DataCell(Text(order['title'])),
              DataCell(Text(order['user'])),
              DataCell(Text(
                status,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSettled
                      ? Colors.green
                      : (status == '배송중' ? Colors.blue : Colors.black),
                ),
              )),
              DataCell(
                status == '대금 지불 대기'
                    ? ElevatedButton(
                  onPressed: () async {
                    final requestId = order['requestId'];
                    final driverUid = order['assignedDriverId'];
                    final price = order['price'] ?? 0;

                    try {
                      await settlePayment(
                        requestId: requestId,
                        driverUid: driverUid,
                        price: price,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('정산 완료되었습니다.')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('정산 실패: $e')),
                      );
                    }
                  },
                  child: const Text('정산'),
                )
                    : const Text('-', style: TextStyle(color: Colors.grey)),
              ),
            ]);
          }).toList(),
        ),
      ],
    );
  }
}