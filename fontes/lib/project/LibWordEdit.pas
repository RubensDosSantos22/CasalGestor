unit LibWordEdit;

interface

uses
  //Bibliotecas da classe rxmv

  fmxRVGrHandler,
  fmxRVStrFuncs,
  fmxRVDialogsFM,
  fmxRVStyle,
  fmxRVClasses,
  fmxRVTypes,
  fmxRVItem,
  fmxRVFontListFM,
  fmxRVGrInFM,
  fmxRVFileOpenFM,
  fmxRVScroll,
  fmxRichView,
  fmxRVEdit,
  fmxPtblRV,

  //--------------------------

  //Bibliotecas da classe System

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.ImageList,
  System.Actions,
  System.Math,

  //----------------------------

  //Bibliotecas da classe FMX

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Ani,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.WebBrowser,
  FMX.Edit,
  FMX.ComboEdit,
  FMX.Layouts,
  FMX.ImgList,
  FMX.Menus,
  FMX.ActnList,
  FMX.Printer,
  FMX.ListBox,
  FMX.Effects,
  FMX.Colors,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.DateTimeCtrls,
  FMX.ListView,

  //-------------------------

  LibAcoesVcl,
  LibDesign;


  type

    TEditCommand = (
      CMD_NONE,

      // Parâmetros Para a função applyStyle

      TEXT_BOLD,
      TEXT_ITALIC,
      TEXT_UNDERLINE,
      TEXT_APPLYFONTNAME,
      TEXT_APPLYFONTSIZE,
      TEXT_COLOR,
      TEXT_BACKCOLOR,
      TEXT_STRIKEOUT,

      // Parâmetros Para a função applyStyleParagraph

      PARA_ALIGNMENT,
      PARA_INDENTINC,
      PARA_INDENTDEC,
      PARA_COLOR
      );

    TProceedProc = reference to procedure;

    WordEdit = class

      //---------------------------------------------------------------------------------------------------
      /// <summary>
      ///   Inicializa os parâmetros de configuração para trabalhar com o editor de textos
      /// </summary>
      ///
      procedure Initialize(RvEditTextArea: TRichViewEdit);
      procedure changeStyle;

      //---------------------------------------------------------------------------------------------------

      /// <summary>
      ///   Essa procedure aplica as alterações feitas na fonte do texto de uma forma geral
      ///   Os Parâmetros devem ser os mesmos da função RvEditTextAreaStyleConversion
      ///   Essa procedure inclusive deve estar dentro dessa mesma função
      /// </summary>
      ///

      procedure conversionStyle(Sender: TCustomRichViewEdit; StyleNo, UserData: Integer; AppliedToText: Boolean; var NewStyleNo: Integer);

      //---------------------------------------------------------------------------------------------------

      /// <summary>
      ///   Essa procedure aplica as alterações feitas no parágrafo do texto de uma forma geral
      ///   Os Parâmetros devem ser os mesmos da função RvEditTextAreaParaStyleConversion
      ///   Essa procedure inclusive deve estar dentro dessa mesma função
      /// </summary>
      ///

      procedure conversionParagraphStyle(Sender: TCustomRichViewEdit; StyleNo, UserData: Integer; AppliedToText: Boolean; var NewStyleNo: Integer);
      function GetAlignmentFromUI: TRVAlignment;

      //---------------------------------------------------------------------------------------------------

      procedure changeColors(Command: TEditCommand; Title: string; btOk: TSpeedbutton);
      procedure styleCommand(Command: TEditCommand);
      procedure paragraphStyleCommand(Command: TEditCommand);
      procedure paragraphAlignmentCommand(Alignment: TRVAlignment);
      procedure SetAlignmentToUI(Alignment: TRVAlignment);
      procedure changeFont(CbFonts: TComboEdit);
      procedure changeFontSize(CbFonts: TComboEdit);
      procedure chooseColor(Button: TSpeedButton);
      procedure closePopupColor(Popup: TPopup);

      //---------------------------------------------------------------------------------------------------
    end;

var
//variáveis usadas na edição dos textos

    FFileName, FFontName, FMimeType, FDisplayName, FURL: String;
    FResizingToolbar: Boolean;
    FCurrentColorCommand: TEditCommand;
    FColorChosen: Boolean;
    FFileFormat: TRVSaveFormat;
    FIgnoreChanges:      Boolean;
    FFontSize:           Single;
    FCurrentColor:       TAlphaColor;
    FCanClose: Boolean;
    FTextEncoding: TEncoding;
    editArea: TRichViewEdit;

    //-------------------------------------


    //Variáveis do menu de navegação ------

    cbFonts, cbSizeFont: TComboEdit;
    RichStyle: TRVStyle;
    bold, italic, underLine, strikeOut, paragraphRight, paragraphJustify, paragraphCenter, paragraphLeft : TAction;
    btbold, btitalic, btunderLine, btstrikeOut, btparagraphRight, btparagraphJustify, btparagraphCenter, btparagraphLeft : TSpeedButton;
    ScreenWidth, ScreenHeight: Single;
    lstColor: TColorListBox;
    colorBox: TColorBox;
    ppupColor: tpopup;
    FontInfo: TFontInfo;
    ParaInfo: TParaInfo;

    //-------------------------------------

implementation

{ WordEdit }

procedure WordEdit.conversionParagraphStyle(Sender: TCustomRichViewEdit; StyleNo, UserData: Integer; AppliedToText: Boolean; var NewStyleNo: Integer);
begin

  ParaInfo := TParaInfo.Create(nil);

  try
    ParaInfo.Assign(RichStyle.ParaStyles[StyleNo]);
    case TEditCommand(UserData) of
      PARA_ALIGNMENT:
        ParaInfo.Alignment := GetAlignmentFromUI;
      PARA_INDENTINC:
        begin
          ParaInfo.LeftIndent := ParaInfo.LeftIndent + 20;
          if ParaInfo.LeftIndent > 200 then
            ParaInfo.LeftIndent := 200;
        end;
      PARA_INDENTDEC:
        begin
          ParaInfo.LeftIndent := ParaInfo.LeftIndent - 20;
          if ParaInfo.LeftIndent < 0 then
            ParaInfo.LeftIndent := 0;
        end;
      PARA_COLOR:
        ParaInfo.Background.Color := FCurrentColor;
      // add your code here....
    end;
    NewStyleNo := RichStyle.FindParaStyle(ParaInfo);
  finally
    ParaInfo.Free;
  end;
end;



procedure WordEdit.conversionStyle(Sender: TCustomRichViewEdit; StyleNo, UserData: Integer; AppliedToText: Boolean; var NewStyleNo: Integer);
  {...........................................................................}
  procedure ApplyFontStyle(FontStyle: TFontStyle; Value: Boolean);
  begin
    if Value then
      FontInfo.Style := FontInfo.Style + [FontStyle]
    else
      FontInfo.Style := FontInfo.Style - [FontStyle];
  end;
  {...........................................................................}
begin
  FontInfo := TFontInfo.Create(nil);
  try
    FontInfo.Assign(RichStyle.TextStyles[StyleNo]);
    case TEditCommand(UserData) of
      TEXT_BOLD:
        ApplyFontStyle(TFontStyle.fsBold, not bold.Checked);
      TEXT_ITALIC:
        ApplyFontStyle(TFontStyle.fsItalic, not italic.Checked);
      TEXT_UNDERLINE:
        ApplyFontStyle(TFontStyle.fsUnderline, not underline.Checked);
      TEXT_STRIKEOUT:
        ApplyFontStyle(TFontStyle.fsStrikeOut, not strikeOut.Checked);
      TEXT_APPLYFONTNAME:
        FontInfo.FontName := FFontName;
      TEXT_APPLYFONTSIZE:
        FontInfo.Size := FFontSize;
      TEXT_COLOR:
        FontInfo.Color := FCurrentColor;
      TEXT_BACKCOLOR:
        FontInfo.BackColor := FCurrentColor;
      // add your code here....
    end;
    NewStyleNo := RichStyle.FindTextStyle(FontInfo);
  finally
    FontInfo.Free;
  end;
end;



function WordEdit.GetAlignmentFromUI: TRVAlignment;
begin
  if paragraphRight.Checked then
    Result := rvaRight
  else if paragraphCenter.Checked then
    Result := rvaCenter
  else if paragraphJustify.Checked then
    Result := rvaJustify
  else
    Result := rvaLeft;
end;

procedure WordEdit.Initialize(RvEditTextArea: TRichViewEdit);
begin

  editArea              := RvEditTextArea;
  cbFonts               := TComboEdit(ActualScreen.FindComponent('CbEdtFonts'));
  cbSizeFont            := TComboEdit(ActualScreen.FindComponent('CbEdtFontSize'));
  bold                  := TAction(ActualScreen.FindComponent('actBold'));
  italic                := TAction(ActualScreen.FindComponent('actItalic'));
  underLine             := TAction(ActualScreen.FindComponent('actUnderline'));
  strikeOut             := TAction(ActualScreen.FindComponent('actStrikeOut'));
  paragraphJustify      := TAction(ActualScreen.FindComponent('actParaJustify'));
  paragraphCenter       := TAction(ActualScreen.FindComponent('actParaCenter'));
  paragraphRight        := TAction(ActualScreen.FindComponent('actParaRight'));
  paragraphLeft         := TAction(ActualScreen.FindComponent('actParaLeft'));

  btBold                := TSpeedButton(ActualScreen.FindComponent('btnBold'));
  btItalic              := TSpeedButton(ActualScreen.FindComponent('btnItalic'));
  btUnderline           := TSpeedButton(ActualScreen.FindComponent('btnUnderline'));
  btStrikeOut           := TSpeedButton(ActualScreen.FindComponent('btnStrikeOut'));
  btparagraphLeft       := TSpeedButton(ActualScreen.FindComponent('btnLeft'));
  btparagraphRight      := TSpeedButton(ActualScreen.FindComponent('btnRight'));
  btparagraphCenter     := TSpeedButton(ActualScreen.FindComponent('btnCenter'));
  btparagraphJustify    := TSpeedButton(ActualScreen.FindComponent('btnJustify'));

  lstColor              := TColorListBox(ActualScreen.FindComponent('ClLstBxSelecionaCor'));
  colorBox              := TColorBox(ActualScreen.FindComponent('ClBxSelecionaCor'));
  ppupColor             := TPopup(ActualScreen.FindComponent('ClPpupSelecionaCor'));

  btBold.StaysPressed := True;
  btItalic.StaysPressed := True;
  btUnderline.StaysPressed := True;
  btStrikeOut.StaysPressed := True;
  btparagraphLeft.StaysPressed := True;
  btparagraphRight.StaysPressed := True;
  btparagraphCenter.StaysPressed := True;
  btparagraphJustify.StaysPressed := True;


  RichStyle             := TRVStyle.Create(Application);
  editArea.Style        := RichStyle;

  RVFillFontFamilies(cbFonts.Items);
  FCurrentColorCommand := CMD_NONE;
end;



procedure WordEdit.paragraphAlignmentCommand(Alignment: TRVAlignment);
begin
  SetAlignmentToUI(Alignment);
  editArea.ApplyParaStyleConversion(ord(PARA_ALIGNMENT));
end;

procedure WordEdit.SetAlignmentToUI(Alignment: TRVAlignment);
begin
  paragraphLeft.Checked    := Alignment = rvaLeft;
  paragraphCenter.Checked  := Alignment = rvaCenter;
  paragraphRight.Checked   := Alignment = rvaRight;
  paragraphJustify.Checked := Alignment = rvaJustify;
end;


procedure WordEdit.paragraphStyleCommand(Command: TEditCommand);
begin
  editArea.ApplyParaStyleConversion(ord(Command));
end;

procedure WordEdit.styleCommand(Command: TEditCommand);
begin
  editArea.ApplyStyleConversion(ord(Command));
end;


procedure WordEdit.changeColors(Command: TEditCommand; Title: string; btOk: TSpeedButton);
begin
  FCurrentColor := RichStyle.TextStyles[editArea.CurTextStyleNo].Color;
  FCurrentColorCommand := Command;
  TLabel(ActualScreen.FindComponent('lblColorTitle')).Text:= Title;
  chooseColor(btOk);
end;

procedure WordEdit.changeFont(CbFonts: TComboEdit);
begin
  if FIgnoreChanges then exit;

  if CbFonts.Items.IndexOf(CbFonts.Text) >= 0 then
    begin
      FFontName := CbFonts.Text;
      styleCommand(TEXT_APPLYFONTNAME);
      editArea.SetFocus;
    end
  else
    Beep;
end;

procedure WordEdit.changeFontSize(CbFonts: TComboEdit);
begin
  if FIgnoreChanges then exit;

  if (CbFonts.Text <> '') and not FIgnoreChanges then
  begin
    FFontSize := StrToFloatDef(CbFonts.Text, 10);
    styleCommand(TEXT_APPLYFONTSIZE);
    editArea.SetFocus;
  end
  else
    Beep;
end;

procedure WordEdit.changeStyle;
begin
  FIgnoreChanges := True;

  // Verificando e trocando o nome da fonte e o tamanho

  FontInfo        := RichStyle.TextStyles[editArea.CurTextStyleNo];
  cbFonts.Text    := FontInfo.FontName;
  cbSizeFont.Text := FloatToStr(FontInfo.Size);

  // Checando as alterações de estio do texto

  bold.Checked      := TFontStyle.fsBold      in FontInfo.Style;
  italic.Checked    := TFontStyle.fsItalic    in FontInfo.Style;
  underLine.Checked := TFontStyle.fsUnderline in FontInfo.Style;
  strikeOut.Checked := TFontStyle.fsStrikeOut in FontInfo.Style;

  FIgnoreChanges := False;
end;

procedure WordEdit.chooseColor(Button: TSpeedButton);
begin

  lstColor.Color := FCurrentColor;

  if FCurrentColor = TAlphaColorRec.Null then
    lstColor.ItemIndex := lstColor.Items.Count - 1;

  ScreenWidth := Screen.Width;
  ScreenHeight := Screen.Height;

  if not IsZero(ScreenWidth) and (ppupColor.Width > Screen.Width) then
    ppupColor.Width := ScreenWidth;

  if not IsZero(ScreenHeight) and (ppupColor.Height > ScreenHeight) then
    ppupColor.Height := ScreenHeight;

  ppupColor.PlacementTarget := Button;
  ppupColor.IsOpen := True;
end;

procedure WordEdit.closePopupColor(Popup: TPopup);
begin

  if csDestroying in Popup.ComponentState then
    exit;

  editArea.SetFocus;
  if FColorChosen then
  begin
    FCurrentColor := lstColor.Color;
    case FCurrentColorCommand of
      TEXT_COLOR, TEXT_BACKCOLOR:
        styleCommand(FCurrentColorCommand);
      PARA_COLOR:
        paragraphStyleCommand(FCurrentColorCommand);
    end;
  end;
end;

end.
