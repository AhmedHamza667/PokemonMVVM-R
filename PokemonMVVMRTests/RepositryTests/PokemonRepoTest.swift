//
//  PokemonRepoTest.swift
//  PokemonMVVMRTests
//
//  Created by Ahmed Hamza on 3/13/25.
//

import XCTest
@testable import PokemonMVVMR

final class PokemonRepoTest: XCTestCase {

    var repo: PokemonRepo!
    var fakeManager: FakeNetworkManager!
    override func setUpWithError() throws {
        // given
        fakeManager = FakeNetworkManager()
        repo = PokemonRepo(networkManager: fakeManager)
    }

    override func tearDownWithError() throws {
        fakeManager = nil
        repo = nil
    }

    func testGetPokemonsWhenExpectingCorrectData() async throws {
        // when
        fakeManager.testPath = "validPokemonData"
        let pokemonResponse = try await repo.getPokemons(offset: "0", limit: "20")
        
        // then
        XCTAssertNotNil(pokemonResponse)
        XCTAssertEqual(pokemonResponse.results.count, 20)
        let firstPokemon = pokemonResponse.results.first
        XCTAssertTrue(firstPokemon?.name == "bulbasaur")
    }
    
    func testGetPokemonsWhenExpectingNoData() async throws {
        // when
        fakeManager.testPath = "EmptyResponse"
        do {
            let pokemonResponse = try await repo.getPokemons(offset: "0", limit: "20")
            XCTAssertEqual(pokemonResponse.results.count, 0)
        } catch {
            XCTAssertNotNil(error)
        }
        
        // then
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
