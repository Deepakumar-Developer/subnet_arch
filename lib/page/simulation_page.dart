import 'package:flutter/material.dart';
import 'package:subnet_arch/function/app_function.dart';

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
  Map<String, dynamic> data = {};

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
      data = SnCore().run(ip, selection, value.replaceAll('/', ''));
      print(data);
      noOfSubnet = data['noOfSubnet'];
      newCidrMask = data['newCidrMask'];
      noOfHost = data['noOfHost'];
      subnetMask = data['subnet_mask'];
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
          child: Padding(
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
                        SnBodyText('No.of Host'),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .start,
                      children: [
                        SnIP(' : $ip', size: 12),
                        SnBodyText('   :   $noOfSubnet'),
                        SnBodyText('   :   /$newCidrMask or $subnetMask'),
                        SnBodyText('   :   $noOfHost'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
