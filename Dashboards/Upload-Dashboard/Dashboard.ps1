$UDScriptRoot = "$PSScriptRoot"

$Navigation = @(
    New-UDListItem -Label 'Show Uploads' -Icon (New-UDIcon -Icon toolbox -Size lg) -OnClick { Invoke-UDRedirect '/Show' }
    New-UDListItem -Label 'Upload file' -Icon (New-UDIcon -Icon upload -Size lg) -OnClick { Invoke-UDRedirect '/Upload' }
    New-UDListItem -Label 'Delete file' -Icon (New-UDIcon -Icon trash_alt -Size lg) -OnClick { Invoke-UDRedirect '/Delete' }
)

$Pages = @()

$Pages += New-UDPage -Name 'Show Uploads' -Url 'Show' -Content {

    . "$UDScriptRoot\Showpage.ps1" 

} -Navigation $Navigation

$Pages += New-UDPage -Name 'Upload File' -Url 'Upload' -Content {

    . "$UDScriptRoot\uploadpage.ps1" 

} -Navigation $Navigation

$Pages += New-UDPage -Name 'Delete File' -Url 'Delete' -Content {

    . "$UDScriptRoot\DelPage.ps1" 

} -Navigation $Navigation

$Theme = @{
    palette = @{
        primary = @{
            main = 'rgba(80, 184, 72, 0.3)'
        }
        grey    = @{
            '300' = 'rgba(0, 151, 207, 0.6)'
        }
        action  = @{
            hover = 'rgba(80, 184, 72, 0.3)'
        }
    }
}

New-UDDashboard -DisableThemeToggle -Title 'Pages' -Theme $Theme -Pages $Pages