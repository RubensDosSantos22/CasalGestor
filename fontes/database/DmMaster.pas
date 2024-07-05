unit DmMaster;

interface

uses
    {$REGION 'Uses do Projeto'}

  System.SysUtils,
  System.Classes,
  System.DateUtils,
  System.IOUtils,
  System.Rtti,
  System.Net.HttpClient {Androidapi.Helpers},
  System.Generics.Collections,
  System.Types,
  System.UITypes,
  System.Variants,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Phys.FBDef,
  FireDAC.Comp.DataSet,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.DatS,
  FireDAC.Phys.FB,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.StdCtrls, Data.DB, FireDAC.FMXUI.Wait, FireDAC.Comp.UI,
  FireDAC.Stan.StorageJSON,
  Winapi.Windows, Winapi.Messages, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

    {$ENDREGION}
type

  TDm = class(TDataModule)
    QrFBSelect1: TFDQuery;
    QrFBSelect2: TFDQuery;
    QrFBSelect3: TFDQuery;
    QrFBUpdate: TFDQuery;
    QrFBInsert: TFDQuery;
    QrFBDelete: TFDQuery;
    Confb: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    QrCT_PAGAR: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);

    {$ENDREGION}

  private
    { Private declarations }
  public
    BaseExiste: boolean;

  end;

  {$REGION 'Fun��es da Classe de Queries do FireDac (TFB)'}

  TFB = class
    procedure setQuery(Qr: integer);


    /// <summary>
    ///   Fun��o respons�vel pelos selects do aplicativo
    /// </summary>
    /// <param name="tables"> Tabelas que o select ir� puxar. ! CAMPO OBRIGAT�RIO ! </param>
    /// <param name="fieldstr"> Campos a serem retornados (Opcional. Se n�o prenchido, retornar� todos os campos) </param>
    /// <param name="joins"> Relacionamentos entre uma tabela e outra (Tabela1.ID = Tabela2.ID) </param>
    /// <param name="where"> Outras condi��es a serem executadas</param>
    /// <param name="order"> Ordena��o dos resultados da consulta </param>
    ///
    procedure select(tables: string; fieldstr: string = ''; joins: string = ''; where: string = ''; order: string = '');


    /// <summary>
    ///   Fun��o respons�vel pelos par�metros dos Selects
    /// </summary>
    /// <param name="parameter"> Array qeu gaurda os valores dos par�metros ( [ valor1, valor2, valor3... ] )</param>
    /// <param name="parameter_name"> Array com os nomes dos par�metros definidos dentro do select ! OBRIGAT�RIAMENTE ID�NTICOS AOS NOMES DO SELECT !</param>
    ///
    procedure parameters(parameter: array of variant; parameter_name: array of string);

    /// <summary>
    ///     Fun��o que retorna o valor do campo informado
    /// </summary>
    /// <param name="field_name"> Nome do campo a puxar o valor </param>
    /// <returns> Valor do campo que foi preenchido em field_name </returns>
    ///
    function vlrField(field_name: string): Variant;

    /// <summary>
    ///     Fun��o respons�vel pelos inserts de cada formul�rio (Para preenchimento dos valores, se usar� a fun��o parameters)
    /// </summary>
    /// <param name="table"> Tabela em que ocorrer� o insert </param>
    /// <param name="fields_names"> Array de campos em que ser�o inseridos os valores </param>
    ///
    procedure insert(table: string; fields_names: array of string);

    /// <summary>
    ///     Fun��o para pegar o valor de chave �nica (id)
    /// </summary>
    /// <param name="retorno"> vari�vel do id</param>
    /// <returns> Valor do pr�ximo id a ser inserido na tabela</returns>
    ///
    function takeID: Integer;

    /// <summary>
    ///     Fun��o respons�vel por deletar registros das tabelas
    /// </summary>
    /// <param name="table"> tabela em que ser� efetuado o delete</param>
    /// <param name="chave"> Campo chave do registro em que ser� deletado. Se n�o for preenchido, apagar� a tabela inteira </param>
    /// <param name="id"> chave do registro em que ser� deletado. Apenas se o campo chave for prenchido </param>
    procedure delete(table: string; chave: string = ''; id: integer = 0);

    procedure update(table: string; fields_names: array of string; id: integer);


    function fimDeArquivo: Boolean;

    procedure percorreQuery(Acao: Tproc);
  end;
  {$ENDREGION}

  {$REGION 'Fun��es da Classe Query (Sempre Abaixo da TFB)'}

  Query = class
    function FB: TFB;
  end;

  {$ENDREGION}

  {$REGION 'Fun��es da Classe Tempo'}

  Tempo = class
    function Hoje: string;
  end;


  {$ENDREGION}

var

  {$REGION 'Declara��o das Vari�veis usadas para a parte dos dados'}

    QryFb: TFDQuery;
    crud_command_type: string;
    command_fields : array of string;

  {$ENDREGION}


  function CheckInternet: Boolean;
  function ConnectFBase: Boolean;

var
  Dm: TDm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}


function GetResourceStream(const ResName: string): TStream;
begin
  Result := TResourceStream.Create(HInstance, ResName, RT_RCDATA);
end;


{$R *.dfm}

    {$REGION 'Verifica��es Conex�o com a  Internet'}

function CheckInternet: boolean;
var
  http : THTTPClient;
begin
  Result := false;

  try
    http := THTTPClient.Create;

    try
      Result := http.Head('https://google.com.br').StatusCode < 400;
    except
    end;
  finally
    http.DisposeOf;
  end;
end;

function ConnectFBase: Boolean;
begin
  //pass
end;
    {$ENDREGION}

    {$REGION 'Tempo'}

function Tempo.Hoje: string;
begin
  result:= FormatDateTime('dd/mm/yyyy',now);
end;
    {$ENDREGION}

    {$REGION 'TFB'}

procedure TFB.delete(table, chave: string; id: integer);
var
  insert_final: string;
begin
  insert_final:= 'DELETE FROM ' + table;

  if chave = '' then
    insert_final:= insert_final + ' WHERE ID = :ID';

  with Dm.QrFBDelete do
    begin
      Close;
      SQL.Clear;
      SQL.Text:= insert_final;

    if chave = '' then
      Params[0].Value:= id;

      ExecSQL;
    end;
end;

function TFB.fimDeArquivo: Boolean;
begin
  Result:= QryFb.Eof;
end;

procedure TFB.insert(table: string; fields_names: array of string);
var
  insert_final: string;
  i: Integer;
begin
  crud_command_type:= 'INSERT';

  insert_final:= 'INSERT INTO ' + table + ' (';

  for i := 0 to length(fields_names) -1 do
    begin

    if i = 0 then
      insert_final:= insert_final + fields_names[i]
    else
      insert_final:= insert_final + ', ' + fields_names[i];
    end;

  insert_final:= insert_final +  ') VALUES ( ';

  for i := 0 to length(fields_names) -1 do
    begin

    if i = 0 then
      insert_final:= insert_final + ' :' + fields_names[i]
    else
      insert_final:= insert_final + ', :' + fields_names[i];
    end;

  insert_final:= insert_final + ')';


  with Dm.QrFBInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text:= insert_final;
    end;

end;

procedure TFB.parameters(parameter: array of variant;
  parameter_name: array of string);
var
  i: Integer;
begin

  if crud_command_type = 'SELECT' then
    begin

    with QryFb do
      begin
      for i := 0 to length(parameter) -1 do
        begin
          ParamByName(parameter_name[i]).Value:= parameter[i];
        end;

        Open;
      end;
    end
  else if crud_command_type = 'INSERT' then
    begin

    with Dm.QrFBInsert do
      begin
      for i := 0 to length(parameter) -1 do
        begin
          ParamByName(command_fields[i]).Value:= parameter[i];
        end;

        ExecSQL;
      end;
    end
  else if crud_command_type = 'UPDATE' then
    begin

    with Dm.QrFBUpdate do
      begin
      for i := 0 to length(parameter) -1 do
        begin
          ParamByName(command_fields[i]).Value:= parameter[i];
        end;

        ExecSQL;
      end;
    end;
end;


procedure TFB.percorreQuery(Acao: Tproc);
begin

  while QryFb.Eof = False do
    begin
      Acao;
      QryFb.Next;
    end;
end;

procedure TFB.select(tables, fieldstr, joins, where, order: string);
var
  finalSelect: string;
begin
  crud_command_type:= 'SELECT';

  if fieldstr <> '' then //SE O PAR�METRO FIELDSTR N�O ESTIVER PREENCHIDO, SER� DADO UM SELECT *
    begin
      finalSelect:= 'SELECT ' + fieldstr + ' FROM ';
    end
  else
    begin
      finalSelect:= 'SELECT * FROM ';
    end;

  finalSelect:= finalSelect + tables;

  if joins <> '' then //SE O PAR�METRO JOINS ESTIVER PREENCHIDO, ELE ADICIONA AO SELECT
    begin
      finalSelect:= finalSelect + ' WHERE ' + joins;
    end;

  if (where <> '') and (joins <> '') then //SE O PAR�METRO JOINS ESTIVER PREENCHIDO, ELE ADICIONA AO SELECT
    begin
      finalSelect:= finalSelect + ' AND ' + where;
    end
  else if (where <> '') then
    begin
      finalSelect:= finalSelect + ' WHERE ' + where;
    end;

  if order <> '' then //SE O PAR�METRO ORDER ESTIVER PREENCHIDO, ELE ADICIONA AO SELECT
    begin
      finalSelect:= finalSelect + ' ORDER BY ' + order;
    end;

  with QryFb do
    begin
      Close;
      SQL.Clear;
      SQL.Text:= finalSelect;

    if (where = '') then
      Open;
    end;
end;


procedure TFB.setQuery(Qr: integer);
begin

  if Qr = 1 then
    QryFb:= Dm.QrFBSelect1
  else if Qr = 2 then
    QryFb:= Dm.QrFBSelect2
  else
    QryFb:= Dm.QrFBSelect3;
end;

function TFB.takeID: Integer;
begin
  with QryFb do
    begin
    if Eof = true then
      begin
        Result:= 1;
      end
    else
      begin
        Result:= vlrField('ID') + 1;
      end;
    end;
end;

procedure TFB.update(table: string; fields_names: array of string; id: integer);
var
  update_final: string;
  i: Integer;
begin
  crud_command_type:= 'UPDATE';

  update_final:= 'UPDATE ' + table + ' SET ';

  for i := 0 to length(fields_names) -1 do
    begin

    if i = 0 then
      update_final:= update_final + fields_names[i] + ' = :' + fields_names[i]
    else
      update_final:= update_final + ', ' + fields_names[i] + ' = :' + fields_names[i];
    end;

  update_final:= update_final + ' WHERE ID = ' + IntToStr(id);

  with Dm.QrFBUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text:= update_final;
    end;

end;


function TFB.vlrField(field_name: string): Variant;
begin
  Result:= QryFb.FieldByName(field_name).Value;
end;

    {$ENDREGION}

    {$REGION 'Query'}

function Query.FB: TFB;
begin
  Result:= TFB.Create;
end;

procedure TDm.DataModuleCreate(Sender: TObject);
var
  DataPath: string;
  ResourceStream: TStream;
  FileStream: TFileStream;
  caminho: string;
begin

  caminho:= ExtractFilePath(ParamStr(0)) + 'database\';

  if not DirectoryExists(caminho) then
  begin
    // Se n�o existir, criar a pasta
    if not CreateDir(caminho) then
    begin
      // Se n�o foi poss�vel criar a pasta, mostrar uma mensagem de erro
      ShowMessage('Erro ao criar a pasta.');
      Exit; // Sair da fun��o
    end;
  end;

  DataPath := caminho + '\Data.FDB';

  // Verifica se o banco de dados j� existe na pasta Data
  if not FileExists(DataPath) then
  begin
    // Se n�o existir, copia o banco de dados dos recursos para a pasta Data
    ResourceStream := GetResourceStream('Resource_5');

    try
      FileStream := TFileStream.Create(DataPath, fmCreate);
      try
        FileStream.CopyFrom(ResourceStream, ResourceStream.Size);
      finally
        FileStream.Free;
      end;
    finally
      ResourceStream.Free;
    end;
  end;

  try

  if Dm.Confb.Connected then
    Dm.Confb.Connected:= False;
    Dm.Confb.Params.Database:= DataPath;
    Dm.Confb.Connected:= True;
  except
    try
    Dm.Confb.Connected:= False;
    Dm.Confb.Params.Database:= DataPath;
    Dm.Confb.Connected:= True;
    except
      ShowMessage('N�o foi poss�vel conectar/reconectar ao banco');
    end;
  end;

end;

    {$ENDREGION}
end.
