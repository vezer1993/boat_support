class Yacht {
  int? id;
  String? name;
  String? model;
  int? modelId;
  int? shipyardId;
  int? year;
  String? kind;
  int? homeBaseId;
  String? homeBase;
  int? companyId;
  String? company;
  int? draught;
  double? beam;
  double? length;
  int? waterCapacity;
  int? fuelCapacity;
  String? engine;
  int? deposit;
  int? commissionPercentage;
  int? wc;
  int? berths;
  int? cabins;
  double? mainsailArea;
  int? genoaArea;
  String? mainsailType;
  String? genoaType;
  int? defaultCheckInDay;
  List<Images>? images;
  List<int>? equipmentIds;
  List<Products>? products;
  List<CabinsLayout>? cabinsLayout;
  List<BerthsLayout>? berthsLayout;

  Yacht(
      {this.id,
        this.name,
        this.model,
        this.modelId,
        this.shipyardId,
        this.year,
        this.kind,
        this.homeBaseId,
        this.homeBase,
        this.companyId,
        this.company,
        this.draught,
        this.beam,
        this.length,
        this.waterCapacity,
        this.fuelCapacity,
        this.engine,
        this.deposit,
        this.commissionPercentage,
        this.wc,
        this.berths,
        this.cabins,
        this.mainsailArea,
        this.genoaArea,
        this.mainsailType,
        this.genoaType,
        this.defaultCheckInDay,
        this.images,
        this.equipmentIds,
        this.products,
        this.cabinsLayout,
        this.berthsLayout});

  Yacht.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    model = json['model'];
    modelId = json['modelId'];
    shipyardId = json['shipyardId'];
    year = json['year'];
    kind = json['kind'];
    homeBaseId = json['homeBaseId'];
    homeBase = json['homeBase'];
    companyId = json['companyId'];
    company = json['company'];
    draught = json['draught'];
    beam = json['beam'];
    length = json['length'];
    waterCapacity = json['waterCapacity'];
    fuelCapacity = json['fuelCapacity'];
    engine = json['engine'];
    deposit = json['deposit'];
    commissionPercentage = json['commissionPercentage'];
    wc = json['wc'];
    berths = json['berths'];
    cabins = json['cabins'];
    mainsailArea = json['mainsailArea'];
    genoaArea = json['genoaArea'];
    mainsailType = json['mainsailType'];
    genoaType = json['genoaType'];
    defaultCheckInDay = json['defaultCheckInDay'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    equipmentIds = json['equipmentIds'].cast<int>();
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['cabinsLayout'] != null) {
      cabinsLayout = <CabinsLayout>[];
      json['cabinsLayout'].forEach((v) {
        cabinsLayout!.add(new CabinsLayout.fromJson(v));
      });
    }
    if (json['berthsLayout'] != null) {
      berthsLayout = <BerthsLayout>[];
      json['berthsLayout'].forEach((v) {
        berthsLayout!.add(new BerthsLayout.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['model'] = this.model;
    data['modelId'] = this.modelId;
    data['shipyardId'] = this.shipyardId;
    data['year'] = this.year;
    data['kind'] = this.kind;
    data['homeBaseId'] = this.homeBaseId;
    data['homeBase'] = this.homeBase;
    data['companyId'] = this.companyId;
    data['company'] = this.company;
    data['draught'] = this.draught;
    data['beam'] = this.beam;
    data['length'] = this.length;
    data['waterCapacity'] = this.waterCapacity;
    data['fuelCapacity'] = this.fuelCapacity;
    data['engine'] = this.engine;
    data['deposit'] = this.deposit;
    data['commissionPercentage'] = this.commissionPercentage;
    data['wc'] = this.wc;
    data['berths'] = this.berths;
    data['cabins'] = this.cabins;
    data['mainsailArea'] = this.mainsailArea;
    data['genoaArea'] = this.genoaArea;
    data['mainsailType'] = this.mainsailType;
    data['genoaType'] = this.genoaType;
    data['defaultCheckInDay'] = this.defaultCheckInDay;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['equipmentIds'] = this.equipmentIds;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.cabinsLayout != null) {
      data['cabinsLayout'] = this.cabinsLayout!.map((v) => v.toJson()).toList();
    }
    if (this.berthsLayout != null) {
      data['berthsLayout'] = this.berthsLayout!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? description;
  String? url;
  int? sortOrder;

  Images({this.description, this.url, this.sortOrder});

  Images.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    url = json['url'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['url'] = this.url;
    data['sortOrder'] = this.sortOrder;
    return data;
  }
}

class Products {
  String? name;
  List<Extras>? extras;

  Products({this.name, this.extras});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['extras'] != null) {
      extras = <Extras>[];
      json['extras'].forEach((v) {
        extras!.add(new Extras.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.extras != null) {
      data['extras'] = this.extras!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Extras {
  String? name;
  bool? obligatory;
  int? price;
  String? unit;
  bool? payableInBase;
  bool? includedDepositWaiver;
  int? validDaysFrom;
  int? validDaysTo;
  int? minNumberOfPersons;
  int? maxNumberOfPersons;
  List<ValidForBases>? validForBases;

  Extras(
      {this.name,
        this.obligatory,
        this.price,
        this.unit,
        this.payableInBase,
        this.includedDepositWaiver,
        this.validDaysFrom,
        this.validDaysTo,
        this.minNumberOfPersons,
        this.maxNumberOfPersons,
        this.validForBases});

  Extras.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    obligatory = json['obligatory'];
    price = json['price'];
    unit = json['unit'];
    payableInBase = json['payableInBase'];
    includedDepositWaiver = json['includedDepositWaiver'];
    validDaysFrom = json['validDaysFrom'];
    validDaysTo = json['validDaysTo'];
    minNumberOfPersons = json['minNumberOfPersons'];
    maxNumberOfPersons = json['maxNumberOfPersons'];
    if (json['validForBases'] != null) {
      validForBases = <ValidForBases>[];
      json['validForBases'].forEach((v) {
        validForBases!.add(new ValidForBases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['obligatory'] = this.obligatory;
    data['price'] = this.price;
    data['unit'] = this.unit;
    data['payableInBase'] = this.payableInBase;
    data['includedDepositWaiver'] = this.includedDepositWaiver;
    data['validDaysFrom'] = this.validDaysFrom;
    data['validDaysTo'] = this.validDaysTo;
    data['minNumberOfPersons'] = this.minNumberOfPersons;
    data['maxNumberOfPersons'] = this.maxNumberOfPersons;
    if (this.validForBases != null) {
      data['validForBases'] =
          this.validForBases!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ValidForBases {
  List<int>? from;
  List<int>? to;

  ValidForBases({this.from, this.to});

  ValidForBases.fromJson(Map<String, dynamic> json) {
    from = json['from'].cast<int>();
    to = json['to'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}

class CabinsLayout {
  String? name;
  int? amount;

  CabinsLayout({this.name, this.amount});

  CabinsLayout.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    return data;
  }
}

class BerthsLayout {
  String? name;
  int? amount;

  BerthsLayout({this.name, this.amount});

  BerthsLayout.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    return data;
  }
}