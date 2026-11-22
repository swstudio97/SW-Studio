Add-Type -AssemblyName System.Drawing

$source = 'C:/Users/ahmed/AppData/Local/Temp/codex-clipboard-1ab7c01a-8fb4-4df0-afe4-d225b345e127.png'
$destination = Join-Path $PSScriptRoot '../assets/posts/familytree-poster.png'
New-Item -ItemType Directory -Force (Split-Path $destination) | Out-Null
$image = [System.Drawing.Image]::FromFile($source)
$canvas = New-Object System.Drawing.Bitmap 1080,1080
$g = [System.Drawing.Graphics]::FromImage($canvas)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

$navy = [System.Drawing.Color]::FromArgb(7,18,48); $navy2 = [System.Drawing.Color]::FromArgb(18,38,82)
$cream = [System.Drawing.Color]::FromArgb(248,243,232); $muted = [System.Drawing.Color]::FromArgb(210,220,219)
$green = [System.Drawing.Color]::FromArgb(163,212,92); $gold = [System.Drawing.Color]::FromArgb(223,187,114)
$background = New-Object System.Drawing.Drawing2D.LinearGradientBrush ((New-Object System.Drawing.Point 0,0)), ((New-Object System.Drawing.Point 1080,1080)), $navy2, $navy
$g.FillRectangle($background,0,0,1080,1080)
$glow = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(35,172,206,255))
$g.FillEllipse($glow,-140,110,560,560); $g.FillEllipse($glow,750,680,420,420)

$badge = New-Object System.Drawing.Rectangle 70,72,200,200
$g.FillRectangle((New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(35,55,104))), $badge)
$pen = New-Object System.Drawing.Pen $green, 13
$g.DrawLine($pen,170,235,170,122); $g.DrawLine($pen,170,170,112,123); $g.DrawLine($pen,170,170,230,112)
$g.DrawLine($pen,170,208,121,234); $g.DrawLine($pen,170,208,220,234)
$node = New-Object System.Drawing.SolidBrush $green
foreach ($p in @(@(112,123),@(230,112),@(121,234),@(220,234),@(170,96))) { $g.FillEllipse($node,$p[0]-15,$p[1]-15,30,30) }
$g.DrawLine((New-Object System.Drawing.Pen $gold,2),314,82,314,262)

$rtl = New-Object System.Drawing.StringFormat; $rtl.Alignment = [System.Drawing.StringAlignment]::Far; $rtl.LineAlignment = [System.Drawing.StringAlignment]::Center; $rtl.FormatFlags = [System.Drawing.StringFormatFlags]::DirectionRightToLeft
$arabicBold = New-Object System.Drawing.Font 'Arial',52,([System.Drawing.FontStyle]::Bold)
$arabicSmall = New-Object System.Drawing.Font 'Arial',22,([System.Drawing.FontStyle]::Regular)
$latinBold = New-Object System.Drawing.Font 'Segoe UI',23,([System.Drawing.FontStyle]::Bold)
$latinSmall = New-Object System.Drawing.Font 'Segoe UI',18,([System.Drawing.FontStyle]::Regular)
$title = -join [char[]](0x0639,0x0627,0x0626,0x0644,0x062A,0x0643,0x0020,0x0643,0x0628,0x064A,0x0631,0x0629,0x061F)
$accent = -join [char[]](0x0644,0x0645,0x0651,0x0020,0x0634,0x0645,0x0644,0x0647,0x0627,0x002E)
$sub = -join [char[]](0x0645,0x0646,0x0020,0x062C,0x0630,0x0648,0x0631,0x0643,0x0020,0x062A,0x0628,0x062F,0x0623,0x0020,0x062D,0x0643,0x0627,0x064A,0x062A,0x0643)
$g.DrawString($title,$arabicBold,(New-Object System.Drawing.SolidBrush $cream),(New-Object System.Drawing.RectangleF 355,64,650,82),$rtl)
$g.DrawString($accent,$arabicBold,(New-Object System.Drawing.SolidBrush $green),(New-Object System.Drawing.RectangleF 355,132,650,82),$rtl)
$g.DrawString($sub,$arabicSmall,(New-Object System.Drawing.SolidBrush $muted),(New-Object System.Drawing.RectangleF 355,227,650,38),$rtl)

$shadow = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(130,0,0,0)); $g.FillRectangle($shadow,55,348,970,522)
$g.FillRectangle((New-Object System.Drawing.SolidBrush $cream),48,340,970,522)
$inner = New-Object System.Drawing.Rectangle 62,354,942,494
$g.DrawImage($image,$inner,(New-Object System.Drawing.Rectangle 40,0,1090,$image.Height),[System.Drawing.GraphicsUnit]::Pixel)

$path = New-Object System.Drawing.Drawing2D.GraphicsPath
$path.AddBezier(42,911,245,849,476,1005,704,927); $path.AddBezier(704,927,841,880,941,882,1040,924)
$g.DrawPath((New-Object System.Drawing.Pen $gold,11),$path)
$g.DrawString('FamilyTree',$latinBold,(New-Object System.Drawing.SolidBrush $cream),62,940)
$g.DrawString('familetree.web.app',$latinSmall,(New-Object System.Drawing.SolidBrush $green),62,981)
$g.DrawString('By SW Studio',$latinSmall,(New-Object System.Drawing.SolidBrush $muted),805,949)
$g.DrawString('SW',$latinBold,(New-Object System.Drawing.SolidBrush $cream),950,981)
$canvas.Save($destination,[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $canvas.Dispose(); $image.Dispose()
