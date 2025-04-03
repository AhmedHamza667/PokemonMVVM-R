# Pokemon MVVM with Repository Pattern

A Swift-based iOS application that demonstrates the implementation of MVVM (Model-View-ViewModel) architecture with Repository pattern for fetching and displaying Pokemon data.

## Architecture Overview

The project follows a clean MVVM architecture with the following key components:

### Repository Pattern
The repository pattern is implemented to abstract the data layer and provide a clean API for the ViewModels. Key repositories include:

- `PokemonRepo`: Handles fetching the list of Pokemon
- `PokemonDetailsRepo`: Manages fetching individual Pokemon details

Each repository implements a protocol (e.g., `PokemonRepoActions`, `PokemonDetailsRepoActions`) that defines its contract, making it easy to:
- Swap implementations (e.g., for testing)
- Maintain separation of concerns
- Keep the codebase testable

### Networking Layer
- `NetworkManager`: Handles all network requests
- `NetworkSessionable`: Protocol for URL session operations
- `Requestable`: Protocol for creating URL requests

### ViewModels
- `PokemonViewModel`: Manages the Pokemon list state and business logic
- `PokemonDetailsViewModel`: Handles individual Pokemon details

## Test Coverage

The project includes comprehensive test coverage across different layers:

### Repository Tests
- `PokemonRepoTest`: Tests Pokemon repository functionality
  - Tests successful data fetching
  - Tests empty response handling
  - Tests error scenarios

### ViewModel Tests
- `PokemonViewModelTest`: Tests Pokemon list view model
  - Tests successful data loading
  - Tests error handling
  - Tests list reset functionality

### Network Manager Tests
- `NetworkManagerTest`: Tests network layer functionality
  - Tests successful API responses
  - Tests error handling (404, invalid requests)
  - Tests data parsing

### Mock Objects
The test suite includes various mock objects:
- `StubPokemonRepo`: For testing ViewModels
- `FakeNetworkManager`: For testing repositories
- `MockSession`: For testing network operations

## Getting Started

1. Clone the repository
2. Open the project in Xcode
3. Build and run the application

## Dependencies

The project uses Swift's built-in networking capabilities and doesn't require external dependencies.

## Architecture Benefits

- **Separation of Concerns**: Clear separation between data, business logic, and presentation layers
- **Testability**: Easy to write unit tests thanks to protocol-based design
- **Maintainability**: Modular code structure makes it easy to modify and extend
- **Reusability**: Repository pattern allows for easy reuse of data access logic 