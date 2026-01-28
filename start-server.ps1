# Simple HTTP Server for Rejected Bookings Dashboard
# Run this script, then open http://localhost:3000 in your browser

$Port = 3000
$ExcelPath = "C:\Users\Norton Araujo\ONE Development\Strategy & Analytics - Documents\03 Users\Norton\Rejected Bookings (Master).xlsx"
$WebRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host ""
Write-Host "========================================"
Write-Host "  Rejected Bookings Dashboard Server"
Write-Host "========================================"
Write-Host "  Open: http://localhost:$Port"
Write-Host "  Excel: $ExcelPath"
Write-Host "========================================"
Write-Host ""
Write-Host "Press Ctrl+C to stop the server"
Write-Host ""

$Listener = New-Object System.Net.HttpListener
$Listener.Prefixes.Add("http://localhost:$Port/")
$Listener.Start()

Write-Host "Server is running..." -ForegroundColor Green

$MimeTypes = @{
    ".html" = "text/html"
    ".js" = "application/javascript"
    ".css" = "text/css"
    ".png" = "image/png"
    ".jpg" = "image/jpeg"
    ".xlsx" = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}

try {
    while ($Listener.IsListening) {
        $Context = $Listener.GetContext()
        $Request = $Context.Request
        $Response = $Context.Response
        
        Write-Host "Request: $($Request.Url.LocalPath)"
        
        # Add CORS headers
        $Response.Headers.Add("Access-Control-Allow-Origin", "*")
        
        $Path = $Request.Url.LocalPath
        
        if ($Path -eq "/api/data") {
            # Serve the Excel file
            if (Test-Path $ExcelPath) {
                $FileBytes = [System.IO.File]::ReadAllBytes($ExcelPath)
                $Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                $Response.ContentLength64 = $FileBytes.Length
                $Response.OutputStream.Write($FileBytes, 0, $FileBytes.Length)
                Write-Host "  -> Served Excel file successfully" -ForegroundColor Green
            } else {
                $Response.StatusCode = 404
                $ErrorMsg = [System.Text.Encoding]::UTF8.GetBytes("Excel file not found")
                $Response.OutputStream.Write($ErrorMsg, 0, $ErrorMsg.Length)
                Write-Host "  -> Excel file not found!" -ForegroundColor Red
            }
        } else {
            # Serve static files
            if ($Path -eq "/") { $Path = "/dashboard.html" }
            $FilePath = Join-Path $WebRoot $Path.TrimStart("/")
            
            if (Test-Path $FilePath) {
                $Ext = [System.IO.Path]::GetExtension($FilePath).ToLower()
                $ContentType = $MimeTypes[$Ext]
                if (-not $ContentType) { $ContentType = "application/octet-stream" }
                
                $FileBytes = [System.IO.File]::ReadAllBytes($FilePath)
                $Response.ContentType = $ContentType
                $Response.ContentLength64 = $FileBytes.Length
                $Response.OutputStream.Write($FileBytes, 0, $FileBytes.Length)
                Write-Host "  -> Served: $FilePath" -ForegroundColor Cyan
            } else {
                $Response.StatusCode = 404
                $ErrorMsg = [System.Text.Encoding]::UTF8.GetBytes("File not found: $Path")
                $Response.OutputStream.Write($ErrorMsg, 0, $ErrorMsg.Length)
                Write-Host "  -> File not found: $FilePath" -ForegroundColor Yellow
            }
        }
        
        $Response.Close()
    }
} finally {
    $Listener.Stop()
    Write-Host "Server stopped."
}
