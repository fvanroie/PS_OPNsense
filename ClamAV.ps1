<#
    MIT License

    Copyright (c) 2017 fvanroie

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
#>

function Get-OPNsenseClamAV {
    [CmdletBinding()]
    param (
        [Switch]$Version
    )
    if ([bool]::Parse($Version)) {
        Return $(Invoke-OPNsenseCommand clamav service version).version
    } else {
        Return $(Invoke-OPNsenseCommand clamav general get).general
    }
}

Function Set-OPNsenseClamAV {
    [CmdletBinding()]
    param (
      [parameter(Mandatory=$false)][bool]$Enable,
      [parameter(Mandatory=$false)][bool]$EnableTCP,

      [parameter(Mandatory=$false)][int]$MaxThreads = 10,
      [parameter(Mandatory=$false)][int]$MaxQueue	= 100,
      [parameter(Mandatory=$false)][int]$IdleTimeout = 30,
      [parameter(Mandatory=$false)][int]$MaxDirRecursion = 20,

      [parameter(Mandatory=$false)][bool]$FollowDirSym,
      [parameter(Mandatory=$false)][bool]$FollowFileSym,
      [parameter(Mandatory=$false)][bool]$DisableCache,
      [parameter(Mandatory=$false)][bool]$ScanPE,
      [parameter(Mandatory=$false)][bool]$ScanELF,
      [parameter(Mandatory=$false)][bool]$DetectBroken,
      [parameter(Mandatory=$false)][bool]$ScanOLE2,
      [parameter(Mandatory=$false)][bool]$OLEe2BlockMarcros,
      [parameter(Mandatory=$false)][bool]$ScanPDF,
      [parameter(Mandatory=$false)][bool]$ScanSWF,
      [parameter(Mandatory=$false)][bool]$ScanXMLdocs,
      [parameter(Mandatory=$false)][bool]$ScanHWP3,
      [parameter(Mandatory=$false)][bool]$ScanMailFiles,
      [parameter(Mandatory=$false)][bool]$ScanHtml,
      [parameter(Mandatory=$false)][bool]$ScanArchive,
      [parameter(Mandatory=$false)][bool]$ArcBlockEnc,

      [parameter(Mandatory=$false)][String]$MaxScanSize	= '100M',
      [parameter(Mandatory=$false)][String]$MaxFileSize	= '25M',
      [parameter(Mandatory=$false)][int]$MaxRecursion	= 16,
      [parameter(Mandatory=$false)][int]$MaxFiles	= 10000,

      # FreshClam
      [parameter(Mandatory=$false)][bool]$FreshClamEnable,
      [parameter(Mandatory=$false)][bool]$FreshClamLogVerbose,
      [parameter(Mandatory=$false)][String]$FreshClamMirror	= 'database.clamav.net',
      [parameter(Mandatory=$false)][int]$FreshClamTimeout	= 60
  )

<#    $argHash = @{
        general = @{
          maxthreads=$MaxThreads;
          maxqueue=$MaxQueue;
          idletimeout=$IdleTimeout;
          maxdirrecursion=$MaxDirRecursion;
          maxscansize=$MaxScanSize;
          maxfilesize=$MaxFileSize;
          maxrecursion=$MaxRecursion;
          maxfiles=$MaxFiles;
          fc_databasemirror=$FreshClamMirror;
          fc_timeout=$FreshClamTimeout
        }

        if ($PSBoundParameters.ContainsKey('Enable'))  {
            $argHash.general.Add('enabled', $( if ([bool]::Parse($Enable)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('FreshClamEnable'))  {
            $argHash.general.Add('fc_enabled',$( if ([bool]::Parse($FreshClamEnable)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('EnableTCP'))  {
            $argHash.general.Add('enabletcp',$( if ([bool]::Parse($EnableTCP)) {'1'} else {'0'} )) }

        if ($PSBoundParameters.ContainsKey('FollowDirSym'))  {
            $argHash.general.Add('followdirsym',$( if ([bool]::Parse($FollowDirSym)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('FollowFileSym'))  {
            $argHash.general.Add('followfilesym',$( if ([bool]::Parse($FollowFileSym)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('DisableCache'))  {
            $argHash.general.Add('disablecache',$( if ([bool]::Parse($DisableCache)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('ScanPE'))  {
            $argHash.general.Add('scanpe',$( if ([bool]::Parse($ScanPE)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('ScanELF'))  {
            $argHash.general.Add('scanelf',$( if ([bool]::Parse($ScanELF)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('DetectBroken'))  {
            $argHash.general.Add('detectbroken',$( if ([bool]::Parse($DetectBroken)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('ScanOLE'))  {
            $argHash.general.Add('scanole2',$( if ([bool]::Parse($ScanOLE2)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('OLEe'))  {
            $argHash.general.Add('ole2blockmarcros',$( if ([bool]::Parse($OLEe2BlockMarcros)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('ScanPDF'))  {
            $argHash.general.Add('scanpdf',$( if ([bool]::Parse($ScanPDF)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('ScanSWF'))  {
            $argHash.general.Add('scanswf',$( if ([bool]::Parse($ScanSWF)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('ScanXMLdocs'))  {
            $argHash.general.Add('scanxmldocs',$( if ([bool]::Parse($ScanXMLdocs)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('ScanHWP'))  {
            $argHash.general.Add('scanhwp3',$( if ([bool]::Parse($ScanHWP3)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('ScanMailFiles'))  {
            $argHash.general.Add('scanmailfiles',$( if ([bool]::Parse($ScanMailFiles)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('ScanHtml'))  {
            $argHash.general.Add('scanhtml',$( if ([bool]::Parse($ScanHtml)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('ScanArchive'))  {
            $argHash.general.Add('scanarchive',$( if ([bool]::Parse($ScanArchive)) {'1'} else {'0'} )) }
        if ($PSBoundParameters.ContainsKey('ArcBlockEnc'))  {
            $argHash.general.Add('arcblockenc',$( if ([bool]::Parse($ArcBlockEnc)) {'1'} else {'0'} )) }

        if ($PSBoundParameters.ContainsKey('FreshClamLogVerbose'))  {
            $argHash.general.Add('fc_logverbose',$( if ([bool]::Parse($FreshClamLogVerbose)) {'1'} else {'0'} )) }



    } #>

    $argHash = Get-OPNsenseClamAV

    if ($PSBoundParameters.ContainsKey('Enable'))  {
        $argHash['enabled'] = $( if ([bool]::Parse($Enable)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('FreshClamEnable'))  {
        $argHash['fc_enabled'] = $( if ([bool]::Parse($FreshClamEnable)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('EnableTCP'))  {
        $argHash['enabletcp'] = $( if ([bool]::Parse($EnableTCP)) {'1'} else {'0'} ) }

    if ($PSBoundParameters.ContainsKey('FollowDirSym'))  {
        $argHash['followdirsym'] = $( if ([bool]::Parse($FollowDirSym)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('FollowFileSym'))  {
        $argHash['followfilesym'] = $( if ([bool]::Parse($FollowFileSym)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('DisableCache'))  {
        $argHash['disablecache'] = $( if ([bool]::Parse($DisableCache)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('ScanPE'))  {
        $argHash['scanpe'] = $( if ([bool]::Parse($ScanPE)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('ScanELF'))  {
        $argHash['scanelf'] = $( if ([bool]::Parse($ScanELF)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('DetectBroken'))  {
        $argHash['detectbroken'] = $( if ([bool]::Parse($DetectBroken)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('ScanOLE'))  {
        $argHash['scanole2'] = $( if ([bool]::Parse($ScanOLE2)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('OLEe'))  {
        $argHash['ole2blockmarcros'] = $( if ([bool]::Parse($OLEe2BlockMarcros)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('ScanPDF'))  {
        $argHash['scanpdf'] = $( if ([bool]::Parse($ScanPDF)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('ScanSWF'))  {
        $argHash['scanswf'] = $( if ([bool]::Parse($ScanSWF)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('ScanXMLdocs'))  {
        $argHash['scanxmldocs'] = $( if ([bool]::Parse($ScanXMLdocs)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('ScanHWP'))  {
        $argHash['scanhwp3'] = $( if ([bool]::Parse($ScanHWP3)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('ScanMailFiles'))  {
        $argHash['scanmailfiles'] = $( if ([bool]::Parse($ScanMailFiles)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('ScanHtml'))  {
        $argHash['scanhtml'] = $( if ([bool]::Parse($ScanHtml)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('ScanArchive'))  {
        $argHash['scanarchive'] = $( if ([bool]::Parse($ScanArchive)) {'1'} else {'0'} ) }
    if ($PSBoundParameters.ContainsKey('ArcBlockEnc'))  {
        $argHash['arcblockenc'] = $( if ([bool]::Parse($ArcBlockEnc)) {'1'} else {'0'} ) }

    if ($PSBoundParameters.ContainsKey('FreshClamLogVerbose'))  {
        $argHash['fc_logverbose'] = $( if ([bool]::Parse($FreshClamLogVerbose)) {'1'} else {'0'} ) }



    return Invoke-OPNsenseCommand clamav general set -Json $argHash
}
