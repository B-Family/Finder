program Finder;

uses
Vcl.Forms, Windows, Master in 'Master.pas';

{$R *.res}

begin
    if (FindWindow('TMaster', nil) = 0) then
    begin
        Application.Initialize();
        Application.MainFormOnTaskbar := True;
        Application.CreateForm(TMaster, Form);
        Application.Run();
    end
    else
    begin
        SetForegroundWindow(FindWindow('TMaster', nil));
    end;
end.