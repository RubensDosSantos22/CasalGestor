unit LibTools;

interface

/// <summary>
///   Aqui, contém as ações e procesamento das informações do sistema como um todo.
/// </summary>

uses
  {$REGION 'Bibliotecas da Lib'}

  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  Vcl.Buttons,
  Vcl.ComCtrls;

{$ENDREGION}

  type
    TAcoes = class

      //---------------------------------------------------------------------------------------------------
      /// <summary>
      ///   Converte o valor contido em Control[2], em um estado de checkbox
      /// </summary>
      /// <param name="CheckField"> Componente do tipo TCheckbox a ter o estado alterado </param>
      /// <returns> [ Checked = True ] para '-1', [ Checked = False ] para qualquer valor diferente de '-1' </returns>

      function parToCheck(par:string): boolean;

      //---------------------------------------------------------------------------------------------------

      //---------------------------------------------------------------------------------------------------
      /// <summary>
      ///   Converte o valor contido em um Checkbox qualquer, em um parâmetro a ser armazenado e Auxiliar[0] (Espaço reservado para esse fim)
      /// </summary>
      /// <param name="CheckField"> Componente do tipo TCheckbox a ser analisado </param>
      /// <returns> [ Checked = '-1' ] para True, [ Checked = '0' ] para qualquer valor diferente de True </returns>

      function checkToPar(CheckField:boolean): string;

      //---------------------------------------------------------------------------------------------------


      //---------------------------------------------------------------------------------------------------
      /// <summary>
      ///   Converte um conjunto de caracteres em um número de telefone ou celular
      /// </summary>
      /// <param name="PhoneText"> campo do tipo string que irá receber o conjunto de caracteres que se tornará o número de telefone formatado </param>
      /// <returns> Número de telefone formatado </returns>

      procedure StrToPhone(PhoneText: String);

      //---------------------------------------------------------------------------------------------------

      procedure SetValuesOnfields(Fields: array of TComponent; Keys: array of Integer; Controls: array of string; ValueFields: array of string);
      procedure AbreTela(CdScreen: string);
      procedure CloseScreens;
  end;

  MathProcess = class
    function checkDiffInt(VlrAi, VlrNi, Resi: integer): integer;
    function checkDiffFloat(VlrAf, VlrNf, Resf: Double): Double;
    function numberize(Txt: string): string;
    function remQuotes(Input:string):string;
    function analizeBool1Condition(val1: boolean): boolean;
    function analizeBool2Condition(val1, val2: boolean): boolean;
  end;

  var
    ScreensOpened: array [0..10] of string;
    ActionScreen : string;
    ItemAction   : string;
    Contagem, i  : Integer;
    IDif, IResult: integer;
    FDif, FResult: Double;
    Acao, nomeArquivo: string;
    FTecladoShow, ConectadoB, ConectadoV, Conectado: boolean;
    numberized, Chave, useSearch, useCad: string;

    Tipo          : array [0..10] of string;
    Parameter     : array [0..10] of string;
    Key           : array [0..10] of Integer;
    Control       : array [0..10] of string;
    Auxiliar      : array [0..10] of string;
    ChaveAcesso   : array [0..20] of string;
    Action        : string;
    FoneAction    : string;
    ConvertedDate : string;

    ActualScreen : Tform;
    LiberaAcesso: boolean;

implementation

//--------------------------------------====<  >====-------------------------------------\\
function TAcoes.parToCheck(par:string): boolean;
begin

  if par  = '-1' then
    begin
      Result:= True;
    end
  else
    begin
      Result:= False;
    end;
end;
//--------------------------------------====<  >====-------------------------------------\\




//--------------------------------------====<  >====-------------------------------------\\
function TAcoes.checkToPar(CheckField:boolean): string;
begin

  if CheckField  = True then
    begin
      Result:= '-1';
    end
  else if CheckField = False then
    begin
      Result:= '0';
    end;
end;
//--------------------------------------====<  >====-------------------------------------\\



//--------------------------------------====<  >====-------------------------------------\\
function MathProcess.numberize(Txt: string): string;
begin

  numberized := '';
  for I := 1 to Length(Txt) do
    begin
    if Txt[I] in ['0'..'9'] then
      begin
        numberized := numberized + Txt[I];
      end;
    end;

  Result:= numberized;
end;
//--------------------------------------====<  >====-------------------------------------\\



//--------------------------------------====<  >====-------------------------------------\\
procedure TAcoes.StrToPhone(PhoneText: String);
const
  // Formatos estrangeiros de números de telefone
  E164:               string = '!\+0 000 000 0000;1;_';
  National:           string = '!\(000) 000-0000;1;_';
  National_areaCode:  string = '!\000 0000 0000;1;_';
  E123:               string = '!\+0 00 0000 0000;1;_';
  Common_Asian:       string = '!\+00 00000 00000;1;_';

  //Formatos Nacionais usados
  CommonCell:         string = '!\(00) 00000-0000;1;_';
  CommonTell:         string = '!\(00) 0000-0000;1;_';
  CommonCellCountry:  string = '!\+00 (00) 00000-0000;1;_';
  CommonTellCountry:  string = '!\+00 (00) 0000-0000;1;_';

var
  Math: MathProcess;

begin

  Math.numberize(PhoneText);

  if Copy(PhoneText, length(PhoneText) - 1, length(PhoneText)) <> 'E' then
    begin

    end
  else
    begin

    if (length(PhoneText) = 13) or (length(PhoneText) = 12) then
      begin
          {
      if length(PhoneText) = 13 then
        FormatFloat(StrToFloat(PhoneText), CommonCellCountry)

         }
      end
    else
      begin

      end;

    end;

  if PhoneText = '!\(99\)00000-0000;1;_' then
    begin
      Control[1]:= 'TELL';
      PhoneText:= '!\(99\)0000-0000;1;_';
    end
  else
    begin
      Control[1]:= 'CELL';
      PhoneText:= '!\(99\)00000-0000;1;_';
    end;
end;
//--------------------------------------====<  >====-------------------------------------\\

//------------====< PEGAR O VALOR DE UM PARÂMETRO E SETÁ-LO EM UM CAMPO >====------------\\
procedure TAcoes.SetValuesOnfields(Fields: array of TComponent;
  Keys: array of Integer; Controls: array of string; ValueFields: array of string);
var
  i, j, k: Integer;
begin
  for i := 0 to length(Fields) -1 do
    begin
    if (Fields[i] is TEdit) then
      begin
        (Fields[i] as TEdit).Text:= ValueFields[i];
      end
    else if (Fields[i] is TMaskEdit) then
      begin
        (Fields[i] as TMaskEdit).Text:= ValueFields[i];
      end
    else if (Fields[i] is TMemo) then
      begin
        (Fields[i] as TMemo).Lines.Add(ValueFields[i]);
      end;
    end;
  for j := 0 to length(Keys) -1 do
    begin
    if Key[0] <> 0then
      begin
        Key[1]:= Keys[j];
      end
    else
      begin
        Key[0]:= Keys[j];
      end;
    end;
  for k := 0 to length(Controls) - 1 do
    begin
      Control[2]:= Controls[k];
    end;
end;

//------------------------====< ABRIR UMA TELA NO PROGRAMA >====-------------------------\\
procedure TAcoes.AbreTela(CdScreen: string);
begin
  {CloseScreens;
  FrIndex.PnlMenu.Width:= 0;
  if CdScreen = 'C001' then
    begin
      FrClientes:= TFrClientes.Create(Application);
      FrClientes.Parent:= FrIndex.PnlAreaDeTrabalho;
      ActualScreen:= FrClientes;
      FrClientes.Show;

      useCad:= 'S';
      useSearch:= 'S';
    end;
  if CdScreen = 'C002' then
    begin
      FrNovoProcesso:= TFrNovoProcesso.Create(Application);
      FrNovoProcesso.Parent:= FrIndex.PnlAreaDeTrabalho;
      ActualScreen:= FrNovoProcesso;
      FrNovoProcesso.Show;

      useCad:= 'S';
      useSearch:= 'S';
    end;
  if CdScreen = 'C003' then
    begin
      FrFinalizaConversao:= TFrFinalizaConversao.Create(Application);
      FrFinalizaConversao.Parent:= FrIndex.PnlAreaDeTrabalho;
      ActualScreen:= FrFinalizaConversao;
      FrFinalizaConversao.Show;

      useCad:= 'S';
      useSearch:= 'S';
    end;
  if CdScreen = 'C004' then
    begin
      FrMultiempresa:= TFrMultiempresa.Create(Application);
      FrMultiempresa.Parent:= FrIndex.PnlAreaDeTrabalho;
      ActualScreen:= FrMultiempresa;
      FrMultiempresa.Show;

      useCad:= 'S';
      useSearch:= 'N';
    end;
  if CdScreen  = 'V001' then
    begin
      FrConversoes:= TFrConversoes.Create(Application);
      FrConversoes.Parent:= FrIndex.PnlAreaDeTrabalho;
      ActualScreen:= FrConversoes;
      FrConversoes.Show;

      useCad:= 'N';
      useSearch:= 'N';
    end;
  if CdScreen = 'S007' then
    begin
      FrSetup:= TFrSetup.Create(Application);
      FrSetup.Parent:= FrIndex.PnlAreaDeTrabalho;
      ActualScreen:= FrSetup;
      FrSetup.Show;

      useCad:= 'S';
      useSearch:= 'N';
    end;
  if CdScreen = 'V003' then
    begin
      FrProcessos:= TFrProcessos.Create(Application);
      FrProcessos.Parent:= FrIndex.PnlAreaDeTrabalho;
      ActualScreen:= FrProcessos;
      FrProcessos.Show;

      useCad:= 'N';
      useSearch:= 'S';
    end;
  if CdScreen = 'S001' then
    begin
      FrConfigurator:= TFrConfigurator.Create(Application);
      FrConfigurator.Parent:= FrIndex.PnlAreaDeTrabalho;
      ActualScreen:= FrConfigurator;
      FrConfigurator.Show;

      useCad:= 'N';
      useSearch:= 'N';
    end;
  if CdScreen = 'S002' then
    begin
      FrConfUsers:= TFrConfUsers.Create(Application);
      FrConfUsers.Parent:= FrIndex.PnlAreaDeTrabalho;
      ActualScreen:= FrConfUsers;
      FrConfUsers.Show;

      useCad:= 'N';
      useSearch:= 'N';
    end;
  if CdScreen = 'S003' then
    begin
      FrConfDefaults:= TFrConfDefaults.Create(Application);
      FrConfDefaults.Parent:= FrIndex.PnlAreaDeTrabalho;
      ActualScreen:= FrConfDefaults;
      FrConfDefaults.Show;

      useCad:= 'N';
      useSearch:= 'N';
    end;
  if CdScreen = 'S004' then
    begin
      FrConfTax:= TFrConfTax.Create(Application);
      FrConfTax.Parent:= FrIndex.PnlAreaDeTrabalho;
      ActualScreen:= FrConfTax;
      FrConfTax.Show;

      useCad:= 'N';
      useSearch:= 'N';
    end;
  if CdScreen = 'S005' then
    begin
      FrAdicionaUsuariosHeveasoft:= TFrAdicionaUsuariosHeveasoft.Create(Application);
      FrAdicionaUsuariosHeveasoft.Parent:= FrIndex.PnlAreaDeTrabalho;
      ActualScreen:= FrAdicionaUsuariosHeveasoft;
      FrAdicionaUsuariosHeveasoft.Show;

      useCad:= 'N';
      useSearch:= 'N';
    end;
  if CdScreen = 'S006' then
    begin
      FrAdicionaUsuariosAGSPainel:= TFrAdicionaUsuariosAGSPainel.Create(Application);
      FrAdicionaUsuariosAGSPainel.Parent:= FrIndex.PnlAreaDeTrabalho;
      ActualScreen:= FrAdicionaUsuariosAGSPainel;
      FrAdicionaUsuariosAGSPainel.Show;

      useCad:= 'S';
      useSearch:= 'N';
    end;

  Pesquisa;

  if ScreensOpened[0] <> '' then
    begin
      ScreensOpened[1]:= CdScreen;
    end
  else
    begin
      ScreensOpened[0]:= CdScreen;
    end; }
end;
//--------------------------------------====<  >====-------------------------------------\\

//----------------------------====< FECHAR TODAS AS TELAS >====--------------------------\\
procedure TAcoes.CloseScreens;
var
  i: Integer;
begin
  {if FrDadosClientes <> nil then
    begin
      FrDadosClientes.Close;
      FrDadosClientes:= nil;
    end;
  if FrConversoes <> nil then
    begin
      FrConversoes.Close;
      FrConversoes:= nil;
    end;
  if FrSetup <> nil then
    begin
      FrSetup.Close;
      FrSetup:= nil;
    end;
  if FrFinalizaConversao <> nil then
    begin
      FrFinalizaConversao.Close;
      FrFinalizaConversao:= nil;
    end;
  if FrNovoProcesso <> nil then
    begin
      FrNovoProcesso.Close;
      FrNovoProcesso:= nil;
    end;
  if FrProcessos <> nil then
    begin
      FrProcessos.Close;
      FrProcessos:= nil;
    end;
  if FrMultiempresa <> nil then
    begin
      FrMultiempresa.Close;
      FrMultiempresa:= nil;
    end;
  if FrClientes <> nil then
    begin
      FrClientes.Close;
      FrClientes:= nil;
    end;
  if FrConfigurator <> nil then
    begin
      FrConfigurator.Close;
      FrConfigurator:= nil;
    end;
  if FrAdicionaUsuariosHeveasoft <> nil then
    begin
      FrAdicionaUsuariosHeveasoft.Close;
      FrAdicionaUsuariosHeveasoft:= nil;
    end;
  if FrAdicionaUsuariosAGSPainel <> nil then
    begin
      FrAdicionaUsuariosAGSPainel.Close;
      FrAdicionaUsuariosAGSPainel:= nil;
    end;
  for i := 0 to Length(ScreensOpened) - 1 do
    begin
      ScreensOpened[i]:= '';
    end; }
end;
//--------------------------------------====<  >====-------------------------------------\\


//------====< [AÇÕES MATEMÁTICAS QUE SÃO EXECUTADAS PARA FACILITAR PROCESOS] >====-------\\
function MathProcess.analizeBool1Condition(val1: boolean): boolean;
begin
//pass
end;

function MathProcess.analizeBool2Condition(val1, val2: boolean): boolean;
begin
//pass
end;

function MathProcess.checkDiffFloat(VlrAf, VlrNf, Resf: Double): Double;
begin
  if VlrAf < VlrNf then
    begin
      FDif:= VlrNf - VlrAf;
      Resf:= Resf + FDif;
    end
  else if VlrAf > VlrNf then
    begin
      FDif:= VlrAf - VlrNf;
      Resf:= Resf - FDif;
    end;
  FResult:= Resf;
  Result:= FResult;
end;

function MathProcess.checkDiffInt(VlrAi, VlrNi, Resi: integer): integer;
begin
  if VlrAi < VlrNi then
    begin
      IDif:= VlrNi - VlrAi;
      Resi:= Resi + IDif;
    end
  else if VlrAi > VlrNi then
    begin
      IDif:= VlrAi - VlrNi;
      Resi:= Resi - IDif;
    end;
  IResult:= Resi;
  Result:= IResult;
end;

function MathProcess.remQuotes(Input: string): string;
begin
  if Copy(Input, 0, 1) = '"' then
    begin
      nomeArquivo:= Copy(Input, 2, length(Input)-2);
    end
  else
    begin
      nomeArquivo:= Input;
    end;
  result:= nomeArquivo;
end;

end.

