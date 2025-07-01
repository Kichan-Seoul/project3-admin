import 'package:flutter/material.dart';

class Topbar extends StatelessWidget {
  const Topbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.indigo[100],
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('화물운송 관리자페이지', style: TextStyle(fontSize: 20)),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // 로그아웃 기능 추가 예정
            },
          )
        ],
      ),
    );
  }
}