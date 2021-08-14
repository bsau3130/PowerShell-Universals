# README 1
$Folder1 = "D:\Upload\Folder1"
$Folder2 = "D:\Upload\Folder2"
$Folder3 = "D:\Upload\Folder3"
$Folder4 = "D:\Upload\Folder4"

function Get-DelBTN {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)][string]$Folder,
        [Parameter(Mandatory)][string]$File,
        [Parameter(Mandatory)][string]$RefreshID
    )

    New-UDButton -Text "Delete" -size small -OnClick {
        $DelFilePath = "$($Folder)\$($File)"
        if ($Null -ne $DelFilePath) {
            try {
                Remove-Item -Path $DelFilePath -force
                Show-UDToast -Message "$($File) are now deleted!" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                Sync-UDElement -id $RefreshID
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
}

New-UDGrid -Spacing '1' -Container -Content {
    New-UDGrid -Item -MediumSize 4 -Content {
        # README 2
        New-UDCard -Title 'Folder 1' -Content {
            New-UDDynamic -Id 'Folder1' -content {
                $FilesFolder1 = Get-ChildItem -Path $Folder1 | select-object -ExpandProperty name
                New-UDList -Content {
                    foreach ($1Doc in $FilesFolder1) {
                        New-UDListItem -Label "$1Doc" -Icon (New-UDIcon -Icon file_download -Size lg) -OnClick {
                            # README 3
                            Invoke-UDRedirect "https://EXAMPLE/Upload/Folder1/$1Doc"
                        }
                        Get-DelBTN -Folder $Folder1 -File $1Doc -RefreshID "Folder1"
                    }
                }
            } -LoadingComponent {
                New-UDProgress -Circular
            }  
        }
    }

    New-UDGrid -Item -MediumSize 4 -Content {
        New-UDCard -Title 'Folder 2' -Content {
            New-UDDynamic -Id 'Folder2' -content {
                $FilesFolder2 = Get-ChildItem -Path $Folder2 | select-object -ExpandProperty name
                New-UDList -Content {
                    foreach ($2Doc in $FilesFolder2) {
                        New-UDListItem -Label "$2Doc" -Icon (New-UDIcon -Icon file_download -Size lg) -OnClick {
                            Invoke-UDRedirect "https://EXAMPLE/Upload/Folder2/$2Doc"
                        }
                        Get-DelBTN -Folder $Folder2 -File $2Doc -RefreshID "Folder2"
                    }
                }
            } -LoadingComponent {
                New-UDProgress -Circular
            }  
        }
    }
    
    New-UDGrid -Item -MediumSize 4 -Content {
        New-UDCard -Title 'Folde 3' -Content {
            New-UDDynamic -Id 'Folder3' -content {
                $FilesFolder3 = Get-ChildItem -Path $Folder3 | select-object -ExpandProperty name
                New-UDList -Content {
                    foreach ($3Doc in $FilesFolder3) {
                        New-UDListItem -Label "$3Doc" -Icon (New-UDIcon -Icon file_download -Size lg) -OnClick {
                            Invoke-UDRedirect "https://EXAMPLE/Upload/Folder3/$3Doc"
                        }
                        Get-DelBTN -Folder $Folder3 -File $3Doc -RefreshID "Folder3"
                    }
                }
            } -LoadingComponent {
                New-UDProgress -Circular
            }  
        }
    }

    New-UDGrid -Item -MediumSize 4 -Content {
        New-UDCard -Title 'Folder 4' -Content {
            New-UDDynamic -Id 'Folder4' -content {
                $FilesFolder4 = Get-ChildItem -Path $Folder4 | select-object -ExpandProperty name
                New-UDList -Content {
                    foreach ($4Doc in $FilesFolder4) {
                        New-UDListItem -Label "$4Doc" -Icon (New-UDIcon -Icon file_download -Size lg) -OnClick {
                            Invoke-UDRedirect "https://EXAMPLE/Upload/Folder4/$4Doc"
                        }
                        Get-DelBTN -Folder $Folder4 -File $4Doc -RefreshID "Folder4"
                    }
                }
            } -LoadingComponent {
                New-UDProgress -Circular
            }  
        }
    }
}