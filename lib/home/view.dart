import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("powered by"),
                Image(
                  image: AssetImage("assets/logo.jpg"),
                  width: 200,
                ),
              ],
            ),
            const Text(
              "简单描述工作内容\n帮你生成完整周报",
              maxLines: 2,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("写周报头大? 我来帮你"),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: TextField(
                decoration: const InputDecoration(label: Text("api key:")),
                onChanged: (value) {
                  logic.updateAPIKey(value);
                },
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: TextField(
                maxLength: 500,
                decoration: const InputDecoration(
                    label: Text("简单描述工作内容:"), hintText: "完成新闻稿的编写及发布"),
                onChanged: (value) {
                  logic.updatePrompt(value);
                },
              ),
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
                return Expanded(
                    child: Markdown(selectable: true, data: logic.response));
              },
            ),
          ],
        ),
      ),
    );
  }
}
