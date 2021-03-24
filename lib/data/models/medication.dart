class Medication {
  const Medication({
    this.name,
    this.description,
    this.type,
    this.imgSrc,
    this.price,
    this.sellerName,
    this.packSize,
    this.constituents,
    this.dispensedIn,
    this.productId,
  });

  final String name;
  final String description;
  final String type;
  final String imgSrc;
  final int price;
  final String sellerName;
  final String packSize;
  final String constituents;
  final String dispensedIn;
  final String productId;
}
