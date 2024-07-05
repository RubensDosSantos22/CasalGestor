unit MsRdpSessionManager_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 98336 $
// File generated on 31/03/2022 14:51:55 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Windows\System32\mstsc.exe (1)
// LIBID: {9C757116-4367-4DA9-AC0E-6C6577AD5560}
// LCID: 0
// Helpfile: 
// HelpString: MsRdpSessionManager 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// Errors:
//   Hint: TypeInfo 'MsRdpSessionManager' changed to 'MsRdpSessionManager_'
//   Error creating palette bitmap of (TMsRdpSessionManager) : No Server registered for this CoClass
//   Error creating palette bitmap of (TMsRdpSessionManagerSingleUse) : No Server registered for this CoClass
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  MsRdpSessionManagerMajorVersion = 1;
  MsRdpSessionManagerMinorVersion = 0;

  LIBID_MsRdpSessionManager: TGUID = '{9C757116-4367-4DA9-AC0E-6C6577AD5560}';

  IID_IMsRdpSessionManager: TGUID = '{A0B2DD9A-7F53-4E65-8547-851952EC8C96}';
  CLASS_MsRdpSessionManager_: TGUID = '{1B462D7B-72D8-4544-ACC1-D84E5B9A8A14}';
  CLASS_MsRdpSessionManagerSingleUse: TGUID = '{6B7F33AC-D91D-4563-BF36-0ACCB24E66FB}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IMsRdpSessionManager = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  MsRdpSessionManager_ = IMsRdpSessionManager;
  MsRdpSessionManagerSingleUse = IMsRdpSessionManager;


// *********************************************************************//
// Interface: IMsRdpSessionManager
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {A0B2DD9A-7F53-4E65-8547-851952EC8C96}
// *********************************************************************//
  IMsRdpSessionManager = interface(IUnknown)
    ['{A0B2DD9A-7F53-4E65-8547-851952EC8C96}']
    function StartRemoteApplication(psaCreds: PSafeArray; psaParams: PSafeArray; lFlags: Integer): HResult; stdcall;
    function GetProcessId(out pulProcessId: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoMsRdpSessionManager_ provides a Create and CreateRemote method to          
// create instances of the default interface IMsRdpSessionManager exposed by              
// the CoClass MsRdpSessionManager_. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMsRdpSessionManager_ = class
    class function Create: IMsRdpSessionManager;
    class function CreateRemote(const MachineName: string): IMsRdpSessionManager;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMsRdpSessionManager
// Help String      : MsRdpSessionManager Class
// Default Interface: IMsRdpSessionManager
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TMsRdpSessionManager = class(TOleServer)
  private
    FIntf: IMsRdpSessionManager;
    function GetDefaultInterface: IMsRdpSessionManager;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMsRdpSessionManager);
    procedure Disconnect; override;
    function StartRemoteApplication(psaCreds: PSafeArray; psaParams: PSafeArray; lFlags: Integer): HResult;
    function GetProcessId(out pulProcessId: LongWord): HResult;
    property DefaultInterface: IMsRdpSessionManager read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoMsRdpSessionManagerSingleUse provides a Create and CreateRemote method to          
// create instances of the default interface IMsRdpSessionManager exposed by              
// the CoClass MsRdpSessionManagerSingleUse. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMsRdpSessionManagerSingleUse = class
    class function Create: IMsRdpSessionManager;
    class function CreateRemote(const MachineName: string): IMsRdpSessionManager;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMsRdpSessionManagerSingleUse
// Help String      : MsRdpSessionManagerSingleUse Class
// Default Interface: IMsRdpSessionManager
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TMsRdpSessionManagerSingleUse = class(TOleServer)
  private
    FIntf: IMsRdpSessionManager;
    function GetDefaultInterface: IMsRdpSessionManager;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMsRdpSessionManager);
    procedure Disconnect; override;
    function StartRemoteApplication(psaCreds: PSafeArray; psaParams: PSafeArray; lFlags: Integer): HResult;
    function GetProcessId(out pulProcessId: LongWord): HResult;
    property DefaultInterface: IMsRdpSessionManager read GetDefaultInterface;
  published
  end;

procedure Register;

resourcestring
  dtlServerPage = 'RDPDelphi';

  dtlOcxPage = 'RDPDelphi';

implementation

uses System.Win.ComObj;

class function CoMsRdpSessionManager_.Create: IMsRdpSessionManager;
begin
  Result := CreateComObject(CLASS_MsRdpSessionManager_) as IMsRdpSessionManager;
end;

class function CoMsRdpSessionManager_.CreateRemote(const MachineName: string): IMsRdpSessionManager;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MsRdpSessionManager_) as IMsRdpSessionManager;
end;

procedure TMsRdpSessionManager.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{1B462D7B-72D8-4544-ACC1-D84E5B9A8A14}';
    IntfIID:   '{A0B2DD9A-7F53-4E65-8547-851952EC8C96}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMsRdpSessionManager.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMsRdpSessionManager;
  end;
end;

procedure TMsRdpSessionManager.ConnectTo(svrIntf: IMsRdpSessionManager);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMsRdpSessionManager.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMsRdpSessionManager.GetDefaultInterface: IMsRdpSessionManager;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TMsRdpSessionManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TMsRdpSessionManager.Destroy;
begin
  inherited Destroy;
end;

function TMsRdpSessionManager.StartRemoteApplication(psaCreds: PSafeArray; psaParams: PSafeArray; 
                                                     lFlags: Integer): HResult;
begin
  Result := DefaultInterface.StartRemoteApplication(psaCreds, psaParams, lFlags);
end;

function TMsRdpSessionManager.GetProcessId(out pulProcessId: LongWord): HResult;
begin
  Result := DefaultInterface.GetProcessId(pulProcessId);
end;

class function CoMsRdpSessionManagerSingleUse.Create: IMsRdpSessionManager;
begin
  Result := CreateComObject(CLASS_MsRdpSessionManagerSingleUse) as IMsRdpSessionManager;
end;

class function CoMsRdpSessionManagerSingleUse.CreateRemote(const MachineName: string): IMsRdpSessionManager;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MsRdpSessionManagerSingleUse) as IMsRdpSessionManager;
end;

procedure TMsRdpSessionManagerSingleUse.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{6B7F33AC-D91D-4563-BF36-0ACCB24E66FB}';
    IntfIID:   '{A0B2DD9A-7F53-4E65-8547-851952EC8C96}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMsRdpSessionManagerSingleUse.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMsRdpSessionManager;
  end;
end;

procedure TMsRdpSessionManagerSingleUse.ConnectTo(svrIntf: IMsRdpSessionManager);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMsRdpSessionManagerSingleUse.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMsRdpSessionManagerSingleUse.GetDefaultInterface: IMsRdpSessionManager;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TMsRdpSessionManagerSingleUse.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TMsRdpSessionManagerSingleUse.Destroy;
begin
  inherited Destroy;
end;

function TMsRdpSessionManagerSingleUse.StartRemoteApplication(psaCreds: PSafeArray; 
                                                              psaParams: PSafeArray; lFlags: Integer): HResult;
begin
  Result := DefaultInterface.StartRemoteApplication(psaCreds, psaParams, lFlags);
end;

function TMsRdpSessionManagerSingleUse.GetProcessId(out pulProcessId: LongWord): HResult;
begin
  Result := DefaultInterface.GetProcessId(pulProcessId);
end;

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TMsRdpSessionManager, TMsRdpSessionManagerSingleUse]);
end;

end.
