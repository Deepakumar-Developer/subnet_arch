import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class SnDataBase {
  static const String _storageKey = 'works';

  static Future<bool> saveProjects(List<Map<String, dynamic>> projects) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonString = jsonEncode(projects);
      await prefs.setString(_storageKey, jsonString);
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getProjects() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_storageKey);
    if (jsonString == null) return [];
    List<dynamic> decodedData = jsonDecode(jsonString);
    return decodedData.map((item) => item as Map<String, dynamic>).toList();
  }
}

class SnCore {
  Map<String, dynamic> data = {};

  Map<String, dynamic> run(String inputIP, String selection, String value) {
    String ipAddress = inputIP;
    List<int> ip = [];
    for (String i in ipAddress.split('.')) {
      ip.add(int.parse(i));
    }

    Map<String, List<int>> ipClass = {
      'a': [0, 126],
      'b': [128, 191],
      'c': [192, 223],
    };
    String ipClassType = '';
    if (ip[0] >= ipClass['a']![0] && ip[0] <= ipClass['a']![1]) {
      ipClassType = 'a';
    } else if (ip[0] >= ipClass['b']![0] && ip[0] <= ipClass['b']![1]) {
      ipClassType = 'b';
    } else if (ip[0] >= ipClass['c']![0] && ip[0] <= ipClass['c']![1]) {
      ipClassType = 'c';
    } else {
      print('Invalid IP');
      return {'status': 'error', 'message': 'Invalid IP'};
    }

    print('IP Class: Class $ipClassType');

    print(
      'press 1 for sub-network, press 2 for CIDR notation, press 3 for no.of host',
    );
    int select = selection == 'sn'
        ? 1
        : selection == 'mask'
        ? 2
        : selection == 'host'
        ? 3
        : 0;

    int need = 0;
    List<int> subnet = [];
    if (select == 1) {
      need = int.parse(value);
      subnet = bySubnet(need, ipClassType);
    } else if (select == 2) {
      need = int.parse(value);
      subnet = byCidr(need);
    } else if (select == 3) {
      need = int.parse(value);
      subnet = byHost(need, ipClassType);
    } else {
      print('Invalid Operation');
      return {'status': 'error', 'message': 'Invalid Operation'};
    }

    if (subnet.length == 1) {
      return {'status': 'error', 'message': 'Invalid Operation'};
    }

    int jump = subnet[0], sub = subnet[1], ipType = subnet[2];
    print('Sub-networks: $sub');
    data['noOfSubnet'] = sub;
    List<int> newIp = [
      ip[0],
      ipType == 1 ? 0 : ip[1],
      ipType == 1 || ipType == 2 ? 0 : ip[2],
      ipType == 1 || ipType == 2 || ipType == 3 ? 0 : ip[3],
    ];

    List<Map<String, String>> subnetList = [];

    for (int i = 0; i < sub; i++) {
      Map<String, String> subnet = {};
      if (ipType == 1) {
        String network = '${newIp[0]}.${newIp[1]}.${newIp[2]}.${newIp[3]}';
        String first = '${newIp[0]}.${newIp[1] + 1}.${newIp[2]}.${newIp[3]}';
        newIp[1] += jump;
        String last = '${newIp[0]}.${newIp[1] - 1}.${newIp[2]}.${newIp[3]}';
        String broadcast = '${newIp[0]}.${newIp[1]++}.255.255';

        print('Network Ip : $network');
        print('First Ip   : $first');
        print('Last Ip    : $last');
        print('Broadcast  : $broadcast');
        subnet = {
          'network': network,
          'first': first,
          'last': last,
          'broadcast': broadcast,
        };
      } else if (ipType == 2) {
        String network = '${newIp[0]}.${newIp[1]}.${newIp[2]}.${newIp[3]}';
        String first = '${newIp[0]}.${newIp[1]}.${newIp[2] + 1}.${newIp[3]}';
        newIp[2] += jump;
        String last = '${newIp[0]}.${newIp[1]}.${newIp[2] - 1}.${newIp[3]}';
        String broadcast = '${newIp[0]}.${newIp[1]}.${newIp[2]++}.255';

        print('Network Ip : $network');
        print('First Ip   : $first');
        print('Last Ip    : $last');
        print('Broadcast  : $broadcast');
        subnet = {
          'network': network,
          'first': first,
          'last': last,
          'broadcast': broadcast,
        };
      } else if (ipType == 3) {
        String network = '${newIp[0]}.${newIp[1]}.${newIp[2]}.${newIp[3]}';
        String first = '${newIp[0]}.${newIp[1]}.${newIp[2]}.${newIp[3] + 1}';
        newIp[3] += jump;
        String last = '${newIp[0]}.${newIp[1]}.${newIp[2]}.${newIp[3] - 1}';
        String broadcast = '${newIp[0]}.${newIp[1]}.${newIp[2]}.${newIp[3]++}';

        print('Network Ip : $network');
        print('First Ip   : $first');
        print('Last Ip    : $last');
        print('Broadcast  : $broadcast');
        subnet = {
          'network': network,
          'first': first,
          'last': last,
          'broadcast': broadcast,
        };
      }
      print('----------------');
      subnetList.add(subnet);
    }
    data['subnetList'] = subnetList;
    data['status'] = 'done';
    return data;
  }

  List<int> bySubnet(int sNet, String ipClass) {
    List<int> twoPower = [128, 64, 32, 16, 8, 4, 2, 1];
    if (twoPower.contains(sNet)) {
      int n = 7 - twoPower.indexOf(sNet);
      int ipType = ipClass == 'a'
          ? 1
          : ipClass == 'b'
          ? 2
          : ipClass == 'c'
          ? 3
          : 0;
      int cidr = ipType * 8 + n;
      return byCidr(cidr);
    } else {
      print('Invalid Subnet');
    }
    return [-1];
  }

  List<int> byCidr(int cidr) {
    List<int> twoPower = [128, 64, 32, 16, 8, 4, 2, 1];
    if (cidr >= 0 && cidr <= 32) {
      int n = cidr;
      while (n > 7) {
        n -= 8;
      }
      int jump = 0;
      for (int i = n; i < 8; i++) {
        jump += twoPower[i];
      }
      int ipType = cidr >= 24
          ? 3
          : cidr >= 14
          ? 2
          : cidr >= 8
          ? 1
          : 0;
      print('CIDR: /$cidr');
      data['newCidrMask'] = cidr;
      newSubnetMask(cidr);
      print('Host per sub-net: ${pow(2, (32 - cidr)) - 2}');
      data['noOfHost'] = pow(2, (32 - cidr)) - 2;
      return [jump, pow(2, n).toInt(), ipType];
    } else {
      print('Invalid Notation');
    }
    return [-1];
  }

  List<int> byHost(int hNet, String classType) {
    int n = 0;
    int host = classType == 'a'
        ? 255 * 255 * 255
        : classType == 'b'
        ? 255 * 255
        : 255;
    if (hNet > 1 && host >= hNet) {
      for (int i = 0; i < 32; i++) {
        if ((pow(2, i) - 2) >= hNet) {
          n = 32 - i;
          break;
        }
      }
      return byCidr(n);
    } else {
      print('Invalid Host');
    }
    return [-1];
  }

  void newSubnetMask(int cidr) {
    List<int> twoPower = [128, 64, 32, 16, 8, 4, 2, 1];
    int time = cidr ~/ 8;
    int rem = cidr % 8;
    List<int> mask = [0, 0, 0, 0];
    for (int i = 0; i < time; i++) {
      mask[i] = 255;
    }
    for (int i = 0; i < rem; i++) {
      mask[time] += twoPower[i];
    }
    print('Subnet Mask = ${mask.join('.')}');
    data['subnet_mask'] = mask.join('.');
  }
}
