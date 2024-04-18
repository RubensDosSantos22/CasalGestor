
unit LibAcoes;
interface

/// <summary>
///   Aqui, contém as ações e procesamento das informações do sistema como um todo.
/// </summary>

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, LibDatabase,Vcl.ComCtrls;
  type
    Acoes = class

      //---------------------------------------------------------------------------------------------------
      /// <summary>
      ///   Converte o valor contido em Control[2], em um estado de checkbox
      /// </summary>
      /// <param name="CheckField"> Componente do tipo TCheckbox a ter o estado alterado </param>
      /// <returns> [ Checked = True ] para '-1', [ Checked = False ] para qualquer valor diferente de '-1' </returns>

      procedure parToCheck(CheckField:TCheckBox);

      //---------------------------------------------------------------------------------------------------

      //---------------------------------------------------------------------------------------------------
      /// <summary>
      ///   Converte o valor contido em um Checkbox qualquer, em um parâmetro a ser armazenado e Auxiliar[0] (Espaço reservado para esse fim)
      /// </summary>
      /// <param name="CheckField"> Componente do tipo TCheckbox a ser analisado </param>
      /// <returns> [ Checked = '-1' ] para True, [ Checked = '0' ] para qualquer valor diferente de True </returns>

      procedure checkToPar(CheckField:TCheckBox);

      //---------------------------------------------------------------------------------------------------


      //---------------------------------------------------------------------------------------------------
      /// <summary>
      ///   Converte um conjunto de caracteres em um número de telefone ou celular
      /// </summary>
      /// <param name="PhoneText"> campo do tipo string que irá receber o conjunto de caracteres que se tornará o número de telefone formatado </param>
      /// <returns> Número de telefone formatado </returns>

      procedure StrToPhone(PhoneText: String);

      //---------------------------------------------------------------------------------------------------

      procedure Estado(Components: array of TComponent; State: Boolean);
      procedure LimpaCampos(Components: array of TComponent);
      procedure SetParamsMaster(Parameters: array of string);
      procedure SetValuesOnfields(Fields: array of TComponent; Keys: array of Integer; Controls: array of string; ValueFields: array of string);
      procedure AbrirPrograma(IndexProgram: Integer);
      procedure AbreTela(CdScreen: string);
      procedure CloseScreens;
      procedure shortcutKeys(var Key: Word);
      procedure sttsBarSetup;
  end;
  type
    AcessoTS = class
      procedure ShowUsers(Index: Integer);
      procedure EnterTS(Index: Integer);
    end;

  MathProcess = class
    function checkDiffInt(VlrAi, VlrNi, Resi: integer): integer;
    function checkDiffFloat(VlrAf, VlrNf, Resf: Double): Double;
    function numberize(Txt: string): string;
    function remQuotes(Input:string):string;
    function analizeBool1Condition(val1: boolean): boolean;
    function analizeBool2Condition(val1, val2: boolean): boolean;
  end;
  type
    CardServico = class
      procedure CriaCard(List: TListBox);
      procedure AtualizaCard(List: TListBox);
    end;
  type
    connectionServices = class
//      function fbconnectWithString(base: string; conexao: TFDConnection; modelo: integer): boolean;
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

    ActualScreen: TForm;
implementation
{uses
     UnClientes, UnSetup, UnFinalizaConversao, UnProcessos, UnNovoProcesso,
     UnMultiempresa, UnConversoes, Index, UnDadosClientes, UnConfigurator,
     UnConfUsers, UnConfigDefaults, UnConfTax, UnAdicionaUsuariosHeveasoft,
     UnAdicionaUsuariosAGSPainel; }

//--------------------------------------====<  >====-------------------------------------\\
procedure Acoes.parToCheck(CheckField: TCheckBox);
begin

  //Avaliando o parâmetro mestre de comboboxes e convertendo em um estado booleano (True/false)

  if Control[2]  = '-1' then
    begin
      CheckField.Checked:= True;
    end
  else
    begin
      CheckField.Checked:= False;
    end;
end;
//--------------------------------------====<  >====-------------------------------------\\




//--------------------------------------====<  >====-------------------------------------\\
procedure Acoes.checkToPar(CheckField: TCheckBox);
begin

  //Avaliando o combobox e convertendo em um estado legível pelo parâmetro mestre ( Control[2] ) futuramente ('-1'/'0')

  if CheckField.Checked  = True then
    begin
      Auxiliar[0]:= '-1';
    end
  else if CheckField.Checked = False then
    begin
      Auxiliar[0]:= '0';
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
procedure Acoes.StrToPhone(PhoneText: String);
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

//------====< SETAR OS PARÂMETROS DENTRO DA ARRAY PARAMETERS >====-----------------------\\
procedure Acoes.SetParamsMaster(Parameters: array of string);
var
  i: Integer;
begin
  for i := 0 to Length(Parameters) - 1 do
    begin
      Parameter[i]:= Parameters[i];
    end;
end;
//--------------------------------------====<  >====-------------------------------------\\

//------------====< PEGAR O VALOR DE UM PARÂMETRO E SETÁ-LO EM UM CAMPO >====------------\\
procedure Acoes.SetValuesOnfields(Fields: array of TComponent;
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

procedure Acoes.shortcutKeys(var Key: Word);
var
  Bt: TSpeedButton;
begin
  {if (key = VK_F5) and (useCad = 'S') then
    begin
      bt:= TSpeedButton(ActualScreen.FindComponent('BtSalvar'));
      bt.OnClick(Application);
    end
  else if (key = VK_F6) and (useCad = 'S') and (ActualScreen <> FrSetup) then
    begin
      bt:= TSpeedButton(ActualScreen.FindComponent('BtNovo'));
      bt.OnClick(Application);
    end
  else if (key = VK_DELETE) and (ActualScreen <> FrAdicionaUsuariosHeveasoft) then
    begin
      bt:= TSpeedButton(ActualScreen.FindComponent('BtExcluir'));
      bt.OnClick(Application);
    end
  else if (key = VK_F7) and (ActualScreen = FrMultiempresa) then
    begin
      bt:= TSpeedButton(ActualScreen.FindComponent('BtConfigurar'));
      bt.OnClick(Application);
    end
  else if (key = VK_RETURN) and (ActualScreen = FrAdicionaUsuariosHeveasoft) then
    begin
      bt:= TSpeedButton(ActualScreen.FindComponent('BtAdicionaUsuarioPropriedade'));
      bt.OnClick(Application);
    end
  else if (key = VK_DELETE) and (ActualScreen = FrAdicionaUsuariosHeveasoft) then
    begin
      bt:= TSpeedButton(ActualScreen.FindComponent('BtRemoveUsuarioPropriedade'));
      bt.OnClick(Application);
    end
  else if key = VK_ESCAPE then
    begin
      CloseScreens;
    end
  else if (key = VK_F3) and (useSearch = 'S') then
    begin
      Pesquisa;
    end; }
end;

procedure Acoes.sttsBarSetup;
var
  Menu: TStatusBar;
begin
  {Menu:= TStatusBar(FrIndex.FindComponent('StsAtalhos'));

  with Menu do
    begin
    if useCad = 'S' then
      begin
        Panels[0].Text:= 'F5  - SALVAR';

      if  ActualScreen <> FrSetup then
        begin
          Panels[1].Text:= 'F6  - NOVO';
        end
      else
        begin
          Panels[1].Text:= '';
        end;

        Panels[2].Text:= 'DEL - EXCLUIR';
      end
    else
      begin
        Panels[0].Text:= '';
        Panels[1].Text:= '';
        Panels[2].Text:= '';
      end;

    if useSearch = 'S' then
      begin
        Panels[3].Text:= 'F3 - PESQUISAR';
      end
    else
      begin
        Panels[3].Text:= '';
      end;

    if ActualScreen = FrMultiempresa then
      begin
        Panels[4].Text:= 'F7 - CONFIGURAR';
      end
    else
      begin
        Panels[4].Text:= '';
      end;
    end;  }
end;

//--------------------------------------====<  >====-------------------------------------\\

//--------------------------====< ABRIR UM PROGRAMA EXTERNO >====------------------------\\
procedure Acoes.AbrirPrograma(IndexProgram: Integer);
begin
  if IndexProgram = 1 then
    begin
      WinExec('C:\Program Files (x86)\AnyDesk\AnyDesk.exe', sw_show);
    end
  else if IndexProgram = 2 then
    begin
      WinExec('C:\Program Files (x86)\Borland\Delphi7\Bin\delphi32.exe', sw_show);
    end
  else if IndexProgram = 3 then
    begin
      WinExec('C:\Program Files (x86)\HK-Software\IBExpert\IBExpert.exe', sw_show);
    end
  else if IndexProgram = 4 then
    begin
      WinExec('C:\Program Files (x86)\TeamViewer\TeamViewer.exe', sw_show);
    end
  else if IndexProgram = 5 then
    begin
      WinExec('C:\Users\AGSNote\Documents\Delphi AGS\AGS Adm\Atualizar.bat', SW_SHOW);
    end
  else if IndexProgram = 6 then
    begin
      WinExec('C:\AgsSoftware\Exe\AtualizaAGSFDB.bat', SW_SHOW);
    end;
end;
//--------------------------------------====<  >====-------------------------------------\\

//------====< DEFINE O ESTADO DOS COMPOENTES QUE ESTIVEREM NA ARRAY D E COMPONENTES >====------\\
procedure Acoes.Estado(Components: array of TComponent; State: Boolean);
var
  i: Integer;
begin
  for i := 0 to Length(Components) - 1 do
    begin
    if (Components[i] is TEdit) then
      begin
        (Components[i] as TEdit).Enabled:= State;
      end
    else if (Components[i] is TMaskEdit) then
      begin
        (Components[i] as TMaskEdit).Enabled:= State;
      end
    else if (Components[i] is TPanel) then
      begin
        (Components[i] as TPanel).Enabled:= State;
      end;
    end;
end;
//--------------------------------------====<  >====-------------------------------------\\

//------====< LIMPA OS CAMPOS QUE ESTÃO DENTRO DA ARRAY DE COMPONENTES >====-------------\\
procedure Acoes.LimpaCampos(Components: array of TComponent);
var
  i: Integer;
begin
  for i := 0 to length(Components) -1 do
    begin
    if (Components[i] is TEdit) then
      begin
        (Components[i] as TEdit).Clear;
      end
    else if (Components[i] is TMaskEdit) then
      begin
        (Components[i] as TMaskEdit).Clear;
      end
    else if (Components[i] is TMemo) then
      begin
        (Components[i] as TMemo).Clear;
      end;
    end;
end;
//--------------------------------------====<  >====-------------------------------------\\


//------====< [AÇÕES EXECUTADAS DENTRO DA CLASSE DE EXIBIÇÃO DOS SERVIÇOS] >====---------\\

//------====< PEGAR UM PARÂMETRO E CONVERTÊ-LO PARA UM ESTADO DE UM CHECKBOX >====------\\
procedure CardServico.AtualizaCard(List: TListBox);
var
  ListaServicos: TListBox;
  NomeCartao: string;
begin
 // ListaServicos:= TListBox(FrIndex.FindComponent('lstServicos'));
  ListaServicos.Clear;
 // CriaCard(FrIndex.lstServicos);
end;
//--------------------------------------====<  >====-------------------------------------\\

//------====< CRIAR CARTÃO DE SERVIÇO DA TELA PRINCIPAL >====------\\
procedure CardServico.CriaCard(List: TListBox);
var
  Card: TPanel;
  Situacao, Servico, Data: TLabel;
  DataAtual: string;
  HoraAtual: string;
begin
  try
  {Contagem:= 0;

  FrIndex.QrServicos.Close;
  FrIndex.QrServicos.SQL.Clear;
  FrIndex.QrServicos.SQL.Text:= 'SELECT * FROM SERVICOS WHERE ATENDENTE = :ATENDENTE';
  FrIndex.QrServicos.Params[0].Value:= FrIndex.QrSetupATENDENTE.Value;
  FrIndex.QrServicos.Open;

  while FrIndex.QrServicos.Eof = False do
    begin
    Contagem:= Contagem + 1;
    Card:= TPanel.Create(Application);
    Card.ParentColor:= False;
    Card.Color:= clGradientInactiveCaption;
    Card.Name:= 'SvcCard' + IntToStr(Contagem);
    Card.Caption:= '';
    Card.Parent:= List;
    Card.Align:= alTop;
    Card.Height:= 70;
    Card.BevelOuter:= bvNone;
    Card.BevelInner:= bvNone;
    Card.BevelKind:= bkNone;
    Situacao:= TLabel.Create(Application);
    Situacao.Name:= 'LblSit' + IntToStr(Contagem);
    Situacao.Parent:= Card;
    Situacao.ParentColor:= False;
    DataAtual:= FormatDateTime('dd/mm/yyyy', Now);
    HoraAtual:= FormatDateTime('hh:mm', Now);
    if FrIndex.QrServicosDATAPREV.Value < StrToDate(DataAtual) then
      begin
        Situacao.Font.Color:= clRed;
        Situacao.Caption:= '@----<X>---|---====< [ ATRASADO ] >====---|---<X>----@';
      end
    else if FrIndex.QrServicosDATAPREV.Value = StrToDate(DataAtual) then
      begin
      if StrToTime(FrIndex.QrServicosHORAPREV.Value) < StrToTime(HoraAtual) then
        begin
          Situacao.Font.Color:= clRed;
          Situacao.Caption:= '@----<X>---|---====< [ ATRASADO ] >====---|---<X>----@';
        end
      else
        begin
          Situacao.Font.Color:= clBlue;
          Situacao.Caption:= '@---<X>---|---====< [ PARA HOJE ] >====---|---<X>----@';
        end;
      end
    else
      begin
        Situacao.Font.Color:= clLime;
        Situacao.Caption:= '@----<X>---|---====< [ NO PRAZO ] >====---|---<X>----@';
      end;
    Situacao.Font.Size:= 7;
    Situacao.Align:= alTop;
    Situacao.Alignment:= taCenter;
    Servico:= TLabel.Create(Application);
    Servico.Parent:= Card;
    Servico.AlignWithMargins:= True;
    Servico.Margins.Top:= 0;
    Servico.Margins.Bottom:= 0;
    Servico.Margins.Right:= 0;
    Servico.Margins.Left:= 5;
    Servico.Name:= 'LblSrv' + IntToStr(Contagem);
    Servico.Caption:= FrIndex.QrServicosSERVICO.Value;
    Servico.WordWrap:= True;
    Servico.Align:= alClient;
    Servico.Alignment:= taLeftJustify;
    Data:= TLabel.Create(Application);
    Data.Parent:= Card;
    Data.Name:= 'LblDt' + IntToStr(Contagem);
    Data.Caption:= 'Previsão: ' + DateToStr(FrIndex.QrServicosDATAPREV.Value) + ' - ' + FrIndex.QrServicosHORAPREV.Value + '  ';
    Data.Font.Size:= 7;
    Data.Align:= alBottom;
    Data.Alignment:= taRightJustify;
    FrIndex.QrServicos.Next;
    end; }
  except
    //FrIndex.tmrAtualizaServicos.Enabled:= false;
  end;
end;
//--------------------------------------====<  >====-------------------------------------\\

//------------------------====< ABRIR UMA TELA NO PROGRAMA >====-------------------------\\
procedure Acoes.AbreTela(CdScreen: string);
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
procedure Acoes.CloseScreens;
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
//------====< [AÇÕES EXECUTADAS PARA A PARTE DE ACESSO REMOTO DO PROGRAMA] >====---------\\
procedure AcessoTS.EnterTS(Index: Integer);
begin
  if Index = 0 then
    begin
      WinExec('',SW_HIDE);
    end;
  if Index = 1 then
    begin
      WinExec('mstsc /v 172.16.35.9 /f',SW_HIDE);
    end;
  if Index = 2 then
    begin
      WinExec('mstsc /v fachimacessorios.ddns.net:42333 /f',SW_HIDE);
    end;
  if Index = 3 then
    begin
      WinExec('mstsc /v 172.16.45.11 /f',SW_HIDE);
    end;
  if Index = 4 then
    begin
      WinExec('mstsc /v 189.50.142.178:59901 /f',SW_HIDE);
    end;
  if Index = 5 then
    begin
      WinExec('mstsc /v 172.16.33.11 /f',SW_HIDE);
    end;
  if Index = 6 then
    begin
      WinExec('mstsc /v miraalimentos.ddns.net:7171 /f',SW_HIDE);
    end;
  if Index = 7 then
    begin
      WinExec('mstsc /v 200.95.223.18 /f',SW_HIDE);
    end;
  if Index = 8 then
    begin
      WinExec('mstsc /v 172.16.35.10 /f',SW_HIDE);
    end;
  if Index = 9 then
    begin
      WinExec('mstsc /v 192.168.0.253 /f',SW_HIDE);
    end;
  if Index = 10 then
    begin
      WinExec('mstsc /v vertexts.ddns.net:49649 /f',SW_HIDE);
    end;
  if Index = 11 then
    begin
      WinExec('mstsc /v 177.39.197.167 /f',SW_HIDE);
    end;
  if Index = 12 then
    begin
      WinExec('mstsc /v 172.16.35.11 /f',SW_HIDE);
    end;
end;

procedure AcessoTS.ShowUsers(Index: Integer);
begin
  {with FrIndex do
    begin
    if Index = 0 then
      begin
        EdtUsuario.Text := '';
        EdtSenha.Text   := '';
      end;
    if Index = 1 then
      begin
        EdtUsuario.Text := 'extra.1';
        EdtSenha.Text   := 'vpn@1020';
      end;
    if Index = 2 then
      begin
        EdtUsuario.Text := 'ags';
        EdtSenha.Text   := 'fachim@1';
      end;
    if Index = 3 then
      begin
        EdtUsuario.Text := 'ags';
        EdtSenha.Text   := 'ags@1020';
      end;
    if Index = 4 then
      begin
        EdtUsuario.Text := 'ags';
        EdtSenha.Text   := 'Mirassol@#$147';
      end;
    if Index = 5 then
      begin
        EdtUsuario.Text := 'cliente';
        EdtSenha.Text   := 'max@1020';
      end;
    if Index = 6 then
      begin
        EdtUsuario.Text := 'AGS';
        EdtSenha.Text   := 'Mirassol@Jaci147';
      end;
    if Index = 7 then
      begin
        EdtUsuario.Text := 'AGS';
        EdtSenha.Text   := 'Mirassol@Jaci147';
      end;
    if Index = 8 then
      begin
        EdtUsuario.Text := 'compras.01';
        EdtSenha.Text   := 'sh@1020';
      end;
    if Index = 9 then
      begin
        EdtUsuario.Text := 'Credenciais não solicitadas';
        EdtSenha.Text   := 'Credenciais não solicitadas';
      end;
    if Index = 10 then
      begin
        EdtUsuario.Text := 'administrator';
        EdtSenha.Text   := 'VERTEX2022vertex';
      end;
    if Index = 11 then
      begin
        EdtUsuario.Text := 'Credenciais não solicitadas';
        EdtSenha.Text   := 'Credenciais não solicitadas';
      end;
    if Index = 12 then
      begin
        EdtUsuario.Text := 'ags';
        EdtSenha.Text   := 'sm@1020';
      end;
    end;}
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



{ connectionServices }

{
function connectionServices.fbconnectWithString(base: string;
  conexao: TFDConnection; modelo: integer): boolean;
begin
  With conexao do
    begin
    try
      Params.Database:= base;
      Connected:= True;
    if modelo = 1 then
      begin
        ConectadoB:= true;
      end
    else if modelo = 2 then
      begin
        ConectadoV:= true;
      end;
    except on E: Exception do
      begin
      if modelo = 1 then
        begin
          ConectadoB:= false;
        end
      else if modelo = 2 then
        begin
          ConectadoV:= false;
        end;
        raise Exception.Create('ERRO AO CONECTAR COM A BASE! - ' + E.Message);
      end;
    end;
    end;
end;}
end.

