import 'package:contacts_app/screens/add_edit_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/providers/contact_provider.dart';

class ContactProfileScreen extends StatelessWidget {
  final Contact contact;

  ContactProfileScreen({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddEditContactScreen(contact: contact),
              ));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<ContactProvider>(context, listen: false)
                  .deleteContact(contact.id);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${contact.name}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Phone: ${contact.phone}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Email: ${contact.email}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Integrate with device's calling functionality
              },
              icon: Icon(Icons.call),
              label: Text('Call Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
