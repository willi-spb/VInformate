object VRep_DM: TVRep_DM
  OldCreateOrder = False
  Height = 184
  Width = 590
  object DataSetTableProducer1: TDataSetTableProducer
    Columns = <
      item
        FieldName = 'ID'
      end
      item
        FieldName = 'WORK_ID'
      end
      item
        FieldName = 'USER_ID'
      end
      item
        FieldName = 'B_DATE'
      end
      item
        FieldName = 'E_DATE'
      end
      item
        FieldName = 'NAME'
      end
      item
        FieldName = 'U_REMARKS'
      end
      item
        FieldName = 'U_GRAPH'
        Title.BgColor = 'Aqua'
      end
      item
        FieldName = 'CATALOG'
      end
      item
        FieldName = 'COMMENTARY'
      end
      item
        FieldName = 'GROUP_ID'
      end
      item
        FieldName = 'GRAPH'
        Title.BgColor = 'Aqua'
      end
      item
        FieldName = 'STATE'
      end
      item
        FieldName = 'PRICE'
      end
      item
        FieldName = 'PAID'
      end
      item
        FieldName = 'PD_DATE'
      end
      item
        FieldName = 'SIGN'
      end>
    Footer.Strings = (
      #1055#1077#1088#1077#1095#1077#1085#1100)
    DataSet = VD_DM.FDT_Tasks
    TableAttributes.Align = haCenter
    TableAttributes.Border = 1
    TableAttributes.CellSpacing = 1
    TableAttributes.CellPadding = 0
    TableAttributes.Width = 98
    Left = 72
    Top = 16
  end
  object PageProducer1: TPageProducer
    HTMLFile = 'D:\Execute\Work_temp\VInformate\Resource\rep_sha1.html'
    OnHTMLTag = PageProducer1HTMLTag
    Left = 184
    Top = 32
  end
  object DataSetPageProducer1: TDataSetPageProducer
    DataSet = VD_DM.FDT_Tasks
    Left = 360
    Top = 32
  end
end
