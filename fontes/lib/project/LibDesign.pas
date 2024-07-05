unit LibDesign;

interface

/// <summary>
///  Esta unit contém a implementação das classes de design do projeto, de forma global
/// </summary>
/// <remarks>
///  A classe animNoTime realiza o trabalho gráfico dos menus das telas.
/// </remarks>

uses


  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShellAPI,

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

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


  Vcl.Dialogs,

  AnexoEmailServico;

  type
    animNoTime = class
      /// <summary>
      ///  Abre e fecha o menu das demais telas do sistema.
      /// </summary>
      procedure abreAuxiliar;

    end;
{
    btAnim = class
      procedure state;

    end;}

    imgTiposDeArquivo = class
      function changeIconFIleType(fileExtension: string): TBitmap;
      function GetFileSize(const FileName: string): Int64;
      procedure addAnexo(lb: TListbox);
  private
    procedure deleteItem(Sender: TObject);
    end;

  var
    ActualScreen: Tform;
    FrAnexo: TFrmAnServ;


implementation

{ animNoTime }

procedure animNoTime.abreAuxiliar;
var
  Menu:  TRectangle;
  aMenu: TfloatAnimation;
  fMenu: TfloatAnimation;
begin

  aMenu           := TFloatAnimation(ActualScreen.FindComponent('anSizeWPnlChild11'));
  fMenu           := TFloatAnimation(ActualScreen.FindComponent('anSizeWPnlChild1'));
  Menu            := TRectangle(ActualScreen.FindComponent('PnlChild1'));

  if Menu.Width = 265 then
    begin
      fMenu.Start;
    end
  else
    begin
      aMenu.Start;
    end;

end;



{ imgTiposDeArquivo }

function imgTiposDeArquivo.changeIconFIleType(fileExtension: string): TBitmap;
var
  ResourceStream: TResourceStream;
  Bitmap: TBitmap;
begin

  if UpperCase(fileExtension) = '.CSV' then
    begin
      ResourceStream := TResourceStream.Create(HInstance, 'CSV', RT_RCDATA);
    end
  else if (UpperCase(fileExtension) = '.XLSX') OR (UpperCase(fileExtension) = '.XLS') then
    begin
      ResourceStream := TResourceStream.Create(HInstance, 'EXCEL', RT_RCDATA);
    end
  else if UpperCase(fileExtension) = '.EXE' then
    begin
      ResourceStream := TResourceStream.Create(HInstance, 'EXE', RT_RCDATA);
    end
  else if UpperCase(fileExtension) = '.PDF' then
    begin
      ResourceStream := TResourceStream.Create(HInstance, 'PDF', RT_RCDATA);
    end
  else if UpperCase(fileExtension) = '.PNG' then
    begin
      ResourceStream := TResourceStream.Create(HInstance, 'PNG', RT_RCDATA);
    end
  else if UpperCase(fileExtension) = '.RAR' then
    begin
      ResourceStream := TResourceStream.Create(HInstance, 'RAR', RT_RCDATA);
    end
  else if (UpperCase(fileExtension) = '.DOC') OR (UpperCase(fileExtension) = '.DOCX') then
    begin
      ResourceStream := TResourceStream.Create(HInstance, 'WORD', RT_RCDATA);
    end
  else if UpperCase(fileExtension) = '.ZIP' then
    begin
      ResourceStream := TResourceStream.Create(HInstance, 'ZIP', RT_RCDATA);
    end
  else
    begin
      ResourceStream := TResourceStream.Create(HInstance, 'ARQUIVO', RT_RCDATA);
    end;

    Bitmap := TBitmap.Create;

    Bitmap.LoadFromStream(ResourceStream);
      Result:= Bitmap;
end;

function imgTiposDeArquivo.GetFileSize(const FileName: string): Int64;
var
  Handle: THandle;
  FindData: TWin32FindData;
begin
  Result := -1; // Retorna -1 em caso de erro

  // Abre o arquivo
  Handle := FindFirstFile(PChar(FileName), FindData);
  if Handle <> INVALID_HANDLE_VALUE then
  begin
    try
      // Verifica se é um arquivo
      if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
      begin
        // Calcula o tamanho do arquivo
        Result := Int64(FindData.nFileSizeLow) or (Int64(FindData.nFileSizeHigh) shl 32);
      end;
    finally
      // Fecha o arquivo
      Winapi.Windows.FindClose(Handle);
    end;
  end;
end;

procedure imgTiposDeArquivo.addAnexo(lb: TListbox);
var
  item: TlistboxItem;
  Img: imgTiposDeArquivo;
  OpenDialog: TOpenDialog;
  Nome, Tamanho, UpdatedAt: string;
begin

  OpenDialog := TOpenDialog.Create(nil);
  try
    OpenDialog.Options := [ofFileMustExist];
    if OpenDialog.Execute then
    begin
      item:= TListBoxItem.Create(nil);
      item.Text:= '';
      item.Height:= 65;
      item.TagString:= OpenDialog.FileName;

      FrAnexo:= TFrmAnServ.Create(item);
      FrAnexo.Parent:= item;
      FrAnexo.Align:= TAlignLayout.Client;

      FrAnexo.LblTitle.Text         := ExtractFileName(OpenDialog.FileName);
      FrAnexo.LblTamanhoAnexo.Text  := 'Tamanho do Arquivo: ' + FormatFloat('###,###,##0', Round(Img.GetFileSize(OpenDialog.FileName)/1024)) + ' KB';

      FrAnexo.ImgTipo.Bitmap.Assign(Img.changeIconFIleType(ExtractFileExt(OpenDialog.FileName)));

      FrAnexo.SpBtMenuItem.OnClick:= deleteItem;
      lb.AddObject(item);
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure imgTiposDeArquivo.deleteItem(Sender: TObject);
var
  Anexo: TFrmAnServ;
  Item: TListBoxItem;
  btn: TSpeedButton;
begin

  btn:= Sender as TSpeedbutton;
  Anexo:= btn.Parent as TFrmAnServ;
  Item:= Anexo.Parent as TListBoxItem;
  Item.Destroy;
end;

end.
