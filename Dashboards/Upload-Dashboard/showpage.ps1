# README 1
$Folder1 = "D:\Upload\Folder1"
$Folder2 = "D:\Upload\Folder2"
$Folder3 = "D:\Upload\Folder3"
$Folder4 = "D:\Upload\Folder4"

# README 2
$TargetDomain = ""

New-UDGrid -Spacing '1' -Container -Content {
    New-UDGrid -Item -MediumSize 4 -Content {
        # README 3
        New-UDCard -Title 'Folder 1' -Content {
            New-UDDynamic -Id 'Folder1' -content {
                $FilesFolder1 = Get-ChildItem -Path $Folder1 | select-object -ExpandProperty name
                New-UDList -Content {
                    foreach ($1Doc in $FilesFolder1) {
                        New-UDListItem -Label "$1Doc" -Icon (New-UDIcon -Icon file_download -Size lg) -OnClick {
                            # README 4
                            Invoke-UDRedirect "https://$TargetDomain/Upload/Folder1/$1Doc"
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
            New-UDDynamic -Id 'Folder2' -content {
                $FilesFolder2 = Get-ChildItem -Path $Folder2 | select-object -ExpandProperty name
                New-UDList -Content {
                    foreach ($2Doc in $FilesFolder2) {
                        New-UDListItem -Label "$2Doc" -Icon (New-UDIcon -Icon file_download -Size lg) -OnClick {
                            Invoke-UDRedirect "https://$TargetDomain/Upload/Folder2/$2Doc"
                        }
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
                            Invoke-UDRedirect "https://$TargetDomain/Upload/Folder3/$3Doc"
                        }
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
                            Invoke-UDRedirect "https://$TargetDomain/Upload/Folder4/$4Doc"
                        }
                    }
                }
            } -LoadingComponent {
                New-UDProgress -Circular
            }  
        }
    }
}