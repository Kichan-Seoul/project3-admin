import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderListSection extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const OrderListSection({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final sortedOrders = [...orders]
      ..sort((a, b) {
        // 미매칭 우선 → 최신순 정렬
        if (a['matched'] != b['matched']) {
          return a['matched'] ? 1 : -1;
        }
        return b['createdAt'].compareTo(a['createdAt']);
      });

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
            DataColumn(label: Text('제목')),
            DataColumn(label: Text('주문자')),
            DataColumn(label: Text('매칭 여부')),
          ],
          rows: sortedOrders.map((order) {
            return DataRow(cells: [
              DataCell(Text(DateFormat('yyyy-MM-dd HH:mm').format(order['createdAt']))),
              DataCell(Text(order['title'])),
              DataCell(Text(order['user'])),
              DataCell(
                Text(
                  order['matched'] ? '매칭' : '미매칭',
                  style: TextStyle(
                    color: order['matched'] ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 10
                  ),
                ),
              ),
            ]);
          }).toList(),
        ),
      ],
    );
  }
}