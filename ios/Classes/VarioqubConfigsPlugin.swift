//
//  VarioqubNullAdapter.swift
//  varioqub_configs
//
//  Created by Igor Molchanov on 27.02.2024.
//

import Varioqub
import MetricaAdapter

#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif



public class VarioqubApiPigeonImpl: NSObject, FlutterPlugin, VarioqubApiPigeon {
    
    
    var idProvider: VarioqubIdProvider? = nil;
    var reporter: VarioqubReporter? = nil;
    
    init(binaryMessenger: FlutterBinaryMessenger) {
        super.init()
        VarioqubApiPigeonSetup.setUp(binaryMessenger: binaryMessenger, api: self)
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "varioqub_configs", binaryMessenger: registrar.messenger())
        let instance = VarioqubApiPigeonImpl(binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func build(settings: VarioqubSettingsPigeon) throws {
        var config = VarioqubConfig.default
        if (settings.fetchThrottleIntervalMs != nil) {
            config.fetchThrottle = Double(settings.fetchThrottleIntervalMs! / 1000)
        }
        if (settings.url != nil) {
            config.baseURL = URL(string: settings.url!)
        }
        
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
            idProvider:  settings.trackingWithAppMetrica ? AppmetricaAdapter() :  VarioqubNullHandler(),
            reporter: settings.trackingWithAppMetrica ? AppmetricaAdapter() :  VarioqubNullHandler()
        )
    }
    
    
    func fetchConfig(completion: @escaping (Result<FetchErrorPigeon?, any Error>) -> Void) {
        VarioqubFacade.shared.fetchConfig({ status in
            switch (status) {
            case .success, .cached:
                completion(.success(nil))
                return
            case .throttled:
                completion(.success(FetchErrorPigeon(error: VarioqubFetchErrorPigeon.requestThrottled)))
                return
            case .error(let error):
                let message: String?
                let fetchError: VarioqubFetchErrorPigeon
                switch (error) {
                case .emptyResult:
                    fetchError = VarioqubFetchErrorPigeon.emptyResult
                    message = nil
                case .nullIdentifiers:
                    fetchError = VarioqubFetchErrorPigeon.identifiersNull
                    message = nil
                case .response(let error), .parse(let error):
                    fetchError = VarioqubFetchErrorPigeon.responseParseError
                    message = error.localizedDescription
                case .request:
                    fetchError = VarioqubFetchErrorPigeon.internalError
                    message = nil
                case .underlying(let error):
                    fetchError = VarioqubFetchErrorPigeon.internalError
                    message = error.localizedDescription
                case .network(let error):
                    fetchError = VarioqubFetchErrorPigeon.networkError
                    message = error.localizedDescription
                @unknown default:
                    fetchError = VarioqubFetchErrorPigeon.internalError
                    message = nil
                }
                completion(.success(FetchErrorPigeon(message: message, error: fetchError)))
                return
            @unknown default:
                completion(.success(nil))
                return
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
    
    func getAllValues() throws -> [String : String] {
        return VarioqubFacade.shared.allItems
            .map { key, value in (key.rawValue, value.stringValueOrDefault) }
            .reduce(into: [:]) { result, tuple in
                result[tuple.0] = tuple.1
            }
    }
}
