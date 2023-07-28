$json = Get-Content -Path vcf_transition_file_list.json | ConvertFrom-Json
$x=3

###### USER INPUT #######    
 while ($x -ne 1 -and $x -ne 2 )
    {
    $x=Read-Host  "Enter 1 for VXRAIL or 2 for VSRN(Non VXRAIL)"
        if ($x -ne 1 -and $x -ne 2 )
        {
        Write-Output "wrong input"
        }
    }
Write-Output ""

 
##### MIGRATION BUNDLES ##########
$mig_bundles=$json.migrationBundles.files
$z=0
ForEach ($item in $mig_bundles)
{
$filename=$mig_bundles[$z].fileName 
$file_disc=$mig_bundles[$z].comments 
$file_md5sum= Get-FileHash   $filename  -Algorithm MD5 2>&1
    if ($file_md5sum -eq $Error[0])  ##check if file exists
        {
        Write-Host -Object "$file_disc ($filename) does not exist" -ForegroundColor yellow
         Write-Output ""
        }
    else
        {
            $file_md5sum=$file_md5sum.Hash
            $json_md5sum= $mig_bundles[$z].chkSum
            if ($json_md5sum -eq $file_md5sum)
                {
                    Write-Host -Object "$file_disc ($filename) is GOOD" -ForegroundColor Green
                    Write-Output ""
                }
            else
                {
                    Write-Host -Object "$file_disc ($filename) is NOT GOOD" -ForegroundColor Red
                    Write-Output ""
                }
        }
$z=$z+1
}

##### COMMON BUNDLES ##########
$common_bundles=$json.commonBundles.files
$z=0
ForEach ($item in $common_bundles)
{
$filename=$common_bundles[$z].fileName 
$file_disc=$common_bundles[$z].comments
$filename="$filename.tar"
$file_md5sum= Get-FileHash   $filename  -Algorithm MD5 2>&1
    if ($file_md5sum -eq $Error[0])  ##check if file exists
        {
        Write-Host -Object "$file_disc ($filename) does not exist" -ForegroundColor yellow
         Write-Output ""
        }
    else
        {
            $file_md5sum=$file_md5sum.Hash
            $json_md5sum= $common_bundles[$z].tarChksum
            if ($json_md5sum -eq $file_md5sum)
                {
                    Write-Host -Object "$file_disc ($filename) is GOOD" -ForegroundColor Green
                    Write-Output ""
                }
            else
                {
                    Write-Host -Object "$file_disc ($filename) is NOT GOOD" -ForegroundColor Red
                    Write-Output ""
                }
        }
$z=$z+1
}



##### VXRAIL BUNDLES ##########
if ($x -eq 1)
{
$vxrail_bundles=$json.vxrailBundles.files
$z=0
ForEach ($item in $vxrail_bundles)
{
$filename=$vxrail_bundles[$z].fileName  
$file_disc=$vxrail_bundles[$z].comments
$file_md5sum= Get-FileHash   $filename  -Algorithm MD5 2>&1
    if ($file_md5sum -eq $Error[0])  ##throws error if file does not exist
        {
        Write-Host -Object "$file_disc ($filename) does not exist" -ForegroundColor yellow
         Write-Output ""
        }
    else
        {
            $file_md5sum=$file_md5sum.Hash
            $json_md5sum= $vxrail_bundles[$z].chkSum
            if ($json_md5sum -eq $file_md5sum)
                {
                    Write-Host -Object "$file_disc ($filename) is GOOD" -ForegroundColor Green
                    Write-Output ""
                }
            else
                {
                    Write-Host -Object "$file_disc ($filename) is NOT GOOD" -ForegroundColor Red
                    Write-Output ""
                }
        }
$z=$z+1
}
}

##### VSRN BUNDLES ##########
elseif ($x -eq 2)
{
$vsrn_bundles=$json.vsrnBundles.files
$z=0
ForEach ($item in $vsrn_bundles)
{
$filename=$vsrn_bundles[$z].fileName 
$file_disc=$vsrn_bundles[$z].comments 
$filename="$filename.tar"
$file_md5sum= Get-FileHash   $filename  -Algorithm MD5 2>&1
    if ($file_md5sum -eq $Error[0])  ##check if file exists
        {
         Write-Host -Object "$filename does not exist" -ForegroundColor Red
         Write-Output ""
        }
    else
        {
            $file_md5sum=$file_md5sum.Hash
            $json_md5sum= $common_bundles[$z].tarChksum
            if ($json_md5sum -eq $file_md5sum)
                {
                    Write-Host -Object "$file_disc ($filename) is GOOD" -ForegroundColor Green
                    Write-Output ""
                }
            else
                {
                    Write-Host -Object "$file_disc ($filename) is NOT GOOD" -ForegroundColor Red
                    Write-Output ""
                }
        }
$z=$z+1
}
}


