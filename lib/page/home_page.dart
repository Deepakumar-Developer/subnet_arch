import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subnet_arch/function/app_function.dart';
import 'package:subnet_arch/page/create_page.dart';
import 'package:subnet_arch/widget/sn_text.dart';

import '../function/backend_function.dart';
import '../widget/sn_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> works = [data, data, data, data, data];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   SnDataBase.getProjects().then((value) {
  //     setState(() {
  //       works = value;
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SizedBox(
          height: height(context),
          width: width(context),
          child: Padding(
            padding: SnPadding.pagePadding,
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .start,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: .all(Radius.circular(8)),
                      child: Image.asset('assets/AppIcon.png', width: 40),
                    ),
                    SnTitle(appName),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    bool get = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreatePage(),
                      ),
                    );
                    if(get) {
                      List<Map<String, dynamic>> data = await SnDataBase.getProjects();
                      setState(() {
                        works = data;
                      });
                    }
                  },
                  child: Container(
                    margin: SnPadding.sectionGap,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: height(context) * 0.2,
                    width: width(context),
                    alignment: .center,
                    child: Icon(
                      Icons.add_sharp,
                      size: 50,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
                SnSubTitle('Works'),
                SizedBox(height: 8),
                Expanded(
                  child: SizedBox(
                    width: width(context),
                    child: ListView.builder(
                      itemCount: works.isEmpty ? 1 : works.length,
                      itemBuilder: (context, index) {
                        if (works.isEmpty) {
                          return SizedBox(
                            width: width(context),
                            height: height(context) * 0.6,
                            child: Center(
                              child: Column(
                                spacing: 12,
                                mainAxisAlignment: .center,
                                crossAxisAlignment: .center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/home_page.svg',
                                    width: width(context) * 0.6,
                                  ),
                                  SnBodyText('No Works!'),
                                ],
                              ),
                            ),
                          );
                        }
                        return WorkCard(data: works[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
