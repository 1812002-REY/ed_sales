import 'package:ed_sales/screens/invoice_screen.dart';
import 'package:ed_sales/screens/softnet_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'sale_vfd_screen.dart';

class DeviceScreen extends StatefulWidget {
  final bool initialIsVfd;
  const DeviceScreen({super.key, this.initialIsVfd = true});
 

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
 
  bool isVfd = true;
   bool isLoading = true;
  @override
  void initState() {
    super.initState();
    isVfd = widget.initialIsVfd;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // hide spinner after "loading"
      });
    });
  }

  List<Map<String,dynamic>> efds = [
    {"model":"EFD-1000","date":"April 15,2024","status":"Fiscalization"},
    {"model":"EFD-2000","date":"May 10,2024","status":"Fiscalization"},
    {"model":"EFD-3000","date":"June 5,2024","status":"Fiscalization"},
    {"model":"EFD-4000","date":"July 20,2024","status":"Fiscalization"},
    {"model":"EFD-5000","date":"August 25,2024","status":"Fiscalization"},
    {"model":"EFD-6000","date":"September 14,2024","status":"Fiscalization"},
    {"model":"EFD-7000","date":"October 30,2024","status":"Fiscalization"},
    {"model":"EFD-8000","date":"November 18,2024","status":"Fiscalization"},
    {"model":"EFD-9000","date":"December 22,2024","status":"Fiscalization"},
    {"model":"EFD-10000","date":"January 11,2025","status":"Fiscalization"}
  ];
 List<Map<String,dynamic>> vfds = [
  {"model":"VFD-1000","date":"September 10,2025","status":"Active"},
  {"model":"VFD-2000","date":"October 5,2025","status":"Inactive"},
  {"model":"VFD-3000","date":"November 15,2025","status":"Active"},
  {"model":"VFD-4000","date":"December 20,2025","status":"Inactive"},
  {"model":"VFD-5000","date":"January 25,2026","status":"Active"},
  {"model":"VFD-6000","date":"February 14,2026","status":"Inactive"},
  {"model":"VFD-7000","date":"March 30,2026","status":"Active"},
  {"model":"VFD-8000","date":"April 18,2026","status":"Inactive"},
  {"model":"VFD-9000","date":"May 22,2026","status":"Active"},
  {"model":"VFD-10000","date":"June 11,2026","status":"Inactive"},

 ];

 void _refreshDevices() {
    setState(() {
      // You can fetch new devices from API or database here
      // For demo, we just shuffle the list to simulate a refresh
      efds.shuffle();
    });
  }

  _toggleDeviceType(bool vfd) {
    setState(() {
      isVfd = vfd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        // leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back)),
        title: Text("EFD"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.feed_sharp),
            onPressed: () {
              _refreshDevices();
              // Handle feed icon press
            },
          ),
          IconButton(
            icon: Icon(Icons.crop),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("No device"),
                  content: Text("Sorry, you don't have any device to transfer"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"),
                    ),
                  ],
                ),
              );
              // Handle settings icon press
            },
          ),
        PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [PopupMenuItem(value: 3, child: Text("Logout"), onTap: () => {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SoftNetLoginPage()), (route) => false)
              })];
            },
          )
        ],
      ),
      body:isLoading
          ? const Center(
              child: CupertinoActivityIndicator(radius: 16 ,color: Colors.white10,),
            
            )
            : ListView(
        padding: EdgeInsets.all(12),
        children: [
          if(!isVfd) Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.bar_chart, size: 70),
                Column(
                  children: [
                    Text(
                      "DISTRIBUTED",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "0",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "INSTOCK",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "59",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "SOLD",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "0",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: !isVfd ? Colors.white70 : Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // Background color,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width /2 - 24,
                    MediaQuery.of(context).size.height * 0.045,
                  ),
                ),
                child: Text("EFD", style: TextStyle(color: !isVfd ? Colors.black : Colors.white)),
                onPressed: () {
                  _toggleDeviceType(false);
                  // Handle add device action
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isVfd ? Colors.white70 : Colors.black12,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width/2 - 24,
                    MediaQuery.of(context).size.height * 0.045,
                  ),
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // Background color
                ),
                child: Text("VFD", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  _toggleDeviceType(true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SaleVFDPage()),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 20),

          Column(
            children: (!isVfd? efds: vfds)
                .map(
                  (device) => Card(
                    color: const Color.fromARGB(221, 47, 45, 45),
                    child: ListTile(
                      leading: Image.asset(
                        "assets/pos.png",
                      ), //replace this with img
                      title: Text(
                          device["model"],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                          device["date"],
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: Container(
                        width: 100,
                        height: 30,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(device["status"],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      onTap: () {
                        if(!isVfd) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => InvoiceScreen(fromEFD: true)),
                          );
                        }
                        // Handle device tap
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
