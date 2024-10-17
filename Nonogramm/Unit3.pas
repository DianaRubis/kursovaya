unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Menus, ShellApi;

type
  TForm4 = class(TForm)
    StringGrid1: TStringGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Image1: TImage;
    SpeedButton2: TSpeedButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    procedure InitializeSolution;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure LoadLevelFromFile(const ColumnsFilePath, RowsFilePath: string; const Grid: TStringGrid);
    procedure SetFilePathAndInitializeSolution(const FilePath: string);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);




  private
    SolutionGrid: array[1..10, 1..10] of Integer;

  public
  LevelsCompleted: Integer;
    FilePath: string; // Путь к файлу
    GridPath: string; // Путь к файлу с заголовками строк и столбцов
  end;

var
  Form4: TForm4;
  LevelsCompleted: Integer = 0;

implementation

{$R *.dfm}

uses Unit4, Unit1;




procedure TForm4.SetFilePathAndInitializeSolution(const FilePath: string);
begin
  Self.FilePath := FilePath;
  InitializeSolution;
end;





procedure TForm4.SpeedButton1Click(Sender: TObject);
var
  ACol, ARow: Integer;
  IsCorrect: Boolean;
begin
  InitializeSolution;
  IsCorrect := True;
  for ACol := 1 to StringGrid1.ColCount - 1 do
  begin
    for ARow := 1 to StringGrid1.RowCount - 1 do
    begin
      if ((StringGrid1.Cells[ACol, ARow] = '1') and (SolutionGrid[ACol, ARow] <> 1)) or
         ((StringGrid1.Cells[ACol, ARow] = '') and (SolutionGrid[ACol, ARow] = 1)) then
      begin
        IsCorrect := False;
        Break;
      end;
    end;
    if not IsCorrect then
      Break;
  end;
  if IsCorrect then
  begin
    ShowMessage('Правильное решение!');
    Inc(LevelsCompleted);
    if not Assigned(Form5) then
      Form5 := TForm5.Create(Self);
    Form5.UnlockLevels;
  end
  else
  begin
    ShowMessage('Неправильное решение!');
  end;
end;








procedure TForm4.SpeedButton2Click(Sender: TObject);
begin
Form4.Hide;
Form2.Show;
end;

procedure TForm4.SpeedButton3Click(Sender: TObject);
var
  i, j: Integer;
begin
  // Очистка таблицы
  for i := 1 to StringGrid1.ColCount - 1 do
  begin
    for j := 1 to StringGrid1.RowCount - 1 do
    begin
      StringGrid1.Objects[i, j] := TObject(clWhite);
      StringGrid1.Cells[i, j] := '';
    end;
  end;

  // обновление таблицы
  StringGrid1.Invalidate;

  Form4.Hide;
  Form5.Show;
end;

procedure TForm4.FormCreate(Sender: TObject);
var
  i, j: Integer;
begin
   SpeedButton1.Font.Name := 'Ink Free';
   SpeedButton2.Font.Name := 'Ink Free';
   SpeedButton3.Font.Name := 'Ink Free';


  StringGrid1.Options := StringGrid1.Options + [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected];
  StringGrid1.Options := StringGrid1.Options - [goEditing];

  for i := 0 to StringGrid1.ColCount - 1 do
    for j := 0 to StringGrid1.RowCount - 1 do
    begin
      StringGrid1.Objects[i, j] := TObject(clWhite);
      end;

end;

procedure TForm4.InitializeSolution;
var
  F: TextFile;
  ACol, ARow, number: Integer;
begin
  if FilePath = '' then
  begin
    ShowMessage('Не указан путь к файлу данных.');
    Exit;
  end;

  AssignFile(F, FilePath);
  try
    Reset(F);
    for ACol := 1 to StringGrid1.ColCount - 1 do
    begin
      for ARow := 1 to StringGrid1.RowCount - 1 do
      begin
        if not Eof(F) then
        begin
          Read(F, number);
          SolutionGrid[ACol, ARow] := number;

        end
        else
        begin
          ShowMessage('Недостаточно данных в файле.');
          Exit;
        end;
      end;
      Readln(F);
    end;
    CloseFile(F);
  except
    on E: Exception do
    begin
      ShowMessage('Ошибка чтения файла: ' + E.Message);
      CloseFile(F);
    end;
  end;
end;







procedure TForm4.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  // Установка цвета для закрашивания ячеек
  StringGrid1.Canvas.Brush.Color := TColor(StringGrid1.Objects[ACol, ARow]);
  StringGrid1.Canvas.FillRect(Rect);
  StringGrid1.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, StringGrid1.Cells[ACol, ARow]);

  // Отрисовка крестика, если цвет красный
  if TColor(StringGrid1.Objects[ACol, ARow]) = clRed then
  begin
    StringGrid1.Canvas.Pen.Color := clBlack;
    StringGrid1.Canvas.MoveTo(Rect.Left, Rect.Top);
    StringGrid1.Canvas.LineTo(Rect.Right, Rect.Bottom);
    StringGrid1.Canvas.MoveTo(Rect.Left, Rect.Bottom);
    StringGrid1.Canvas.LineTo(Rect.Right, Rect.Top);
  end;
end;

procedure TForm4.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow: Integer;
  CurrentColor: TColor;
begin
  StringGrid1.MouseToCell(X, Y, ACol, ARow);
  if (ACol > 0) and (ARow > 0) then
  begin
    CurrentColor := TColor(StringGrid1.Objects[ACol, ARow]);
    if CurrentColor = clWhite then
    begin
      SolutionGrid[ACol, ARow] := 1;
      StringGrid1.Objects[ACol, ARow] := TObject(clBlack);
      StringGrid1.Cells[ACol, ARow] := '1';

    end
    else if CurrentColor = clBlack then
    begin
      SolutionGrid[ACol, ARow] := 0;
      StringGrid1.Objects[ACol, ARow] := TObject(clRed);
      StringGrid1.Cells[ACol, ARow] := '';

    end
    else
    begin
      SolutionGrid[ACol, ARow] := 0;
      StringGrid1.Objects[ACol, ARow] := TObject(clWhite);
      StringGrid1.Cells[ACol, ARow] := '';

    end;
    StringGrid1.Invalidate;
  end;
end;



function Min(const A, B: Integer): Integer;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

procedure TForm4.LoadLevelFromFile(const ColumnsFilePath, RowsFilePath: string; const Grid: TStringGrid);
var
  F: TextFile;
  RowIndex, ColIndex: Integer;
  Line: string;
  Numbers: TStringList;
begin
  // Проверка существования файлов
  if not FileExists(ColumnsFilePath) then
  begin
    ShowMessage('Файл для столбцов не найден: ' + ColumnsFilePath);
    Exit;
  end;
  if not FileExists(RowsFilePath) then
  begin
    ShowMessage('Файл для строк не найден: ' + RowsFilePath);
    Exit;
  end;
  // Заполнение данных для столбцов
  AssignFile(F, ColumnsFilePath);
  Reset(F);
  ColIndex := 1;
  try
    while not Eof(F) do
    begin
      Readln(F, Line);
      Numbers := TStringList.Create;
      try
        Numbers.Delimiter := ' ';
        Numbers.DelimitedText := Line;
        for RowIndex := 0 to Min(Numbers.Count - 1, Grid.RowCount - 1) do
          Grid.Cells[ColIndex, RowIndex] := Numbers[RowIndex];
      finally
        Numbers.Free;
      end;
      Inc(ColIndex);
      if ColIndex >= Grid.ColCount then
        Break;
    end;
  finally
    CloseFile(F);
  end;
  // Заполнение данных для строк
  AssignFile(F, RowsFilePath);
  Reset(F);
  RowIndex := 1;
  try
    while not Eof(F) do
    begin
      Readln(F, Line);
      Numbers := TStringList.Create;
      try
        Numbers.Delimiter := ' ';
        Numbers.DelimitedText := Line;
        for ColIndex := 0 to Min(Numbers.Count - 1, Grid.ColCount - 1) do
          Grid.Cells[ColIndex, RowIndex] := Numbers[ColIndex];
      finally
        Numbers.Free;
      end;
      Inc(RowIndex);
      if RowIndex >= Grid.RowCount then
        Break;
    end;
  finally
    CloseFile(F);
  end;
end;



procedure TForm4.N1Click(Sender: TObject);
begin
ShellExecute(0, 'open', PChar ('help.chm'), nil, nil, SW_SHOW);
end;

end.

