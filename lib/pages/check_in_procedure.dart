import 'package:auto_size_text/auto_size_text.dart';
import 'package:boat_support/constants/strings.dart';
import 'package:boat_support/dialogs/admin_verification.dart';
import 'package:boat_support/dialogs/boat_pick.dart';
import 'package:boat_support/dialogs/checkin/dialog_checkin_issue.dart';
import 'package:boat_support/dialogs/checkin/dialog_help.dart';
import 'package:boat_support/dialogs/report_issue.dart';
import 'package:boat_support/models/check_in_model.dart';
import 'package:boat_support/pages/settings_page.dart';
import 'package:boat_support/services/api_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../dialogs/checkin/dialog_confirm_checkin.dart';
import '../dialogs/checkin/template.dart';

class CheckIn extends StatefulWidget {
  CheckInModel boatCheckIn = CheckInModel();
  int index = 0;
  ScrollController scrollController = ScrollController();

  double progressPercent = 0;
  String progressText = "Progress Bar";

  CheckIn({Key? key}) : super(key: key);

  @override
  CheckInState createState() => CheckInState();
}

class CheckInState extends State<CheckIn> {
  @override
  void initState() {
    super.initState();
  }

  bool buttonenabled = false;

  bool yesValue = false;
  bool noValue = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.05), BlendMode.dstATop),
              image: const AssetImage("assets/images/background_image_2.jpg"),
            ),
          ),
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: const [
                  Center(
                    child: AutoSizeText(
                      "CHECK IN",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: AutoSizeText(
                      "Help: " + Strings.charterHelp,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 33,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              AutoSizeText(
                widget.boatCheckIn.checklist[widget.index].name.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                controller: widget.scrollController,
                scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: width / 1.2,
                      maxWidth: width / 1.2,
                      minHeight: height / 5,
                      maxHeight: height / 4.5),
                  child: AutoSizeText(
                    widget.boatCheckIn.checklist[widget.index].description
                        .toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogHelp(
                            widget.boatCheckIn.checklist[widget.index]);
                      });
                },
                child: Container(
                  width: width / 6,
                  height: height / 15,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.help,
                        color: Color(0xFF202124),
                        size: 40,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      AutoSizeText(
                        "Help",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF202124)),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: width / 1.2,
                child: const AutoSizeText(
                  "Please acknowledge that you have checked that the above item/items is accounted for/undameged and in good condition",
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: width / 2.2,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          yesValue = !yesValue;
                          noValue = false;
                          widget.boatCheckIn.checklist[widget.index]
                              .acknowledgment = yesValue;

                          if (yesValue || noValue) {
                            buttonenabled = true;
                          } else {
                            buttonenabled = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.scale(
                            scale: 2,
                            child: Checkbox(
                              value: yesValue,
                              onChanged: (newValue) {
                                setState(() {
                                  yesValue = newValue!;
                                  noValue = false;
                                  widget.boatCheckIn.checklist[widget.index]
                                      .acknowledgment = yesValue;

                                  if (yesValue || noValue) {
                                    buttonenabled = true;
                                  } else {
                                    buttonenabled = false;
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const AutoSizeText(
                            "YES",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 35,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width / 2.2,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          noValue = !noValue;
                          yesValue = false;
                          widget.boatCheckIn.checklist[widget.index]
                              .acknowledgment = yesValue;

                          if (yesValue || noValue) {
                            buttonenabled = true;
                          } else {
                            buttonenabled = false;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.scale(
                            scale: 2,
                            child: Checkbox(
                              value: noValue,
                              onChanged: (newValue) {
                                setState(() {
                                  noValue = newValue!;
                                  yesValue = false;
                                  widget.boatCheckIn.checklist[widget.index]
                                      .acknowledgment = yesValue;
                                  if (yesValue || noValue) {
                                    buttonenabled = true;
                                  } else {
                                    buttonenabled = false;
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const AutoSizeText(
                            "NO",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 35,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: width / 4,
                child: ElevatedButton(
                  onPressed: buttonenabled
                      ? () {
                    widget.boatCheckIn.checklist[widget.index]
                        .acknowledgment = yesValue;
                          if (noValue) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return DialogCheckInIssue(
                                      notifyParent: issueReport);
                                });
                          } else if (widget.index ==
                              widget.boatCheckIn.checklist.length - 1) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return DialogCompleteCheckIn(
                                      widget.boatCheckIn);
                                });
                          } else if (yesValue) {
                            setState(() {
                              nextSegment();
                            });
                          }
                        }
                      : null,
                  child: const Align(
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      ("Continue"),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              LinearPercentIndicator(
                width: width,
                lineHeight: 35,
                percent: widget.progressPercent,
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
                center: Text(
                  widget.progressText.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF202124),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void issueReport(String problem, String image) {
    widget.boatCheckIn.checklist[widget.index].problem = problem;
    widget.boatCheckIn.checklist[widget.index].images.add(image);
    if (widget.index ==
        widget.boatCheckIn.checklist.length - 1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return DialogCompleteCheckIn(
                widget.boatCheckIn);
          });
    }else{
      setState(() {
        nextSegment();
      });
    }
  }

  void nextSegment() {
    widget.index++;
    yesValue = false;
    noValue = false;
    buttonenabled = false;

    widget.progressPercent = widget.index / widget.boatCheckIn.checklist.length;
    widget.progressText = widget.index.toString() +
        "/" +
        widget.boatCheckIn.checklist.length.toString();
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF202124),
            title: const Text(
              'Are you sure?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            content: const Text(
              'Do you want to abort Check In?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Container(
                    color: Colors.white,
                    width: 100,
                    height: 40,
                    child: const Center(
                      child: Text(
                        'No',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  )),
              const SizedBox(height: 16),
              GestureDetector(
                  onTap: () => Navigator.of(context).pop(true),
                  child: Container(
                    color: Colors.white,
                    width: 100,
                    height: 40,
                    child: const Center(
                      child: Text(
                        'Yes',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  )),
            ],
          ),
        ) ??
        false;
  }
}
