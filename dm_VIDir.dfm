object VD_DM: TVD_DM
  OldCreateOrder = False
  Height = 367
  Width = 831
  object conLite: TFDConnection
    Params.Strings = (
      'Database=D:\Execute\Work_temp\VInformate\Resource\dataLite.sdb'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 40
    Top = 32
  end
  object FDT_Users: TFDTable
    IndexFieldNames = 'ID'
    Connection = conLite
    UpdateOptions.UpdateTableName = 'users_t'
    TableName = 'users_t'
    Left = 120
    Top = 48
    object FDT_UsersID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDT_UsersU_DATE: TDateTimeField
      FieldName = 'U_DATE'
      Origin = 'U_DATE'
    end
    object FDT_UsersNAME: TWideStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Required = True
      Size = 2048
    end
    object FDT_UsersU_INFO: TWideStringField
      FieldName = 'U_INFO'
      Origin = 'U_INFO'
      Size = 32767
    end
    object FDT_UsersCONTACTS: TWideStringField
      FieldName = 'CONTACTS'
      Origin = 'CONTACTS'
      Size = 32767
    end
    object FDT_UsersCOMMENTARY: TWideStringField
      FieldName = 'COMMENTARY'
      Origin = 'COMMENTARY'
      Size = 32767
    end
    object FDT_UsersCATALOG: TWideStringField
      FieldName = 'CATALOG'
      Origin = 'CATALOG'
      Size = 4095
    end
    object FDT_UsersGROUP_ID: TIntegerField
      FieldName = 'GROUP_ID'
      Origin = 'GROUP_ID'
      Required = True
    end
    object FDT_UsersSIGN: TIntegerField
      FieldName = 'SIGN'
      Origin = 'SIGN'
      Required = True
    end
  end
  object FDT_works: TFDTable
    IndexFieldNames = 'USER_ID'
    MasterSource = dsUsers
    MasterFields = 'ID'
    Connection = conLite
    UpdateOptions.UpdateTableName = 'works_t'
    TableName = 'works_t'
    Left = 264
    Top = 48
    object FDT_worksID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDT_worksUSER_ID: TIntegerField
      FieldName = 'USER_ID'
      Origin = 'USER_ID'
      Required = True
    end
    object FDT_worksINFO: TWideStringField
      FieldName = 'INFO'
      Origin = 'INFO'
      Size = 32767
    end
    object FDT_worksB_DATE: TDateTimeField
      FieldName = 'B_DATE'
      Origin = 'B_DATE'
      Required = True
    end
    object FDT_worksE_DATE: TDateTimeField
      FieldName = 'E_DATE'
      Origin = 'E_DATE'
    end
    object FDT_worksCOMMENTARY: TWideStringField
      FieldName = 'COMMENTARY'
      Origin = 'COMMENTARY'
      Size = 32767
    end
    object FDT_worksSTATE: TIntegerField
      FieldName = 'STATE'
      Origin = 'STATE'
      Required = True
    end
    object FDT_worksCATALOG: TWideStringField
      FieldName = 'CATALOG'
      Origin = 'CATALOG'
      Size = 4095
    end
    object FDT_worksPRICE: TIntegerField
      FieldName = 'PRICE'
      Origin = 'PRICE'
    end
    object FDT_worksPAID: TIntegerField
      FieldName = 'PAID'
      Origin = 'PAID'
    end
    object FDT_worksPD_DATE: TDateTimeField
      FieldName = 'PD_DATE'
      Origin = 'PD_DATE'
    end
    object FDT_worksSIGN: TIntegerField
      FieldName = 'SIGN'
      Origin = 'SIGN'
      Required = True
    end
  end
  object FDT_Tasks: TFDTable
    IndexFieldNames = 'WORK_ID'
    MasterSource = dsWorks
    MasterFields = 'ID'
    Connection = conLite
    UpdateOptions.UpdateTableName = 'tasks_t'
    TableName = 'tasks_t'
    Left = 336
    Top = 104
    object FDT_TasksID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDT_TasksWORK_ID: TIntegerField
      FieldName = 'WORK_ID'
      Origin = 'WORK_ID'
      Required = True
    end
    object FDT_TasksUSER_ID: TIntegerField
      FieldName = 'USER_ID'
      Origin = 'USER_ID'
      Required = True
    end
    object FDT_TasksB_DATE: TDateTimeField
      FieldName = 'B_DATE'
      Origin = 'B_DATE'
    end
    object FDT_TasksE_DATE: TDateTimeField
      FieldName = 'E_DATE'
      Origin = 'E_DATE'
    end
    object FDT_TasksNAME: TWideStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Size = 255
    end
    object FDT_TasksU_REMARKS: TWideStringField
      FieldName = 'U_REMARKS'
      Origin = 'U_REMARKS'
      Size = 32767
    end
    object FDT_TasksU_GRAPH: TBlobField
      FieldName = 'U_GRAPH'
      Origin = 'U_GRAPH'
    end
    object FDT_TasksCATALOG: TWideStringField
      FieldName = 'CATALOG'
      Origin = 'CATALOG'
      Size = 4095
    end
    object FDT_TasksCOMMENTARY: TWideStringField
      FieldName = 'COMMENTARY'
      Origin = 'COMMENTARY'
      Size = 32767
    end
    object FDT_TasksGROUP_ID: TIntegerField
      FieldName = 'GROUP_ID'
      Origin = 'GROUP_ID'
      Required = True
    end
    object FDT_TasksGRAPH: TBlobField
      FieldName = 'GRAPH'
      Origin = 'GRAPH'
    end
    object FDT_TasksSTATE: TIntegerField
      FieldName = 'STATE'
      Origin = 'STATE'
      Required = True
    end
    object FDT_TasksPRICE: TIntegerField
      FieldName = 'PRICE'
      Origin = 'PRICE'
    end
    object FDT_TasksPAID: TIntegerField
      FieldName = 'PAID'
      Origin = 'PAID'
    end
    object FDT_TasksPD_DATE: TDateTimeField
      FieldName = 'PD_DATE'
      Origin = 'PD_DATE'
    end
    object FDT_TasksSIGN: TIntegerField
      FieldName = 'SIGN'
      Origin = 'SIGN'
      Required = True
    end
  end
  object dsUsers: TDataSource
    DataSet = FDT_Users
    Left = 72
    Top = 120
  end
  object dsWorks: TDataSource
    DataSet = FDT_works
    Left = 136
    Top = 144
  end
  object conImages: TFDConnection
    Params.Strings = (
      'Database=D:\Execute\Work_temp\VInformate\Resource\imagesLite.sdb'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 72
    Top = 224
  end
  object FDQ_Images: TFDQuery
    Connection = conImages
    Left = 152
    Top = 256
  end
  object FDT_Images: TFDTable
    IndexFieldNames = 'ID'
    Connection = conImages
    UpdateOptions.UpdateTableName = 'images_t'
    TableName = 'images_t'
    Left = 232
    Top = 232
    object FDT_ImagesID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object FDT_ImagesITYPE: TIntegerField
      FieldName = 'ITYPE'
      Origin = 'ITYPE'
      Required = True
    end
    object FDT_ImagesGROUP_ID: TIntegerField
      FieldName = 'GROUP_ID'
      Origin = 'GROUP_ID'
      Required = True
    end
    object FDT_ImagesTASK_ID: TIntegerField
      FieldName = 'TASK_ID'
      Origin = 'TASK_ID'
    end
    object FDT_ImagesUSER_ID: TIntegerField
      FieldName = 'USER_ID'
      Origin = 'USER_ID'
    end
    object FDT_ImagesIMG: TBlobField
      FieldName = 'IMG'
      Origin = 'IMG'
    end
    object FDT_ImagesIDESC: TWideMemoField
      FieldName = 'IDESC'
      Origin = 'IDESC'
      BlobType = ftWideMemo
    end
    object FDT_ImagesCDATE: TDateTimeField
      FieldName = 'CDATE'
      Origin = 'CDATE'
    end
    object FDT_ImagesSIGN: TIntegerField
      FieldName = 'SIGN'
      Origin = 'SIGN'
      Required = True
    end
  end
end
