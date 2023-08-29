class Contact {
  final String id;
  final String name;
  final String contacts;
  String? url;

  Contact(
      {required this.id, required this.name, required this.contacts, this.url});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        id: json['id'],
        name: json['name'] ?? '',
        contacts: json['Contacts'] ?? '',
        url: json['url']);
  }
}
