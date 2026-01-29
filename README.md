# 🌐 Subnet Arch

## 📌 Design. Calculate. Visualize.
**Subnet Arch** is a high-precision networking workspace built with Flutter and Dart. It transforms the complex math of IPv4 subnetting into a visual, interactive experience, allowing students and network engineers to "architect" their digital environments with surgical precision.

`Note: This project is mainly intended for networking students, ECE / IT students, and beginners learning IPv4 subnetting.`

---

##  🏗 Project Evolution

What started as a menu-driven calculator has evolved into a Network Simulation Canvas. Subnet Arch combines raw mathematical power with a modern, light-themed UI to help users bridge the gap between theory and implementation.

## 🚀 Smart Features

1. **Three-Way Calculation Engine:** Unlike standard calculators, Subnet Arch allows you to solve for your network based on:
    - **Subnet Count:** Perfect for dividing a school into specific departments.
    - **CIDR Notation:** The industry standard for quick prefixing.
    - **Host Requirements:** Essential for scaling classrooms and labs.

2. **Automatic Class Detection:** Instant identification of Class A, B, and C addresses.

3. **Project Persistence:** Save your entire network layout to local storage using JSON-based persistence—pick up your design right where you left off.

4. **Architectural UI:** A clean, professional light theme using the Afacad font for readability and Roboto Mono for data precision.

---

## ⚙️ The "Architect" Workflow

1. **Initialize:** Enter your base IPv4 address.

2. **Define Constraints:** Use the ArchNeedSelector to choose your calculation priority (subnet, CIDR, or hosts).

3. **Generate:** The engine calculates the mask, range, and broadcast addresses for all generated subnets.

4. **Visualize:** View the results in "Blueprint Cards" or place them on the Interactive Canvas to see how data flows.

5. **Save:** Export your design to the local device database for future reference.

---

## 🧠 Networking Intelligence

Subnet Arch handles the heavy lifting of:
- Network ID & Broadcast Calculation
- Usable IP Range mapping
- Bit-shifting for Prefix lengths
- Local Data Serialization (JSON)

---

## 🛠 Tech Stack
- Language: Dart 3.x
- Framework: Flutter (Material 3)
- Fonts: Afacad & Roboto Mono
- Storage: Shared Preferences (JSON Strings)
- Gestures: InteractiveViewer & X/Y Coordinate Mapping

---

## 📥 Sample Input

```

Enter the IPv4 address: 172.168.14.3
Press 1 for subnet
Press 2 for CIDR notation
Press 3 for number of hosts
CIDR notation /25
```
## 📥 Sample Output

```

IP Class: Class B
CIDR: /25
Subnet Mask: 255.255.255.128
Hosts per subnet: 126
Number of subnets: 2

Network IP   : 172.168.14.0
First IP     : 172.168.14.1
Last IP      : 172.168.14.126
Broadcast IP : 172.168.14.127
-------------------------
Network IP   : 172.168.14.128
First IP     : 172.168.14.129
Last IP      : 172.168.14.254
Broadcast IP : 172.168.14.255
```
---
## 🎯 Use Cases

- Learning IPv4 subnetting concepts
- Academic projects and lab work
- Exam preparation (CN / CCNA basics)
- Quick offline subnet calculations