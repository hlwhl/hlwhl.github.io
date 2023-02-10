import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final logic = Get.put(HomeLogic());

  final state = Get.find<HomeLogic>().state;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Text(
              "简单描述工作内容\n帮你生成完整周报",
              maxLines: 2,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("写周报头大? 我来帮你"),
            TextField(
              decoration: const InputDecoration(label: Text("api key:")),
              onChanged: (value) {
                logic.updateAPIKey(value);
              },
            ),
            TextField(
              decoration: const InputDecoration(label: Text("简单描述工作内容:")),
              onChanged: (value) {
                logic.updatePrompt(value);
              },
            ),
            MaterialButton(
              child: const Text(
                "生成",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              onPressed: () {
                logic.init();
              },
            ),
            GetBuilder<HomeLogic>(
              builder: (logic) {
                return Text(logic.response,
                    style: const TextStyle(fontSize: 12, color: Colors.black));
              },
            ),
          ],
        ),
      ),
    );
  }
}
