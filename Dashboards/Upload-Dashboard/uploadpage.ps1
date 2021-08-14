Show-UDModal -Header { "Upload files" } -Content {
    New-UDDynamic -Id 'UploadStart' -content {
        $Support = Get-ChildItem -Path D:\Upload | select-object -ExpandProperty name

        New-UDSelect -Id 'Select' -Option {
            New-UDSelectOption -Name "Select..." -Value 1
            foreach ($Folder in $Support) {
                New-UDSelectOption -Name $Folder -Value $Folder
            }
        }
    }
} -Footer {
    New-UDUpload -Text 'Select file to upload' -OnUpload {
        try {
            $Path = (Get-UDElement -Id "Select").value
            $Data = $Body | ConvertFrom-Json 
            $bytes = [System.Convert]::FromBase64String($Data.Data)
            [System.IO.File]::WriteAllBytes("D:\Upload\$Path\$($Data.Name)", $bytes)
            Show-UDToast -Message "The file $($Data.Name) are now uploaded!" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
            Sync-UDElement -Id 'UploadStart'
        }
        catch {
            Show-UDToast -Message "$($PSItem.Exception)" -MessageColor 'red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
            Break
        }
    }
    New-UDButton -Text "Close" -OnClick {
        # Returns to the Upload dashboard
        Invoke-UDRedirect "/Show"
        Hide-UDModal
    }
} -FullWidth -MaxWidth 'xs' -Persistent