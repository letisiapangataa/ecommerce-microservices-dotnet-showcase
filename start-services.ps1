# E-commerce Microservices Deployment Script

# Build and Deploy Script for Local Development
Write-Host "Building E-commerce Microservices..." -ForegroundColor Green

# Build all services
Write-Host "Building all services..." -ForegroundColor Yellow
dotnet build EcommerceMicroservices.sln

if ($LASTEXITCODE -eq 0) {
    Write-Host "Build successful!" -ForegroundColor Green
    
    # Option 1: Run services individually
    Write-Host "`nStarting individual services..." -ForegroundColor Yellow
    
    Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd 'src\UserService\UserService.API'; dotnet run --urls='http://localhost:5001'"
    Start-Sleep 2
    
    Write-Host "User Service started at http://localhost:5001" -ForegroundColor Green
    Write-Host "Health check: http://localhost:5001/health" -ForegroundColor Cyan
    Write-Host "API endpoints: http://localhost:5001/api/users" -ForegroundColor Cyan
    
    # Future services can be added here:
    # Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd 'src\ProductService\ProductService.API'; dotnet run --urls='http://localhost:5002'"
    # Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd 'src\OrderService\OrderService.API'; dotnet run --urls='http://localhost:5003'"
    
} else {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "`nAll services are starting up..." -ForegroundColor Green
Write-Host "Press any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
