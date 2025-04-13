//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Alper Gok on 12.04.2025.
//

import XCTest
@testable import WeatherApp

final class WeatherViewModelTests: XCTestCase {
    
    
    // MARK: -  Mock Delegate
    class MockDelegate: WeatherViewModelDelegate {
        
        var didFetchWeatherCalled        = false
        var didFailFetchingWeatherCalled = false
        var didStartLoadingCalled        = false
        var didStopLoadingCalled         = false
        var receivedError: Error?
        
        func didFetchWeatherSuccessfully(with properties: [WeatherApp.WeatherProperty]) {
            didFetchWeatherCalled = true
        }
        
        func didFailFetchingWeather(with error: any Error) {
            didFailFetchingWeatherCalled = true
            receivedError = error
        }
        
        func didStartLoading() {
            didStartLoadingCalled = true
        }
        
        func didStopLoading() {
            didStopLoadingCalled = true
        }
        
        
        
    }
    
    @MainActor func testFetchWeather_WithEmptyCity_ShouldCallDidFailFetchingWeather() {
        // Given
        let viewModel = WeatherViewModel()
        let mockDelegate = MockDelegate()
        viewModel.delegate = mockDelegate
        
        // When
        // Using a city name with only spaces should trigger the error immediately.
        viewModel.fetchWeather(city: "  ")
        
        
        // Then
        XCTAssertTrue(mockDelegate.didFailFetchingWeatherCalled, "The failure delegate method should have been called for an empty city string.")
        XCTAssertNotNil(mockDelegate.receivedError, "There should be an error returned.")
        XCTAssertEqual(mockDelegate.receivedError?.localizedDescription, "Please enter a valid city name.", "Error message should match the one for empty input.")
        
    }
    
    
    
    //    override func setUpWithError() throws {
    //        // Put setup code here. This method is called before the invocation of each test method in the class.
    //    }
    //
    //    override func tearDownWithError() throws {
    //        // Put teardown code here. This method is called after the invocation of each test method in the class.
    //    }
    //
    //    func testExample() throws {
    //        // This is an example of a functional test case.
    //        // Use XCTAssert and related functions to verify your tests produce the correct results.
    //        // Any test you write for XCTest can be annotated as throws and async.
    //        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    //        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    //    }
    //
    //    func testPerformanceExample() throws {
    //        // This is an example of a performance test case.
    //        measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
}
