import 'dart:convert';

Client clientFromMap(String str) {
    final jsonData = json.decode(str);
    return Client.fromMap(jsonData);
}

String clientToMap(Client data) {
    final dyn = data.toMap();
    return json.encode(dyn);
}

class Client {
    int id;
    bool status;

    Client({
        this.id,
        this.status,
    });

    factory Client.fromMap(Map<String, dynamic> json) => new Client(
        id: json["id"],
        status: json["blocked"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
    };
}