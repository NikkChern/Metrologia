program Metrology_Chepin;

uses
  Forms,
  Umain in 'Umain.pas' {Metrika};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMetrika, Metrika);
  Application.Run;
end.
