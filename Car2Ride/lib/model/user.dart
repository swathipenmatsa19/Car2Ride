class User{
  String email;
  String password;
  String displayName;
  int zip;
  String uid;

  User({
    this.email,
    this.password,
    this.displayName,
    this.zip,
    this.uid
  });

  Map<String,dynamic> serialize(){
    return <String,dynamic>{
      EMAIL:email,
      DISPLAYNAME:displayName,
      ZIP:zip,
      UID:uid,
    };
  }

  static User deserialiize(Map<String,dynamic> document){
    return User(
      email:document[EMAIL],
      displayName:document[DISPLAYNAME],
      zip: document[ZIP],
      uid: document[UID],
    );
  }

  static const PROFILE_COLLECTION = 'userprofile';
  static const EMAIL = 'email';
  static const DISPLAYNAME = 'displayName';
  static const ZIP = 'zip';
  static const UID = 'uid';
}