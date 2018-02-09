unit wAppEnviron;
/// Модуль позволяет развязать класс Окружения с модулями программы и использовать только
/// обращение через переменную и функции.
///
/// Также в модуле набор функций для логирования действий программы - типа LogPt - если не требуется использовать
/// информацию структуры - можно подключить модуль в режиме заглушки (временно, для отладки), при этом структура берется
/// непосредственно отсюда, ссылок на класс окружения нет.
///


/// Для использования заглушки (чтобы подключить только данный модуль к проекту без его использования)
///  НЕОБХОДИМО ВКЛЮЧИТЬ ДАННУЮ ДИРЕКТИВУ - в этом случае
///         (но, только если нет вызовов методов и свойств класса appEnv) можно не менять код модулей.
///         При этом функции данного модуля ничего (по логированию) выполнять НЕ БУДУТ.
///  Директиву включать только для случаев экспорта куда-либо модулей проекта.

{DEFINE APP_ENV_STUB}

///  очень желательно добавлять модуль последним в список модулей проекта
///  (чтобы освобождение глобального объекта настроек происходило после всех)

interface

{$IFDEF APP_ENV_STUB}
  var appEnv:TObject=nil;

  type
   // подключается только в режиме заглушки
   // описания полей смотри в структуре с этим же именем в wAppEnvironClass
      TwAppEnvironParams=record
        Id:Integer; // в списке например InstallTraffic
        guIDStr,ShortName,Name,Caption,CaptionLeftPart:string;
        versionVisPrecision:integer;
        ApHandle:NativeUInt;
        mpIdentStr,wndClassNames,winSendRStr:string;
        winSendRegime:Integer;
        winHomeRVerifyFlag,winAutoHookFlag:boolean;
        iniFileName,iniCodeKey:string;
        iniShift:Integer;
        runAppName,CopyRightStr,PublisherStr,CompanyDirectoryPart,CompanyName:string;
        defLicenseCode:integer;
      end;

   var appParams:TwAppEnvironParams;
{$ELSE}
 ///
 uses System.Classes, wAppEnvironClass;
 ///
 var appEnv:TwAppEnvironment=nil;
     appParams:TwAppEnvironParams;
{$ENDIF}
/// <summary>
///      чтобы не вызывать напрямую конструктор - исп. создание глоб. объекта с глоб параметрами
/// </summary>
procedure appEnvironCreateWithParams;

/// <summary>
///     для глобального объекта удалить и выставить указатель в nil
///     (этот важный момент если есть логирование с потоками и ошибками)
/// </summary>
procedure appEnvironFree;

 /// <summary>
 ///      логирование доп. сущностей - для локализации ошибок
 ///      добавить точку прохода apCommand='' -нет логирования - иначе 'log' - только внутр. или команда лога
 /// </summary>
 procedure appSetPt(const aptName,aValue:string; const apCommand:string='');
 /// <summary>
 ///      логирование доп. сущностей - для локализации ошибок
 ///     убрать точку прохода из логов
 /// </summary>
 procedure appDeletePt(const aptName:string);
 /// <summary>
 ///      добавил для удобства работы с точкой -аналог appSetPt
 /// <param name="aDeleteFlag">
 ///     true - тут же удалить точку (только логирование операции)
 /// </param>
 /// </summary>
 procedure LogPt(const aptName,aValue:string; const apCommand:string=''; aDeleteFlag:Boolean=false);
 /// <summary>
 ///   синоним предыдущей процедуры (рекомендация)
 /// </summary>
 procedure Log_Pt(const aptName,aValue:string; const apCommand:string=''; aDeleteFlag:Boolean=false);
 /// <summary>
 ///    включить выключить логирование по ошибкам
 ///   (возм. использование отключения, если закрывается окно, но идет поток с выполнением)
 /// </summary>
 procedure appTraceState(aNewState:boolean);
 ///
 /// <summary>
 ///    задать начальные установки для madExcept из параметров appEnv
 /// </summary>
 procedure appInitDefaultTrace(const addPrx:string='');
 ///
 /// <summary>
 ///     тип события для логирования
 /// </summary>
 type
  TTraceExternalLogEvent=procedure(const aCommand,aMsgData:String) of object;
 /// <summary>
 ///     выставить указатель по заданному событию
 /// </summary>
 procedure appDefineTraceLogEvent(AEvent:TTraceExternalLogEvent);

implementation

{$IFDEF madExcept}
 uses System.SysUtils, u_wMadExcept;
{$ENDIF}

///////////////////////////////////////////////////////////////////////
////
///
procedure appEnvironCreateWithParams;
 begin
  {$IFNDEF APP_ENV_STUB}
  Assert(Assigned(appEnv)=false,'appCreateWithParams - repeat Create Singleton!');
  Assert(appParams.Id<>0,'appCreateWithParams - not fiill appParams - Id=0!');
  appEnv:=TwAppEnvironment.Create(appParams);
  /// a теперь главное!  хотя спрашивать параметры следует через свойство
  appParams:=appEnv.Params; // !
  {$ENDIF}
 end;

procedure appEnvironFree;
 begin
  if (Assigned(appEnv)=false) then
      appEnv:=nil
  else
   try
     appEnv.Free;
    finally
     appEnv:=nil;
   end;
 end;


 procedure appSetPt(const aptName,aValue:string; const apCommand:string='');
  begin
    {$IFDEF madExcept}
     { if (Assigned(appEnv)) and (Assigned(wTrace)) and (wTrace.Enabled=true) then
         wTrace.SetPt(aptName,aValue,apLogFlag)
      else
      }
       if Assigned(wTrace) then
          wtrace.SetPt(aptName,aValue,apCommand);
    {$ENDIF}
  end;

 procedure appDeletePt(const aptName:string);
  begin
    {$IFDEF madExcept}
     { if (Assigned(appEnv)) and (Assigned(wTrace)) and (wTrace.Enabled=true) then
         wTrace.DeletePt(aptName)
      else
      }
       if Assigned(wTrace) then
          wtrace.DeletePt(aptName);
    {$ENDIF}
  end;

procedure LogPt(const aptName,aValue:string; const apCommand:string=''; aDeleteFlag:Boolean=false);
 begin
   appSetPt(aptName,aValue,apCommand);
   if aDeleteFlag=true then
      appDeletePt(aptName); // в этом случае - смысл вызова appSetPt - только в логировании, точка удалается
 end;

procedure Log_Pt(const aptName,aValue:string; const apCommand:string=''; aDeleteFlag:Boolean=false);
 begin
  // не использую вызов LoggPt - т.к. он может быть закомментирован скриптом, поэтому повтор команд из него:
   appSetPt(aptName,aValue,apCommand);
   if aDeleteFlag=true then
      appDeletePt(aptName);
 end;


 procedure appTraceState(aNewState:boolean);
  begin
    {$IFDEF madExcept}
     { if (Assigned(appEnv)) and (Assigned(wTrace)) then
         wTrace.Enabled:=aNewState
      else
      }
       if Assigned(wTrace) then
          wTrace.Enabled:=aNewState;
    {$ENDIF}
  end;


 procedure appInitDefaultTrace(const addPrx:string='');
 var LIdStr:string;
  begin
    {$IFDEF madExcept}
      if (Assigned(appEnv)) and (Assigned(wTrace)) then
        begin
          ///
          if appEnv.Params.Id>0 then LIdStr:=IntToStr(appEnv.Params.Id)+'|'
          else LIdStr:='|';
          {$IFDEF APP_ENV_STUB}
           wTrace.BugReportName:=Concat(addPrx,LIdStr,'APP_ENV_STUB_DT|',DateToStr(Now));
          {$ELSE}
           wTrace.BugReportName:=Concat(addPrx,LIdStr,appEnv.ServiceInfo.appVersionStr,
                         '|',appEnv.ServiceInfo.userName,'|',
                           DateTimeToStr(Now));
          {$ENDIF}
          wTrace.SetPt('aAppEnv','initTrace',''); // служебн. метка
        end;
    {$ENDIF}
  end;

procedure appDefineTraceLogEvent(AEvent:TTraceExternalLogEvent);
 begin
   {$IFDEF madExcept}
      if (Assigned(wTrace)) then
        begin
           wTrace.OnExternalLogEvent:=AEvent;
        end;
    {$ENDIF}
 end;

initialization

  appEnv:=nil;
  appParams.Id:=0;
  appParams.CaptionLeftPart:='';
  appParams.winSendRStr:='';
  appParams.ApHandle:=0;
  appParams.versionVisPrecision:=3; // !
  appParams.winHomeRVerifyFlag:=False;
  appParams.mpIdentStr:='COMCOMBODEFAULT';
  appParams.publicPrefix:='';
  appParams.CompanyDirectoryPart:='';
  appParams.CompanyName:='';
  appParams.portabled:=false;
  appParams.subSettingsDir:='Settings';
  appParams.defLicenseCode:=0;

finalization

// !
  appEnvironFree;

end.
