import 'package:flutter/material.dart';

import '../utils.dart';
import 'register_screen.dart';

class SaleVFDPage extends StatefulWidget {
  @override
  _SaleVFDPageState createState() => _SaleVFDPageState();
}

class _SaleVFDPageState extends State<SaleVFDPage> {
  String? selectedPaymentMode;
  String? selectedPackage;
  String selectedClient = 'Select Client';
  TextEditingController amountController = TextEditingController();
  String attachmentText = 'Attachment here';
Widget _buildSelectPaymentMode(){
  return Container(
    padding: EdgeInsets.only(left: 10,right: 10),
    decoration: BoxDecoration(
      color: const Color(0xFF1E4A5F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButton<String>(
      alignment: AlignmentGeometry.center,
      hint: const Text('Select Payment Mode', style: TextStyle(color: Colors.white)),
      value: selectedPaymentMode,
      isExpanded: true,
      
      borderRadius: BorderRadius.circular(10),
      dropdownColor: const Color(0xFF1E4A5F),
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.lightBlue),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      underline: Container(height: 0),
      onChanged: (String? newValue) {
        setState(() {
          selectedPaymentMode = newValue!;
        });
      },
      items: paymentModes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(fontSize: 12)),
        );
      }).toList(),
    ),
  );
}

Widget _buildSelectPackage(){
  return Container(
        padding: EdgeInsets.only(left: 10,right: 10),

    decoration: BoxDecoration(
      color: const Color(0xFF1E4A5F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButton<String>(
      alignment: AlignmentGeometry.center,
      hint: const Text('Select Package', style: TextStyle(color: Colors.white)),
      value: selectedPackage,
      isExpanded: true,
      
      borderRadius: BorderRadius.circular(10),
      // padding: EdgeInsets.all(5),
      dropdownColor: const Color(0xFF1E4A5F),
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.lightBlue),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      underline: Container(height: 0),
      onChanged: (String? newValue) {
        setState(() {
          selectedPackage = newValue!;
        });
      },
      items: packages.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(fontSize: 12)),
        );
      }).toList(),
    ),
  );
}

 void _showClientSelectionDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Client', style: TextStyle(fontSize: 10)),
        content: SizedBox(               // 👈 constrain dialog height
          width: double.maxFinite,
          height: 300,                   // set max height for the dialog
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 246, 240, 240),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded( // now works inside the SizedBox
                child: ListView(
                  children: clients.map((client) {
                    return ListTile(
                      title: Text(client, style: const TextStyle(fontSize: 12)),
                      onTap: () {
                        setState(() {
                          selectedClient = client;
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


List<String> clients = ['CROPSCHAIN COMPANY LTD', 'PRIVA LAURENT KIMARIO', 'REMMY BATHOLOMEW MACHAGE', 'SHOMASA.CO.LIMITED', 'ZUHURA WAZIRI SHABANI', 'THOMAS JOSEPH KISEMA', 'TANDI INTERNATIONAL COMPANY LIMITED', 'UMOJA WA WAUZA MCHELE MASHINENI', 'LUCY JOHN MATOLI', 'KALOMBO EDWARD KASSANGA','AMOS WILSON CHARICHA'];
List<String> packages = ['BASIC - 100,000 TZS', 'STANDARD - 200,000 TZS', 'PREMIUM - 300,000 TZS', 'ENTERPRISE - 500,000 TZS' ,'ULTIMATE - 1,000,000 TZS', 'CUSTOM - Contact Us', 'TRIAL - 0 TZS', 'ECONOMY - 50,000 TZS', 'BUSINESS - 150,000 TZS', 'CORPORATE - 400,000 TZS', 'STARTUP - 75,000 TZS', 'PROFESSIONAL - 250,000 TZS', 'ADVANCED - 350,000 TZS', 'DELUXE - 600,000 TZS', 'SUPREME - 1,500,000 TZS'];
List<String> paymentModes = ['HQ', 'Bank Transfer', 'Mobile Money', 'Cash', 'Cheque', 'PayPal', 'Stripe', 'Square', 'Cryptocurrency', 'Direct Debit', 'EFT', 'Western Union', 'MoneyGram', 'Alipay', 'WeChat Pay'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A9EFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Device',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ======= Header =======
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/pos.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      'Sale VFD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                // Toggle buttons
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: const Center(
                            child: Text(
                              'EFD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Center(
                            child: Text(
                              'VFD',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // ======= Form Section =======
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Choose Client"),

                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle client selection
                    _showClientSelectionDialog();
                  },
                  child: _buildBox(selectedClient),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle navigation to register screen
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterScreen()));
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "If new register here →",
                      style: TextStyle(color: Colors.blue[200], fontSize: 12),
                    ),
                  ),
                ),

                const SizedBox(height: 25),
                _sectionTitle("Choose Package"),
                const SizedBox(height: 10),
                //_buildBox(selectedPackage, withArrow: true),
                _buildSelectPackage(),  
                const SizedBox(height: 25),
                _sectionTitle("Payment Detail"),
                const SizedBox(height: 10),
                _buildSelectPaymentMode(),
                const SizedBox(height: 15),
                _amountField(amountController),

                const SizedBox(height: 25),
                _sectionTitle("Upload att`achment"),
                const SizedBox(height: 10),
                GestureDetector(
                        onTap: () => pickImage(context),
                  child: _buildBox(attachmentText, withUpload: true)),

                const SizedBox(height: 30),
                _submitButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable section title
Widget _sectionTitle(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.white70,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
  );
}

// Custom Input Container
Widget _buildBox(
  String text, {
  bool withArrow = false,
  bool withUpload = false,
}) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: const Color(0xFF1E4A5F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        if (withArrow)
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.lightBlue,
              size: 24,
            ),
          ),
        if (withUpload)
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.file_upload_outlined,
              color: Colors.lightBlue,
              size: 24,
            ),
          ),
      ],
    ),
  );
}


// Amount Field
Widget _amountField(TextEditingController controller) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: const Color(0xFF3A3A3C),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        hintText: 'Enter Amount',
        hintStyle: TextStyle(color: Colors.white54),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
      ),
      keyboardType: TextInputType.number,
    ),
  );
}

// Submit Button
Widget _submitButton() {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextButton(
      onPressed: _handleSubmit,
      child: const Text(
        'SUBMIT',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    ),
  );
}

void _handleSubmit() {
  print("Form Submitted ✅");
}
