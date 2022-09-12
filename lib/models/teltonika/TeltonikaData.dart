class Data {
  int? id;
  int? companyId;
  String? model;
  String? originalModel;
  String? name;
  String? serial;
  String? mac;
  String? wlanMac;
  int? mqtt;
  int? dynamicMonitoring;
  int? staticMonitoring;
  int? ioMonitoring;
  int? gpsMonitoring;
  int? hotspotMonitoring;
  int? speedtestMonitoring;
  int? wirelessMonitoring;
  int? ddnsMonitoring;
  String? lastConnectionAt;
  String? activationStatus;
  int? isFacelift;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? creditEnabled;
  int? creditActivated;
  String? creditExpireDate;
  int? monitoringEnabled;
  int? autoExtendCredit;
  String? companyName;
  int? temperature;
  int? signal;
  String? firmware;
  String? bootloaderVersion;
  String? cellId;
  String? connectionType;
  String? connectionState;
  int? connectionUptime;
  String? iccid;
  String? lac;
  String? mcc;
  String? mnc;
  int? simSlot;
  String? simState;
  String? pinState;
  String? operator;
  String? operatorNumber;
  int? routerUptime;
  String? wanState;
  String? wanIp;
  String? mobileIp;
  String? networkState;
  int? sent;
  int? received;
  int? rscp;
  int? ecio;
  int? rsrp;
  double? sinr;
  int? rsrq;
  String? imei;
  String? batchNumber;
  String? productCode;
  String? modemManufacturer;
  String? modemModel;
  String? modemFirmware;
  String? hardwareRevision;
  String? imsi;
  int? fixStatus;
  int? satellites;
  double? latitude;
  double? longitude;
  String? speed;
  String? course;
  String? gpsTime;
  String? accuracy;
  double? cellTowerLatitude;
  double? cellTowerLongitude;
  int? cellTowerAccuracy;
  String? lastUpdateAt;
  String? creditType;
  int? ddnsRulesCount;

  Data(
      {this.id,
        this.companyId,
        this.model,
        this.originalModel,
        this.name,
        this.serial,
        this.mac,
        this.wlanMac,
        this.mqtt,
        this.dynamicMonitoring,
        this.staticMonitoring,
        this.ioMonitoring,
        this.gpsMonitoring,
        this.hotspotMonitoring,
        this.speedtestMonitoring,
        this.wirelessMonitoring,
        this.ddnsMonitoring,
        this.lastConnectionAt,
        this.activationStatus,
        this.isFacelift,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.creditEnabled,
        this.creditActivated,
        this.creditExpireDate,
        this.monitoringEnabled,
        this.autoExtendCredit,
        this.companyName,
        this.temperature,
        this.signal,
        this.firmware,
        this.bootloaderVersion,
        this.cellId,
        this.connectionType,
        this.connectionState,
        this.connectionUptime,
        this.iccid,
        this.lac,
        this.mcc,
        this.mnc,
        this.simSlot,
        this.simState,
        this.pinState,
        this.operator,
        this.operatorNumber,
        this.routerUptime,
        this.wanState,
        this.wanIp,
        this.mobileIp,
        this.networkState,
        this.sent,
        this.received,
        this.rscp,
        this.ecio,
        this.rsrp,
        this.sinr,
        this.rsrq,
        this.imei,
        this.batchNumber,
        this.productCode,
        this.modemManufacturer,
        this.modemModel,
        this.modemFirmware,
        this.hardwareRevision,
        this.imsi,
        this.fixStatus,
        this.satellites,
        this.latitude,
        this.longitude,
        this.speed,
        this.course,
        this.gpsTime,
        this.accuracy,
        this.cellTowerLatitude,
        this.cellTowerLongitude,
        this.cellTowerAccuracy,
        this.lastUpdateAt,
        this.creditType,
        this.ddnsRulesCount,});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    model = json['model'];
    originalModel = json['original_model'];
    name = json['name'];
    serial = json['serial'];
    mac = json['mac'];
    wlanMac = json['wlan_mac'];
    mqtt = json['mqtt'];
    dynamicMonitoring = json['dynamic_monitoring'];
    staticMonitoring = json['static_monitoring'];
    ioMonitoring = json['io_monitoring'];
    gpsMonitoring = json['gps_monitoring'];
    hotspotMonitoring = json['hotspot_monitoring'];
    speedtestMonitoring = json['speedtest_monitoring'];
    wirelessMonitoring = json['wireless_monitoring'];
    ddnsMonitoring = json['ddns_monitoring'];
    lastConnectionAt = json['last_connection_at'];
    activationStatus = json['activation_status'];
    isFacelift = json['is_facelift'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    creditEnabled = json['credit_enabled'];
    creditActivated = json['credit_activated'];
    creditExpireDate = json['credit_expire_date'];
    monitoringEnabled = json['monitoring_enabled'];
    autoExtendCredit = json['auto_extend_credit'];
    companyName = json['company_name'];
    temperature = json['temperature'];
    signal = json['signal'];
    firmware = json['firmware'];
    bootloaderVersion = json['bootloader_version'];
    cellId = json['cell_id'];
    connectionType = json['connection_type'];
    connectionState = json['connection_state'];
    connectionUptime = json['connection_uptime'];
    iccid = json['iccid'];
    lac = json['lac'];
    mcc = json['mcc'];
    mnc = json['mnc'];
    simSlot = json['sim_slot'];
    simState = json['sim_state'];
    pinState = json['pin_state'];
    operator = json['operator'];
    operatorNumber = json['operator_number'];
    routerUptime = json['router_uptime'];
    wanState = json['wan_state'];
    wanIp = json['wan_ip'];
    mobileIp = json['mobile_ip'];
    networkState = json['network_state'];
    sent = json['sent'];
    received = json['received'];
    rscp = json['rscp'];
    ecio = json['ecio'];
    rsrp = json['rsrp'];
    sinr = json['sinr'];
    rsrq = json['rsrq'];
    imei = json['imei'];
    batchNumber = json['batch_number'];
    productCode = json['product_code'];
    modemManufacturer = json['modem_manufacturer'];
    modemModel = json['modem_model'];
    modemFirmware = json['modem_firmware'];
    hardwareRevision = json['hardware_revision'];
    imsi = json['imsi'];
    fixStatus = json['fix_status'];
    satellites = json['satellites'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    speed = json['speed'];
    course = json['course'];
    gpsTime = json['gps_time'];
    accuracy = json['accuracy'];
    cellTowerLatitude = json['cell_tower_latitude'];
    cellTowerLongitude = json['cell_tower_longitude'];
    cellTowerAccuracy = json['cell_tower_accuracy'];
    lastUpdateAt = json['last_update_at'];
    creditType = json['credit_type'];
    ddnsRulesCount = json['ddns_rules_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['model'] = this.model;
    data['original_model'] = this.originalModel;
    data['name'] = this.name;
    data['serial'] = this.serial;
    data['mac'] = this.mac;
    data['wlan_mac'] = this.wlanMac;
    data['mqtt'] = this.mqtt;
    data['dynamic_monitoring'] = this.dynamicMonitoring;
    data['static_monitoring'] = this.staticMonitoring;
    data['io_monitoring'] = this.ioMonitoring;
    data['gps_monitoring'] = this.gpsMonitoring;
    data['hotspot_monitoring'] = this.hotspotMonitoring;
    data['speedtest_monitoring'] = this.speedtestMonitoring;
    data['wireless_monitoring'] = this.wirelessMonitoring;
    data['ddns_monitoring'] = this.ddnsMonitoring;
    data['last_connection_at'] = this.lastConnectionAt;
    data['activation_status'] = this.activationStatus;
    data['is_facelift'] = this.isFacelift;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['credit_enabled'] = this.creditEnabled;
    data['credit_activated'] = this.creditActivated;
    data['credit_expire_date'] = this.creditExpireDate;
    data['monitoring_enabled'] = this.monitoringEnabled;
    data['auto_extend_credit'] = this.autoExtendCredit;
    data['company_name'] = this.companyName;
    data['temperature'] = this.temperature;
    data['signal'] = this.signal;
    data['firmware'] = this.firmware;
    data['bootloader_version'] = this.bootloaderVersion;
    data['cell_id'] = this.cellId;
    data['connection_type'] = this.connectionType;
    data['connection_state'] = this.connectionState;
    data['connection_uptime'] = this.connectionUptime;
    data['iccid'] = this.iccid;
    data['lac'] = this.lac;
    data['mcc'] = this.mcc;
    data['mnc'] = this.mnc;
    data['sim_slot'] = this.simSlot;
    data['sim_state'] = this.simState;
    data['pin_state'] = this.pinState;
    data['operator'] = this.operator;
    data['operator_number'] = this.operatorNumber;
    data['router_uptime'] = this.routerUptime;
    data['wan_state'] = this.wanState;
    data['wan_ip'] = this.wanIp;
    data['mobile_ip'] = this.mobileIp;
    data['network_state'] = this.networkState;
    data['sent'] = this.sent;
    data['received'] = this.received;
    data['rscp'] = this.rscp;
    data['ecio'] = this.ecio;
    data['rsrp'] = this.rsrp;
    data['sinr'] = this.sinr;
    data['rsrq'] = this.rsrq;
    data['imei'] = this.imei;
    data['batch_number'] = this.batchNumber;
    data['product_code'] = this.productCode;
    data['modem_manufacturer'] = this.modemManufacturer;
    data['modem_model'] = this.modemModel;
    data['modem_firmware'] = this.modemFirmware;
    data['hardware_revision'] = this.hardwareRevision;
    data['imsi'] = this.imsi;
    data['fix_status'] = this.fixStatus;
    data['satellites'] = this.satellites;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['speed'] = this.speed;
    data['course'] = this.course;
    data['gps_time'] = this.gpsTime;
    data['accuracy'] = this.accuracy;
    data['cell_tower_latitude'] = this.cellTowerLatitude;
    data['cell_tower_longitude'] = this.cellTowerLongitude;
    data['cell_tower_accuracy'] = this.cellTowerAccuracy;
    data['last_update_at'] = this.lastUpdateAt;
    data['credit_type'] = this.creditType;
    data['ddns_rules_count'] = this.ddnsRulesCount;
    return data;
  }
}

class Meta {
  Sorters? sorters;
  int? total;

  Meta({this.sorters, this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    sorters =
    json['sorters'] != null ? new Sorters.fromJson(json['sorters']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sorters != null) {
      data['sorters'] = this.sorters!.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}

class Sorters {
  String? id;

  Sorters({this.id});

  Sorters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}