# Contributing to E-commerce Microservices Application

Thank you for your interest in contributing to this project! This document provides guidelines and information for contributors.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Changes](#making-changes)
- [Submitting Changes](#submitting-changes)
- [Style Guidelines](#style-guidelines)
- [Testing](#testing)

## Code of Conduct

This project follows a code of conduct to ensure a welcoming environment for all contributors. Please be respectful and professional in all interactions.

## Getting Started

1. Fork the repository
2. Clone your fork locally
3. Set up the development environment (see below)
4. Create a new branch for your feature/fix
5. Make your changes
6. Test your changes
7. Submit a pull request

## Development Setup

### Prerequisites

- [.NET 9 SDK](https://dotnet.microsoft.com/download/dotnet/9.0)
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Visual Studio Code](https://code.visualstudio.com/) or [Visual Studio 2022](https://visualstudio.microsoft.com/)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) (optional, for Azure deployment)

### Local Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/ecommerce-microservices-application.git
   cd ecommerce-microservices-application
   ```

2. **Restore dependencies**
   ```bash
   dotnet restore EcommerceMicroservices.sln
   ```

3. **Build the solution**
   ```bash
   dotnet build EcommerceMicroservices.sln
   ```

4. **Run the services**
   ```bash
   # User Service
   cd src/UserService/UserService.API
   dotnet run --urls="http://localhost:5001"
   ```

## Making Changes

### Branch Naming Convention

- `feature/description-of-feature` for new features
- `bugfix/description-of-bug` for bug fixes
- `hotfix/description-of-hotfix` for critical fixes
- `docs/description-of-change` for documentation updates

### Commit Message Format

Use conventional commit format:
```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Examples:
```
feat(user-service): add user profile update endpoint
fix(order-service): resolve order status validation bug
docs(readme): update installation instructions
```

## Submitting Changes

1. **Push your changes** to your fork
2. **Create a pull request** against the main repository
3. **Fill out the PR template** with:
   - Description of changes
   - Related issues
   - Testing performed
   - Screenshots (if applicable)

### Pull Request Guidelines

- Keep PRs focused and atomic
- Include tests for new functionality
- Update documentation as needed
- Ensure CI/CD pipeline passes
- Request review from maintainers

## Style Guidelines

### C# Code Style

Follow Microsoft's C# coding conventions:

- Use PascalCase for public members
- Use camelCase for private fields and local variables
- Use meaningful names for variables and methods
- Include XML documentation for public APIs
- Keep methods focused and small
- Use async/await for I/O operations

### File Organization

```
src/
├── ServiceName/
│   ├── ServiceName.API/          # Web API project
│   │   ├── Controllers/          # API controllers
│   │   ├── Models/              # Domain models
│   │   ├── Services/            # Business logic
│   │   └── Program.cs           # Application entry point
│   └── ServiceName.Tests/       # Unit tests
└── Shared/
    └── Shared.Models/           # Shared DTOs and models
```

### Docker Guidelines

- Use multi-stage builds for optimization
- Include health checks in containers
- Use non-root users for security
- Optimize image layers
- Include proper labels and metadata

## Testing

### Unit Tests

- Write unit tests for business logic
- Use xUnit testing framework
- Aim for 80%+ code coverage
- Mock external dependencies

### Integration Tests

- Test API endpoints end-to-end
- Use TestContainers for database testing
- Test service-to-service communication
- Validate error scenarios

### Running Tests

```bash
# Run all tests
dotnet test

# Run tests with coverage
dotnet test --collect:"XPlat Code Coverage"

# Run specific test project
dotnet test tests/UserService.Tests/
```

## Documentation

- Update README.md for significant changes
- Include API documentation in controllers
- Update architectural diagrams if needed
- Document configuration changes

## Security Considerations

- Never commit secrets or sensitive data
- Use Azure Key Vault for production secrets
- Validate all input data
- Follow OWASP security guidelines
- Report security issues privately

## Performance Guidelines

- Use async/await for I/O operations
- Implement proper caching strategies
- Monitor and optimize database queries
- Use connection pooling
- Implement health checks

## Questions or Issues?

- Check existing issues first
- Create a new issue with detailed description
- Use appropriate labels
- Provide steps to reproduce bugs
- Include environment information

Thank you for contributing to make this project better! 🚀
