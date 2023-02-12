import 'package:dart_openai/openai.dart';
import 'package:get/get.dart';

import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  String _editingPrompt = "";

  String _apiKey = "";

  String response = "";

  init() async {
    OpenAI.apiKey = _apiKey;
    var completionStream = OpenAI.instance.completion.createStream(
      model: "text-davinci-003",
      prompt: "请帮我把以下的工作内容填充为一篇完整的周报,用 markdown 格式以分点叙述的形式输出:$_editingPrompt",
      maxTokens: 1000,
      temperature: 0.5,
      topP: 1,
    );

    var subscription = completionStream.listen((event) {
      response += event.choices.first.text;
      update();
    }, onDone: () {
    }, onError: (error) {
    }, cancelOnError: true);
  }

  updatePrompt(String prompt) {
    _editingPrompt = prompt;
  }

  updateAPIKey(String key) {
    _apiKey = key;
  }
}
