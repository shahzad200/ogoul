//
//  SocketSharedManager.swift
//  WorldNoor
//
//  Created by Raza najam on 10/28/19.
//  Copyright © 2019 Raza najam. All rights reserved.
//

import UIKit
import SocketIO
//import WebRTC

//@objc protocol feedCommentDelegate:AnyObject {
//    @objc optional func feedCommentReceivedFromSocket(res: NSDictionary)
//    @objc optional func chatMessageReceived(res:NSArray)
//    @objc optional func chatMessageDelete(res:NSArray)
//    @objc optional func videoProcessingSocketResponse(res:NSArray)
//    @objc optional func goLiveSessionSocketResponse(res:NSArray)
//
//}
//protocol SocketDelegateAppdelegate {
//    func didSocketConnectedAppdelegate(data: [Any])
//}
//
//protocol SocketDelegateForGroup {
//    func didSocketContactGroup(data: [String : Any])
//    func didSocketRemoveContactGroup(data: [String : Any])
//    func didSocketGroupUpdate(data: [String : Any])
//}
//extension SocketDelegateAppdelegate {
//    //default implementation for optional methods
//    func didSocketConnectedAppdelegate(data: [Any]){}
//}

////////////call delegates//////////////////


//protocol SocketDelegateCallmanager {
//
//    func didSocketConnected(data: [Any])
//    func didSocketDisConnected(data: [Any])
//
//
//    func didReceiveOffer(data: SignalingMessage)
//    func didReceiveAnswer(data: SignalingMessage)
//    func didReceiveCandidate(data: SignalingMessage)
//    func didReceiveReject(data :[String :Any])
//    func didReceiveReadyforcall(data: Available, join:Bool)
//    func didReceiveNewCallData(data: [String :Any])
//    func didReceiveVideoSwitch(data: [String :Any])
//    func didReceiveNewCallReceived(data: Available)
//
//
//}
//extension SocketDelegateCallmanager {
//    //default implementation for optional methods
//
//    func didSocketConnected(data: [Any]) {}
//    func didSocketDisConnected(data: [Any]) {}
//
//
//    func didReceiveOffer(data: SignalingMessage) {}
//    func didReceiveAnswer(data: SignalingMessage) {}
//    func didReceiveCandidate(data: SignalingMessage){}
//    func didReceiveReject(data :[String :Any]){}
//    func didReceiveReadyforcall(data: Available, join:Bool){}
//    func didReceiveNewCallData(data: [String :Any]){}
//    func didReceiveVideoSwitch(data: [String :Any]){}
//    func didReceiveNewCallReceived(data: Available) {}
//
//}


////////////messaging delegates//////////////////

//protocol SocketDelegate {
//
//
//    func didSocketConnected(data: [Any])
//    func didSocketDisConnected(data: [Any])
//    func didReceiveCallstatusAck(data: [String:Any])
//
//}
//
//extension SocketDelegate {
//
//    //default implementation for optional methods
//
//    func didSocketConnected(data: [Any])
//    {}
//    func didSocketDisConnected(data: [Any])
//    {}
//    func didReceiveCallstatusAck(data: [String:Any])
//    {}
//}


class SocketSharedManager: NSObject {
//    weak var commentDelegate:feedCommentDelegate?
//    var delegate: SocketDelegate?
//    var delegateAppdelegate: SocketDelegateAppdelegate?
//    var delegateCallmanager: SocketDelegateCallmanager?
    
//    var delegateGroup: SocketDelegateForGroup?
    
    static let sharedSocket = SocketSharedManager()
    var manager: SocketManager?
    var socket:SocketIOClient!
    var resetAck: SocketAckEmitter?
    
    private override init() {
        super.init()
    }
    
    func closeConnection() {
        socket.disconnect()
        socket.removeAllHandlers()
        manager = nil
        socket = nil
    }
    
    func establishConnection(userId:String){
        print("establishConnection  ==>")
        manager = SocketManager(socketURL: URL(string:"https://nodeapi.ogoullms.com/")!, config: [.log(false), .connectParams(["user_id" : userId]),.forceWebsockets(true)])
    
        
        
        self.socket = manager?.defaultSocket
        manager?.forceNew = true
        manager?.reconnects = true
        manager?.reconnectWaitMax = 0
        manager?.reconnectWait = 0
        
        
        self.socket.connect()
        self.addHandlers()
    }
    func sendLocation(userId:String,token:String,role:String,lat:Double,lng:Double,address:String) {
        let dic=["user_id":userId,"token":token,"role":role,"lat":String(lat),"lng":String(lng),"address":address]
        
        self.socket?.emitWithAck("app_driver_location", with: [returnJsonObject(dictionary: dic)]).timingOut(after: 0) { (data) in
                    
                    print("private \(data)")
                }
        
          
    }
    
    public func returnJsonObject(dictionary:[String:Any]) -> String{
         var jsobobj:String = ""
         if #available(iOS 11.0, *) {
            let jsonData = try! JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.sortedKeys)
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            jsobobj = jsonString
         } else {
            
         }
         let valid = JSONSerialization.isValidJSONObject(jsobobj) // true
         if(valid){debugPrint(jsobobj)}
         return jsobobj
      }
    
    
    func addHandlers() {
        print("addHandlers ==>")
        self.socket.on(clientEvent: .connect) {data, ack in
            print("connect ==>")
            print(data)
        }
        
        socket.on(clientEvent: .disconnect) {data, ack in
            print("disconnect ==>")
            print(data)
        }
        
        self.socket.on(clientEvent: .statusChange) {data, ack in
            print("statusChange ==>")
            print(data)
        }
        self.socket.on(clientEvent: .error) {data, ack in
            print("error ==>")
            print(data)
        }
        
        self.socket.on("welcome") {data, ack in
            print("welcome ==>")
            print(data)
        }
        self.socket.on("error") {data, ack in
            print("error ==>")
            print(data)
        }
    }
//
//
       
//
//            self.delegateAppdelegate?.didSocketConnectedAppdelegate(data: data)
//            self.delegate?.didSocketConnected(data: data)
//            self.delegateCallmanager?.didSocketConnected(data: data)
//            self.appDelegate.didenterForegroundSocket()
//            if(CallManager.sharedInstance.isCallStarted){
//                let param: [String:Any] = ["callId": CallManager.sharedInstance.callIdGlobal,"chatId": CallManager.sharedInstance.chatIdGlobal]
//                self.socket.emit("rejoined", with: [SharedManager.shared.returnJsonObject(dictionary: param)])
//            }
//
//        }
//        socket.on(clientEvent: .disconnect) {data, ack in
//
//            self.delegate?.didSocketDisConnected(data: data)
//            self.delegateCallmanager?.didSocketDisConnected(data: data)
//        }
//
//        socket.on("callaccepted") {[weak self] data, ack in
//
//            CallManager.sharedInstance.closeCallScreen()
//        }
//
//        socket.on("update_profile_user") {[weak self] data, ack in
//            print("update_profile_user data ===>")
//            print(data)
//            if ((data as? [String : Any]) != nil) {
//                print("update_profile_user data ===> 1")
//            }else if let arrayData = (data as? [[String : Any]]) {
//                print("update_profile_user data ===> 2")
//
//                print(arrayData[0])
//                if arrayData.count > 0 {
//                    if let firstObj = arrayData[0] as? [String : Any]{
//
//                        print("SharedManager.shared.userObj?.data.id ==> ")
//                        print(SharedManager.shared.ReturnValueCheck(value: firstObj["id"] ))
//                              print(SharedManager.shared.userObj?.data.id)
//
//
//                        if SharedManager.shared.ReturnValueCheck(value: firstObj["id"] ) == String((SharedManager.shared.userObj?.data.id)!) {
//                            SharedManager.shared.userObj?.data.profile_image = SharedManager.shared.ReturnValueCheck(value: firstObj["profile_image"])
//                            SharedManager.shared.userObj?.data.firstname = SharedManager.shared.ReturnValueCheck(value: firstObj["firstname"])
//
//                            SharedManager.shared.userObj?.data.lastname = SharedManager.shared.ReturnValueCheck(value: firstObj["lastname"])
//
//                            SharedManager.shared.downloadUserImage(imageUrl: (SharedManager.shared.userObj?.data.profile_image)!)
//                        }
//                    }
//                }
//            }
//        }
//
//        socket.on("answer") {[weak self] data, ack in
//            debugPrint("answer received")
//            debugPrint(data)
//
//            let dictionary : [String : Any] = data.first as! [String : Any]
//            let offerDic = dictionary["offer"] as! [String:Any]
//            //            debugPrint(offerDic)
//            let sdp = SDP.init(sdp: offerDic["sdp"] as! String)
//            //            debugPrint(sdp)
//
//            do {
//                let signalingMessage = try SignalingMessage.init(type: dictionary["type"] as! String, offer: sdp, candidate: dictionary["candidate"] as? Candidate, phone: dictionary["phone"] as? String, photoUrl: dictionary["photoUrl"] as? String, name: dictionary["name"] as? String, connectedUserId: (dictionary["connectedUserId"] as? String)!, isVideo: dictionary["isVideo"] as? Bool,callId:(dictionary["callId"] as? String)!,chatId: (dictionary["chatId"] as? String)!,sessionId: dictionary["sessionId"] as? String, socketId: dictionary["socketId"] as? String)
//                try self?.delegateCallmanager?.didReceiveAnswer(data: signalingMessage)
//
//            }
//            catch{
//                debugPrint("crash")
//            }
//        }
//        socket.on("callaccepted") {[weak self] data, ack in
//
//            CallManager.sharedInstance.closeCallScreen()
//        }
//
//        socket.on("groupCallStatus") {[weak self] data, ack in
//            debugPrint("groupCallStatus received")
//            debugPrint(data)
//
//            let dictionary : [String : Any] = data.first as! [String : Any]
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CallStatus"), object: nil,userInfo: dictionary)
//
//        }
//        socket.on("switchvideo") {[weak self] data, ack in
//            debugPrint("switch video received")
//            debugPrint(data)
//
//            let dictionary : [String : Any] = data.first as! [String : Any]
//            self?.delegateCallmanager?.didReceiveVideoSwitch(data: dictionary)
//        }
//        socket.on("candidate") {[weak self] data, ack in
//            debugPrint("candidate received")
//            let dictionary : [String : Any] = data.first as! [String : Any]
//            let candidate = dictionary["candidate"]  as! [String:Any]
//            let candidate1 = Candidate.init(sdp: candidate["sdp"] as! String, sdpMLineIndex: candidate["sdpMLineIndex"] as! Int32, sdpMid: candidate["sdpMid"] as! String)
//
//            let signalingMessage = SignalingMessage.init(type: dictionary["type"] as! String, offer: nil, candidate: candidate1, phone: dictionary["phone"] as? String, photoUrl: dictionary["photoUrl"] as? String, name: dictionary["name"] as? String, connectedUserId: (dictionary["connectedUserId"] as? String)!, isVideo: dictionary["isVideo"] as? Bool,callId: (dictionary["callId"] as? String)!, chatId: (dictionary["chatId"] as? String)!,sessionId: dictionary["sessionId"] as? String, socketId: dictionary["socketId"] as? String)
//            self?.delegateCallmanager?.didReceiveCandidate(data: signalingMessage)
//        }
//
//
//        socket.on("reject") {[weak self] data, ack in
//            debugPrint("reject received")
//            debugPrint(data)
//
//            let dictionary : [String : Any] = data.first as! [String : Any]
//            self?.delegateCallmanager?.didReceiveReject(data: dictionary)
//        }
//
//        socket.on("newcall") {[weak self] data, ack in
//            debugPrint("newcall received \(data)")
//            //            debugPrint(data)
//
//            let dictionary : [String : Any] = data.first as! [String : Any]
//            debugPrint(dictionary)
//            let signalingMessage = Available.init(type: dictionary["type"] as! String, connectedUserId: (dictionary["connectedUserId"] as? String)!, isAvailable: dictionary["isAvailable"] as? Bool, reason: dictionary["reason"] as? String, name: dictionary["name"] as? String,callId: (dictionary["callId"] as? String)!,chatId: (dictionary["chatId"] as? String)!, photoUrl: dictionary["photoUrl"] as? String, isVideo: dictionary["isVideo"] as? Bool, isBusy: dictionary["isBusy"] as? Bool,sessionId: dictionary["sessionId"] as? String, socketId: dictionary["socketId"] as? String)
//
//            //send reject for busy
//            //else send ready for call
//            var dic = [String:Any]()
//            dic["callId"] = signalingMessage.callId
//            dic["chatId"] = signalingMessage.chatId
//            dic["manually"] = "0"
//            dic["sessionId"] = signalingMessage.sessionId
//            dic["socketId"] = signalingMessage.socketId
//            debugPrint("newCallData \(CallManager.sharedInstance.newCallData)")
//            if (CallManager.sharedInstance.isCallStarted == true || CallManager.sharedInstance.isCallkitShown == true){
//                debugPrint("==============CALL STARTED DIFFERENT CHAT ID=============")
//                dic["type"] = "newcallreceived"
//                dic["isBusy"] = true
//                dic["connectedUserId"] = signalingMessage.connectedUserId
//                SocketSharedManager.sharedSocket.sendReadyForCall(dictionary: dic)
//
//            }else{
//                let isVideo = dictionary["isVideo"] as? Bool
//                CallManager.sharedInstance.newCallData = signalingMessage
//                CallManager.sharedInstance.showlocalView = isVideo ?? false
//
//                if(CallManager.sharedInstance.isCallStarted){
//                    if(signalingMessage.chatId != CallManager.sharedInstance.chatIdGlobal || signalingMessage.callId != CallManager.sharedInstance.callIdGlobal){
//                        debugPrint("==============CALL STARTED DIFFERENT CHAT ID=============")
//                        dic["type"] = "newcallreceived"
//                        dic["isBusy"] = true
//                        dic["connectedUserId"] = signalingMessage.connectedUserId
//                        SocketSharedManager.sharedSocket.sendReadyForCall(dictionary: dic)
//                    } else {
//                        debugPrint("==============CALL STARTED SAME CHAT ID=============")
//                        self?.getGroupCallMembers(dictionary: ["chatId":signalingMessage.chatId])
//                        dic["type"] = "readyforcall"
//                        dic["connectedUserId"] = signalingMessage.connectedUserId
//                        CallManager.sharedInstance.connectedUserName = signalingMessage.name ?? "group call"
//                        SocketSharedManager.sharedSocket.sendReadyForCall(dictionary: dic)
//                    }
//                } else {
//                    CallManager.sharedInstance.callIdGlobal = signalingMessage.callId
//                    CallManager.sharedInstance.chatIdGlobal = signalingMessage.chatId
//                    RTCAudioSession.sharedInstance().isAudioEnabled = false
//                    debugPrint("calldebug false newcall")
//                    debugPrint("==============CALL NOT STARTED=============")
//                    self?.getGroupCallMembers(dictionary: ["chatId":signalingMessage.chatId])
//                    var isbusy = Shared.instance.isCallStarted
//                    dic["type"] = "newcallreceived"
//                    dic["connectedUserId"] = signalingMessage.connectedUserId
//                    CallManager.sharedInstance.connectedUserName = signalingMessage.name ?? "group call"
//                    if let tabController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
//                        if tabController.presentedViewController == CallManager.sharedInstance.callscreen  {
//                            CallManager.sharedInstance.callscreen?.dismissVC(completion: {
//                                print("call screen was already present")
//                                CallManager.sharedInstance.callscreen = nil
//                            })
//                        }
//                    }
//                    dic["isBusy"] = isbusy
//                    SocketSharedManager.sharedSocket.sendReadyForCall(dictionary: dic)
//                    print("call screen was already present1")
//                }
//
//                CallManager.sharedInstance.isVideoEnabled = isVideo ?? false
//                CallManager.sharedInstance.connectedUserName = signalingMessage.name!
//                CallManager.sharedInstance.connectedUserPhoto = signalingMessage.photoUrl!
//                if(CallManager.sharedInstance.isCallHandled == false) {
//                    #if targetEnvironment(simulator)
//                    // we're on the simulator - calculate pretend movement
//                    #else
//                    if(CallManager.sharedInstance.isCallStarted == false){
//                        //ATCallManager.shared.provider?.invalidate()
//                        if (SharedManager.shared.isCallKitSupported()) {
//                            ATCallManager.shared.incommingCall(from: signalingMessage.name!,hasVideo: CallManager.sharedInstance.isVideoEnabled, delay: 0)
//                        }
//                        CallManager.sharedInstance.isCallkitShown = true
//                    }
//                    #endif
//                }
//                CallManager.sharedInstance.isCallHandled = false
//                CallManager.sharedInstance.isIncomingCall = true
//                if(CallManager.sharedInstance.isCallStarted == false){
//                    CallManager.sharedInstance.startWebrtc()
//                    if !SharedManager.shared.isCallKitSupported() {
//                        CallManager.sharedInstance.showCallScreen()
//                    }
//                }
//            }
//        }
//
//
//        socket.on("newcallreceived") {[weak self] data, ack in
//            debugPrint("newcallreceived received")
//            debugPrint(data)
//
//            let dictionary : [String : Any] = data.first as! [String : Any]
//            debugPrint(dictionary)
//
//            let signalingMessage = Available.init(type: dictionary["type"] as! String, connectedUserId: (dictionary["connectedUserId"] as? String)!, isAvailable: dictionary["isAvailable"] as? Bool, reason: dictionary["reason"] as? String, name: dictionary["name"] as? String,callId: (dictionary["callId"] as? String)!,chatId: (dictionary["chatId"] as? String)!, photoUrl: dictionary["photoUrl"] as? String, isVideo: dictionary["isVideo"] as? Bool, isBusy: dictionary["isBusy"] as? Bool,sessionId: dictionary["sessionId"] as? String, socketId: dictionary["socketId"] as? String)
//
//            self?.delegateCallmanager?.didReceiveNewCallReceived(data: signalingMessage)
//        }
//
//        socket.on("readyforcall") {[weak self] data, ack in
//            debugPrint("readyforcall received")
//            debugPrint(data)
//
//            let dictionary : [String : Any] = data.first as! [String : Any]
//            debugPrint(dictionary)
//            var join = dictionary["join"] as? Bool
//            let signalingMessage = Available.init(type: dictionary["type"] as! String, connectedUserId: (dictionary["connectedUserId"] as? String)!, isAvailable: dictionary["isAvailable"] as? Bool, reason: dictionary["reason"] as? String, name: dictionary["name"] as? String,callId: (dictionary["callId"] as? String)!,chatId: (dictionary["chatId"] as? String)!, photoUrl: dictionary["photoUrl"] as? String, isVideo: dictionary["isVideo"] as? Bool, isBusy: dictionary["isBusy"] as? Bool,sessionId: dictionary["sessionId"] as? String, socketId: dictionary["socketId"] as? String)
//            self?.delegateCallmanager?.didReceiveReadyforcall(data: signalingMessage,join: join ?? false)
//
//        }
//        socket.on("offer") {[weak self] data, ack in
//            debugPrint("offer received")
//            debugPrint(data)
//
//            let dictionary : [String : Any] = data.first as! [String : Any]
//            let offerDic = dictionary["offer"] as! [String:Any]
//            let sdp = SDP.init(sdp: offerDic["sdp"] as! String)
//            //            debugPrint(sdp)
//            let signalingMessage = SignalingMessage.init(type: dictionary["type"] as! String, offer: sdp, candidate: dictionary["candidate"] as? Candidate, phone: dictionary["phone"] as? String, photoUrl: dictionary["photoUrl"] as? String, name: dictionary["name"] as? String, connectedUserId: (dictionary["connectedUserId"] as? String)!, isVideo: dictionary["isVideo"] as? Bool,callId: (dictionary["callId"] as? String)!,chatId: (dictionary["chatId"] as? String)!,sessionId: dictionary["sessionId"] as? String, socketId: dictionary["socketId"] as? String)
//
//            CallManager.sharedInstance.didReceiveOffer(data: signalingMessage)
//        }
//        socket.on("newUserAddedToConversation") {[weak self] data, ack in
//            let dictionary : [String : Any] = data.first as! [String : Any]
//            self?.delegateGroup?.didSocketContactGroup(data: dictionary)
//        }
//
//        socket.on("groupConversationDataUpdated") {[weak self] data, ack in
//            let dictionary : [String : Any] = data.first as! [String : Any]
//            self?.delegateGroup?.didSocketGroupUpdate(data: dictionary)
//        }
//
//
//        socket.on("userHasLeftConversation") {[weak self] data, ack in
//                   let dictionary : [String : Any] = data.first as! [String : Any]
//                   self?.delegateGroup?.didSocketRemoveContactGroup(data: dictionary)
//        }
//
//        self.socket.on(clientEvent: .statusChange) {data, ack in
//
//        }
//        self.socket.on(clientEvent: .error) {data, ack in
//
//        }
//        self.socket.on("new_comment") {data, ack in
//            if data.count > 0 {
//                let dict = data[0] as! NSDictionary
//                self.commentDelegate?.feedCommentReceivedFromSocket?(res:dict)
//            }
//        }
//
//        self.socket.on("deleted_a_message") {data, ack in
//
//            if data.count > 0 {
//                let dict = data[0] as! NSDictionary
//                self.commentDelegate?.feedCommentReceivedFromSocket?(res:dict)
//            }
//        }
//
//        self.socket.on("welcome") {data, ack in
//
//        }
//        self.socket.on("error") {data, ack in
//
//        }
//        self.receiveGenericNotification()
//    }
    
    
    
    
//    func updateUserProfile(dictionary:[String:Any]){
        
//        self.socket.emit("update_profile_user_web", with: [SharedManager.shared.returnJsonObject(dictionary: dictionary)])
        
//    }
    
//    func receiveChatMessage(){
//        self.socket.on("new_message") {data, ack in

//            print("new_message new_message")
//            if self.commentDelegate?.chatMessageReceived != nil {
//                self.commentDelegate?.chatMessageReceived?(res: data as NSArray)
//            }
//        }
//    }
//
//    func deleteChatMessage(){
//        self.socket.on("deleted_a_message") {data, ack in
//
////            if self.commentDelegate?.chatMessageDelete != nil {
////                self.commentDelegate?.chatMessageDelete?(res: data as NSArray)
////            }
//        }
//    }
//
//    func newsFeedProcessingHandler(){
//        let userID = String(SharedManager.shared.getUserID())
//        let userEvent = String(format: "user.%@", userID)
//
//        self.socket.on(userEvent) {data, ack in
//            self.commentDelegate?.videoProcessingSocketResponse?(res: data as NSArray)
//        }
//    }
//
//    func newsFeedProcessingHandlerGlobal(){
//        let userEvent = "global"
//
//        self.socket.on(userEvent) {data, ack in
//
//            self.commentDelegate?.videoProcessingSocketResponse?(res: data as NSArray)
//        }
//    }
//    func senddidenterBackground(dictionary:[String:Any]) {
//        self.socket.emit(dictionary["type"] as! String, with: [SharedManager.shared.returnJsonObject(dictionary: dictionary)])
//    }
    
//
//    func markmessageSeen(valueMain : Int ){
//        let messageDict:NSDictionary = ["m":[valueMain]]
//        self.socket.emit("markMessagesAsSeen", messageDict)
//    }
//
//    func senddidenterForeground(dictionary:[String:Any]) {
//        self.socket.emit(dictionary["type"] as! String, with: [SharedManager.shared.returnJsonObject(dictionary: dictionary)])
//    }
//    // MARK: - socket call methods
//    func sendReject(dictionary:[String:Any]) {
//
//        self.socket.emit(dictionary["type"] as! String, with: [SharedManager.shared.returnJsonObject(dictionary: dictionary)])
//    }
//
//
//    func sendSDP(dictionary:[String:Any]) {
//        self.socket.emit(dictionary["type"] as! String, with: [SharedManager.shared.returnJsonObject(dictionary: dictionary)])
//    }
//    func sendCandidates(dictionary:[String:Any]) {
//        self.socket.emit(dictionary["type"] as! String, with: [SharedManager.shared.returnJsonObject(dictionary: dictionary)])
//    }
//    func sendReadyForCall(dictionary:[String:Any]) {
//        self.socket.emit(dictionary["type"] as! String, with: [SharedManager.shared.returnJsonObject(dictionary: dictionary)])
//    }
//
//    func sendNewCall(dictionary :[String:Any])  {
//
//        self.socket.emitWithAck(dictionary["type"] as! String, with: [SharedManager.shared.returnJsonObject(dictionary: dictionary)]).timingOut(after: 0) { (data) in
//            let dic = data.first
//            self.delegateCallmanager?.didReceiveNewCallData(data: dic as! [String : Any])
//        }
//    }
//    func sendaddtocall(dictionary:[String:Any]) {
//        self.socket.emit(dictionary["type"] as! String, with: [SharedManager.shared.returnJsonObject(dictionary: dictionary)])
//    }
//
//    // MARK: - socket user methods
//
//    func getGroupCallMembers(dictionary :[String:Any])  {
//        debugPrint("getGroupCallMembers")
//        var dic:[String:Any] = ["firstname":(SharedManager.shared.userObj?.data.firstname!)! + " " + (SharedManager.shared.userObj?.data.lastname!)!]
//        dic["lastname"] = ""
//        dic["profile_image"] = SharedManager.shared.userObj?.data.profile_image
//        dic["id"] = SharedManager.shared.userObj?.data.id
//        let value = MessageMember(fromDictionary: dic )
//        CallManager.sharedInstance.groupMembersArray.removeAll()
//        //CallManager.sharedInstance.groupMembersArray.append(value)
//    }
//
//
//    func check_call_status(dictionary:[String:Any]) {
//        self.socket.emitWithAck("checkCallStatus", SharedManager.shared.returnJsonObject(dictionary: dictionary)).timingOut(after: 0) {data in
//            let dictionary : [String : Any] = data.first as! [String : Any]
//            self.delegate?.didReceiveCallstatusAck(data: dictionary)
//        }
//    }
//
//    func likeEvent(dict:NSDictionary) {
//        print("likeEvent ==> ")
//        print(dict)
//        self.socket.emitWithAck("notification", dict).timingOut(after: 0) {data in
//
//
//            let dictionary : [String : Any] = data.first as! [String : Any]
//            print("dictionary notification ===>")
//            print(dictionary)
//            self.delegate?.didReceiveCallstatusAck(data: dictionary)
//        }
//    }
//
//    func SendVideoSwitch(dictionary:[String:Any]) {
//        self.socket.emit("switchvideo", with: [SharedManager.shared.returnJsonObject(dictionary: dictionary)])
//    }
//
//    // Notification section...
//    func receiveGenericNotification(){
//        self.socket.on("notification") {data, ack in
//            GenericNotification.shared.manageGenericNotification(arr: data)
//        }
//    }
    
    
    // MARK: -
    // MARK: Emit Actions...
    
//    func emitSomeAction(dict: NSDictionary) {
//        self.socket.emit("onJob", dict)
//    }
//
//    func emitSaveLiveStream(dict: NSDictionary) {
//        self.socket.emit("save_stream", dict)
//    }
//
//    func emitLiveStreamingStayLive(dict: NSDictionary) {
//        self.socket.emit("last_packet_sent_at", dict)
//    }
//
//    func emitFeedComment(dict:NSDictionary) {
//        let dataDict = dict ["data"] as! NSDictionary
//
//        let commentDict:NSDictionary = ["new_comment":dataDict]
//
//        self.socket.emit("new_comment", commentDict)
//    }
//
//    // MARK:Messenger Socket
//    func emitChatText(dict:NSDictionary) {
//        print("11 dict ===>")
//        print(dict)
//        self.socket.emitWithAck("new_message", dict).timingOut(after: 0) {data in
//            print("emitChatText ==>")
//            print(data)
//        }
//    }
//
//    func emitDeleteChatText(dict:NSDictionary) {
//
//
//        self.socket.emitWithAck("delete_message", dict).timingOut(after: 0) {data in
//
//        }
//    }
//
//
//    func checkUserIsBlocked(dict:NSDictionary , completionHandler: @escaping (_ returnValue: [Any]?)->Void) {
//        self.socket.emitWithAck("isUserBlocked", dict).timingOut(after: 0) {data in
//
//            completionHandler(data)
//        }
//    }
//
//    func removeUserFromGroupText(dict:NSDictionary , completionHandler: @escaping (_ returnValue: [Any]?)->Void) {
//        self.socket.emitWithAck("removeFromGroupConversation", dict).timingOut(after: 0) {data in
//            completionHandler(data)
//        }
//    }
//
//
//    func updateGroupConversation(dict:NSDictionary , completionHandler: @escaping (_ returnValue: [Any]?)->Void) {
//          self.socket.emitWithAck("groupConversationDataUpdated", dict).timingOut(after: 0) {data in
//              completionHandler(data)
//          }
//      }
//
//    func makeNewAdminForGroup(dict:NSDictionary , completionHandler: @escaping (_ returnValue: [Any]?)->Void) {
//        self.socket.emitWithAck("removeFromGroupConversation", dict).timingOut(after: 0) {data in
//            completionHandler(data)
//        }
//    }
//
//    func addUserstoGroup(dict:NSDictionary , completionHandler: @escaping (_ returnValue: [Any]?)->Void) {
//        self.socket.emitWithAck("addUserToGroupConversation", dict).timingOut(after: 0) {data in
//            completionHandler(data)
//        }
//    }
    
//    func emitLiveStreamNotificationAction(dict: [String:Any]) {
//        self.socket.emit("notification", dict)
//    }
//
//    func goLiveSession() {
//        // self.socket.emit("live_stream_session_id", [:])
//        self.socket.emitWithAck("get_live_stream_id", ["generate_new":"true"]).timingOut(after: 60) {data in
//            self.commentDelegate?.goLiveSessionSocketResponse?(res: data as NSArray)
//        }
//    }
}
