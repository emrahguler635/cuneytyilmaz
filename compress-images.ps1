# Buyuk resimleri sikistirir (web ve GitHub icin)
Add-Type -AssemblyName System.Drawing

$imgPath = "$PSScriptRoot\assets\img"
$maxSizeKB = 500  # 500 KB ustu dosyalari sikistir
$maxDimension = 1920
$logoMaxDimension = 600  # Logolar kucuk gosterilir
$jpegQuality = 82

Get-ChildItem $imgPath -File | Where-Object {
    $_.Extension -match '\.(png|jpg|jpeg)$' -and 
    $_.Length -gt ($maxSizeKB * 1024) -and
    $_.Name -notlike '*.zip'
} | ForEach-Object {
    $file = $_
    $targetDim = if ($file.Name -like 'logo*' -or $file.Name -like 'imza*') { $logoMaxDimension } else { $maxDimension }
    Write-Host "Sikistiriliyor: $($file.Name) ($([math]::Round($file.Length/1MB,2)) MB)"
    try {
        $img = [System.Drawing.Image]::FromFile($file.FullName)
        $w = $img.Width
        $h = $img.Height
        if ($w -gt $targetDim -or $h -gt $targetDim) {
            if ($w -gt $h) {
                $newW = $targetDim
                $newH = [int]($h * $targetDim / $w)
            } else {
                $newH = $targetDim
                $newW = [int]($w * $targetDim / $h)
            }
        } else {
            $newW = $w
            $newH = $h
        }
        $bmp = New-Object System.Drawing.Bitmap($newW, $newH)
        $g = [System.Drawing.Graphics]::FromImage($bmp)
        $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.DrawImage($img, 0, 0, $newW, $newH)
        $g.Dispose()
        $img.Dispose()
        $ext = $file.Extension.ToLower()
        $saveAsJpeg = ($ext -eq '.jpg' -or $ext -eq '.jpeg') -or ($file.Name -like 'slide*')
        if ($saveAsJpeg) {
            $enc = [System.Drawing.Imaging.Encoder]::Quality
            $encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
            $encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter($enc, $jpegQuality)
            $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
            $outPath = if ($file.Name -like 'slide*') { $file.FullName -replace '\.png$','.jpg' } else { $file.FullName }
            $bmp.Save($outPath, $codec, $encParams)
            if ($file.Name -like 'slide*' -and $outPath -ne $file.FullName) { Remove-Item $file.FullName -Force }
        } else {
            $bmp.Save($file.FullName, [System.Drawing.Imaging.ImageFormat]::Png)
        }
        $bmp.Dispose()
        $checkPath = if ($file.Name -like 'slide*') { $file.FullName -replace '\.png$','.jpg' } else { $file.FullName }
        $newSize = (Get-Item $checkPath -ErrorAction SilentlyContinue).Length
        Write-Host "  -> $([math]::Round($newSize/1KB,0)) KB" -ForegroundColor Green
    } catch {
        Write-Host "  Hata: $_" -ForegroundColor Red
    }
}
Write-Host "`nTamamlandi!" -ForegroundColor Cyan
