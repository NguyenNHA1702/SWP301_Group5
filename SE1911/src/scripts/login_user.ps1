param (
      [string]$email,
      [string]$password
  )

  # Import cấu hình cơ sở dữ liệu
  $configPath = Join-Path $PSScriptRoot "..\database\config.ps1"
  Import-Module $configPath

  # Lấy chuỗi kết nối từ cấu hình
  $connectionString = Get-ConnectionString
  $connection = New-Object System.Data.SqlClient.SqlConnection
  $connection.ConnectionString = $connectionString

  try {
      $connection.Open()

      # Tìm tài khoản theo email
      $query = "SELECT password FROM users WHERE email = @email"
      $command = $connection.CreateCommand()
      $command.CommandText = $query
      $command.Parameters.AddWithValue("@email", $email) | Out-Null

      $result = $command.ExecuteScalar()

      if ($result -eq $null) {
          Write-Output "Email not found"
          exit
      }

      # Kiểm tra mật khẩu
      if ($result -eq $password) {
          Write-Output "Login successful"
      } else {
          Write-Output "Incorrect password"
      }
  }
  catch {
      Write-Error "Error: $_"
  }
  finally {
      $connection.Close()
  }