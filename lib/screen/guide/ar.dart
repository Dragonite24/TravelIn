import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:travel_in/blocs/attractions/attractions_state.dart';
import 'package:travel_in/components/indicator.dart';
import 'package:travel_in/constants.dart';
import 'package:travel_in/models/attractions_model.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import '../../blocs/attractions/attractions_bloc.dart';

/// Экран с дополненной реальностью
class ARPage extends StatefulWidget {
  final num index;

  const ARPage({Key key, this.index}) : super(key: key);

  @override
  _ARPageState createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  ArCoreController arCoreController;

  /// Синтез речи
  FlutterTts flutterTts = FlutterTts();


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttractionsBloc, AttractionsState>(
        builder: (BuildContext context, AttractionsState state) {
      if (state is AttractionsLoadedState) {
        return Scaffold(
          body: Stack(
            children: [
              ArCoreView(
                onArCoreViewCreated: _onArCoreViewCreated,
                enableTapRecognizer: true,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (Question question
                      in state.attractions[widget.index ?? 0].questions)
                    Container(
                      width: double.infinity,
                      color: CColors.dark_grey.withOpacity(0.6),
                      child: MaterialButton(
                        onPressed: () {
                          say(question.answer);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Row(
                              children: [
                                Text(
                                  question.question,
                                  style:TextStyle(color:  CColors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        );
      } else {
        return Indicator.circle;
      }
    });
  }

  void say(String s) async {
    await flutterTts.setPitch(0.5);
    await flutterTts.setLanguage("ru-RU");
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(s);
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addSphere(controller);
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  _addSphere(ArCoreController _arcoreController) {
    final material = ArCoreMaterial(color: Colors.deepPurple);
    final sphere = ArCoreSphere(materials: [material], radius: 0.2);
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(
        0,
        0,
        -1,
      ),
    );

    _arcoreController.addArCoreNodeWithAnchor(node);
  }

  void onTapHandler(String name) =>
      print("Для чего использовать касание гида?");

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addGuide(hit);
  }

  /// Размещение гида на поверхности по касанию
  void _addGuide(ArCoreHitTestResult plane) {
    print("HIT");
    var guideNode = ArCoreReferenceNode(
      name: "untitled.sfb",
      object3DFileName: "untitled.sfb",
      position: plane.pose.translation,
      rotation: plane.pose.rotation,
    );
    arCoreController.addArCoreNodeWithAnchor(guideNode);
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
