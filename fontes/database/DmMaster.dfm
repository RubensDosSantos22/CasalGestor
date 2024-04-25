object Dm: TDm
  Height = 423
  Width = 613
  object QrFBSelect1: TFDQuery
    Connection = Confb
    Left = 23
    Top = 82
  end
  object QrFBSelect2: TFDQuery
    Connection = Confb
    Left = 96
    Top = 82
  end
  object QrFBSelect3: TFDQuery
    Connection = Confb
    Left = 169
    Top = 82
  end
  object QrFBUpdate: TFDQuery
    Connection = Confb
    Left = 242
    Top = 82
  end
  object QrFBInsert: TFDQuery
    Connection = Confb
    Left = 310
    Top = 82
  end
  object QrFBDelete: TFDQuery
    Connection = Confb
    Left = 377
    Top = 82
  end
  object Confb: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\ruben\OneDrive\Documentos\GitHub\CasalGestor\f' +
        'ontes\database\DATA.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 432
    Top = 82
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 509
    Top = 82
  end
end
