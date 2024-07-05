unit libWebNavigator;

interface
uses


  {$IFDEF MSWINDOWS}
  Winapi.Messages, Winapi.Windows,
  {$ENDIF}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, uCEFFMXWindowParent, uCEFFMXChromium,
  System.SyncObjs,
  uCEFInterfaces, uCEFConstants, uCEFTypes, uCEFChromiumCore, FMX.Layouts,
  FMX.ListBox, FMX.DateTimeCtrls, FMX.TabControl, FMX.Objects,
  uCEFFMXBufferPanel, uCEFFMXWorkScheduler,
  FMX.ComboEdit;


const
  MINIBROWSER_CONTEXTMENU_SHOWDEVTOOLS    = MENU_ID_USER_FIRST + 1;
  CEF_SHOWBROWSER   = WM_APP + $101;


type
    TWebNavigator = class(TFMXChromium)
      tmr1: TTimer;
      dlgSave1: TSaveDialog;

    procedure Tmr1Timer(Sender: TObject);

    procedure FMXChromium1Close(Sender: TObject; const browser: ICefBrowser; var aAction : TCefCloseBrowserAction);
    procedure FMXChromium1BeforeClose(Sender: TObject; const browser: ICefBrowser);
    procedure FMXChromium1BeforePopup(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const targetUrl, targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean; const popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo; var client: ICefClient; var settings: TCefBrowserSettings; var extra_info: ICefDictionaryValue; var noJavascriptAccess, Result: Boolean);
    procedure FMXChromium1AfterCreated(Sender: TObject; const browser: ICefBrowser);
    procedure FMXChromium1BeforeContextMenu(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const params: ICefContextMenuParams; const model: ICefMenuModel);
    procedure FMXChromium1ContextMenuCommand(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const params: ICefContextMenuParams; commandId: Integer; eventFlags: TCefEventFlags; out Result: Boolean);
    procedure FMXChromium1GotFocus(Sender: TObject; const browser: ICefBrowser);
    procedure FMXChromium1StatusMessage(Sender: TObject; const browser: ICefBrowser; const value: ustring);

    procedure BtSnapShotBtnClick(Sender: TObject);

  protected
    // Variables to control when can we destroy the form safely
    FCanClose : boolean;  // Set to True in TFMXChromium.OnBeforeClose
    FClosing  : boolean;  // Set to True in the CloseQuery event.
    FMXWindowParent         : TFMXWindowParent;
    {$IFDEF MSWINDOWS}
    // This is a workaround for the issue #253
    // https://github.com/salvadordf/CEF4Delphi/issues/253
    FCustomWindowState      : TWindowState;
    FOldWndPrc              : TFNWndProc;
    FFormStub               : Pointer;
    {$ENDIF}
    procedure LoadURL;
    procedure ResizeChild;
    procedure CreateFMXWindowParent;
    function  GetFMXWindowParentRect : System.Types.TRect;
    function  PostCustomMessage(aMsg : cardinal; aWParam : WPARAM = 0; aLParam : LPARAM = 0) : boolean;
    {$IFDEF MSWINDOWS}
    function  GetCurrentWindowState : TWindowState;
    procedure UpdateCustomWindowState;
    procedure CreateHandle; override;
    procedure DestroyHandle; override;
    procedure CustomWndProc(var aMessage: TMessage);
    {$ENDIF}
  public
    procedure NotifyMoveOrResizeStarted;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;

    end;

procedure CreateGlobalCEFApp;


implementation

{$R *.fmx}

uses
  FMX.Platform, FMX.Platform.Win,
  uCEFMiscFunctions, uCEFApplication;

{$REGION 'Ações do navegador Web'}

procedure CreateGlobalCEFApp;
begin
  GlobalCEFApp                  := TCefApplication.Create;
end;

procedure TWebNavigator.FMXChromium1AfterCreated(Sender: TObject;
  const browser: ICefBrowser);
begin
  PostCustomMessage(CEF_AFTERCREATED);
end;

procedure TWebNavigator.FMXChromium1BeforeClose(Sender: TObject; const browser: ICefBrowser);
begin
  FCanClose := True;
  PostCustomMessage(WM_CLOSE);
end;

procedure TWebNavigator.FMXChromium1BeforeContextMenu(
  Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame;
  const params: ICefContextMenuParams; const model: ICefMenuModel);
begin
  model.AddItem(MINIBROWSER_CONTEXTMENU_SHOWDEVTOOLS, 'Show DevTools');
end;

procedure TWebNavigator.FMXChromium1BeforePopup(      Sender             : TObject;
                                                       const browser            : ICefBrowser;
                                                       const frame              : ICefFrame;
                                                       const targetUrl          : ustring;
                                                       const targetFrameName    : ustring;
                                                             targetDisposition  : TCefWindowOpenDisposition;
                                                             userGesture        : Boolean;
                                                       const popupFeatures      : TCefPopupFeatures;
                                                       var   windowInfo         : TCefWindowInfo;
                                                       var   client             : ICefClient;
                                                       var   settings           : TCefBrowserSettings;
                                                       var   extra_info         : ICefDictionaryValue;
                                                       var   noJavascriptAccess : boolean;
                                                       var   Result             : boolean);
begin
  // For simplicity, this demo blocks all popup windows and new tabs
  Result := (targetDisposition in [CEF_WOD_NEW_FOREGROUND_TAB, CEF_WOD_NEW_BACKGROUND_TAB, CEF_WOD_NEW_POPUP, CEF_WOD_NEW_WINDOW]);
end;

procedure TWebNavigator.FMXChromium1Close(Sender: TObject; const browser: ICefBrowser; var aAction : TCefCloseBrowserAction);
begin
  PostCustomMessage(CEF_DESTROY);
  aAction := cbaDelay;
end;

{$ENDREGION}
procedure TWebNavigator.FMXChromium1ContextMenuCommand(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  const params: ICefContextMenuParams; commandId: Integer;
  eventFlags: TCefEventFlags; out Result: Boolean);
var
  TempPoint : TPoint;
begin
  if (commandId = MINIBROWSER_CONTEXTMENU_SHOWDEVTOOLS) then
    begin
      TempPoint.x := params.XCoord;
      TempPoint.y := params.YCoord;
      TWebNavigator.ShowDevTools(TempPoint);
    end;
end;

procedure TWebNavigator.FMXChromium1GotFocus(Sender: TObject;
  const browser: ICefBrowser);
begin
  // We use a hidden button to fix the focus issues when the browser has the real focus.
  TThread.Queue(nil,
    procedure
    begin
      BtFocusWorkaroundBtn.SetFocus;
    end);
end;

procedure TWebNavigator.FMXChromium1StatusMessage(Sender: TObject;
  const browser: ICefBrowser; const value: ustring);
begin

end;

function TWebNavigator.PostCustomMessage(aMsg : cardinal; aWParam : WPARAM; aLParam : LPARAM) : boolean;
{$IFDEF MSWINDOWS}
var
  TempHWND : HWND;
{$ENDIF}
begin
  {$IFDEF MSWINDOWS}
  TempHWND := FmxHandleToHWND(Handle);
  Result   := (TempHWND <> 0) and WinApi.Windows.PostMessage(TempHWND, aMsg, aWParam, aLParam);
  {$ELSE}
  Result   := False;
  {$ENDIF}
end;
{$IFDEF MSWINDOWS}

procedure TWebNavigator.CreateHandle;
begin
  inherited CreateHandle;
  FFormStub  := MakeObjectInstance(CustomWndProc);
  FOldWndPrc := TFNWndProc(SetWindowLongPtr(FmxHandleToHWND(Handle), GWLP_WNDPROC, NativeInt(FFormStub)));
end;

procedure TWebNavigator.DestroyHandle;
begin
  SetWindowLongPtr(FmxHandleToHWND(Handle), GWLP_WNDPROC, NativeInt(FOldWndPrc));
  FreeObjectInstance(FFormStub);
  inherited DestroyHandle;
end;

procedure TWebNavigator.CustomWndProc(var aMessage: TMessage);
const
  SWP_STATECHANGED = $8000;  // Undocumented
var
  TempWindowPos : PWindowPos;
begin
  try
    case aMessage.Msg of
      WM_ENTERMENULOOP :
        if (aMessage.wParam = 0) and
           (GlobalCEFApp <> nil) then
          GlobalCEFApp.OsmodalLoop := True;
      WM_EXITMENULOOP :
        if (aMessage.wParam = 0) and
           (GlobalCEFApp <> nil) then
          GlobalCEFApp.OsmodalLoop := False;
      WM_MOVE,
      WM_MOVING : NotifyMoveOrResizeStarted;
      WM_SIZE :
        if (aMessage.wParam = SIZE_RESTORED) then
          UpdateCustomWindowState;
      WM_WINDOWPOSCHANGING :
        begin
          TempWindowPos := TWMWindowPosChanging(aMessage).WindowPos;
          if ((TempWindowPos.Flags and SWP_STATECHANGED) <> 0) then
            UpdateCustomWindowState;
        end;
      WM_SHOWWINDOW :
        if (aMessage.wParam <> 0) and (aMessage.lParam = SW_PARENTOPENING) then
          PostCustomMessage(CEF_SHOWBROWSER);
      CEF_AFTERCREATED :
        begin
          ResizeChild;
        end;
      CEF_DESTROY :
        if (FMXWindowParent <> nil) then
          FreeAndNil(FMXWindowParent);
      CEF_SHOWBROWSER :
        if (FMXWindowParent <> nil) then
          begin
            FMXWindowParent.WindowState := TWindowState.wsNormal;
            ResizeChild;
          end;
    end;
    aMessage.Result := CallWindowProc(FOldWndPrc, FmxHandleToHWND(Handle), aMessage.Msg, aMessage.wParam, aMessage.lParam);
  except
    on e : exception do
      if CustomExceptionHandler('TWebNavigator.CustomWndProc', e) then raise;
  end;
end;

procedure TWebNavigator.UpdateCustomWindowState;
var
  TempNewState : TWindowState;
begin
  TempNewState := GetCurrentWindowState;
  if (FCustomWindowState <> TempNewState) then
    begin
      // This is a workaround for the issue #253
      // https://github.com/salvadordf/CEF4Delphi/issues/253
      if (FCustomWindowState = TWindowState.wsMinimized) then
        PostCustomMessage(CEF_SHOWBROWSER);
      FCustomWindowState := TempNewState;
    end;
end;

function TWebNavigator.GetCurrentWindowState : TWindowState;
var
  TempPlacement : TWindowPlacement;
  TempHWND      : HWND;
begin
  // TForm.WindowState is not updated correctly in FMX forms.
  // We have to call the GetWindowPlacement function in order to read the window state correctly.
  Result   := TWindowState.wsNormal;
  TempHWND := FmxHandleToHWND(Handle);
  ZeroMemory(@TempPlacement, SizeOf(TWindowPlacement));
  TempPlacement.Length := SizeOf(TWindowPlacement);
  if GetWindowPlacement(TempHWND, @TempPlacement) then
    case TempPlacement.showCmd of
      SW_SHOWMAXIMIZED : Result := TWindowState.wsMaximized;
      SW_SHOWMINIMIZED : Result := TWindowState.wsMinimized;
    end;
  if IsIconic(TempHWND) then Result := TWindowState.wsMinimized;
end;
{$ENDIF}

function TWebNavigator.GetFMXWindowParentRect : System.Types.TRect;
begin
  Result.Left   := round(LytBrowserLay.Position.x);
  Result.Top    := round(LytBrowserLay.Position.y);
  Result.Right  := round(Result.Left + LytBrowserLay.Width);
  Result.Bottom := round(Result.Top  + LytBrowserLay.Height);
end;

procedure TWebNavigator.ResizeChild;
begin
  if (FMXWindowParent <> nil) then
    begin
      FMXWindowParent.SetBounds(GetFMXWindowParentRect);
      FMXWindowParent.UpdateSize;
    end;
end;

procedure TWebNavigator.BtSnapShotBtnClick(Sender: TObject);
var
  TempBitmap : TBitmap;
begin
  TempBitmap := nil;
  try
    dlgSave1.DefaultExt := 'bmp';
    dlgSave1.Filter     := 'Bitmap files (*.bmp)|*.BMP';
    if dlgSave1.Execute and (length(dlgSave1.FileName) > 0) then
      begin
        TempBitmap := TBitmap.Create;
        if FMXChromium1.TakeSnapshot(TempBitmap, GetFMXWindowParentRect) then
          TempBitmap.SaveToFile(dlgSave1.FileName);
      end;
  finally
    if (TempBitmap <> nil) then FreeAndNil(TempBitmap);
  end;
end;
procedure TWebNavigator.CreateFMXWindowParent;
begin
  if (FMXWindowParent = nil) then
    begin
      FMXWindowParent          := TFMXWindowParent.CreateNew(nil);
      FMXWindowParent.Chromium := FMXChromium1;
      FMXWindowParent.Reparent(Handle);
      ResizeChild;
      FMXWindowParent.Show;
    end;
end;

procedure TWebNavigator.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  PositionChanged: Boolean;
begin
  PositionChanged := (ALeft <> Left) or (ATop <> Top);
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if PositionChanged then
    NotifyMoveOrResizeStarted;
end;

procedure TWebNavigator.NotifyMoveOrResizeStarted;
begin
  if (FMXChromium1 <> nil) then FMXChromium1.NotifyMoveOrResizeStarted;
end;

procedure TWebNavigator.tmr1Timer(Sender: TObject);
var
  TempHandle : HWND;
  TempRect   : System.Types.TRect;
  TempClientRect : TRectF;
begin
  tmr1.Enabled  := False;
  TempHandle      := FmxHandleToHWND(FMXWindowParent.Handle);
  TempClientRect  := FMXWindowParent.ClientRect;
  TempRect.Left   := round(TempClientRect.Left);
  TempRect.Top    := round(TempClientRect.Top);
  TempRect.Right  := round(TempClientRect.Right);
  TempRect.Bottom := round(TempClientRect.Bottom);
  if not(FMXChromium1.CreateBrowser(TempHandle, TempRect)) and not(FMXChromium1.Initialized) then
    tmr1.Enabled := True;
end;

procedure TWebNavigator.LoadURL;
begin
  FMXChromium1.LoadURL(EdtAddressEdt.Text);
end;

end.
