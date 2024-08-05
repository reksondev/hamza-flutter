import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactsPage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class ContactsPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  Future<void> getContacts() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      // ignore: no_leading_underscores_for_local_identifiers
      List<Contact> _contacts = (await ContactsService.getContacts()).toList();
      setState(() {
        contacts = _contacts;
      });
    } else {
      // Handle the case where permission was not granted
      await Permission.contacts.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts List'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          Contact contact = contacts[index];
          return ListTile(
            leading: (contact.avatar != null && contact.avatar!.isNotEmpty)
                ? CircleAvatar(
                    backgroundImage: MemoryImage(contact.avatar!),
                  )
                : CircleAvatar(
                    child: Text(contact.initials()),
                  ),
            title: Text(contact.displayName ?? ''),
          );
        },
      ),
    );
  }
}
