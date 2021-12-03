import 'package:flutter/material.dart';

class OTPUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: 500,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              //
              Center(
                child: Container(
                  width: 300,
                  // height:100,
                  //color: Colors.red,
                  child: TextField(
                    maxLength: 6,
                    cursorColor: Colors.transparent,
                    keyboardType: TextInputType.number,
                    cursorWidth: 0,
                    style: TextStyle(
                      letterSpacing: 30,
                      fontSize: 32,
                    ),
                    decoration: InputDecoration(
                     // border: InputBorder.none,
                      counterText: '',
                    ),
                  ),
                ),
              ),

              //
              Container(
                width: 300,
                margin: const EdgeInsets.only(top: 35),
                height: 2,
                //color:Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getBox(),
                    getBox(),
                    getBox(),
                    getBox(),
                    getBox(),
                    getBox(),
                  ],
                ),
              ),

              //
            ],
          ),
        ),
      ),
    );
  }

  Widget getBox() {
    return Container(
      width: double.infinity,
      color: Colors.black.withOpacity(0.5),
    );
  }
}
