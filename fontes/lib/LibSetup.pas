unit LibSetup;

interface

uses
    System.JSON,
    System.JSON.BSON,
    System.JSON.Builders,
    System.JSON.Converters,
    System.JSON.Readers,
    System.JSON.Serializers,
    System.JSON.Types,
    System.JSON.Utils,
    System.JSON.Writers,
    System.JSONConsts,
    System.SysUtils,
    System.Classes,
    System.DateUtils,
    System.IOUtils,
    System.Rtti,
    System.Net.HttpClient {Androidapi.Helpers},
    System.Generics.Collections,
    System.Types,
    System.UITypes,
    System.Variants;

type
    TPrm = class
     private
        TdefaultPath: string;
        Tinstalled: string;

     public
        property defaultPath                          : string      read TdefaultPath           write TdefaultPath;
        property installed                            : string      read Tinstalled             write Tinstalled;

    end;

    TBkp = class

    end;

    TUsr = class

    end;

    TSys = class

    end;

    TScr = class

    end;

    TPrt = class

    end;

    TSetup = class
      function init: TList<TPrm>;
      function System: TSys;
      function User: TUsr;
      function Backup: TBkp;
      function Screen: TSCr;
      function Printer: TPrt;
    end;

implementation

{ TSetup }

function TSetup.Backup: TBkp;
begin
  Result:= TBkp.Create;
end;

function TSetup.init: TList<TPrm>;
begin
  //pass
end;

function TSetup.Printer: TPrt;
begin
  Result:= TPrt.Create;
end;

function TSetup.Screen: TSCr;
begin
  Result:= TScr.Create;
end;

function TSetup.System: TSys;
begin
  Result:= TSys.Create;
end;

function TSetup.User: TUsr;
begin
  Result:= TUsr.Create;
end;

end.
