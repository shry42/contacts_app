import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_app/models/contact.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts => [..._contacts];
  List<Contact> get favoriteContacts =>
      _contacts.where((c) => c.isFavorite).toList();

  Future<void> fetchContacts() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('contacts').get();
    final List<Contact> loadedContacts = [];
    result.docs.forEach((doc) {
      loadedContacts.add(Contact.fromMap({
        ...doc.data() as Map<String, dynamic>,
        'id': doc.id, // Ensure the id is set correctly from Firestore
      }));
    });
    _contacts = loadedContacts;
    notifyListeners();
  }

  Future<void> addContact(Contact contact) async {
    final docRef = await FirebaseFirestore.instance
        .collection('contacts')
        .add(contact.toMap());
    _contacts.add(Contact(
        id: docRef.id,
        name: contact.name,
        phone: contact.phone,
        email: contact.email,
        isFavorite: contact.isFavorite));
    notifyListeners();
  }

  Future<void> updateContact(Contact contact) async {
    await FirebaseFirestore.instance
        .collection('contacts')
        .doc(contact.id)
        .update(contact.toMap());
    final index = _contacts.indexWhere((c) => c.id == contact.id);
    _contacts[index] = contact;
    notifyListeners();
  }

  Future<void> deleteContact(String id) async {
    await FirebaseFirestore.instance.collection('contacts').doc(id).delete();
    _contacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
  }

  void toggleFavoriteStatus(Contact contact) {
    contact.isFavorite = !contact.isFavorite;
    updateContact(contact);
  }
}
