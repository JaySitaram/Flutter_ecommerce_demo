class CartModel{
  String? image;
  String? title;
  String? price;
  String? qty;
  int? id;

  CartModel({this.image,this.title,this.price,this.qty});

  CartModel.fromJson(Map<String,dynamic> map){
    id=map['_id'];
    image=map['image'];
    title=map['product_name'];
    price=map['product_price'];
    qty=map['product_qty'];
  }
}