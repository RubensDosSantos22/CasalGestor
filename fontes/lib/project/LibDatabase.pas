unit LibDatabase;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,System.Win.Registry;
  type
    Buscar = class
      procedure Clientes(TypeShare: string);
      procedure Processos(TypeShare: string);
      procedure Conversoes;
      procedure AbrePesquisa;
      procedure Pesquisar;
    end;
  type
    DatabaseActions = class
      procedure Insere;
      procedure Exclui;
      procedure Edita;
      procedure ExcluiProcesso;
      procedure InsereProcesso;
      procedure EditaProcesso;

      procedure commandOnSrting_nopar(Qr: TFDQuery; txt: string);
      procedure commandOfsql(Qr: TFDQuery; txt: string);
      procedure commandOfTxt(Qr: TFDQuery; txt: string; output: TMemo; titulo: string);
      procedure configAlias(alias: string; addressFile: string);
      procedure copyTable(Tables, OrigniDb, TargetDb: string; QrTarget, QrOrigin: TFDQuery);
    end;
  type
    ConsultaComFiltro = class
      procedure SetComboFilter(IndiceCombo: Integer; FilterValues: array of Integer);
      procedure SetNumberFilter(IntFilter:Integer; DoubleFilter: Double; FilterIntValues: array of Integer; FilterDoubleValues: array of Double);
      procedure SetTextFilter(StrFilter: string; FilterValues: array of string);
      procedure SetDateFilter(StartDate, EndDate: string);
      procedure SetLikeFilter(Field: string; FieldLike: string);
      procedure SetJoinFilter(Filter: string);
      procedure AbreConsulta;
    end;
    procedure ConvertDate(Date:string);
  var
    Tipo          : array [0..10] of string;
    Parameter     : array [0..10] of string;
    Key           : array [0..10] of Integer;
    Control       : array [0..10] of string;
    Auxiliar      : array [0..10] of string;
    ChaveAcesso   : array [0..20] of string;
    Action        : string;
    FoneAction    : string;
    ItemAction    : string;
    ConvertedDate : string;

    ComboFilter,
    NumberFilter,
    TexteFilter,
    TextFilter,
    DateFilter,
    LikeFilter,
    JoinFilter,
    IndexFilter: string;
    ActualScreen : Tform;
    LiberaAcesso: boolean;
    i: integer;
implementation
//uses UnClientes, UnSetup, UnFinalizaConversao, UnProcessos, UnNovoProcesso, UnMultiempresa, UnConversoes;
procedure ConvertDate(Date:string);
var
  DataAntes, Dia, Mes, Ano: string;
begin
  DataAntes:= Date;
  Dia:= copy(DataAntes, 0, 2);
  Mes:= copy(DataAntes, 4, 2);
  Ano:= copy(DataAntes, 7, 4);
  ConvertedDate:= Ano + '-' + Mes + '-' + Dia;
end;

// ---- AÇÕES DE BUSCA E PESQUISA NA BASE DE DADOS ----\\
procedure Buscar.AbrePesquisa;
var
  QueryDePesquisa: TFDQuery;
begin
  QueryDePesquisa:= TFDQuery(ActualScreen.FindComponent('QrPesquisa'));
 { with QueryDePesquisa do
    begin
      Close;
      SQL.Clear;
      if ActualScreen = FrClientes then
        begin
          SQL.Text:= 'SELECT * FROM CLIENTES ORDER BY C_NOME';
        end
      else if ActualScreen = FrFinalizaConversao then
        begin
          SQL.Text:= 'SELECT * FROM CON_CONVERSAO';
        end
      else if (ActualScreen = FrProcessos) or (ActualScreen = FrNovoProcesso) then
        begin
          SQL.Text:= 'SELECT * FROM PROCESSOS';
        end
      else if (ActualScreen = FrMultiempresa) then
        begin
          SQL.Text:= 'SELECT * FROM CON_EMPRESAS ORDER BY E_CLIENTE';
        end;
      Open;
    end; }
end;

procedure Buscar.Clientes(TypeShare: string);
var
  QueryDePesquisa: TFDQuery;
begin
  QueryDePesquisa:= TFDQuery(ActualScreen.FindComponent('QrClientes'));
  if TypeShare = 'DBF_CLIENTS' then
    begin
    with QueryDePesquisa do
      begin
        Close;
        SQL.Clear;
        SQL.Text:= 'SELECT * FROM DBF_CLIENTS';
        Open;
      end;
    end
  else if TypeShare = 'ALL_CLIENTS' then
    begin
    with QueryDePesquisa do
      begin
        Close;
        SQL.Clear;
        SQL.Text:= 'SELECT ID, C_NOME FROM CLIENTES ORDER BY C_NOME';
        Open;
      end;
    end;

end;
procedure Buscar.Conversoes;
var
  QueryDePesquisa: TFDQuery;
begin
  QueryDePesquisa:= TFDQuery(Screen.FindComponent('QrClientes'));
  with QueryDePesquisa do
    begin
      Close;
      SQL.Clear;
      SQL.Text:= 'SELECT ID, CV_CLIENTE FROM CONVERSOES WHERE CV_CLIENTE = :CLIENTE';
      Params[0].Value:= Key[1];
      Open;
    end;
end;
procedure Buscar.Pesquisar;
var
  QueryDePesquisa: TFDQuery;
  EditPesquisa: TEdit;
begin
  QueryDePesquisa:= TFDQuery(ActualScreen.FindComponent('QrPesquisa'));
  EditPesquisa:= TEdit(ActualScreen.FindComponent('EdtPesquisa'));
  {with QueryDePesquisa do
    begin
      Close;
      SQL.Clear;
      if ActualScreen = FrClientes then
        begin
          SQL.Text:= 'SELECT * FROM CLIENTES WHERE C_NOME LIKE ' + '''' + UpperCase(EditPesquisa.Text) + '%' + '''' + ' ORDER BY C_NOME';
        end
      else if ActualScreen = FrFinalizaConversao then
        begin
          SQL.Text:= 'SELECT * FROM CON_CONVERSAO WHERE C_NOME LIKE ' + '''' + UpperCase(EditPesquisa.Text) + '%' + '''';
        end
      else if (ActualScreen = FrProcessos) or (ActualScreen = FrNovoProcesso) then
        begin
          SQL.Text:= 'SELECT * FROM PROCESSOS WHERE P_NOME LIKE ' + '''' + UpperCase(EditPesquisa.Text) + '%' + '''' + ' ORDER BY P_NOME';
        end;
      Open;
    end; }
end;
procedure Buscar.Processos(TypeShare: string);
var
  QueryDePesquisa: TFDQuery;
begin
  QueryDePesquisa:= TFDQuery(ActualScreen.FindComponent('QrItens'));
  Tipo[1]:= TypeShare;
  with QueryDePesquisa do
    begin
      Close;
      SQL.Clear;
      if Tipo[1] = 'SEARCH_PROCESS' then
        begin
          SQL.Text:= 'SELECT * FROM I_PROCESSOS WHERE IT_PROCESSO = ' + '''' + IntToStr(Key[0]) + '''';
        end
      else
        begin
          SQL.Text:= 'SELECT * FROM I_PROCESSOS WHERE IT_PROCESSO = 999999';
        end;
      Open;
    end;
end;

{ DatabaseActions }
procedure DatabaseActions.commandOfsql(Qr: TFDQuery; txt: string);
begin
with Qr do
    begin
      Close;
      SQL.Clear;
      SQL.LoadFromFile(txt);
      ExecSQL;
    end;
end;
procedure DatabaseActions.commandOfTxt(Qr: TFDQuery; txt: string; output: TMemo; titulo: string);
var
  arq: TextFile;
  linha: string;
begin
  AssignFile(arq, txt);
  {$I-}
  Reset(arq);
  {$I+}
  if (IOResult <> 0)then
    begin
      ShowMessage('Erro na abertura do arquivo !!!');
    end
  else
    begin
    while (not eof(arq)) do
      begin
        readln(arq, linha);
        try
          commandOnSrting_nopar(Qr, linha);
        except
        end;
        output.Lines.Add(titulo + ': ' + linha);
      end;
    CloseFile(arq);
    end;
end;
procedure DatabaseActions.commandOnSrting_nopar(Qr: TFDQuery; txt: string);
begin
  with Qr do
    begin
      Close;
      SQL.Clear;
      SQL.Text:= txt;
      ExecSQL;
    end;
end;
procedure DatabaseActions.configAlias(alias, addressFile: string);
var
  R: TRegistry;
begin

  R:= TRegistry.Create;
  R.RootKey:= HKEY_CURRENT_USER;

  if R.KeyExists('Software\ODBC\ODBC.INI\' + alias) = True then
    begin
      R.OpenKey('Software\ODBC\ODBC.INI\' + alias, true);
      R.WriteString('Dbname', addressFile);
    end
  else
    begin
      R.Free;
      R         := TRegistry.Create;
      R.RootKey := HKEY_LOCAL_MACHINE;

    if R.KeyExists('Software\WOW6432Node\ODBC\ODBC.INI\' + alias) = True then
      begin
         R.OpenKey('Software\WOW6432Node\ODBC\ODBC.INI\' + alias, true);
         R.WriteString('Dbname', addressFile);
      end;
    if R.KeyExists('Software\ODBC\ODBC.INI\' + alias) = True then
      begin
         R.OpenKey('Software\ODBC\ODBC.INI\' + alias, true);
         R.WriteString('Dbname', addressFile);
      end;
    end;
    try
      R.Free;
    except
    end;
end;

procedure DatabaseActions.copyTable(Tables, OrigniDb, TargetDb: string;
  QrTarget, QrOrigin: TFDQuery);
var
  arq: TextFile;
  linha: string;
  campos: string;
begin
  AssignFile(arq, Tables);
  {$I-}
  Reset(arq);
  {$I+}
  if (IOResult <> 0)then
    begin
      ShowMessage('Erro na abertura do arquivo !!!');
    end
  else
    begin
    while (not eof(arq)) do
      begin
        readln(arq, linha);
        try
        with QrTarget do
          begin
            Close;
            SQL.Clear;
            SQL.Text:= 'SELECT RDB$RELATION_NAME AS TABELA FROM RDB$RELATION_FIELDS WHERE RDB$RELATION_NAME = ' + '''' + linha + '''';
            Open;
          end;
        if QrTarget.Eof = false then
          begin
          with QrTarget do
            begin
              Close;
              SQL.Clear;
              SQL.Text:= 'DROP TABLE ' + linha;
              ExecSQL;
            end;
          end;
        with QrOrigin do
          begin
            Close;
            SQL.Clear;
            SQL.LoadFromFile('A:\PhoneAgend2\Txt\Select_campos_da_tabela.sql');
            Params[0].Value:= linha;
            Open;
          end;
        with QrTarget do
          begin
            Close;
            SQL.Clear;
            SQL.Text:= 'CREATE TABLE ' + linha + ' ( ';
            campos:= '';
          for i := 0 to QrOrigin.RecordCount - 2 do
            begin
            with SQL do
              begin
              if (QrOrigin.FieldByName('TIPO').AsString = 'VARCHAR') or (QrOrigin.FieldByName('TIPO').AsString = 'NUMERIC') or (QrOrigin.FieldByName('TIPO').AsString = 'DECIMAL') or (QrOrigin.FieldByName('TIPO').AsString = 'CHAR') or (QrOrigin.FieldByName('TIPO').AsString = 'BLOB') then
                begin
                if QrOrigin.FieldByName('ESCALA').value = 0 then
                  begin
                    Add(QrOrigin.FieldByName('CAMPO').AsString + ' ' + QrOrigin.FieldByName('TIPO').AsString + '(' + QrOrigin.FieldByName('TAMANHO').AsString + '),');
                  end
                else
                  begin
                    Add(QrOrigin.FieldByName('CAMPO').AsString + ' ' + QrOrigin.FieldByName('TIPO').AsString + '(' + QrOrigin.FieldByName('TAMANHO').AsString + ',' + QrOrigin.FieldByName('ESCALA').AsString + '),');
                  end;
                end
              else
                begin
                  Add(QrOrigin.FieldByName('CAMPO').AsString + ' ' + QrOrigin.FieldByName('TIPO').AsString + ',');
                end;
                campos:= campos + QrOrigin.FieldByName('CAMPO').AsString + ' ';
              end;
              QrOrigin.Next;
            end;
          with SQL do
            begin
            if (QrOrigin.FieldByName('TIPO').AsString = 'VARCHAR') or (QrOrigin.FieldByName('TIPO').AsString = 'NUMERIC') or (QrOrigin.FieldByName('TIPO').AsString = 'DECIMAL') or (QrOrigin.FieldByName('TIPO').AsString = 'CHAR') or (QrOrigin.FieldByName('TIPO').AsString = 'BLOB') then
              begin
              if QrOrigin.FieldByName('ESCALA').value = 0 then
                begin
                  Add(QrOrigin.FieldByName('CAMPO').AsString + ' ' + QrOrigin.FieldByName('TIPO').AsString + '(' + QrOrigin.FieldByName('TAMANHO').AsString + ')');
                end
              else
                begin
                  Add(QrOrigin.FieldByName('CAMPO').AsString + ' ' + QrOrigin.FieldByName('TIPO').AsString + '(' + QrOrigin.FieldByName('TAMANHO').AsString + ',' + QrOrigin.FieldByName('ESCALA').AsString + ')');
                end;
              end
            else
              begin
                Add(QrOrigin.FieldByName('CAMPO').AsString + ' ' + QrOrigin.FieldByName('TIPO').AsString);
              end;
              campos:= campos + QrOrigin.FieldByName('CAMPO').AsString + ' ';
            end;
            SQL.Add(' );');
            ShowMessage(SQL.Text);
            ExecSQL;
          end;
        with QrTarget do
          begin
            Close;
            SQL.Clear;
            SQL.TExt:= 'SELECT * FROM ' + linha;
            Params[0].Value:= linha;
            Open;
          end;
        except
        end;
      end;
    CloseFile(arq);
    end;
end;
procedure DatabaseActions.Edita;
var
  QueryDePesquisa: TFDQuery;
begin
  QueryDePesquisa:= TFDQuery(ActualScreen.FindComponent('QrTrabalho'));
 { with QueryDePesquisa do
    begin
      Close;
      SQL.Clear;
      if ActualScreen = FrClientes then
        begin
          SQL.Text:= 'UPDATE CLIENTES SET C_NOME = :NOME, C_CD = :CD, C_FDB = :FIREBIRD WHERE ID = :ID';
          Params[0].Value:= Parameter[0];
          Params[1].Value:= Parameter[1];
          Params[2].Value:= Parameter[2];
          Params[3].Value:= Key[0];
        end
      else if ActualScreen = FrFinalizaConversao then
        begin
          ConvertDate(Parameter[1]);
          SQL.Text:= 'UPDATE CONVERSOES SET CV_CLIENTE = :CLIENTE, CV_DATA = :DATA, CV_TEMPO = :TEMPO, CV_BRANCO = :BRANCO, CV_VERMELHO = :VERMELHO WHERE ID = :ID';
          Params[0].Value:= StrToInt(Parameter[0]);
          Params[1].Value:= ConvertedDate;
          Params[2].Value:= Parameter[2];
          Params[3].Value:= Auxiliar[0];
          Params[4].Value:= Auxiliar[1];
          Params[5].Value:= Key[0];
        end
      else if ActualScreen = FrNovoProcesso then
        begin
          Close;
          SQL.Clear;
          SQL.Text:= 'UPDATE PROCESSOS SET P_NOME = :NOME, P_INF_ADIC = :INFORMA_ADIC WHERE ID = :IDs';
          Params[0].Value:= Parameter[0];
          Params[1].Value:= Parameter[1];
          Params[2].Value:= Key[0];
          ExecSQL;
        end
      else if ActualScreen = FrMultiempresa then
        begin
          Close;
          SQL.Clear;
          SQL.Text:= 'UPDATE EMPRESAS SET E_NOME = :EMPRESA, E_AGS = :AGS, E_AGS_ = :AGS_ WHERE ID = :ID';
          Params[0].Value:= Parameter[0];
          Params[1].Value:= Parameter[1];
          Params[2].Value:= Parameter[2];
          Params[3].Value:= Key[0];
          ExecSQL;
        end;
      ExecSQL;
    end; }
end;
procedure DatabaseActions.EditaProcesso;
var
  QueryDeTrabalho: TFDQuery;
begin
  QueryDeTrabalho:= TFDQuery(ActualScreen.FindComponent('QrItens'));
  with QueryDeTrabalho do
    begin
      SQL.text:= 'UPDATE I_PROCESSOS SET IT_DESCRICAO = :ITEMDESCRICAO WHERE ID = :ID';
      ParamByName('ITEMDESCRICAO').Value:= Parameter[0];
      ParamByName('ID').Value:= key[1];
      ExecSQL;
    end;
end;
procedure DatabaseActions.Exclui;
var
  QueryDeTrabalho: TFDQuery;
begin
  QueryDeTrabalho:= TFDQuery(ActualScreen.FindComponent('QrTrabalho'));
 { with QueryDeTrabalho do
    begin
      Close;
      SQL.Clear;
      if ActualScreen = FrClientes then
        begin
          Close;
          SQL.Clear;
          SQL.Text:= 'DELETE FROM CLIENTES WHERE ID = :ID';
          Params[0].Value:= Key[0];
        end
      else if ActualScreen = FrFinalizaConversao then
        begin
          SQL.Text:= 'UPDATE CLIENTES SET C_FDB = 0 WHERE ID = :ID';
          Params[0].Value:= Key[1];
          ExecSQL;
          Close;
          SQL.Clear;
          SQL.Text:= 'DELETE FROM CONVERSOES WHERE ID = :ID';
          Params[0].Value:= Key[0];
        end
      else if ActualScreen = FrNovoProcesso then
        begin
          Close;
          SQL.Clear;
          SQL.Text:= 'DELETE FROM I_PROCESSOS WHERE IT_PROCESSO = :PROCESSO ';
          Params[0].Value:= key[0];
          ExecSQL;
          Close;
          SQL.Clear;
          SQL.Text:= 'DELETE FROM PROCESSOS WHERE ID = :ID ';
          Params[0].Value:= key[0];
        end;
      ExecSQL;
    end; }
end;
procedure DatabaseActions.ExcluiProcesso;
var
  QueryDeTrabalho: TFDQuery;
begin
  QueryDeTrabalho:= TFDQuery(ActualScreen.FindComponent('QrItens'));
  with QueryDeTrabalho do
    begin
      Close;
      SQL.Clear;
      SQL.Text:= 'DELETE FROM I_PROCESSOS WHERE ID = :ID ';
      ParamByName('ID').Value:= key[1];
      ExecSQL;
    end;
end;
procedure DatabaseActions.Insere;
var
  QueryDeTrabalho: TFDQuery;
begin
  QueryDeTrabalho:= TFDQuery(ActualScreen.FindComponent('QrTrabalho'));
 { with QueryDeTrabalho do
    begin
      Close;
      SQL.Clear;
      if ActualScreen = FrClientes then
        begin
          SQL.Text:= 'INSERT INTO CLIENTES (C_NOME, C_CD, C_FDB) VALUES (:NOME, :CD, :FIREBIRD)';
          Params[0].Value:= Parameter[0];
          Params[1].Value:= Parameter[1];
          Params[2].Value:= Auxiliar[0];
        end
      else if ActualScreen = FrFinalizaConversao then
        begin
          ConvertDate(Parameter[1]);
          SQL.Text:= 'INSERT INTO CONVERSOES (CV_CLIENTE, CV_DATA, CV_TEMPO, CV_BRANCO, CV_VERMELHO) VALUES (:CLIENTE, :DATA, :TEMPO, :BRANCO, :VERMELHO)';
          Params[0].Value:= StrToInt(Parameter[0]);
          Params[1].Value:= ConvertedDate;
          Params[2].Value:= Parameter[2];
          Params[3].Value:= Auxiliar[0];
          Params[4].Value:= Auxiliar[1];
          ExecSQL;
          Close;
          SQL.Clear;
          SQL.Text:= 'UPDATE CLIENTES SET C_FDB = ' + '''' + '-1' + '''' + ' WHERE ID = :ID';
          Params[0].Value:= StrToInt(Parameter[0]);
        end
      else if ActualScreen = FrMultiempresa then
        begin
          SQL.Text:= 'INSERT INTO EMPRESAS (E_NOME, E_AGS, E_AGS_) VALUES (:EMPRESA, :AGS, :AGS_)';
          Params[0].Value:= Parameter[0];
          Params[1].Value:= Parameter[1];
          Params[2].Value:= Parameter[2];
        end
      else if ActualScreen = FrNovoProcesso then
        begin
          
        end;
      ExecSQL;
    end;  }
end;
procedure DatabaseActions.InsereProcesso;
var
  QueryDePesquisa: TFDQuery;
begin
  QueryDePesquisa:= TFDQuery(ActualScreen.FindComponent('QrItens'));
  with QueryDePesquisa do
    begin
      SQL.Text:= 'INSERT INTO I_PROCESSOS (IT_PROCESSO, IT_DESCRICAO) VALUES (:PROCESSO, :DESCRICAO)';
      Params[0].Value:= StrToInt(Parameter[0]);
      Params[1].Value:= Parameter[1];
      ExecSQL;
    end;
end;

{ ConsultaComFiltro }
procedure ConsultaComFiltro.AbreConsulta;
var
  Queryconsulta: TFDQuery;
begin
  Queryconsulta:= TFDQuery(ActualScreen.FindComponent('QrConsultaConversoes'));
  with QueryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Text:= 'SELECT * FROM CON_CONVERSAO WHERE CV_DATA <> '+ '''' + '1899-12-31' + '''' + ComboFilter + NumberFilter + DateFilter + TextFilter + LikeFilter + JoinFilter + IndexFilter + ' ORDER BY CV_DATA';
      Open;
    end;
end;
procedure ConsultaComFiltro.SetComboFilter(IndiceCombo: Integer;
  FilterValues: array of Integer);
begin
  ComboFilter:= '';
 { if ActualScreen = FrConversoes then
    begin
    if IndiceCombo = 0 then
      begin
        ComboFilter:= ComboFilter + ' AND CV_BRANCO = ' + '''' + '-1' + '''' + ' AND CV_VERMELHO = ' + '''' + '0' + '''';
      end
    else if IndiceCombo = 1 then
      begin
        ComboFilter:= ComboFilter + ' AND CV_BRANCO = ' + '''' + '-1' + '''' + ' AND CV_VERMELHO = ' + '''' + '-1' + '''';
      end
    else if IndiceCombo = 2 then
      begin
        ComboFilter:= ComboFilter + '';
      end;
    end; }
end;
procedure ConsultaComFiltro.SetDateFilter(StartDate, EndDate: string);
begin
  DateFilter:= '';
{ if ActualScreen = FrConversoes then
    begin
    if StartDate <> '  /  /    ' then
      begin
        ConvertDate(StartDate);
        DateFilter:= DateFilter + ' AND CV_DATA >= ' + '''' +  ConvertedDate + '''';
      end
    else
      begin
        DateFilter:= DateFilter + '';
      end;
    if EndDate <> '  /  /    '  then
      begin
        ConvertDate(EndDate);
        DateFilter:= DateFilter + ' AND CV_DATA <= ' + '''' + ConvertedDate + '''';
      end
    else
      begin
        ConvertDate(DateTimeToStr(Now));
        DateFilter:= DateFilter + ' AND CV_DATA <= ' + '''' + ConvertedDate + '''';
      end;
    end;}
end;
procedure ConsultaComFiltro.SetJoinFilter(Filter: string);
begin
  JoinFilter:= ''
end;
procedure ConsultaComFiltro.SetLikeFilter(Field, FieldLike: string);
begin
  LikeFilter:= '';
end;
procedure ConsultaComFiltro.SetNumberFilter(IntFilter: Integer;
  DoubleFilter: Double; FilterIntValues: array of Integer;
  FilterDoubleValues: array of Double);
begin
  NumberFilter:= '';
end;
procedure ConsultaComFiltro.SetTextFilter(StrFilter: string;
  FilterValues: array of string);
begin
  TextFilter:= '';
end;
end.
