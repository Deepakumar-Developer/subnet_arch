import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subnet_arch/function/app_function.dart';
import 'package:subnet_arch/widget/sn_button.dart';
import 'package:subnet_arch/widget/sn_text.dart';
import 'package:subnet_arch/widget/sn_textfield.dart';

import '../function/backend_function.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String selectedNeed = 'mask';
  TextEditingController projectController = TextEditingController();
  TextEditingController ipController = TextEditingController();
  TextEditingController subnetController = TextEditingController();
  TextEditingController maskController = TextEditingController();
  TextEditingController hostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SizedBox(
          width: width(context),
          height: height(context),
          child: SingleChildScrollView(
            child: Padding(
              padding: SnPadding.pagePadding,
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  SizedBox(
                    width: width(context),
                    height: height(context) * 0.4,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/create.svg',
                        width: width(context) * 0.6,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  SnTitle('Create Work'),
                  SizedBox(height: 12),
                  SnTextField(
                    controller: projectController,
                    label: 'Name',
                    hintText: 'Assign Name for this Work',
                    isRequired: true,
                  ),
                  SizedBox(height: 12),
                  SnTextField(
                    controller: ipController,
                    label: 'Address',
                    hintText: 'Enter IPv4 Address!',
                    isRequired: true,
                  ),
                  SizedBox(height: 12),
                  SnBodyText('Select Need'),
                  Column(
                    children: [
                      RadioListTile(
                        title: SnBodyText("By Subnet"),
                        value: "sn",
                        groupValue: selectedNeed,
                        onChanged: (value) {
                          setState(() {
                            selectedNeed = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: SnBodyText("By CIDR"),
                        value: "mask",
                        groupValue: selectedNeed,
                        onChanged: (value) {
                          setState(() {
                            selectedNeed = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: SnBodyText("By Host"),
                        value: "host",
                        groupValue: selectedNeed,
                        onChanged: (value) {
                          setState(() {
                            selectedNeed = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  if (selectedNeed == 'sn')
                    SnTextField(
                      controller: subnetController,
                      label: 'Subnet',
                      hintText: 'Enter Subnet Count!',
                      isRequired: true,
                    ),

                  if (selectedNeed == 'mask')
                    SnTextField(
                      controller: maskController,
                      label: 'Subnet Mask',
                      hintText: 'Enter CIDR!',
                      isRequired: true,
                    ),
                  if (selectedNeed == 'host')
                    SnTextField(
                      controller: hostController,
                      label: 'Host',
                      hintText: 'Enter No.of Host!',
                      isRequired: true,
                    ),
                  SizedBox(height: 12),
                  SnButton(
                    text: 'Create',
                    icon: Icons.keyboard_arrow_right_sharp,
                    onPressed: () async {
                      bool need = false;
                      if (selectedNeed == 'sn') {
                        need = subnetController.text.isNotEmpty;
                      } else if (selectedNeed == 'mask') {
                        need = maskController.text.isNotEmpty;
                      } else if (selectedNeed == 'host') {
                        need = hostController.text.isNotEmpty;
                      }
                      if (projectController.text.isNotEmpty &&
                          ipController.text.isNotEmpty &&
                          need) {
                        if(checkIP()) {
                          print(ipController.text);
                          if(checkNeed()) {
                            List<Map<String,dynamic>> data = await SnDataBase.getProjects();
                            data.add({
                              'ip': ipController.text,
                              'by': selectedNeed,
                              'sn': selectedNeed == 'sn' ? subnetController.text : '',
                              'mask': selectedNeed == 'mask' ? maskController.text : '',
                              'host': selectedNeed == 'host' ? hostController.text : '',
                              'name': projectController.text,
                              'time': DateTime.now().millisecondsSinceEpoch
                            });
                            SnDataBase.saveProjects(data);
                            Navigator.pop(context,true);
                            print({
                              'ip': ipController.text,
                              'by': selectedNeed,
                              'sn': selectedNeed == 'sn' ? subnetController.text : '',
                              'mask': selectedNeed == 'mask' ? maskController.text : '',
                              'host': selectedNeed == 'host' ? hostController.text : '',
                            });
                          } else {
                            showToast('Enter valid input', context);
                          }
                        } else {
                          showToast('Enter valid IP', context);
                        }
                      } else {
                        showToast('Enter all fields', context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool checkIP() {
    bool validIP = false;
    List<int> ip = [];
    for(String i in ipController.text.split('.')) {
      ip.add(int.parse(i));
    }
    if(ip.length != 4) return false;
    if(ip[0] == 10) {
      if((0 <= ip[1] && ip[1] <= 255) &&(0 <= ip[2] && ip[2] <= 255) &&(0 <= ip[3] && ip[3] <= 255)) {
        validIP = true;
      }
    } else if(ip[0] == 172) {
      if((16 <= ip[1] && ip[1] <= 31) &&(0 <= ip[2] && ip[2] <= 255) &&(0 <= ip[3] && ip[3] <= 255)) {
        validIP = true;
      }
    } else if(ip[0] == 192 && ip[1] == 168) {
      if((0 <= ip[2] && ip[2] <= 255) &&(0 <= ip[3] && ip[3] <= 255)) {
        validIP = true;
      }
    }
    return validIP;
  }

  bool checkNeed() {
    int input = 0;
    if(selectedNeed == 'sn') {
      input = int.parse(subnetController.text);
      if([128,64,32,16,8,4,2,1].contains(input)) {
        return true;
      }
    }
    if(selectedNeed == 'mask') {
      input = int.parse(maskController.text);
      print(input);

      if(8 <= input && input <= 32) {
        return true;
      }
    }
    if(selectedNeed == 'host') {
      input = int.parse(hostController.text);
      int ip = int.parse(ipController.text.split('.')[0]);
      int classType = ip == 10 ? 1 : ip == 172 ? 2 : 3;
      int host = classType == 1 ? 255*255*255 : classType == 2 ? 255*255 : 255;
      if(1 <= input && input <= host) {
        return true;
      }
    }
    return false;
  }
}

