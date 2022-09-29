import UIKit
import Flutter
import CoreLocation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    public var dId = "";
    public var tok = "";
    public var rol = "";
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      handleMethodChannel()
    GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    func handleMethodChannel() {
           let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
           let batteryChannel = FlutterMethodChannel(
               name: "com.ogoul.driver/driver",
               binaryMessenger: controller.binaryMessenger)
           batteryChannel.setMethodCallHandler({
             (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
               if (call.method == "driverOnline") {
                   guard let args = call.arguments as? [String : Any] else {return}
                    let driverId = args["driverId"] as? String
                    let token = args["token"] as? String
                    let role = args["role"] as? String
                   self.dId = driverId!
                   self.tok = token!
                   self.rol = role!
                   print("OnLINE")
                   print(driverId)
                   print(token)
                   print(role)
                   result("success")
                   SocketSharedManager.sharedSocket.establishConnection(userId: driverId!)
                   LocationManager.shared.getLocation { location, error in
                            if let loc =  location {
                                print("I AM IN--->")
                                self.didGetLocation(location: loc)
                            }
                        }
                   print("LocationPermission")
                           print(LocationManager.shared.isLocationEnabled() == true)
                         LocationManager.shared.delegate = self
               }
               if (call.method == "driverOffline") {
                   print("OffLINE")
                   LocationManager.shared.destroyLocationManager()
                   result("success")
               }
               
           })
       }
    
}


extension AppDelegate: RunnerLocationDelegate {
    func didGetLocation(location: CLLocation) {
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
                center.latitude = location.coordinate.latitude
                center.longitude = location.coordinate.longitude
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                    {(placemarks, error) in
                        if (error != nil)
                        {
                            print("reverse geodcode fail: \(error!.localizedDescription)")
                        }
            
            do {
                if let pm = placemarks as? [CLPlacemark]
                {
                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country)
                        print(pm.locality)
                        print(pm.subLocality)
                        print(pm.thoroughfare)
                        print(pm.postalCode)
                        print(pm.subThoroughfare)
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }
//
                        SocketSharedManager.sharedSocket.sendLocation(userId: self.dId,token: self.tok,role: self.rol,lat: location.coordinate.latitude,lng: location.coordinate.longitude,address: addressString)
                        print(addressString)
                  }
                }
                
                
            }catch let error {
                print("Not me error")
            }
                })
        
        
    }
    
}
