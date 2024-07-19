import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contacts_app/providers/contact_provider.dart';
import 'package:contacts_app/widgets/contact_list_item.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: contactProvider.favoriteContacts.length,
        itemBuilder: (ctx, index) {
          return ContactListItem(
              contact: contactProvider.favoriteContacts[index]);
        },
      ),
    );
  }
}
