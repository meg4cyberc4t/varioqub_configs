import Varioqub
import MetricaAdapter

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif



public class VarioqubConfigsPlugin: NSObject, FlutterPlugin, VarioqubSender {
    var idProvider: VarioqubIdProvider? = nil;
    var reporter: VarioqubReporter? = nil;
    
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
        
      
        switch (settings.adapterMode) {
           case .appmetrica:
            let adapter = AppmetricaAdapter();
            reporter = adapter;
            idProvider = adapter;
           case .none:
            let adapter = VarioqubNullHandler();
            reporter = adapter;
            idProvider = adapter;
        }
        
        VarioqubFacade.shared.initialize(
            clientId: settings.clientId,
            config: config,
            idProvider: idProvider,
            reporter: reporter
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
