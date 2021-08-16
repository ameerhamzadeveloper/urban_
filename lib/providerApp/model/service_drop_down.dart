class ServiceDropDown{
  final String? namel;
  ServiceDropDown({this.namel});
  static List<ServiceDropDown> nameList(){
    return <ServiceDropDown>[
      ServiceDropDown(namel: "Pause Service"),
      ServiceDropDown(namel: "Delete Service")
    ];
  }
}