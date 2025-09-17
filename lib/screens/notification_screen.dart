import 'package:ed_sales/screens/softnet_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoading = true;
  List<Map<String, String>> notifications = [
    {"title": "23233326787982", "body": "No status yet.", "time": "Today"},
    {"title": "23233326787983", "body": "Shipped.", "time": "Yesterday"},
    {"title": "23233326787984", "body": "Delivered.", "time": "2 days ago"},
    {"title": "23233326787985", "body": "In transit.", "time": "3 days ago"},
    {
      "title": "23233326787986",
      "body": "Out for delivery.",
      "time": "4 days ago",
    },
    {"title": "23233326787987", "body": "No status yet.", "time": "5 days ago"},
    {"title": "23233326787988", "body": "Shipped.", "time": "6 days ago"},
    {"title": "23233326787989", "body": "Delivered.", "time": "1 week ago"},
    {"title": "23233326787990", "body": "In transit.", "time": "1 week ago"},
    {
      "title": "23233326787991",
      "body": "Out for delivery.",
      "time": "2 weeks ago",
    },
    {
      "title": "23233326787992",
      "body": "No status yet.",
      "time": "2 weeks ago",
    },
    {"title": "23233326787993", "body": "Shipped.", "time": "3 weeks ago"},
    {"title": "23233326787994", "body": "Delivered.", "time": "3 weeks ago"},
    {"title": "23233326787995", "body": "In transit.", "time": "1 month ago"},
    {
      "title": "23233326787996",
      "body": "Out for delivery.",
      "time": "1 month ago",
    },
    {
      "title": "23233326787997",
      "body": "No status yet.",
      "time": "1 month ago",
    },
    {"title": "23233326787998", "body": "Shipped.", "time": "1 month ago"},
    {"title": "23233326787999", "body": "Delivered.", "time": "1 month ago"},
    {"title": "23233326788000", "body": "In transit.", "time": "1 month ago"},
  ];
  @override
  void initState() {
    super.initState();
    // simulate loading for 1-2 seconds when page opens
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // hide spinner and show notifications
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("EFD"),
        automaticallyImplyLeading: false,

        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [PopupMenuItem(value: 3, child: Text("Logout"), onTap: () => {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SoftNetLoginPage()), (route) => false)
              })];
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CupertinoActivityIndicator(radius: 16, color: Colors.white70,),
            )
     : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: () {}, child: Text("Refresh")),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,

                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text(
                        notification["title"]!,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 123, 184, 231),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        notification["body"]!,
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time, size: 16),
                          SizedBox(width: 4),
                          Text(
                            notification["time"]!,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 247, 244, 244),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
