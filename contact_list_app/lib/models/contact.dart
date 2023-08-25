class Contact {
  final String name;
  final String contacts;
  // final String? url; 
  bool isSelected;

  Contact({
    required this.name,
    required this.contacts,
    // this.url,
    required this.isSelected 
  });

  factory Contact.fromJson(Map<String, dynamic> json) =>  
    Contact(
      name: json['name'] ?? '', 
      contacts: json['Contacts'] ?? '', 
      // url: json['url'], 
      isSelected: false
    );
    Map<String, dynamic> toJson() => {
     "name" : name,
     "contacts" : contacts,
    //  "url" : url
    };
  }


  class ContactGroup {
  final String name;
  final List<Contact> contacts;

  ContactGroup({
    required this.name,
    required this.contacts,
  });
}

