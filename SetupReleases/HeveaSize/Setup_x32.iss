; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "AGENDA"
#define MyAppVersion "830.820.22.1305"
#define MyAppPublisher "Rubens dso Santos"
#define MyAppExeName "PhoneAgend2.exe"
#define MyAppAssocName "PhoneAgend"
#define MyAppAssocExt ".exe"
#define MyAppAssocKey StringChange(MyAppAssocName, " ", "") + MyAppAssocExt

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{5EACF0E1-C462-4AFF-8018-9DDB86725397}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\PhoneAgend2
ChangesAssociations=yes
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=A:\PhoneAgend2\SetupExe
OutputBaseFilename=Setup_PhoneAgend2_x32
SetupIconFile=A:\PhoneAgend2\Img\ico\Setup.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: english; MessagesFile: compiler:Default.isl
Name: brazilianportuguese; MessagesFile: compiler:Languages\BrazilianPortuguese.isl

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: A:\PhoneAgend2\Fonte\Win32\Debug\{#MyAppExeName}; DestDir: {app}; Flags: ignoreversion
Source: Firebird-2.5_x32.exe; DestDir: {app}; Flags: ignoreversion confirmoverwrite deleteafterinstall 32bit
Source: A:\PhoneAgend2\Setup Iss\dll\*; DestDir: {app}; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Registry]
Root: HKA; Subkey: Software\Classes\{#MyAppAssocExt}\OpenWithProgids; ValueType: string; ValueName: {#MyAppAssocKey}; ValueData: ; Flags: uninsdeletevalue
Root: HKA; Subkey: Software\Classes\{#MyAppAssocKey}; ValueType: string; ValueName: ; ValueData: {#MyAppAssocName}; Flags: uninsdeletekey
Root: HKA; Subkey: Software\Classes\{#MyAppAssocKey}\DefaultIcon; ValueType: string; ValueName: ; ValueData: {app}\{#MyAppExeName},0
Root: HKA; Subkey: Software\Classes\{#MyAppAssocKey}\shell\open\command; ValueType: string; ValueName: ; ValueData: """{app}\{#MyAppExeName}"" ""%1"""
Root: HKA; Subkey: Software\Classes\Applications\{#MyAppExeName}\SupportedTypes; ValueType: string; ValueName: .myp; ValueData: 

[Icons]
Name: {autoprograms}\{#MyAppName}; Filename: {app}\{#MyAppExeName}
Name: {autodesktop}\{#MyAppName}; Filename: {app}\{#MyAppExeName}; Tasks: desktopicon

[Run]
Filename: {app}\{#MyAppExeName}; Description: {cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}; Flags: nowait postinstall skipifsilent