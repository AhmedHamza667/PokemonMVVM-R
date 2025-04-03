//
//  PokemonViewModelTest.swift
//  PokemonMVVMRTests
//
//  Created by Ahmed Hamza on 3/13/25.
//

import XCTest
@testable import PokemonMVVMR

final class PokemonViewModelTest: XCTestCase {
    
    var viewModel: PokemonViewModel!
    var repo: StubPokemonRepo!
    override func setUpWithError() throws {
        // given
        repo = StubPokemonRepo()
        viewModel = PokemonViewModel(repsitory: repo)
    }

    override func tearDownWithError() throws {
        repo = nil
        viewModel = nil
    }

    func testGetPokemonListWhenExpectCorrectBehaviour() async throws {
        // when
        let expectation = expectation(description: "Fetching list expecting correct behaviour")
        repo.setPokemonResponse(pokemonResponse: PokemonResponse(count: 100, next: "next.url", previous: "previous.url", results: [Pokemon(name: "bulbasaur", url: "url")]))
        Task{
            await viewModel.getPokemonList()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        // then
        XCTAssertEqual(viewModel.pokemonList.count, 1)
        let pokemon = viewModel.pokemonList.first!
        XCTAssertTrue(pokemon.name == "bulbasaur")
    }
    
    func testGetPokemonListWhenExpectNoDataError() async throws {
        // when
        let expectation = expectation(description: "Fetching list expecting no data error")
        repo.setError(error: WebServiceError.noData)
        Task{
            await viewModel.getPokemonList()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        // then
        XCTAssertEqual(viewModel.pokemonList.count, 0)
        XCTAssertEqual(viewModel.viewState, PokemonViewState.error(WebServiceError.noData))
    }

    func testGetPokemonListWhenExpectInvalidURLError() async throws {
        // when
        let expectation = expectation(description: "Fetching list expecting invalid URL")
        repo.setError(error: WebServiceError.invalidURL)
        Task{
            await viewModel.getPokemonList()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        // then
        XCTAssertEqual(viewModel.pokemonList.count, 0)
        XCTAssertEqual(viewModel.viewState, PokemonViewState.error(WebServiceError.invalidURL))
    }



    func testResetPokemonListWhenExpectCorrectBehaviour() async throws {
        // when
        let expectation = expectation(description: "resetting list expecting correct behaviour")
        repo.setPokemonResponse(pokemonResponse: PokemonResponse(count: 100, next: "next.url", previous: "previous.url", results: [Pokemon(name: "bulbasaur", url: "url")]))
        Task{
            await viewModel.resetPokemonList()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        // then
        XCTAssertEqual(viewModel.pokemonList.count, 1)
        let pokemon = viewModel.pokemonList.first!
        XCTAssertTrue(pokemon.name == "bulbasaur")
    }

}
