# E-commerce Microservices Application

A comprehensive microservices-based e-commerce platform built with .NET 9, designed to showcase Azure Container Orchestration capabilities for AZ-204 certification.

## 🏗️ Architecture Overview

This application demonstrates a microservices architecture with the following services:

- **User Service**: User authentication, profile management, and user data
- **Product Service**: Product catalog, inventory management, and product search
- **Order Service**: Order processing, order history, and payment coordination
- **API Gateway**: Request routing, authentication, rate limiting, and API composition

## 🛠️ Technology Stack

### Backend
- **.NET 9**: Primary framework for all microservices
- **ASP.NET Core Web API**: RESTful API development
- **Entity Framework Core**: Data access with In-Memory database
- **Azure Service Bus**: Inter-service messaging and events
- **Application Insights**: Monitoring and telemetry

### Container & Orchestration
- **Docker**: Containerization of microservices
- **Azure Container Registry (ACR)**: Container image storage
- **Azure Kubernetes Service (AKS)**: Container orchestration
- **Docker Compose**: Local development environment

### Azure Services
- **Azure Service Bus**: Message queuing and pub/sub
- **Application Insights**: Application monitoring
- **Azure Key Vault**: Secrets management
- **Azure Container Registry**: Image repository
- **Azure Kubernetes Service**: Container orchestration
- **Log Analytics**: Centralized logging

## 🚀 Quick Start

### Prerequisites

- [.NET 9 SDK](https://dotnet.microsoft.com/download/dotnet/9.0)
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) (for Azure deployment)
- [kubectl](https://kubernetes.io/docs/tasks/tools/) (for Kubernetes management)

### Local Development Setup

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd ecommerce-microservices-application
   ```

2. **Build the solution**
   ```bash
   dotnet build EcommerceMicroservices.sln
   ```

3. **Run services individually**
   ```bash
   # User Service
   cd src/UserService/UserService.API
   dotnet run
   # Available at: https://localhost:5001

   # Product Service
   cd src/ProductService/ProductService.API
   dotnet run
   # Available at: https://localhost:5002

   # Order Service
   cd src/OrderService/OrderService.API
   dotnet run
   # Available at: https://localhost:5003
   ```

4. **Run with Docker Compose**
   ```bash
   cd docker-compose
   docker-compose up --build
   ```

   Services will be available at:
   - API Gateway: http://localhost:5000
   - User Service: http://localhost:5001
   - Product Service: http://localhost:5002
   - Order Service: http://localhost:5003

## 📊 API Documentation

Each service exposes Swagger documentation:

- User Service: http://localhost:5001/swagger
- Product Service: http://localhost:5002/swagger
- Order Service: http://localhost:5003/swagger
- API Gateway: http://localhost:5000/swagger

### Key Endpoints

#### User Service
```
GET    /api/users              # Get all users (paginated)
GET    /api/users/{id}         # Get user by ID
POST   /api/users              # Create new user
PUT    /api/users/{id}         # Update user
DELETE /api/users/{id}         # Delete user (soft delete)
GET    /api/users/health       # Health check
```

#### Product Service
```
GET    /api/products           # Get all products (paginated)
GET    /api/products/{id}      # Get product by ID
POST   /api/products           # Create new product
PUT    /api/products/{id}      # Update product
DELETE /api/products/{id}      # Delete product
GET    /api/products/search    # Search products
GET    /api/products/health    # Health check
```

#### Order Service
```
GET    /api/orders             # Get all orders (paginated)
GET    /api/orders/{id}        # Get order by ID
POST   /api/orders             # Create new order
PUT    /api/orders/{id}/status # Update order status
GET    /api/orders/user/{id}   # Get orders by user
GET    /api/orders/health      # Health check
```

## 🐳 Container Deployment

### Build Docker Images

```bash
# Build all images
docker build -f src/UserService/UserService.API/Dockerfile -t user-service .
docker build -f src/ProductService/ProductService.API/Dockerfile -t product-service .
docker build -f src/OrderService/OrderService.API/Dockerfile -t order-service .
docker build -f src/ApiGateway/ApiGateway/Dockerfile -t api-gateway .
```

### Deploy to Azure Container Registry

```bash
# Login to Azure and ACR
az login
az acr login --name your-acr-name

# Tag and push images
docker tag user-service your-acr-name.azurecr.io/user-service:latest
docker push your-acr-name.azurecr.io/user-service:latest

docker tag product-service your-acr-name.azurecr.io/product-service:latest
docker push your-acr-name.azurecr.io/product-service:latest

docker tag order-service your-acr-name.azurecr.io/order-service:latest
docker push your-acr-name.azurecr.io/order-service:latest

docker tag api-gateway your-acr-name.azurecr.io/api-gateway:latest
docker push your-acr-name.azurecr.io/api-gateway:latest
```

## ☁️ Azure Deployment

### 1. Deploy Azure Resources

```bash
# Create resource group
az group create --name rg-ecommerce-microservices --location eastus

# Deploy ARM template
az deployment group create \
  --resource-group rg-ecommerce-microservices \
  --template-file infrastructure/azure-resources.json \
  --parameters projectName=ecommerce-microservices environment=dev
```

### 2. Deploy to AKS

```bash
# Get AKS credentials
az aks get-credentials --resource-group rg-ecommerce-microservices --name ecommerce-microservices-dev-aks

# Create secrets
kubectl create secret generic servicebus-secret \
  --from-literal=connectionstring="your-servicebus-connection-string"

kubectl create secret generic appinsights-secret \
  --from-literal=connectionstring="your-appinsights-connection-string"

# Deploy services
kubectl apply -f infrastructure/k8s/
```

## 🔍 Monitoring and Observability

### Application Insights

The application is instrumented with Application Insights for:
- Request tracking
- Dependency tracking
- Exception logging
- Custom metrics and events
- Distributed tracing across services

### Health Checks

Each service exposes health check endpoints:
- `/health` - Basic health status
- Kubernetes readiness and liveness probes configured
- Service-specific health checks (database connectivity, external dependencies)

### Logging

Structured logging with:
- Request correlation IDs
- Service-specific log categories
- Centralized logging to Azure Log Analytics

## 🏛️ Architecture Patterns

### Microservices Patterns Implemented

1. **API Gateway Pattern**: Centralized entry point for all client requests
2. **Service Discovery**: Services communicate via well-defined contracts
3. **Event-Driven Architecture**: Asynchronous communication via Service Bus
4. **CQRS**: Separate read/write models where appropriate
5. **Circuit Breaker**: Resilient service-to-service communication
6. **Health Check**: Monitoring service availability

### Design Principles

- **Single Responsibility**: Each service has a specific business domain
- **Loose Coupling**: Services are independent and communicate via APIs/events
- **High Cohesion**: Related functionality is grouped within services
- **Fault Tolerance**: Services handle failures gracefully
- **Scalability**: Services can be scaled independently

## 🧪 Testing

### Running Tests

```bash
# Run all tests
dotnet test

# Run tests with coverage
dotnet test --collect:"XPlat Code Coverage"

# Run specific test project
dotnet test tests/UserService.Tests/
```

### Test Types

- **Unit Tests**: Business logic validation
- **Integration Tests**: API endpoint testing
- **Contract Tests**: Service interface validation
- **Performance Tests**: Load and stress testing

## 🛡️ Security

### Security Features Implemented

- **HTTPS Enforcement**: All communications encrypted
- **Input Validation**: Data validation at API boundaries
- **Authentication**: JWT token-based authentication
- **Authorization**: Role-based access control
- **Secrets Management**: Azure Key Vault integration
- **Container Security**: Non-root user containers

## 📈 Performance Considerations

- **Caching**: Redis caching for frequently accessed data
- **Connection Pooling**: Efficient database connections
- **Async/Await**: Non-blocking I/O operations
- **Pagination**: Large dataset handling
- **Resource Limits**: Container resource constraints

## 🚦 CI/CD Pipeline

The project includes Azure DevOps pipeline configurations for:

1. **Build Stage**: Code compilation and testing
2. **Security Scanning**: Vulnerability assessment
3. **Image Building**: Docker image creation
4. **Registry Push**: Image deployment to ACR
5. **Infrastructure**: ARM template deployment
6. **Application Deployment**: Kubernetes deployment

## 📁 Project Structure

```
ecommerce-microservices-application/
├── src/
│   ├── UserService/
│   │   └── UserService.API/
│   ├── ProductService/
│   │   └── ProductService.API/
│   ├── OrderService/
│   │   └── OrderService.API/
│   ├── ApiGateway/
│   │   └── ApiGateway/
│   └── Shared/
│       └── Shared.Models/
├── infrastructure/
│   ├── azure-resources.json
│   └── k8s/
├── docker-compose/
│   └── docker-compose.yml
├── tests/
├── .github/
│   └── copilot-instructions.md
└── README.md
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Run the test suite
6. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🎯 AZ-204 Skills Demonstrated

This project showcases the following AZ-204 certification skills:

### Azure Compute Solutions
- ✅ Azure Container Instances and Azure Kubernetes Service
- ✅ Container image creation and management
- ✅ Multi-container solutions with Docker Compose

### Azure Storage Solutions
- ✅ Azure Container Registry for image storage
- ✅ Azure Service Bus for messaging

### Azure Security Implementation
- ✅ Azure Key Vault for secrets management
- ✅ Managed identities and RBAC

### Azure Monitoring and Optimization
- ✅ Application Insights integration
- ✅ Azure Monitor and Log Analytics
- ✅ Health checks and diagnostics

### Azure Integration Solutions
- ✅ Event-driven architecture with Service Bus
- ✅ API Gateway pattern implementation
- ✅ Service-to-service communication

---

## 📞 Support

For questions and support, please open an issue in the GitHub repository or contact the development team.

**Happy coding! 🚀**
