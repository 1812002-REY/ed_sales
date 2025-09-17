import 'package:ed_sales/screens/device_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils.dart';

class InvoiceScreen extends StatefulWidget {
  final bool fromEFD;
  const InvoiceScreen({super.key, this.fromEFD = false});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF424242),
      appBar: AppBar(
        title: Text('Invoice'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),

          onPressed: () {
            // Go back to EFD page
            // Navigator.pushNamed(context, '/efd');
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DeviceScreen(initialIsVfd: !widget.fromEFD),
              ),
            );
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                // Handle logout
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'logout', child: Text('Logout')),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          // Green header with invoice number
          Container(
            width: double.infinity,
            color: const Color(0xFF4CAF50),
            padding: const EdgeInsets.all(30),
            child: Row(
              children: [
                Image.asset(
                  'assets/pos.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 30),
                Text(
                  '06TZ020002165',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Dark background content
          Container(
            color: const Color(0xFF424242),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---- Client Details ----
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Client Details',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2196F3),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'ROSE CORBIAN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'NDUMBARO',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'RUVUMA',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            '0673281067',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ---- More Detail ----
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'More Detail',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Tin Number row
                _detailRow('Tin Number', '138785068'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(color: Colors.white24, thickness: 1),
                ),
                // Invoice Number row
                _detailRow('Invoice Number', 'Quotation_391198'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(color: Colors.white24, thickness: 1),
                ),
                const SizedBox(height: 30),

                // View buttons row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _twoLineBlueText('View Business', 'Licence'),
                      _twoLineBlueText('View Customer', 'Information'),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Attachments
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _attachColumn('Delivery Note'),
                      _attachColumn('Job Completion Form'),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Complete button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green, // same as register
                        borderRadius: BorderRadius.circular(
                          25,
                        ), // rounded like register
                      ),
                      child: TextButton(
                        onPressed: () {
                          // TODO: complete logic here
                          print('Complete button pressed');
                        },
                        child: const Text(
                          'Complete',
                          style: TextStyle(
                            color: Colors.white, // white text like register
                            fontSize: 16, // same as register
                            fontWeight: FontWeight.bold, // same as register
                            letterSpacing: 1.1, // same as register
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper widgets for cleaner code
Widget _detailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Text(
          'View',
          style: TextStyle(
            color: Color(0xFF2196F3),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

class _twoLineBlueText extends StatelessWidget {
  final String line1, line2;
  const _twoLineBlueText(this.line1, this.line2);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          line1,
          style: const TextStyle(
            color: Color(0xFF2196F3),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          line2,
          style: const TextStyle(
            color: Color(0xFF2196F3),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _attachColumn extends StatelessWidget {
  final String title;
  const _attachColumn(this.title);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pickImage(context),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Text(
                'Attachment here',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              SizedBox(width: 8),
              Icon(Icons.upload, color: Color(0xFF2196F3), size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
