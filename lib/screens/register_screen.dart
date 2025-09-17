import 'package:ed_sales/utils.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _selectedRegion;
  String? _selectedDocType;
  final List<String> _regions = [
    'Arusha',
    'coast Region',
    'Dar -es- salaam',
    'Dodoma',
    'Geita',
    'Iringa',
    'Kagera',
    'Katavi',
    'Kigoma',
    'Kilimanjaro',
    'Lindi',
    'Manyara',
    'Mara',
    'Mbeya',
    'Morogoro',
    'Mtwara',
    'Mwanza',
    'Njombe',
    'Pemba North',
    'Pemba South',
    'Pwani',
    'Rukwa',
    'Ruvuma',
    'Shinyanga',
    'Simiyu',
    'Singida',
    'Tabora',
    'Tanga',
    'Zanzibar Central/South',
    'Zanzibar North',
    'Zanzibar Urban/West',
  ];
  final List<String> _docTypes = [
    'Customer Form',
    'ID Card',
    'Delibery Note',
    'Invoice',
    'Job Completion Form',
    'Quotation',
    'Receipt',
    'Sales Agreement',
    'Sales Order',
    'Tax Invoice',
    'Waybill',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Register Client', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 17, 149, 238),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [PopupMenuItem(value: 3, child: Text("Logout"))];
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Client Details",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 245, 244, 244),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "First Name",
                    hintStyle: TextStyle(color: Colors.white70),
                    fillColor: const Color.fromARGB(221, 28, 28, 28),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white70),
                    labelText: "Address",
                    fillColor: const Color.fromARGB(221, 28, 28, 28),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white70),
                    labelText: "Phone",
                    fillColor: const Color.fromARGB(221, 28, 28, 28),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                SizedBox(height: 12),

                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white70),
                    labelText: "TIN",
                    fillColor: const Color.fromARGB(221, 28, 28, 28),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white70),
                    labelText: "Email",
                    fillColor: const Color.fromARGB(221, 28, 28, 28),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white70),
                    labelText: "Sales Person",
                    fillColor: const Color.fromARGB(221, 28, 28, 28),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                SizedBox(height: 20),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFF1E4A5F),
                  ),
                  child: DropdownButton<String>(
                    hint: Text(
                      "Select Region",
                      style: TextStyle(color: Colors.white70),
                    ),
                    isExpanded: true,
                    underline: Container(),
                    value: _selectedRegion,
                    items: _regions
                        .map(
                          (region) => DropdownMenuItem(
                            value: region,
                            child: Text(region),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() => _selectedRegion = value);
                    },
                  ),
                  // DropdownButton<String>(
                  //   hint: Text("Select Region"),
                  //   isExpanded: true,
                  //   alignment: Alignment.center,
                  //   // decoration: const InputDecoration(
                  //   //   labelText: "Select Region",
                  //   //   border: OutlineInputBorder(),
                  //   // ),
                  //   value: _selectedRegion,
                  //   items: _regions
                  //       .map(
                  //         (region) => DropdownMenuItem(
                  //           value: region,
                  //           child: Text(region),
                  //         ),
                  //       )
                  //       .toList(),
                  //   onChanged: (value) {
                  //     setState(() => _selectedRegion = value);
                  //   },
                  // ),
                ),
                const SizedBox(height: 20),

                // --- Dropdown for Document Type ---
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFF1E4A5F),
                  ),
                  child: DropdownButton<String>(
                    // decoration: const InputDecoration(
                    //   labelText: "Select Document Type",
                    //   border: OutlineInputBorder(),
                    // ),
                    hint: Text(
                      "Select Document Type",
                      style: TextStyle(color: Colors.white70),
                    ),
                    isExpanded: true,
                    underline: Container(),
                    value: _selectedDocType,
                    items: _docTypes
                        .map(
                          (doc) =>
                              DropdownMenuItem(value: doc, child: Text(doc)),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() => _selectedDocType = value);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => pickImage(context),

                      child: const Text(
                        'Attach TIN Number',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => pickImage(context),
                      child: const Text(
                        'Attach Customer Form',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // --- Row 2: Business License & Customer ID ---
                const SizedBox(height: 30),
                // ... previous code ...

                // --- Row 2: Business License & Customer ID ---
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => pickImage(context),

                      child: const Text(
                        'Business License',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => pickImage(context),
                      child: const Text(
                        'Attach Customer ID',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // --- Register Button ---
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green, // same light blue as submit
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // TODO: register logic here
                        print('Register button pressed');
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
