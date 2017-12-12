//
//  GoogleAnalytics.swift
//  SandboxGA
//
//  Created by Hiromi Motodera on 12/12/17.
//  Copyright © 2017 moaible. All rights reserved.
//

protocol GoogleAnalyticsCustomDimensionable {
    
    var dimensionIndex: UInt { get }
    
    var dimensionName: String { get }
    
    var dimensionValue: String { get }
}

protocol GoogleAnalyticsSendable {
    
    static var googleAnalyticsTrackingId: String { get }
}

extension GoogleAnalyticsSendable {
    
    // MARK: -
    
    static func sendScreenTracking(_ screenName: String,
                                   customDimensions: [GoogleAnalyticsCustomDimensionable] = [])
    {
        guard let tracker = self.tracker() else {
            return
        }
        
        self.updateTracker(tracker, customDimensions: customDimensions)
        defer {
            self.resetTracker(tracker, customDimensions: customDimensions)
        }
        
        let builder = GAIDictionaryBuilder.createScreenView().set(screenName, forKey: kGAIScreenName)
        if let build = builder?.build() as NSDictionary? as? [AnyHashable: Any] {
            tracker.send(build)
        }
    }
    
    static func sendEventTracking(category: String, action: String, label: String? = nil, value: NSNumber? = nil,
                                  customDimensions: [GoogleAnalyticsCustomDimensionable] = [])
    {
        guard let tracker = self.tracker() else {
            return
        }
        
        self.updateTracker(tracker, customDimensions: customDimensions)
        defer {
            self.resetTracker(tracker, customDimensions: customDimensions)
        }
        
        let builder = GAIDictionaryBuilder.createEvent(
            withCategory: category, action: action, label: label, value: value)
        if let build = builder?.build() as NSDictionary? as? [AnyHashable: Any] {
            tracker.send(build)
        }
    }
    
    // MARK: - Private
    
    private static func tracker() -> GAITracker? {
        let tracker = GAI.sharedInstance().tracker(withTrackingId: googleAnalyticsTrackingId)
        tracker?.allowIDFACollection = true
        return tracker ?? nil
    }
    
    private static func updateTracker(_ tracker: GAITracker,
                                          customDimensions: [GoogleAnalyticsCustomDimensionable]) {
        customDimensions.forEach {
            tracker.set(GAIFields.customDimension(for: $0.dimensionIndex), value: $0.dimensionValue)
        }
    }
    
    private static func resetTracker(_ tracker: GAITracker,
                                         customDimensions: [GoogleAnalyticsCustomDimensionable]) {
        customDimensions.forEach {
            tracker.set(GAIFields.customDimension(for: $0.dimensionIndex), value: nil)
        }
    }
}
