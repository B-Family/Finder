unit Master;

interface

uses
Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.Jpeg, Vcl.ExtCtrls,
sGauge, Vcl.StdCtrls, sLabel, sButton, sPanel, sSkinManager, Vcl.ImgList, AcAlphaImageList,
sSkinProvider, AcPNG, sEdit, ShellApi, GBlur, sDialogs, MMSystem, IdHTTP, IdHashMessageDigest,
SyncObjs, sCheckBox, sSpinEdit, JsonDataObjects, SynaCode, System.ImageList;

const
SERVER_ADDRESS = '';

type
TDateAndTime = array[0..1] of string;
TShapeCoordinates = array[0..3] of Integer;

TMaster = class(TForm)
private
    function GetDateAndTime(): TDateAndTime;
    function GetShapeCoordinates(const ShapeNumber: Integer): TShapeCoordinates;
    procedure FormBackgroundShape(const ShapeCoordinates: TShapeCoordinates; var TargetImage: TImage);
    procedure ChangePanel(const PanelNumber: Integer);
    procedure SetKey(const Key: string);
    procedure NormalizeBase(var TargetStringList: TStringList);
published
    FPI_BM: TImage;
    FPP_CM: TsPanel;
    FPPB_Launch: TsButton;
    FPPB_AB: TsButton;
    FPPB_Stop: TsButton;
    FPP_LC: TsPanel;
    FPP_CA: TsPanel;
    FPPB_OF: TsButton;
    FPPB_Chat: TsButton;
    FPPB_Options: TsButton;
    FPPB_Screenshot: TsButton;
    FPP_LS: TsPanel;
    FPP_PB: TsPanel;
    FPPG_PB: TsGauge;
    FPP_Version: TsPanel;
    FPPL_Version: TsLabel;
    FPP_Key: TsPanel;
    FPPL_Key: TsLabel;
    FPP_CB: TsPanel;
    FPPB_Minimize: TsButton;
    FPPB_Close: TsButton;
    FS_SM: TsSkinManager;
    FI_CB: TImageList;
    FI_CA: TImageList;
    FI_CM: TImageList;
    FI_CS: TImageList;
    FP_Master: TsPanel;
    FP_SS: TsPanel;
    FPI_BSS: TImage;
    FPP_CSS: TsPanel;
    FPPB_CSS: TsButton;
    FPP_LSS: TsPanel;
    FPP_SSS: TsPanel;
    FPPL_LCE: TsLabel;
    FPPL_CCE: TsLabel;
    FPPP_LDS: TsPanel;
    FPPP_SDS: TsPanel;
    FI_CSS: TImageList;
    FI_Border: TImage;
    FO_OFD: TsOpenDialog;
    FPPB_Reset: TsButton;
    FI_CO: TImageList;
    FPP_Statistics: TsPanel;
    FPPL_LBLAR: TsLabel;
    FPPL_LF: TsLabel;
    FPPL_LNF: TsLabel;
    FPPL_CBLAR: TsLabel;
    FPPL_CNF: TsLabel;
    FPPL_CF: TsLabel;
    FPPL_LE: TsLabel;
    FPPL_CE: TsLabel;
    FPPB_SS: TsButton;
    FPPP_CH: TsPanel;
    FP_Options: TsPanel;
    FPI_BO: TImage;
    FPP_CO: TsPanel;
    FPPB_CO: TsButton;
    FPP_LO: TsPanel;
    FPP_Switches: TsPanel;
    FPPC_SNF: TsCheckBox;
    procedure FPPB_MinimizeClick(Sender: TObject);
    procedure FPPB_MinimizeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_MinimizeMouseEnter(Sender: TObject);
    procedure FPPB_MinimizeMouseLeave(Sender: TObject);
    procedure FPPB_MinimizeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_CloseClick(Sender: TObject);
    procedure FPPB_CloseMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_CloseMouseEnter(Sender: TObject);
    procedure FPPB_CloseMouseLeave(Sender: TObject);
    procedure FPPB_CloseMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_ABClick(Sender: TObject);
    procedure FPPB_ABMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_ABMouseEnter(Sender: TObject);
    procedure FPPB_ABMouseLeave(Sender: TObject);
    procedure FPPB_ABMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_LaunchClick(Sender: TObject);
    procedure FPPB_LaunchMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_LaunchMouseEnter(Sender: TObject);
    procedure FPPB_LaunchMouseLeave(Sender: TObject);
    procedure FPPB_LaunchMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_StopClick(Sender: TObject);
    procedure FPPB_StopMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_StopMouseEnter(Sender: TObject);
    procedure FPPB_StopMouseLeave(Sender: TObject);
    procedure FPPB_StopMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_ResetClick(Sender: TObject);
    procedure FPPB_ResetMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_ResetMouseEnter(Sender: TObject);
    procedure FPPB_ResetMouseLeave(Sender: TObject);
    procedure FPPB_ResetMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_OFClick(Sender: TObject);
    procedure FPPB_OFMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_OFMouseEnter(Sender: TObject);
    procedure FPPB_OFMouseLeave(Sender: TObject);
    procedure FPPB_OFMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_ChatClick(Sender: TObject);
    procedure FPPB_ChatMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_ChatMouseEnter(Sender: TObject);
    procedure FPPB_ChatMouseLeave(Sender: TObject);
    procedure FPPB_ChatMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_OptionsClick(Sender: TObject);
    procedure FPPB_OptionsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_OptionsMouseEnter(Sender: TObject);
    procedure FPPB_OptionsMouseLeave(Sender: TObject);
    procedure FPPB_OptionsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_COClick(Sender: TObject);
    procedure FPPB_COMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_COMouseEnter(Sender: TObject);
    procedure FPPB_COMouseLeave(Sender: TObject);
    procedure FPPB_COMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_ScreenshotClick(Sender: TObject);
    procedure FPPB_ScreenshotMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_ScreenshotMouseEnter(Sender: TObject);
    procedure FPPB_ScreenshotMouseLeave(Sender: TObject);
    procedure FPPB_ScreenshotMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_SSClick(Sender: TObject);
    procedure FPPB_SSMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_SSMouseEnter(Sender: TObject);
    procedure FPPB_SSMouseLeave(Sender: TObject);
    procedure FPPB_SSMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_CSSClick(Sender: TObject);
    procedure FPPB_CSSMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPPB_CSSMouseEnter(Sender: TObject);
    procedure FPPB_CSSMouseLeave(Sender: TObject);
    procedure FPPB_CSSMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPI_BMMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPI_BOMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FPI_BSSMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
end;
TWorker = class(TThread)
private
    class var FCriticalSection: TCriticalSection;
    class var FDateAndTime: TDateAndTime;
    class var FWorkersCounter: Integer;
    FSaveNotFound: Boolean;
    function SaveLineInFile(const FileName, Line: string): Boolean;
    procedure SetResetButtonActive();
    procedure IncrementFoundCounter();
    procedure IncrementNotFoundCounter();
    procedure IncrementErrorCounter();
    procedure IncrementConnectionErrorCounter();
    procedure AddProgress();
protected
    procedure Execute(); override;
public
    constructor Create(const SaveNotFound: Boolean);
    destructor Destroy(); override;
end;
TWriter = class(TThread)
private
    FKey: string;
    FBufferLine: string;
    procedure SetLabelCaption();
    procedure SetBufferLine();
protected
    procedure Execute(); override;
public
    constructor Create(const Key: string);
end;

var
Form: TMaster;
Workers: array of TWorker;
Writer: TWriter;
Base: TStringList;


implementation

{$R *.dfm}

{
    TMaster: private section implementation.
}
function TMaster.GetDateAndTime(): TDateAndTime;
var
WordArray: array[0..6] of Word;
DateAndTime: TDateAndTime;
Separator: string;
I: Integer;

begin
    DecodeDate(Now, WordArray[0], WordArray[1], WordArray[2]);
    DecodeTime(Now, WordArray[3], WordArray[4], WordArray[5], WordArray[6]);
    for I := 0 to 5 do
    begin
        if ((I = 0) or (I = 3)) then
        begin
            Separator := '';
        end
        else
        begin
            Separator := '.';
        end;
        if (Length(IntToStr(WordArray[I])) = 1) then
        begin
            if (I < 3) then
            begin
                DateAndTime[0] := '0' + IntToStr(WordArray[I]) + Separator + DateAndTime[0];
            end
            else
            begin
                DateAndTime[1] := DateAndTime[1] + Separator + '0' + IntToStr(WordArray[I]);
            end;
        end
        else
        begin
            if (I < 3) then
            begin
                DateAndTime[0] := IntToStr(WordArray[I]) + Separator + DateAndTime[0];
            end
            else
            begin
                DateAndTime[1] := DateAndTime[1] + Separator + IntToStr(WordArray[I]);
            end;
        end;
    end;
    Result := DateAndTime;
end;
function TMaster.GetShapeCoordinates(const ShapeNumber: Integer): TShapeCoordinates;
var
ShapeCoordinates: TShapeCoordinates;

begin
    case ShapeNumber of
      0:begin
            // !!!
        end;
      1:begin
            ShapeCoordinates[0] := 73;
            ShapeCoordinates[1] := 83;
            ShapeCoordinates[2] := 234;
            ShapeCoordinates[3] := 168;
        end;
      2:begin
            ShapeCoordinates[0] := 73;
            ShapeCoordinates[1] := 60;
            ShapeCoordinates[2] := 234;
            ShapeCoordinates[3] := 192;
        end;
    end;
    Result := ShapeCoordinates;
end;
procedure TMaster.FormBackgroundShape(const ShapeCoordinates: TShapeCoordinates; var TargetImage: TImage);
var
Bitmap: TBitmap;

begin
    Bitmap := TBitmap.Create();
    Bitmap.PixelFormat := pf24Bit;
    Bitmap.Width := ClientWidth - 10;
    Bitmap.Height := ClientHeight - 10;
    BitBlt(Bitmap.Canvas.Handle, 0, 0, Bitmap.Width, Bitmap.Height, Form.Canvas.Handle, 5, 5, SrcCopy);
    Blur(Bitmap, 8.2);
    Bitmap.Canvas.Brush.Color := $00232323;
    Bitmap.Canvas.Pen.Color := $00232323;
    Bitmap.Canvas.Rectangle(ShapeCoordinates[0], ShapeCoordinates[1], ShapeCoordinates[2], ShapeCoordinates[3]);
    TargetImage.Picture.Assign(Bitmap);
    FreeAndNil(Bitmap);
end;
procedure TMaster.ChangePanel(const PanelNumber: Integer);
begin
    case PanelNumber of
      0:begin
            FP_Master.Visible := True;
            FP_Options.Visible := False;
            FP_SS.Visible := False;
        end;
      1:begin
            // !!!
        end;
      2:begin
            FormBackgroundShape(GetShapeCoordinates(1), FPI_BO);
            FP_Options.Visible := True;
            FP_Master.Visible := False;
            FP_SS.Visible := False;
        end;
      3:begin
            FormBackgroundShape(GetShapeCoordinates(2), FPI_BSS);
            FP_SS.Visible := True;
            FP_Master.Visible := False;
            FP_Options.Visible := False;
        end;
    end;
end;
procedure TMaster.SetKey(const Key: string);
begin
    try
        Writer.Terminate();
    except
    end;
    Sleep(40);
    Writer := TWriter.Create(Key);
end;
procedure TMaster.NormalizeBase(var TargetStringList: TStringList);
var
Buffer: TStringList;
I, J, K: Integer;

begin
    Buffer := TStringList.Create();
    for I := 0 to TargetStringList.Count - 1 do
    begin
        if (Length(TargetStringList[I]) > 0) then
        begin
            J := 0;
            for K := 1 to Length(TargetStringList[I]) do
            begin
                if (TargetStringList[I][K] In [';', ':']) then
                begin
                    J := J + 1;
                end;
                if (J > 1) then
				        begin
					          Break;
				        end;
            end;
            if (not((J = 1) and (Length(Copy(TargetStringList[I], (Pos(';', TargetStringList[I]) or Pos(':', TargetStringList[I])) + 1, Length(TargetStringList[I]))) = 32))) then
            begin
                Continue;
            end;
            Buffer.Add(TargetStringList[I]);
        end;
    end;
    TargetStringList.Clear();
    TargetStringList.Assign(Buffer);
    FreeAndNil(Buffer);
end;

{
    TMaster: published section implementation.
}
procedure TMaster.FPPB_MinimizeClick(Sender: TObject);
begin
    Application.Minimize();
end;
procedure TMaster.FPPB_MinimizeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Minimize.SelectedImageIndex := 0;
end;
procedure TMaster.FPPB_MinimizeMouseEnter(Sender: TObject);
begin
    FPPB_Minimize.SelectedImageIndex := 1;
end;
procedure TMaster.FPPB_MinimizeMouseLeave(Sender: TObject);
begin
    FPPB_Minimize.SelectedImageIndex := 0;
end;
procedure TMaster.FPPB_MinimizeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Minimize.SelectedImageIndex := 1;
end;
procedure TMaster.FPPB_CloseClick(Sender: TObject);
begin
    Form.Close;
end;
procedure TMaster.FPPB_CloseMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Close.SelectedImageIndex := 2;
end;
procedure TMaster.FPPB_CloseMouseEnter(Sender: TObject);
begin
    FPPB_Close.SelectedImageIndex := 3;
end;
procedure TMaster.FPPB_CloseMouseLeave(Sender: TObject);
begin
    FPPB_Close.SelectedImageIndex := 2;
end;
procedure TMaster.FPPB_CloseMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Close.SelectedImageIndex := 3;
end;
procedure TMaster.FPPB_ABClick(Sender: TObject);
begin
    SetKey('Adding base.');
    if (FO_OFD.Execute() = True) then
    begin
        Base.Clear();
        Base.LoadFromFile(FO_OFD.FileName);
        NormalizeBase(Base);
        if (Base.Count > 0) then
        begin
            FPPL_CBLAR.Caption := IntToStr(Base.Count);
            FPPG_PB.MaxValue := Base.Count;
            SetKey('Base added!');
        end
        else
        begin
            FPPL_CBLAR.Caption := '0';
            FPPG_PB.MaxValue := 100;
            SetKey('File is empty!');
        end;
    end
    else
    begin
        SetKey('Canceled!');
    end;
end;
procedure TMaster.FPPB_ABMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_AB.SelectedImageIndex := 0;
end;
procedure TMaster.FPPB_ABMouseEnter(Sender: TObject);
begin
    FPPB_AB.SelectedImageIndex := 1;
end;
procedure TMaster.FPPB_ABMouseLeave(Sender: TObject);
begin
    FPPB_AB.SelectedImageIndex := 0;
end;
procedure TMaster.FPPB_ABMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_AB.SelectedImageIndex := 1;
end;
procedure TMaster.FPPB_LaunchClick(Sender: TObject);
var
I: Integer;

begin
    if (Base.Count > 0) then
    begin
        SetLength(Workers, 30);
        TWorker.FDateAndTime := GetDateAndTime();
        for I := 0 to Length(Workers) - 1 do
        begin
            Workers[I] := TWorker.Create(FPPC_SNF.Checked);
        end;
        FPPB_Stop.Enabled := True;
        FPPB_AB.Enabled := False;
        FPPB_Launch.Enabled := False;
        FPPB_Options.Enabled := False;
        FPPL_LBLAR.Caption := 'Remaining -';
        SetKey('In work.');
    end
    else
    begin
        SetKey('Load base!');
    end;
end;
procedure TMaster.FPPB_LaunchMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Launch.SelectedImageIndex := 2;
end;
procedure TMaster.FPPB_LaunchMouseEnter(Sender: TObject);
begin
    FPPB_Launch.SelectedImageIndex := 3;
end;
procedure TMaster.FPPB_LaunchMouseLeave(Sender: TObject);
begin
    FPPB_Launch.SelectedImageIndex := 2;
end;
procedure TMaster.FPPB_LaunchMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Launch.SelectedImageIndex := 3;
end;
procedure TMaster.FPPB_StopClick(Sender: TObject);
var
I: Integer;

begin
    FPPB_Stop.Enabled := False;
    for I := 0 to Length(Workers) - 1 do
    begin
        try
            Workers[I].Terminate();
        except
        end;
    end;
    SetKey('Stopping.');
end;
procedure TMaster.FPPB_StopMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Stop.SelectedImageIndex := 4;
end;
procedure TMaster.FPPB_StopMouseEnter(Sender: TObject);
begin
    FPPB_Stop.SelectedImageIndex := 5;
end;
procedure TMaster.FPPB_StopMouseLeave(Sender: TObject);
begin
    FPPB_Stop.SelectedImageIndex := 4;
end;
procedure TMaster.FPPB_StopMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Stop.SelectedImageIndex := 5;
end;
procedure TMaster.FPPB_ResetClick(Sender: TObject);
begin
    Base.Clear();
    FPPB_AB.Enabled := True;
    FPPB_Launch.Enabled := True;
    FPPB_Options.Enabled := True;
    FPPB_Reset.Enabled := False;
    FPPL_LBLAR.Caption := 'Base Loaded -';
    FPPL_CBLAR.Caption := '0';
    FPPL_CF.Caption := '0';
    FPPL_CNF.Caption := '0';
    FPPL_CE.Caption := '0';
    FPPL_CCE.Caption := '0';
    FPPG_PB.Progress := 0;
    FPPG_PB.MaxValue := 100;
end;
procedure TMaster.FPPB_ResetMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Reset.SelectedImageIndex := 6;
end;
procedure TMaster.FPPB_ResetMouseEnter(Sender: TObject);
begin
    FPPB_Reset.SelectedImageIndex := 7;
end;
procedure TMaster.FPPB_ResetMouseLeave(Sender: TObject);
begin
    FPPB_Reset.SelectedImageIndex := 6;
end;
procedure TMaster.FPPB_ResetMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Reset.SelectedImageIndex := 7;
end;
procedure TMaster.FPPB_OFClick(Sender: TObject);
begin
    ShellExecute(Handle, 'Open', PChar(ExtractFilePath(Application.ExeName)), Nil, Nil, SW_SHOW);
end;
procedure TMaster.FPPB_OFMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_OF.SelectedImageIndex := 0;
end;
procedure TMaster.FPPB_OFMouseEnter(Sender: TObject);
begin
    FPPB_OF.SelectedImageIndex := 1;
end;
procedure TMaster.FPPB_OFMouseLeave(Sender: TObject);
begin
    FPPB_OF.SelectedImageIndex := 0;
end;
procedure TMaster.FPPB_OFMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_OF.SelectedImageIndex := 1;
end;
procedure TMaster.FPPB_ChatClick(Sender: TObject);
begin
    // !!!
end;
procedure TMaster.FPPB_ChatMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Chat.SelectedImageIndex := 2;
end;
procedure TMaster.FPPB_ChatMouseEnter(Sender: TObject);
begin
    FPPB_Chat.SelectedImageIndex := 3;
end;
procedure TMaster.FPPB_ChatMouseLeave(Sender: TObject);
begin
    FPPB_Chat.SelectedImageIndex := 2;
end;
procedure TMaster.FPPB_ChatMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Chat.SelectedImageIndex := 3;
end;
procedure TMaster.FPPB_OptionsClick(Sender: TObject);
begin
    ChangePanel(2);
end;
procedure TMaster.FPPB_OptionsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Options.SelectedImageIndex := 4;
end;
procedure TMaster.FPPB_OptionsMouseEnter(Sender: TObject);
begin
    FPPB_Options.SelectedImageIndex := 5;
end;
procedure TMaster.FPPB_OptionsMouseLeave(Sender: TObject);
begin
    FPPB_Options.SelectedImageIndex := 4;
end;
procedure TMaster.FPPB_OptionsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Options.SelectedImageIndex := 5;
end;
procedure TMaster.FPPB_COClick(Sender: TObject);
begin
    ChangePanel(0);
end;
procedure TMaster.FPPB_COMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_CO.SelectedImageIndex := 0;
end;
procedure TMaster.FPPB_COMouseEnter(Sender: TObject);
begin
    FPPB_CO.SelectedImageIndex := 1;
end;
procedure TMaster.FPPB_COMouseLeave(Sender: TObject);
begin
    FPPB_CO.SelectedImageIndex := 0;
end;
procedure TMaster.FPPB_COMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_CO.SelectedImageIndex := 1;
end;
procedure TMaster.FPPB_ScreenshotClick(Sender: TObject);
var
Bitmap: TBitmap;

begin
    if (not(DirectoryExists(ExtractFilePath(Application.ExeName) + 'Screenshots\') = True)) then
    begin
        if (not(ForceDirectories(ExtractFilePath(Application.ExeName) + 'Screenshots\') = True)) then
        begin
            Beep;
            exit;
        end;
    end;
    Bitmap := TBitmap.Create();
    Bitmap.PixelFormat := pf24Bit;
    Bitmap.Width := ClientWidth;
    Bitmap.Height := ClientHeight;
    BitBlt(Bitmap.Canvas.Handle, 0, 0, Bitmap.Width, Bitmap.Height, Form.Canvas.Handle, 0, 0, SrcCopy);
    try
        Bitmap.SaveToFile(ExtractFilePath(Application.ExeName) + 'Screenshots\Screenshot [' + GetDateAndTime()[0] + '_' + GetDateAndTime()[1] + '].bmp');
        PlaySound('Sounds\Screenshot.wav', 0, SND_ASYNC or SND_NODEFAULT);
    except
        Beep;
    end;
    FreeAndNil(Bitmap);
end;
procedure TMaster.FPPB_ScreenshotMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Screenshot.SelectedImageIndex := 6;
end;
procedure TMaster.FPPB_ScreenshotMouseEnter(Sender: TObject);
begin
    FPPB_Screenshot.SelectedImageIndex := 7;
end;
procedure TMaster.FPPB_ScreenshotMouseLeave(Sender: TObject);
begin
    FPPB_Screenshot.SelectedImageIndex := 6;
end;
procedure TMaster.FPPB_ScreenshotMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_Screenshot.SelectedImageIndex := 7;
end;
procedure TMaster.FPPB_SSClick(Sender: TObject);
var
HTTP: TIdHTTP;
JSON: TJSONObject;
HTTPResult: string;

begin
    HTTP := TIdHTTP.Create();
    try
        HTTPResult := HTTP.Get(EncodeURL(SERVER_ADDRESS + '/api/getHashesAmount'));

        JSON := TJSONObject.Parse(HTTPResult) As TJSONObject;
        if (JSON['Status'] = 'OK') then
        begin
            FPPP_SDS.Caption := 'ON';
            FPPP_CH.Caption := IntToStr(JSON['HashesAmount']);
        end
        else
        begin
            FPPP_SDS.Caption := 'OFF';
            FPPP_CH.Caption := 'ERROR';
        end;
        FreeAndNil(JSON);
    except
        FPPP_SDS.Caption := 'OFF';
        FPPP_CH.Caption := 'ERROR';
    end;
    ChangePanel(3);
    FreeAndNil(HTTP);
end;
procedure TMaster.FPPB_SSMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_SS.SelectedImageIndex := 0;
end;
procedure TMaster.FPPB_SSMouseEnter(Sender: TObject);
begin
    FPPB_SS.SelectedImageIndex := 1;
end;
procedure TMaster.FPPB_SSMouseLeave(Sender: TObject);
begin
    FPPB_SS.SelectedImageIndex := 0;
end;
procedure TMaster.FPPB_SSMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_SS.SelectedImageIndex := 1;
end;
procedure TMaster.FPPB_CSSClick(Sender: TObject);
begin
    ChangePanel(0);
end;
procedure TMaster.FPPB_CSSMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_CSS.SelectedImageIndex := 0;
end;
procedure TMaster.FPPB_CSSMouseEnter(Sender: TObject);
begin
    FPPB_CSS.SelectedImageIndex := 1;
end;
procedure TMaster.FPPB_CSSMouseLeave(Sender: TObject);
begin
    FPPB_CSS.SelectedImageIndex := 0;
end;
procedure TMaster.FPPB_CSSMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FPPB_CSS.SelectedImageIndex := 1;
end;
procedure TMaster.FPI_BMMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    ReleaseCapture;
    Form.Perform(WM_SYSCOMMAND, $F012, 0);
end;
procedure TMaster.FPI_BOMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    ReleaseCapture;
    Form.Perform(WM_SYSCOMMAND, $F012, 0);
end;
procedure TMaster.FPI_BSSMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    ReleaseCapture;
    Form.Perform(WM_SYSCOMMAND, $F012, 0);
end;
procedure TMaster.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    FreeAndNil(Base);
    FreeAndNil(TWorker.FCriticalSection);
end;
procedure TMaster.FormCreate(Sender: TObject);
begin
    Base := TStringList.Create();
    TWorker.FCriticalSection := TCriticalSection.Create();
    SetKey('Hello world!');
end;

{
    TWorker: private section implementation.
}
function TWorker.SaveLineInFile(const FileName, Line: string): Boolean;
var
TargetTextFile: TextFile;

begin
    if (not(DirectoryExists(ExtractFilePath(Application.ExeName) + 'Results\Result [' + FDateAndTime[0] + '_' + FDateAndTime[1] + ']\') = True)) then
    begin
        if (not(ForceDirectories(ExtractFilePath(Application.ExeName) + 'Results\Result [' + FDateAndTime[0] + '_' + FDateAndTime[1] + ']\') = True)) then
        begin
            Result := False;
            exit;
        end;
    end;
    AssignFile(TargetTextFile, ExtractFilePath(Application.ExeName) + 'Results\Result [' + FDateAndTime[0] + '_' + FDateAndTime[1] + ']\' + FileName + '.txt');
    try
        if (FileExists(ExtractFilePath(Application.ExeName) + 'Results\Result [' + FDateAndTime[0] + '_' + FDateAndTime[1] + ']\' + FileName + '.txt') = True) then
        begin
            Append(TargetTextFile);
        end
        else
        begin
            Rewrite(TargetTextFile);
        end;
        WriteLn(TargetTextFile, Line);
        Result := True;
    except
        Result := False;
    end;
    CloseFile(TargetTextFile);
end;
procedure TWorker.SetResetButtonActive();
begin
    Form.FPPB_Reset.Enabled := True;
    Form.FPPB_Stop.Enabled := False;
end;
procedure TWorker.IncrementFoundCounter();
begin
    Form.FPPL_CF.Caption := IntToStr(StrToInt(Form.FPPL_CF.Caption) + 1);
end;
procedure TWorker.IncrementNotFoundCounter();
begin
    Form.FPPL_CNF.Caption := IntToStr(StrToInt(Form.FPPL_CNF.Caption) + 1);
end;
procedure TWorker.IncrementErrorCounter();
begin
    Form.FPPL_CE.Caption := IntToStr(StrToInt(Form.FPPL_CE.Caption) + 1);
end;
procedure TWorker.IncrementConnectionErrorCounter();
begin
    Form.FPPL_CCE.Caption := IntToStr(StrToInt(Form.FPPL_CCE.Caption) + 1);
end;
procedure TWorker.AddProgress();
begin
    Form.FPPL_CBLAR.Caption := IntToStr(StrToInt(Form.FPPL_CBLAR.Caption) - 1);
    Form.FPPG_PB.Progress := Form.FPPG_PB.Progress + 1;
end;

{
    TWorker: protected section implementation.
}
procedure TWorker.Execute();
var
PostData: TStringStream;
HTTP: TIdHTTP;
JSON: TJSONObject;
Result, Item, Hash: string;
ConnectionError: Boolean;

begin
    HTTP := TIdHTTP.Create();
    HTTP.Request.ContentType := 'Application/JSON';
    while (not(Terminated = True)) do
    begin
        try
            FCriticalSection.Enter();
            try
                Result := Base[0];
                Base.Delete(0);
            except
                FreeAndNil(HTTP);
                exit;
            end;
        finally
            FCriticalSection.Leave();
        end;
        Item := Copy(Result, 0, (Pos(';', Result) or Pos(':', Result)) - 1);
        Hash := Copy(Result, (Pos(';', Result) or Pos(':', Result)) + 1, Length(Result));
        PostData := TStringStream.Create('{"Hash": "' + EncodeURL(Hash) + '"}', TEncoding.UTF8);
        repeat
            ConnectionError := False;
            try
                Result := HTTP.Post(EncodeURL(SERVER_ADDRESS + '/api/decryptHash'), PostData);
            except
                ConnectionError := True;
                Synchronize(IncrementConnectionErrorCounter);
            end;
        until ConnectionError = False;
        FreeAndNil(PostData);
        JSON := TJSONObject.Parse(Result) As TJSONObject;
        if (JSON['Status'] = 'OK') then
        begin
            if (JSON['Result'] = 'Password found') then
            begin
                try
                    FCriticalSection.Enter;
                    if (not(SaveLineInFile('Found', Item + ':' + DecodeURL(JSON['Password'])) = True)) then
                    begin
                        FreeAndNil(HTTP);
                        FreeAndNil(JSON);
                        exit;
                    end;
                finally
                    FCriticalSection.Leave;
                end;
                Synchronize(IncrementFoundCounter);
            end
            else
            begin
                if (FSaveNotFound = True) then
                begin
                    try
                        FCriticalSection.Enter;
                        if (not(SaveLineInFile('not Found', Item + ':' + Copy(Hash, 6, Length(Hash))) = True)) then
                        begin
                            FreeAndNil(HTTP);
                            FreeAndNil(JSON);
                            exit;
                        end;
                    finally
                        FCriticalSection.Leave;
                    end;
                end;
                Synchronize(IncrementNotFoundCounter);
            end;
        end
        else
        begin
            try
                FCriticalSection.Enter;
                if (not(SaveLineInFile('Error', Item + ':' + Copy(Hash, 6, Length(Hash))) = True)) then
                begin
                    FreeAndNil(PostData);
                    FreeAndNil(HTTP);
                    FreeAndNil(JSON);
                    exit;
                end;
            finally
                FCriticalSection.Leave;
            end;
            Synchronize(IncrementErrorCounter);
        end;
        FreeAndNil(JSON);
        Synchronize(AddProgress);
    end;
    FreeAndNil(HTTP);
end;

{
    TWorker: Special section implementation.
}
constructor TWorker.Create(const SaveNotFound: Boolean);
begin
    inherited Create(True);
    FreeOnTerminate := True;
    FSaveNotFound := SaveNotFound;
    try
        FCriticalSection.Enter();
        FWorkersCounter := FWorkersCounter + 1;
    finally
        FCriticalSection.Leave();
    end;
    Resume();
end;
destructor TWorker.Destroy();
begin
    try
        FCriticalSection.Enter();
        FWorkersCounter := FWorkersCounter - 1;
    finally
        FCriticalSection.Leave();
    end;
    if (FWorkersCounter = 0) then
    begin
        Synchronize(SetResetButtonActive);
        Form.SetKey('Work finished.');
    end;
    inherited Destroy();
end;

{
    TTypewriter: private section implementation.
}
procedure TWriter.SetBufferLine();
begin
    FBufferLine := Form.FPPL_Key.Caption;
end;
procedure TWriter.SetLabelCaption();
begin
    Form.FPPL_Key.Caption := FBufferLine;
end;

{
    TTypewriter: protected section implementation.
}
procedure TWriter.Execute();
label
L;

var
I: Integer;

begin
    Synchronize(SetBufferLine);
  L:while (Length(FBufferLine) > 13) do
    begin
        Sleep(10);
        if (Terminated = True) then
		    begin
            exit;
		    end;
        Delete(FBufferLine, Length(FBufferLine), 1);
        Synchronize(SetLabelCaption);
    end;
    for I := 1 to Length(FKey) do
    begin
        Sleep(30);
        if (Terminated = True) then
		    begin
			      exit;
		    end;
        FBufferLine := FBufferLine + FKey[I];
        Synchronize(SetLabelCaption);
    end;
    if ((FKey = 'Adding base.') or (FKey = 'Stopping.') or (FKey = 'In work.')) then
    begin
        while (not(Terminated = True)) do
        begin
            for I := 0 to 10 do
            begin
                Sleep(30);
                if (Terminated = True) then
				        begin
                    exit;
				        end;
            end;
            FBufferLine := FBufferLine + '.';
            Synchronize(SetLabelCaption);
            if (((FKey = 'Adding base.') and (Length(FBufferLine) = 28)) or ((FKey = 'Stopping.') and (Length(FBufferLine) = 25)) or ((FKey = 'In work.') and (Length(FBufferLine) = 24))) then
            begin
                FBufferLine := Copy(FBufferLine, 1, 13 + Length(FKey));
                Synchronize(SetLabelCaption);
            end;
        end;
    end
    else
    begin
        if (not(FKey = 'I''m idle.')) then
        begin
            for I := 0 to 100 do
            begin
                Sleep(30);
                if (Terminated = True) then
				        begin
					          exit;
				        end;
            end;
            FKey := 'I''m idle.';
            goto L;
        end;
    end;
end;

{
    TTypewriter: Special section implementation.
}
constructor TWriter.Create(const Key: string);
begin
    inherited Create(True);
    FreeOnTerminate := True;
    FKey := Key;
    Resume();
end;

end.