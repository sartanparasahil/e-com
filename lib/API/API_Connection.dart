class APIConnection{

  static const String hostConnect = "http://192.168.0.123/e-com";
  static const String hostConnectUser = "$hostConnect/user";

  //add Image Folder
  static const String hostConnectImage = "$hostConnect/image";

  //insert API
  static const String addUserAPI = "$hostConnectUser/insert_User.php";

  //Userfetch API
  static const String fetchUserAPI = "$hostConnectUser/fetch_User.php";

  //fetchUserid API
  // static const String fetchUserIdAPI = "$hostConnectUser/fetch_Userid.php";

  //fetch ProductAPI
  static const String fetchProductAPI = "$hostConnectUser/fetch_Product.php";

}