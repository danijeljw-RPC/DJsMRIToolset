!include "MUI2.nsh"

!define MUI_HEADER_TEXT "DJsMRIToolset Installer"
!define MUI_HEADER_SUBTEXT "Welcome to the DJsMRIToolset Setup"
!define MUI_HEADER_TEXT_FONT "Arial"
!define MUI_HEADER_BACKGROUND "header.bmp"
!define MUI_HEADER_IMAGE "header_image.bmp"
!define MUI_BRANDING_TEXT "DJsMRIToolset"
!define MUI_BUTTON_NEXT "Next >"
!define MUI_BUTTON_BACK "< Back"
!define MUI_BUTTON_CANCEL "Cancel"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"

; Define installer name and output
OutFile "DJsMRIToolsetInstaller.exe"
InstallDir "$PROGRAMFILES\DJsMRIToolset"
RequestExecutionLevel admin

; Default section to include files and shortcuts
Section "MainSection" SEC01
  ; Output path
  SetOutPath "$INSTDIR"

  ; Include all files and folders from the specified directory
  File /r "bin\Release\net8.0-windows10.0.19041.0\win10-x64\*.*"

  ; Create start menu shortcut
  CreateDirectory "$SMPROGRAMS\DJsMRIToolset"
  CreateShortCut "$SMPROGRAMS\DJsMRIToolset\DJsMRIToolset.lnk" "$INSTDIR\DJsMRIToolset.exe"

  ; Optional desktop icon
  !ifdef DESKTOP_ICON
    CreateShortCut "$DESKTOP\DJsMRIToolset.lnk" "$INSTDIR\DJsMRIToolset.exe"
  !endif

  ; Write uninstaller to the installation directory
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  ; Set uninstall registry key
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DJsMRIToolset" "DisplayName" "DJsMRIToolset"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DJsMRIToolset" "UninstallString" "$INSTDIR\Uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DJsMRIToolset" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DJsMRIToolset" "DisplayIcon" "$INSTDIR\DJsMRIToolset.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DJsMRIToolset" "Publisher" "D Wynyard"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DJsMRIToolset" "DisplayVersion" "1.0"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DJsMRIToolset" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DJsMRIToolset" "NoRepair" 1
SectionEnd

; Uninstaller section
Section "Uninstall"
  ; Remove installed files
  Delete "$INSTDIR\*.*"
  Delete "$INSTDIR\DJsMRIToolset.exe"

  ; Remove shortcuts
  Delete "$SMPROGRAMS\DJsMRIToolset\DJsMRIToolset.lnk"
  !ifdef DESKTOP_ICON
    Delete "$DESKTOP\DJsMRIToolset.lnk"
  !endif

  ; Remove directory
  RMDir /r "$INSTDIR"
  RMDir /r "$SMPROGRAMS\DJsMRIToolset"
SectionEnd
