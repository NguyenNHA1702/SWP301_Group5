$DatabaseConfig = @{
    Server = "localhost"
    Database = "volunteer_portal"
    UserId = "sa"
    Password = "123"
}

function Get-ConnectionString {
    return "Server=$($DatabaseConfig.Server);Database=$($DatabaseConfig.Database);User Id=$($DatabaseConfig.UserId);Password=$($DatabaseConfig.Password);"
}

Export-ModuleMember -Function Get-ConnectionString -Variable DatabaseConfig
