import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'QuestionModle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Question> questionList = getQuestions();
  int currentQuestion = 0;
  Answers? selectedAns;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '- Simple Quiz App -',
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            Text(
              'Question ${currentQuestion + 1}/${questionList.length}',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(
              height: 40,
            ),
            Stack(clipBehavior: Clip.none, children: [
              Container(
                alignment: Alignment.center,
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  questionList[currentQuestion].questionText,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              const Positioned(
                left: -20,
                top: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                ),
              ),
              const Positioned(
                right: -20,
                top: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: -25,
                child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: const Icon(Icons.check_sharp,
                        size: 50, color: Colors.green)),
              )
            ]),
            Column(
              children: [
                for (Answers ans in questionList[currentQuestion].answerList)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnsBtn(ans),
                  )
              ],
            ),
            nextButton(),
          ],
        ),
      ),
    );
  }

  Widget AnsBtn(Answers ans) {
    bool is_selected = ans == selectedAns;
    return Container(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedAns = ans;
          });
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(200, 30),
          primary: is_selected ? Colors.orange : Colors.white,
        ),
        child: Text(ans.answerText,
            style: const TextStyle(color: Colors.black, fontSize: 18)),
      ),
    );
  }

  nextButton() {
    bool isLastQuestion = false;
    if (currentQuestion == questionList.length - 1) {
      isLastQuestion = true;
    }

    return ElevatedButton(
        onPressed: () {
          if (selectedAns!.isCorrect) {
            score++;
          }
          if (selectedAns == null) {
          } else {
            if (isLastQuestion) {
              bool isPassed = score >= questionList.length * 0.5;
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text(
                      '${isPassed ? 'Passed' : 'Failed'}|| Score is $score',
                      style: TextStyle(
                          color: isPassed ? Colors.green : Colors.red),
                    ),
                    content: SizedBox(
                      height: 50,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              score = 0;
                              currentQuestion = 0;
                              selectedAns = null;
                            });
                          },
                          child: const Text('Restart'),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              setState(() {
                selectedAns = null;
                currentQuestion++;
              });
            }
          }
        },
        child: Text(
          isLastQuestion ? "Submit" : "Next",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }
}
