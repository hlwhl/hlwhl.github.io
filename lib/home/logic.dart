import 'package:get/get.dart';
import 'package:openai_client/openai_client.dart';

import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  String _editingPrompt = "";

  String _apiKey = "";

  String response = "";

  init() async {
    var conf = OpenAIConfiguration(
      apiKey: _apiKey,
    );

    final client = OpenAIClient(configuration: conf);

    final respond = await client.completions
        .create(
            model: 'text-davinci-003',
            prompt:
                "请帮我把以下的工作内容填充为一篇完整的周报,用 markdown 格式以分点叙述的形式输出:$_editingPrompt",
            maxTokens: 1536)
        .data;
    response = respond.choices[0].text;
    update();
  }

  updatePrompt(String prompt) {
    _editingPrompt = prompt;
  }

  updateAPIKey(String key) {
    _apiKey = key;
  }
}
