import 'package:flutter/material.dart';
import 'package:subnet_arch/function/app_function.dart';
import 'package:subnet_arch/widget/sn_button.dart';
import 'package:subnet_arch/widget/sn_card.dart';

import '../function/backend_function.dart';
import '../widget/sn_text.dart';

class SimulationPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const SimulationPage({super.key, required this.data});

  @override
  State<SimulationPage> createState() => _SimulationPageState();
}

class _SimulationPageState extends State<SimulationPage> {
  int noOfSubnet = 0;
  int newCidrMask = 0;
  int noOfHost = 0;
  String subnetMask = '255.0.0.0';
  bool showPopUp = false;
  Map<String, dynamic> subnet = {};
  List<Map<String, dynamic>> subnetData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String selection = widget.data['by'].toString();
    String ip = widget.data['ip'].toString();
    String by = selection == 'sn'
        ? 'Subnet'
        : selection == 'mask'
        ? 'CIDR'
        : selection == 'host'
        ? 'Host'
        : 'Oops!';
    String value = selection == 'sn'
        ? widget.data['sn'].toString()
        : selection == 'mask'
        ? '/${widget.data['mask'].toString()}'
        : selection == 'host'
        ? widget.data['host'].toString()
        : '--/--';
    setState(() {
      print(by);
      print(value);
      final data = SnCore().run(ip, selection, value.replaceAll('/', ''));
      print(data);
      if (data['status'] != 'error') {
        noOfSubnet = data['noOfSubnet'];
        newCidrMask = data['newCidrMask'];
        noOfHost = data['noOfHost'];
        subnetMask = data['subnet_mask'];
        subnetData = data['subnetList'];
        subnet = subnetData[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String selection = widget.data['by'].toString();
    String ip = widget.data['ip'].toString();
    String by = selection == 'sn'
        ? 'Subnet'
        : selection == 'mask'
        ? 'CIDR'
        : selection == 'host'
        ? 'Host'
        : 'Oops!';
    String value = selection == 'sn'
        ? widget.data['sn'].toString()
        : selection == 'mask'
        ? '/${widget.data['mask'].toString()}'
        : selection == 'host'
        ? widget.data['host'].toString()
        : '--/--';
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SizedBox(
          height: height(context),
          width: width(context),
          child: Stack(
            children: [
              Padding(
                padding: SnPadding.pagePadding,
                child: Column(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: .all(Radius.circular(8)),
                          child: Image.asset('assets/AppIcon.png', width: 40),
                        ),
                        SnTitle(widget.data['name'].toString()),
                      ],
                    ),
                    SizedBox(height: 20),
                    SnSubTitle('Input'),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: .start,
                          crossAxisAlignment: .start,
                          children: [
                            SnBodyText('IP Address'),
                            SnBodyText('Category'),
                            SnBodyText(by),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: .start,
                          crossAxisAlignment: .start,
                          children: [
                            SnIP(' : $ip', size: 12),
                            SnBodyText('   :   $by'),
                            SnBodyText('   :   $value'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SnSubTitle('Output'),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: .start,
                          crossAxisAlignment: .start,
                          children: [
                            SnBodyText('IP Address'),
                            SnBodyText('No.of Subnet'),
                            SnBodyText('CIDR Mask'),
                            SnBodyText('Subnet Mask'),
                            SnBodyText('No.of Host'),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: .start,
                          crossAxisAlignment: .start,
                          children: [
                            SnIP(' : $ip', size: 12),
                            SnBodyText('   :   $noOfSubnet'),
                            SnBodyText('   :   /$newCidrMask'),
                            SnIP(' : $subnetMask', size: 12),
                            SnBodyText('   :   $noOfHost'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SnSubTitle('Subnet List'),
                    SizedBox(height: 7),
                    Expanded(
                      child: Container(
                        width: width(context),
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: subnetData.isEmpty
                            ? StatusError()
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 5.0,
                                    ),
                                itemCount: subnetData.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        subnet = subnetData[index];
                                        subnet['index'] = '${index + 1}';
                                        showPopUp = true;
                                        print(subnet['index']);
                                      });
                                    },
                                    child: Column(
                                      spacing: 12,
                                      children: [
                                        Image.asset(
                                          'assets/network.png',
                                          width: 124,
                                        ),
                                        SnIP(subnetData[index]['network']),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: showPopUp,
                child: Container(
                  width: width(context),
                  height: height(context),
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      width: width(context) * 0.6,
                      height: 614,
                      padding: SnPadding.innerPadding,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: .start,
                        crossAxisAlignment: .center,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 24),
                              Spacer(),
                              SnTitle(widget.data['name']),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPopUp = false;
                                  });
                                },
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: .center,
                            children: [
                              Visibility(
                                visible: (subnet['index'] ?? '1') != '1',
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      int index = int.parse((subnet['index'] ?? '0')) - 1;
                                      subnet = subnetData[index-1];
                                      subnet['index'] = '${index}';
                                      print(subnet['index']);
                                    });
                                  },
                                  child: Icon(Icons.arrow_left_rounded),
                                ),
                              ),
                              SnBodyText(
                                '${subnet['index'] ?? 0}${(subnet['index'] ?? 0) == 1
                                    ? 'st'
                                    : (subnet['index'] ?? 0) == 2
                                    ? 'nd'
                                    : (subnet['index'] ?? 0) == 3
                                    ? 'rd'
                                    : 'th'} Subnet',
                              ),
                              Visibility(
                                visible: (subnet['index'] ?? subnetData.length) != '${subnetData.length}',
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      int index = int.parse((subnet['index'] ?? '0'));
                                      subnet = subnetData[index];
                                      subnet['index'] = '${index+1}';
                                      print(subnet['index']);
                                    });
                                  },
                                  child: Icon(Icons.arrow_right_rounded),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Theme.of(
                              context,
                            ).colorScheme.tertiary.withOpacity(0.25),
                            thickness: 1,
                          ),
                          Padding(
                            padding: SnPadding.innerPadding,
                            child: SizedBox(
                              width: width(context) * 0.6,
                              height: 486,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: .center,
                                  crossAxisAlignment: .center,
                                  children: [
                                    Image.asset(
                                      'assets/computer.png',
                                      width: 86,
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: .center,
                                      children: [
                                        SnBodyText('Network IP : '),
                                        SnIP(
                                          subnet['network'] ?? '-.-.-.-',
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Image.asset(
                                      'assets/computer.png',
                                      width: 86,
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: .center,
                                      children: [
                                        SnBodyText('Gateway IP : '),
                                        SnIP(
                                          subnet['first'] ?? '-.-.-.-',
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    SnSubTitle('. . .'),
                                    SnSubTitle('. . .'),
                                    SnSubTitle('. . .'),
                                    SizedBox(height: 12),
                                    Image.asset(
                                      'assets/computer.png',
                                      width: 86,
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: .center,
                                      children: [
                                        SnBodyText('Last IP : '),
                                        SnIP(
                                          subnet['last'] ?? '-.-.-.-',
                                          size: 12,
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 12),
                                    Image.asset(
                                      'assets/computer.png',
                                      width: 86,
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: .center,
                                      children: [
                                        SnBodyText('Broadcast IP : '),
                                        SnIP(
                                          subnet['broadcast'] ?? '-.-.-.-',
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
