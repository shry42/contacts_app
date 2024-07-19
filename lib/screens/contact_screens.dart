import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contacts_app/providers/contact_provider.dart';
import 'package:contacts_app/widgets/contact_list_item.dart';
import 'package:contacts_app/screens/add_edit_contact_screen.dart';

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddEditContactScreen()));
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ContactProvider>(context, listen: false)
            .fetchContacts(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<ContactProvider>(
              builder: (ctx, contactProvider, child) {
                return ListView.builder(
                  itemCount: contactProvider.contacts.length,
                  itemBuilder: (ctx, index) {
                    return ContactListItem(
                        contact: contactProvider.contacts[index]);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
