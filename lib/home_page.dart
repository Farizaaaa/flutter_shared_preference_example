import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shared_preference_example/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  List<ContactModelClass> contacts = [];
  //also
  //List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;
  //for accessing sp
  late SharedPreferences sp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreference();
  }

  getSharedPreference() async {
    sp = await SharedPreferences.getInstance();
  }

  saveDataToSp() async {
    //adding the data in contact list to json and encoded and added to the string list
    List<String> setContactList =
        contacts.map((e) => jsonEncode(e.toJson())).toList();
    //
    //add that list to sp
    sp.setStringList("ContactList", setContactList);
    //
  }

  getDataFromSp() async {
    //
    List<String>? getContactList = sp.getStringList("ContactList");
    if (getContactList != null) {
      contacts = getContactList
          .map((e) => ContactModelClass.fromJson(json.decode(e)))
          .toList();
    }
    setState(() {});
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Contact Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                  hintText: 'Contact Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          contactController.text.isNotEmpty) {
                        setState(() {
                          //!1:add data got on controllers to the list
                          contacts.add(ContactModelClass(
                              name: nameController.text.trim(),
                              number: contactController.text.trim()));
                        });
                        nameController.clear();
                        contactController.clear();
                        //save data to sp
                        saveDataToSp();
                        //
                      } else {}
                    },
                    child: const Text('Save')),
                ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          contactController.text.isNotEmpty) {
                        setState(() {
                          //update list
                          contacts[selectedIndex].name = nameController.text;
                          contacts[selectedIndex].number =
                              contactController.text;
                          selectedIndex = -1;
                          //
                        });
                        nameController.clear();
                        contactController.clear();
                        //save data to sp
                        saveDataToSp();
                        //
                      } else {}
                    },
                    child: const Text('Update')),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'No Contact yet..',
              style: TextStyle(fontSize: 22),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) => getRow(index),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            // contacts[index].name[0],
            "", style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "contact",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("text"),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    //
                  },
                  child: const Icon(Icons.edit)),
              InkWell(onTap: (() {}), child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
