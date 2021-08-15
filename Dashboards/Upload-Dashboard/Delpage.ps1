# README 1
$RootPath = "D:\Upload"

Show-UDModal -Header { "Delete file" } -Content {
    $Path = Get-ChildItem -Path $RootPath | select-object -ExpandProperty name

    New-UDSelect -Id 'Select' -Option {
        New-UDSelectOption -Name "Select Card..." -Value "start"
        foreach ($Folder in $Path) {
            New-UDSelectOption -Name $Folder -Value $Folder
        }
    } -OnChange { Sync-UDElement -id 'DelHelpList' }

    New-UDRow {
        New-UDDynamic -Id 'DelHelpList' -content {
            $SelectedFolder = (Get-UDElement -Id 'Select').value
            $fileSearch = Get-ChildItem -Path "$RootPath\$($SelectedFolder)\" | select-object -ExpandProperty name
            $SearchFile = 
            foreach ($files in $fileSearch) {
                [PSCustomObject]@{
                    file = $files
                }
            }
            $SearchFileColumns = @(
                New-UDTableColumn -Property File -Title "File" -IncludeInExport -IncludeInSearch
            )
            New-UDTable -Id 'DelHelpTable' -Data $SearchFile -Columns $SearchFileColumns -Title "" -ShowSearch -ShowPagination -Dense -Sort -PageSize 10 -PageSizeOptions @(10, 20) -DisablePageSizeAll -ShowSelection
        } -LoadingComponent {
            New-UDProgress -Circular
        }
    }
} -Footer {
    New-UDButton -Text "Delete" -size medium -OnClick {
        $DelTable = Get-UDElement -Id 'DelHelpTable'
        $SelectedFolder = (Get-UDElement -Id 'Select').value
        if ($Null -ne $DelTable.selectedRows.File) {
            try {
                @($DelTable.selectedRows.File.ForEach( { 
                            Remove-Item -Path "$RootPath\$($SelectedFolder)\$($_)" -force } ) )
                Show-UDToast -Message "Selected file are now deleted!" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                Sync-UDElement -id 'DelHelpList'
            }
            catch {
                Show-UDToast -Message "$($PSItem.Exception)" -MessageColor 'red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                Break
            }
        }
        else {
            Show-UDToast -Message "You need to select a file!" -MessageColor 'red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
            Break
        }
    }
    New-UDButton -Text "Close" -Size medium -OnClick {
        Invoke-UDRedirect "/Show"
        Hide-UDModal
    }
} -FullWidth -MaxWidth 'sm' -Persistent
