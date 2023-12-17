import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class MicForm extends StatefulWidget {
  @override
  State<MicForm> createState() => _MicFormState();
}

class _MicFormState extends State<MicForm> {
  bool _isListening = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
      ),
      child: Padding(
         padding: EdgeInsets.only(left: 30, top: 70, right: 30, bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(_isListening? 'Đang nghe...' : 'Mi-crô đang tắt. Mời bạn nói lại.', style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.normal,decoration: TextDecoration.none),),
                  ],
                ),
              ],
            ),
            // AvatarGlow widget here
            Column(
              children: [
                Container(
                  child: AvatarGlow(
                    glowColor: primaryColors,
                    endRadius: 80.0,
                    animate: _isListening,
                    duration: Duration(milliseconds: 2000),
                    repeatPauseDuration: Duration(milliseconds: 100),
                    repeat: true,
                    showTwoGlows: true,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isListening = !_isListening;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: primaryColors,
                        radius: 40.0,
                        child: Icon(
                          _isListening ? Icons.mic : Icons.mic_none,
                          color: white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(_isListening? '' : 'Nhấn vào micrô để thử lại',  style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.normal, decoration: TextDecoration.none),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
