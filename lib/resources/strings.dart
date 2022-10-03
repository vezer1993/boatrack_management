class StaticStrings{

  ///UI
  static String buttonTextEdit = "Edit" ;
  static String buttonTextCancel = "Cancel" ;
  static String buttonTextSave = "Save" ;
  static String buttonTextNew = "New";
  static String buttonTextNewModel = "New Check in/out model";

  static String getButtonTextEdit (){
    return buttonTextEdit;
  }

  static String getButtonTextSave (){
    return buttonTextSave;
  }

  static String getButtonTextCancel (){
    return buttonTextCancel;
  }

  static String getButtonTextNew (){
    return buttonTextNew;
  }

  static String getButtonTextNewModel (){
    return buttonTextNewModel;
  }

  /// DASHBOARD
  // CALENDAR
  static String dashboardCalendarTitle = "Booking Calendar";
  static String dashboardHeader = "Yachts";
  static String currentBookingsHeader = "Current Booking";

  static String getDashboardCalendarTitle (){
    return dashboardCalendarTitle;
  }

  static String getDashboardHeader (){
    return dashboardHeader;
  }

  static String getDashboardCurrentBookingTitle(){
    return currentBookingsHeader;
  }

  // YACHT LIST
  static String dashboardYachtListTitle = "Boats";
  static String yachtOut = "BOOKED";
  static String yachtHome = "FREE";
  static String yachtOption = "OPTION";

  static String getDashboardYachtListTitle (){
    return dashboardYachtListTitle;
  }

  static String getTableYachtOut (){
    return yachtOut;
  }

  static String getTableYachtHome (){
    return yachtHome;
  }

  static String getTableYachtOption (){
    return yachtOption;
  }

  ///SETTINGS PAGE
  //TELTONIKA SETTINGS
  static String teltonikaSettingsTitle = "Teltonika Settings";


  static String getTeltonikaSettingsTitle (){
    return teltonikaSettingsTitle;
  }

  /// API STRINGS

  //local: localhost:5001
  //azure: boatrackservices.azurewebsites.net
  static String getApiURL (){
    return "boatrackservices.azurewebsites.net";
  }

  static String getTeltonikaApiURL (){
    return "rms.teltonika-networks.com";
  }

  static String getTeltonikaApiVersion (){
    return "/api";
  }

  static String getTeltonikaDeviceInformation(){
    return "/devices";
  }

  static String getApiVersion (){
    return "/api";
  }

  ///YACHT PATHS
  static String getPathYachtList(){
    return "/Yachts/list";
  }

  static String getPathYacht(){
    return "/Yachts";
  }

  /// CHARTER PATHS
  static String getPathCharter(){
    return "/Charters";
  }

  static String getPathCharterTeltonika(){
    return "/teltonika";
  }

  static String getPathCharterTeltonikaParam(){
    return "teltonikaToken";
  }

  static String getPathYachtCheckModel(){
    return "/checkmodel";
  }

  static String getPathParamYachtCheckModel(){
    return "checkmodel";
  }

  static String getPathCheckInList(){
    return"/Checkins/list";
  }

  static String getPathCheckOutList(){
    return"/Checkouts/list";
  }

  static String getPathIssues(){
    return"/Issues/list";
  }

  static String getPathCleaningList(){
    return"/Cleanings/list";
  }


  /// ACCOUNT PATHS
  static String getPathAccount(){
    return "/Accounts";
  }

  static String getPathModels(){
    return "/Checkmodels";
  }

  ///SESSIONS
  static String getYachtListSession(){
    return "yachts_session";
  }

  static String getCharterSession(){
    return "charter_session";
  }

  ///Yacht
  static String getModel(){
    return "Model:";
  }

  static String getYear(){
    return "Year:";
  }

  static String getLength(){
    return "Length:";
  }

  static String getHomeBase(){
    return "Home:";
  }

  static String getWeeksOut(){
    return "Weeks Out:";
  }

  static String getRevenue(){
    return "Revenue:";
  }

  static String getThisWeek(){
    return "This Week:";
  }

  static String getNextWeek(){
    return "Next Week:";
  }
}