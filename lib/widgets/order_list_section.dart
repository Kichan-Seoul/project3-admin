import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderListSection extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const OrderListSection({super.key, required this.orders});

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
                isSettled
                    ? ElevatedButton(
                  onPressed: () {
                    // 정산 처리 로직 연결 예정
                    debugPrint("정산 처리: ${order['title']}");
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