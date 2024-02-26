import Varioqub

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif


public class VarioqubIdHandler: NSObject, VarioqubIdProvider {
    var deviceId: String = "000"
    var userId: String = "000"
    
    public func fetchIdentifiers(completion: @escaping Completion) {
        completion(Result.success(VarioqubIdentifiers(deviceId: deviceId, userId: userId)))
    }
    
    public var varioqubName: String = "VarioqubIdHandler"
    
   
    
}

public class VarioqubConfigsPlugin: NSObject, FlutterPlugin, VarioqubSender {
    let idHandler: VarioqubIdHandler = VarioqubIdHandler();
    
    init(binaryMessenger: FlutterBinaryMessenger) {
            super.init()
        VarioqubSenderSetup.setUp(binaryMessenger: binaryMessenger, api: self)
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "varioqub_configs", binaryMessenger: registrar.messenger())
        let instance = VarioqubConfigsPlugin(binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: channel)
      }
    
    func build(settings: PigeonBuildSettings) throws {
        var config = VarioqubConfig.default
        
        var clientFeatures: [String : String] = [:]
        for (key, value) in settings.clientFeatures {
            if let key = key, let value = value {
                clientFeatures[key] = value
            }
        }
        config.initialClientFeatures = ClientFeatures(dictionary: clientFeatures)
        
        VarioqubFacade.shared.initialize(
            clientId: settings.clientId,
            config: config,
            idProvider: idHandler,
            reporter: nil
        )
    }
    
    
    func fetchConfig(completion: @escaping (Result<Void, Error>) -> Void) {
        VarioqubFacade.shared.fetchConfig({ status in
            switch status {
                case .success: completion(.success(Void()))
                case .throttled, .cached: completion(.success(Void()))
                case .error(let e): completion(.failure(e))
            }
        })
    }
    
    func activateConfig(completion: @escaping (Result<Void, Error>) -> Void) {
        VarioqubFacade.shared.activateConfigAndWait()
        completion(.success(Void()))
    }
    
    func setDefaults(values: [String : Any]) throws {
        var defaults = [VarioqubFlag: String]()
        for (key, value) in values {
            defaults[VarioqubFlag(rawValue: key)] = String(describing: value)
        }
        return VarioqubFacade.shared.setDefaultsAndWait(defaults)
    }
    
    func getDeviceId() throws -> String {
        return idHandler.deviceId
    }
    
    func updateDeviceId(value: String) throws {
        return idHandler.deviceId = value
    }
    
    func getUserId() throws -> String {
        return idHandler.userId
    }
    
    func updateUserId(value: String) throws {
        return idHandler.userId = value
    }
    
    func getString(key: String, defaultValue: String) throws -> String {
        return VarioqubFacade.shared.getString(for: VarioqubFlag(rawValue: key), defaultValue: defaultValue)
    }
    
    func getBool(key: String, defaultValue: Bool) throws -> Bool {
        return VarioqubFacade.shared.getBool(for: VarioqubFlag(rawValue: key), defaultValue: defaultValue)
    }
    
    func getInt(key: String, defaultValue: Int64) throws -> Int64 {
        return VarioqubFacade.shared.getInt64(for: VarioqubFlag(rawValue: key), defaultValue: defaultValue)
    }
    
    func getDouble(key: String, defaultValue: Double) throws -> Double {
        return VarioqubFacade.shared.getDouble(for: VarioqubFlag(rawValue: key), defaultValue: defaultValue)
    }
    
    func getId() throws -> String {
        return VarioqubFacade.shared.varioqubId ?? ""
    }
    
    func putClientFeature(key: String, value: String) throws {
        return VarioqubFacade.shared.clientFeatures.setFeature(value, forKey: key);
    }
    
    func clearClientFeatures() throws {
        return VarioqubFacade.shared.clientFeatures.clearFeatures()
    }
    
    func getAllKeys() throws -> [String] {
        return Array(VarioqubFacade.shared.allKeys.map {
            return $0.rawValue;
        })
    }
}
