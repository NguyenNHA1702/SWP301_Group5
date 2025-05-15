param (
      [string]$name,
      [string]$email,
      [string]$password,
      [string]$phone
  )

  # Import database configuration
  $configPath = Join-Path $PSScriptRoot "..\database\config.ps1"
  Import-Module $configPath

  # Get connection string from config
  $connectionString = Get-ConnectionString
  $connection = New-Object System.Data.SqlClient.SqlConnection
  $connection.ConnectionString = $connectionString

  try {
      $connection.Open()

      # Kiểm tra email đã tồn tại chưa
      $query = "SELECT COUNT(*) FROM users WHERE email = @email"
      $command = $connection.CreateCommand()
      $command.CommandText = $query
      $command.Parameters.AddWithValue("@email", $email) | Out-Null
      $emailCount = $command.ExecuteScalar()

      if ($emailCount -gt 0) {
          Write-Output "Email already exists"
          exit
      }

      # Thêm tài khoản mới
      $query = "INSERT INTO users (name, email, password, phone) VALUES (@name, @email, @password, @phone)"
      $command = $connection.CreateCommand()
      $command.CommandText = $query

      $command.Parameters.AddWithValue("@name", $name) | Out-Null
      $command.Parameters.AddWithValue("@email", $email) | Out-Null
      $command.Parameters.AddWithValue("@password", $password) | Out-Null
      $command.Parameters.AddWithValue("@phone", $phone) | Out-Null

      $command.ExecuteNonQuery() | Out-Null
      Write-Output "User added successfully"
  }
  catch {
      Write-Error "Error: $_"
  }
  finally {
      $connection.Close()
  }