import 'package:flutter/material.dart';
import 'package:moneymate/util/images.dart';
import 'package:moneymate/view/screen/auth/login_screen.dart';
import 'package:moneymate/view/screen/auth/signUp_screen.dart';
// import 'package:splitwise/view/screen/auth/signUp_screen.dart';
// import 'package:splitwise/view/screen/home/home_screen.dart';

class CustomToolbarShape extends CustomPainter {
  final Color? lineColor;

  const CustomToolbarShape({this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Color myColor = Color(0xFF4CBB9B);

//First oval
    Path path = Path();
    Rect pathGradientRect = Rect.fromCircle(
      center: Offset(size.width / 4, 0),
      radius: size.width / 1.4,
    );

    Gradient gradient = LinearGradient(
      colors: <Color>[
        myColor.withOpacity(1.0), // Full opacity
        myColor.withOpacity(0.8),
      ],
      stops: [
        0.3,
        1.0,
      ],
    );

    path.lineTo(-size.width / 1.4, 0);
    path.quadraticBezierTo(
        size.width / 2, size.height * 2, size.width + size.width / 1.4, 0);

    paint.color = myColor;
    paint.shader = gradient.createShader(pathGradientRect);
    paint.strokeWidth = 40;
    path.close();

    canvas.drawPath(path, paint);

//Second oval
    // Rect secondOvalRect = Rect.fromPoints(
    //   Offset(-size.width / 2.5, -size.height),
    //   Offset(size.width * 1.4, size.height / 1.5),
    // );

    // gradient = LinearGradient(
    //   colors: <Color>[
    //     myColor.withOpacity(1.0), // Full opacity
    //     myColor.withOpacity(0.2),
    //   ],
    //   stops: [
    //     0.0,
    //     1.0,
    //   ],
    // );
    // Paint secondOvalPaint = Paint()
    //   ..color = myColor
    //   ..shader = gradient.createShader(secondOvalRect);

    // canvas.drawOval(secondOvalRect, secondOvalPaint);

//Third oval
    // Rect thirdOvalRect = Rect.fromPoints(
    //   Offset(-size.width / 2.5, -size.height),
    //   Offset(size.width * 1.4, size.height / 2.7),
    // );

    // gradient = LinearGradient(
    //   colors: <Color>[
    //     myColor.withOpacity(1.0), // Full opacity
    //     myColor.withOpacity(0.2),
    //   ],
    //   stops: [
    //     0.0,
    //     1.0,
    //   ],
    // );
    // Paint thirdOvalPaint = Paint()
    //   ..color = myColor
    //   ..shader = gradient.createShader(thirdOvalRect);

    // canvas.drawOval(thirdOvalRect, thirdOvalPaint);

//Fourth oval
    // Rect fourthOvalRect = Rect.fromPoints(
    //   Offset(-size.width / 2.4, -size.width / 1.875),
    //   Offset(size.width / 1.34, size.height / 1.14),
    // );

    // gradient = LinearGradient(
    //   colors: <Color>[
    //     myColor.withOpacity(1.0), // Full opacity
    //     myColor.withOpacity(0.2),
    //   ],
    //   stops: [
    //     0.3,
    //     1.0,
    //   ],
    // );
    // Paint fourthOvalPaint = Paint()
    //   ..color = myColor
    //   ..shader = gradient.createShader(fourthOvalRect);

    // canvas.drawOval(fourthOvalRect, fourthOvalPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: height,
        child: Stack(fit: StackFit.loose, children: <Widget>[
          Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: height,
              child: CustomPaint(
                painter: CustomToolbarShape(lineColor: Colors.green),
              )),
          Align(
            alignment: Alignment(0.0, 1.25),
            child: Container(
              height: MediaQuery.of(context).size.height / 10,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Container(
                  decoration: new BoxDecoration(
                    boxShadow: [
                      // BoxShadow(
                      //   color: Colors.black12,
                      //   blurRadius: 20.0,
                      //   // shadow
                      //   spreadRadius: .5,
                      //   // set effect of extending the shadow
                      //   offset: Offset(
                      //     0.0,
                      //     5.0,
                      //   ),
                      // )
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      border: Border(
                        top: BorderSide(
                            color: Color.fromARGB(255, 210, 210, 210),
                            width: 1),
                        left: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 210, 210, 210)),
                        right: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 210, 210, 210)),
                      ),
                      boxShadow: [
                        // BoxShadow(
                        //     color: Colors.grey.withOpacity(0.2),
                        //     spreadRadius: 1,
                        //     blurRadius: 7,
                        //     offset: Offset(0, 1))
                      ],
                      color: Colors.white,
                    ),
                    height: 150, // Adjust the height
                    width: 500,
                  )),
            ),
          ),
          // Container(child: Text("Hello")),
          Row(children: [
            Align(
              alignment: Alignment(0.9, -0.5),
              child: Container(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 3,
                child: Image.asset(Images.logoImage),
              ),
            ),
            Align(
              alignment: Alignment(0.9, -0.3),
              child: Container(
                height: MediaQuery.of(context).size.height / 13,
                width: MediaQuery.of(context).size.width / 3,
                child: Text("MoneyMate"),
              ),
            ),
          ]),
          Align(
            alignment: Alignment(0.9, 0.2),
            child: Container(
              height: MediaQuery.of(context).size.height / 13,
              width: MediaQuery.of(context).size.width / 3,
              child: TextButton(
                onPressed: () {
                  // print("Sign up");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Text("Sign UP", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.9, 0.2),
            child: Container(
              height: MediaQuery.of(context).size.height / 13,
              width: MediaQuery.of(context).size.width / 3,
              child: TextButton(
                onPressed: () {
                  // print("object");
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text("Login", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ]));
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
