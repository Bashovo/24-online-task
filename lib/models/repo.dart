class Repo {
  String name;
  Owner owner;
  Repo({
    this.name,
    this.owner,
  });

  Repo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    return data;
  }
}

class Owner {
  String avatarUrl;
  Owner({
    this.avatarUrl,
  });
  Owner.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatar_url'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar_url'] = this.avatarUrl;
    return data;
  }
}
