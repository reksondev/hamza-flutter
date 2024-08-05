import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactsPage(),
    );
  }
}

class ContactsPage extends StatefulWidget {
  @override
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
      List<Contact> _contacts = (await ContactsService.getContacts()).toList();
      setState(() {
        contacts = _contacts;
      });
    } else {
      await Permission.contacts.request();
      getContacts(); // Retry after requesting permission
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts List'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
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
                  subtitle: Text(contact.phones!.isNotEmpty
                      ? contact.phones!.map((e) => e.value).join(', ')
                      : 'No phone numbers'),
                );
              },
            ),
    );
  }
}
