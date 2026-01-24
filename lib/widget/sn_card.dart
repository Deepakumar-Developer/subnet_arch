import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subnet_arch/function/app_function.dart';
import 'package:subnet_arch/page/simulation_page.dart';
import 'package:subnet_arch/widget/sn_button.dart';
import 'package:subnet_arch/widget/sn_text.dart';

class WorkCard extends StatefulWidget {
  final Map<String,dynamic> data;
  const WorkCard({super.key, required this.data});

  @override
  State<WorkCard> createState() => _WorkCardState();
}

class _WorkCardState extends State<WorkCard> {
  @override
  Widget build(BuildContext context) {
    String selection = widget.data['by'].toString();
    String ip = widget.data['ip'].toString();
    String by = selection == 'sn' ? 'Subnet' : selection == 'mask' ? 'CIDR' : selection == 'host' ? 'Host' : 'Oops!';
    String value  = selection == 'sn' ? widget.data['sn'].toString() : selection == 'mask' ? '/${widget.data['mask'].toString()}' : selection == 'host' ? widget.data['host'].toString() : '--/--';
    return Container(
      margin: SnPadding.elementGap,
      width: width(context),
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),child: Row(
        children: [
          ClipRRect(borderRadius:.horizontal(left: Radius.circular(20)),child: SvgPicture.asset('assets/ip_location.svg',height: 75,)),
          Container(
            width: width(context) - 174,
            padding: SnPadding.innerPadding,
            child: Column(
              mainAxisAlignment: .spaceEvenly,
              crossAxisAlignment: .start,
              children: [
                SnIP(ip),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    SnBodyText('$by: $value'),
                    SnTextButton('View More!',onPressed: (){Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SimulationPage(data: widget.data)),
                    );},),
                    ]
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
