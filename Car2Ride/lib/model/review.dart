class Review{
  String reviewName;
  String carid;

  String documentId;
  

  Review({
    this.reviewName,
    this.carid,
    
  });

  Review.empty(){
    this.reviewName = '';
    this.carid = '';
    //this.sharedWith = <dynamic>[];
  }

  Review.clone(Review b){
    this.reviewName = b.reviewName;
    this.carid = b.carid;
    
    
  }

  Map<String,dynamic> serialize(){
    return <String,dynamic>{
      REVIEWNAME:reviewName,
      CARID:carid,
    };
  }

  static Review deserialize(Map<String,dynamic> document,String docId){
    return Review(
      reviewName:document[REVIEWNAME],
      carid:document[CARID],
    );
  }

  static const REVIEWSCOLLECTION = 'reviews';
  static const REVIEWNAME = 'reviewName';
  static const CARID = 'carid';
}
	
	
	
