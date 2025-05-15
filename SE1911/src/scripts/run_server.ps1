# Set up the HTTP listener
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8080/")
$listener.Start()
Write-Host "Server running at http://localhost:8080/"

# Define the web root directory
$webRoot = Join-Path $PSScriptRoot "..\web"
Write-Host "Serving files from: $webRoot"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response

    if ($request.HttpMethod -eq "POST" -and $request.Url.LocalPath -eq "/run") {
        $reader = New-Object System.IO.StreamReader($request.InputStream)
        $body = $reader.ReadToEnd() | ConvertFrom-Json
        $reader.Close()

        $command = $body.command
        try {
            # Update script paths to use the new structure
            $command = $command -replace "F:\\SEI911\\", (Join-Path $PSScriptRoot "")

            Invoke-Expression $command
            $response.StatusCode = 200
            $responseContent = "Command executed successfully"
        }
        catch {
            $response.StatusCode = 500
            $responseContent = "Error: $_"
        }
    }
    else {
        $response.StatusCode = 404
        $responseContent = "Not Found"
    }

    $buffer = [System.Text.Encoding]::UTF8.GetBytes($responseContent)
    $response.ContentLength64 = $buffer.Length
    $response.OutputStream.Write($buffer, 0, $buffer.Length)
    $response.Close()
}

$listener.Stop()