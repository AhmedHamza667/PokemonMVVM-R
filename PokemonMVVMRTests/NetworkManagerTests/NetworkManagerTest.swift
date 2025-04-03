//
//  NetworkManagerTest.swift
//  PokemonMVVMRTests
//
//  Created by Ahmed Hamza on 3/14/25.
//

import XCTest
@testable import PokemonMVVMR

final class NetworkManagerTest: XCTestCase {
    
    var networkManager: NetworkManagerActions!
    var mockSession: MockSession!
    
    override func setUpWithError() throws {
        // given
        mockSession = MockSession()
        networkManager = NetworkManager(urlSession: mockSession)
    }
    
    override func tearDownWithError() throws {
        mockSession = nil
        networkManager = nil
    }
    
    func testGetDataFromWebServiceWhenExpectingCorrectResult()async throws {
        let expectation = expectation(description: "Getting data from network manager expecting correct result")
        // when
        let dummyData = """
                {
                  "count": 1302,
                  "next": "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20",
                  "previous": null,
                  "results": [
                    {
                      "name": "bulbasaur",
                      "url": "https://pokeapi.co/api/v2/pokemon/1/"
                    },
                    {
                      "name": "ivysaur",
                      "url": "https://pokeapi.co/api/v2/pokemon/2/"
                    }
                ]
                }
        """.data(using: .utf8)
        mockSession.setData(data: dummyData!)
        let urlResponse = HTTPURLResponse(url: URL(string: "https://www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSession.setURLResponse(urlResponse: urlResponse!)
        var data: PokemonResponse?
        Task{
            let testRequest = PokemonListRequest(paramerters: [:], path: APIEndpoints.pokemonsEndPoint, type: "GET")
            data = try await networkManager.getDataFromWebService(urlRequest: testRequest, modelType: PokemonResponse.self)
            expectation.fulfill()
            // then
            XCTAssertNotNil(data)
            XCTAssertEqual(data?.results.count, 2)
            let pokemon = data?.results.first!
            XCTAssertTrue(pokemon!.name == "bulbasaur")

        }
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    
    
    func testGetDataFromWebServiceWhenExpecting404Error()async throws {
        let expectation = expectation(description: "Getting data from network manager expecting 404 error")
        // when
        let dummyData = """
                {
                  "count": 1302,
                  "next": "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20",
                  "previous": null,
                  "results": [
                    {
                      "name": "bulbasaur",
                      "url": "https://pokeapi.co/api/v2/pokemon/1/"
                    },
                    {
                      "name": "ivysaur",
                      "url": "https://pokeapi.co/api/v2/pokemon/2/"
                    }
                ]
                }
        """.data(using: .utf8)
        mockSession.setData(data: dummyData!)
        let urlResponse = HTTPURLResponse(url: URL(string: "https://www.google.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        mockSession.setURLResponse(urlResponse: urlResponse!)
        var data: PokemonResponse?
        Task{
            let testRequest = PokemonListRequest(paramerters: [:], path: APIEndpoints.pokemonsEndPoint, type: "GET")
            do {
                // then
                data = try await networkManager.getDataFromWebService(urlRequest: testRequest, modelType: PokemonResponse.self)
                XCTAssertNil(data)
            }
            catch {
                XCTAssertNotNil(error)
                XCTAssertEqual(error as! WebServiceError, WebServiceError.invalidResponse(404))
            }
            expectation.fulfill()
    
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        
    }

    
    func testGetDataFromWebServiceWhenExpectinginvalidRequestError()async throws {
        let expectation = expectation(description: "Getting data from network manager expecting invalid request error")
        // when
        let dummyData = """
                {
                  "count": 1302,
                  "next": "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20",
                  "previous": null,
                  "results": [
                    {
                      "name": "bulbasaur",
                      "url": "https://pokeapi.co/api/v2/pokemon/1/"
                    },
                    {
                      "name": "ivysaur",
                      "url": "https://pokeapi.co/api/v2/pokemon/2/"
                    }
                ]
                }
        """.data(using: .utf8)
        mockSession.setData(data: dummyData!)
        let urlResponse = HTTPURLResponse(url: URL(string: "https://www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSession.setURLResponse(urlResponse: urlResponse!)
        var data: PokemonResponse?
        Task{
            let testRequest = PokemonListRequest(paramerters: [:], path: "", type: "GET")
            do {
                // then
                data = try await networkManager.getDataFromWebService(urlRequest: testRequest, modelType: PokemonResponse.self)
                XCTAssertNil(data)
            }
            catch {
                XCTAssertNotNil(error)
                XCTAssertEqual(error as! WebServiceError, WebServiceError.invalidURL)
            }
            expectation.fulfill()
    
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        
    }
    
    
    func testGetDataFromWebServiceWhenExpectingParsingError()async throws {
        let expectation = expectation(description: "Getting data from network manager expecting parsing error")
        // when
        let dummyData = """
                {
                  "da": 1302,
                  "dfaf": "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20",
                  "previous": null,
                  "results": [
                    {
                      "name": "bulbasaur",
                      "url": "https://pokeapi.co/api/v2/pokemon/1/"
                    },
                    {
                      "name": "ivysaur",
                      "url": "https://pokeapi.co/api/v2/pokemon/2/"
                    }
                ]
                }
        """.data(using: .utf8)
        mockSession.setData(data: dummyData!)
        let urlResponse = HTTPURLResponse(url: URL(string: "https://www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSession.setURLResponse(urlResponse: urlResponse!)
        var data: PokemonResponse?
        Task{
            let testRequest = PokemonListRequest(paramerters: [:], path: APIEndpoints.pokemonsEndPoint, type: "GET")
            do {
                // then
                data = try await networkManager.getDataFromWebService(urlRequest: testRequest, modelType: PokemonResponse.self)
                XCTAssertNil(data)
            }
            catch {
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
    
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        
    }


    
}
