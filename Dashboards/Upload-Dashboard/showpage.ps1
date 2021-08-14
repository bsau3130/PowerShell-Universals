# README 1
$Folder1 = Get-ChildItem -Path D:\Upload\Folder1 | select-object -ExpandProperty name
$Folder2 = Get-ChildItem -Path D:\Upload\Folder2 | select-object -ExpandProperty name
$Folder3 = Get-ChildItem -Path D:\Upload\Folder3 | select-object -ExpandProperty name
$Folder4 = Get-ChildItem -Path D:\Upload\Folder4 | select-object -ExpandProperty name

New-UDGrid -Spacing '1' -Container -Content {
    New-UDGrid -Item -MediumSize 4 -Content {
        # README 2
        New-UDCard -Title 'Folder 1' -Content {
            New-UDDynamic -Id 'Folder1' -content {
                New-UDList -Content {
                    foreach ($1Doc in $Folder1) {
                        New-UDListItem -Label "$1Doc" -Icon (New-UDIcon -Icon file_download -Size lg) -OnClick {
                            # README 3
                            Invoke-UDRedirect "https://EXAMPLE/Upload/Folder1/$1Doc"
                        }
                        New-UDButton -Text "Delete" -size small -OnClick {
                            $DelFilePath = "D:\Upload\Folder1\$($1Doc)"
                            if ($Null -ne $DelFilePath) {
                                try {
                                    Remove-Item -Path $DelFilePath -force
                                    Show-UDToast -Message "$($1Doc) are now deleted!" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                                    Sync-UDElement -id 'Folder1'
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
                }
            } -LoadingComponent {
                New-UDProgress -Circular
            }  
        }
    }

    New-UDGrid -Item -MediumSize 4 -Content {
        New-UDCard -Title 'Folder 2' -Content {
            New-UDList -Content {
                foreach ($2Doc in $Folder2) {
                    New-UDListItem -Label "$2Doc" -Icon (New-UDIcon -Icon file_download -Size lg) -OnClick {
                        Invoke-UDRedirect "https://EXAMPLE/Upload/Folder2/$2Doc"
                    }
                    New-UDButton -Text "Delete" -size small -OnClick {
                        $DelFilePath = "D:\Upload\Folder2\$($2Doc)"
                        if ($Null -ne $DelFilePath) {
                            try {
                                Remove-Item -Path $DelFilePath -force
                                Show-UDToast -Message "$($2Doc) are now deleted!" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                                #Sync-UDElement -id 'DelHelpList'
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
            }
        }
    }
    New-UDGrid -Item -MediumSize 4 -Content {
        New-UDCard -Title 'Folde 3' -Content {
            New-UDList -Content {
                foreach ($3Doc in $Folder3) {
                    New-UDListItem -Label "$3Doc" -Icon (New-UDIcon -Icon file_download -Size lg) -OnClick {
                        Invoke-UDRedirect "https://EXAMPLE/Upload/Folder3/$3Doc"
                    }
                    New-UDButton -Text "Delete" -size small -OnClick {
                        $DelFilePath = "D:\Upload\Folder3\$($3Doc)"
                        if ($Null -ne $DelFilePath) {
                            try {
                                Remove-Item -Path $DelFilePath -force
                                Show-UDToast -Message "$($3Doc) are now deleted!" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                                #Sync-UDElement -id 'DelHelpList'
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
            }
        }
    }
    New-UDGrid -Item -MediumSize 4 -Content {
        New-UDCard -Title 'Folder 4' -Content {
            New-UDList -Content {
                foreach ($4Doc in $Folder4) {
                    New-UDListItem -Label "$4Doc" -Icon (New-UDIcon -Icon file_download -Size lg) -OnClick {
                        Invoke-UDRedirect "https://EXAMPLE/Upload/Folder4/$4Doc"
                    }
                    New-UDButton -Text "Delete" -size small -OnClick {
                        $DelFilePath = "D:\Upload\Folder4\$($4Doc)"
                        if ($Null -ne $DelFilePath) {
                            try {
                                Remove-Item -Path $DelFilePath -force
                                Show-UDToast -Message "$($4Doc) are now deleted!" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                                #Sync-UDElement -id 'DelHelpList'
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
            }
        }
    }
}