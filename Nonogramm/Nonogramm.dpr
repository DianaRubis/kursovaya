program Nonogramm;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form2},
  Unit2 in 'Unit2.pas' {Form3},
  Unit3 in 'Unit3.pas' {Form4},
  Unit4 in 'Unit4.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
