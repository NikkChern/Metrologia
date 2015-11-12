unit Umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdCtrls;

type
  TMetrika = class(TForm)
    Memo_Enter: TMemo;
    Clean_But: TButton;
    Label_Enter: TLabel;
    Open_But: TButton;
    OpenFile: TOpenDialog;
    Label_Name: TLabel;
    Label_Formula: TLabel;
    Edit_Result: TEdit;
    Label_P: TLabel;
    Label_M: TLabel;
    Label_C: TLabel;
    Label_T: TLabel;
    Edit_P: TEdit;
    Edit_M: TEdit;
    Edit_C: TEdit;
    Edit_T: TEdit;
    Analyze_But: TButton;
    Memo_Massive: TMemo;
    Label_Massive: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Open_ButClick(Sender: TObject);
    procedure Clean_ButClick(Sender: TObject);
    procedure Analyze();
    procedure Analyze_For();
    procedure Watch_Input_Output();
    procedure Watch_Modificate();
    procedure Search(x: Integer; analyzeString: String; k: Integer; sender: Integer);
    procedure Watch_Control();
    procedure Analyze_ButClick(Sender: TObject);
  public
    { Public declarations }
  end;
  
const
  elementsCount = 100;
  TypesCount = 9;
  signEmpty = '';
  signSpace = ' ';

var
  Metrika: TMetrika;
  massiveOfType : array [1..TypesCount] of String = ('char','short','int','long','float','double','void','signed','unsigned');
  massiveAllElements, massiveNotFound_P, massiveNotFound_M, massiveNotFound_C : array [1..elementsCount] of String;

implementation

{$R *.dfm}

procedure TMetrika.FormCreate(Sender: TObject);
begin
  Memo_Enter.Lines.Clear;
  Analyze_But.Enabled := False;
  Clean_But.Enabled := False;
end;

procedure TMetrika.Open_ButClick(Sender: TObject);
var
  Fil : TextFile;
  Enter_File, temporaryString : String;
begin
  if OpenFile.Execute then
  begin
    Enter_File := OpenFile.FileName;
    AssignFile(Fil,Enter_File);
    Reset(Fil);
    while not EOF(Fil) do
    begin
      Readln(Fil,temporaryString);
      Memo_Enter.Lines.Add(temporaryString);
    end;
    CloseFile(Fil);
    Clean_But.Enabled := True;
  end
  else
    ShowMessage('Открытие файла отменено!');
end;


procedure TMetrika.Clean_ButClick(Sender: TObject);
const
  signTab = #9;
  signHash = '#';
  signSlash = '/';
  signStar = '*';
var
  i, j, k, h, z, count : Integer;
  nextString : array[1..TypesCount+1] of Integer;
  analyzeString, temporaryString: String;
begin

  analyzeString := signEmpty;
  count := 0;
  for i := Memo_Enter.Lines.Count-1 downto 0 do
  begin
    analyzeString := Memo_Enter.Lines[i];
    for j:=1 to length(analyzeString) do
      if analyzeString[j] = signSpace then inc(count);
    if count = length(analyzeString) then Memo_Enter.Lines.Delete(i)
    else
      Memo_Enter.Lines[i] := analyzeString;
    analyzeString := signEmpty;
    count := 0;
  end;

  k := 1;
  analyzeString := signEmpty;
  for i := 0 to Memo_Enter.Lines.Count-1 do
  begin
    analyzeString := Memo_Enter.Lines[i];
    if analyzeString[1] = signHash then
    begin
      nextString[k] := i;
      inc(k);
    end;
    analyzeString := signEmpty;
  end;
  for i:=1 to k-1 do
  begin
    Memo_Enter.Lines.Delete(nextString[i]);
    nextString[i+1] := nextString[i];
  end;

  analyzeString := signEmpty;
  for i := 0 to Memo_Enter.Lines.Count-1 do
  begin
    analyzeString := Memo_Enter.Lines[i];
    j := 1;
    while analyzeString[j] = signSpace do
      inc(j);
    Delete(analyzeString,1,j);
    Memo_Enter.Lines[i] := analyzeString;
    analyzeString := signEmpty;
  end;

  analyzeString := signEmpty;
  for i := 0 to Memo_Enter.Lines.Count-1 do
  begin
    analyzeString := Memo_Enter.Lines[i];
    j := 1;
    while j <= length(analyzeString) do
    begin
      if analyzeString[j] = signTab then
      begin
        Delete(analyzeString,j,1);
        dec(j);
      end;
      inc(j);
    end;
    Memo_Enter.Lines[i] := analyzeString;
    analyzeString := signEmpty;
  end;

  analyzeString := signEmpty;
  for i := 0 to Memo_Enter.Lines.Count-1 do
  begin
    analyzeString := Memo_Enter.Lines[i];
    for j:=1 to length(analyzeString) do
      if (analyzeString[j] = signSlash) and (analyzeString[j+1] = signSlash) then
        if j = 1 then Memo_Enter.Lines.Delete(i)
        else
        begin
          Delete(analyzeString,j,length(analyzeString)-j+1);
          Memo_Enter.Lines[i] := analyzeString;
        end;
    analyzeString := signEmpty;
  end;

  analyzeString := signEmpty;
  for i := 0 to Memo_Enter.Lines.Count-1 do
  begin
    z := 0;
    count := 0;
    analyzeString := Memo_Enter.Lines[i];
    for j:=1 to length(analyzeString) do
      if (analyzeString[j] = signSlash) and (analyzeString[j+1] = signStar) then
      begin
        if j = 1 then Memo_Enter.Lines.Delete(i)
        else
        begin
          Delete(analyzeString,j,length(analyzeString)-j+1);
          Memo_Enter.Lines[i] := analyzeString;
          z := 1;
        end;
        count := 1;
        break;
      end;

    h := 0;
    if count = 1 then
    begin
      for k := i to Memo_Enter.Lines.Count-1 do
      begin
        temporaryString := Memo_Enter.Lines[k];
        for j:=1 to length(temporaryString) do
          if (temporaryString[j] = signStar) and (temporaryString[j+1] = signSlash) then
          begin
            h := k;
            break;
          end;
        if h <> 0 then break;
      end;
    end;

    if h <> 0 then
    begin
        if z = 0 then
          for j := h downto i do
            Memo_Enter.Lines.Delete(j);
        if z = 1 then
          for j := h downto i+1 do
            Memo_Enter.Lines.Delete(j);
    end;
    analyzeString := signEmpty;
  end;
  Analyze_But.Enabled := True;
end;


procedure TMetrika.Analyze();
const
  signComma = ',';
  signDigit : array[1..10] of String = ('0','1','2','3','4','5','6','7','8','9');
  signOpenSquareBracket = '[';
  signCloseSquareBracket = ']';
  signOpenBracket = '{';
  signCloseBracket = '}';
  signEqual = '=';
  signPointComma = ';';
  digitTwo = 2;
var
  i, j, k, h, x, y, z, countElements, commaCount : Integer;
  analyzeString, temporaryString, temporaryStr, temporaryStepString : String;
begin
  analyzeString := signEmpty;
  temporaryString := signEmpty;
  temporaryStr := signEmpty;
  temporaryStepString := signEmpty;
  countElements := 0;
  commaCount := 0;
  for i := 1 to Memo_Enter.Lines.Count-digitTwo do
  begin
    k := 0;
    analyzeString := Memo_Enter.Lines[i];

    for j:=1 to length(analyzeString) do
      if analyzeString[j] = signSpace then break;
    temporaryString := copy(analyzeString,1,j-1);
    for z := 1 to TypesCount do
    begin
      if temporaryString = massiveOfType[z] then k := z;
      if k <> 0 then break;
    end;

    if k <> 0 then
    begin
      temporaryStr := copy(analyzeString,j+1,length(analyzeString)-j);
      for x := 1 to length(temporaryStr) do
      begin
        if temporaryStr[x] = signComma then inc(commaCount);
        if temporaryStr[x] = signOpenBracket then break;
      end;
      y := 0;
      z := 1;

      while y <= commaCount do
      begin
        for x := z to length(temporaryStr) do
          if (temporaryStr[x] = signComma) then break;
        temporaryStepString := copy(temporaryStr,z,x-z);
        if temporaryStr[x+1] = signSpace then z := x+digitTwo;
        if temporaryStr[x+1] <> signSpace then z := x+1;
        h := 1;
        while h <= length(temporaryStepString) do
        begin
          if (temporaryStepString[h] = signOpenSquareBracket) or (temporaryStepString[h] = signCloseSquareBracket) then
          begin
            Delete(temporaryStepString,h,1);
            h := h-digitTwo;
          end;
          if (temporaryStepString[h] = signEqual) or (temporaryStepString[h] = signPointComma) or (temporaryStepString[h] = signSpace) then
          begin
            Delete(temporaryStepString,h,1);
            h := h-digitTwo;
          end;
          if (temporaryStepString[h] = signDigit[1]) or (temporaryStepString[h] = signDigit[2]) or (temporaryStepString[h] = signDigit[3]) then
          begin
            Delete(temporaryStepString,h,1);
            h := h-digitTwo;
          end;
          if (temporaryStepString[h] = signDigit[4]) or (temporaryStepString[h] = signDigit[5]) then
          begin
            Delete(temporaryStepString,h,1);
            h := h-2;
          end;
          if (temporaryStepString[h] = signDigit[6]) or (temporaryStepString[h] = signDigit[7]) then
          begin
            Delete(temporaryStepString,h,1);
            h := h-digitTwo;
          end;
          if (temporaryStepString[h] = signDigit[8]) or (temporaryStepString[h] = signDigit[9]) or (temporaryStepString[h] = signDigit[10]) then
          begin
            Delete(temporaryStepString,h,1);
            h := h-digitTwo;
          end;
          if (temporaryStepString[h] = signOpenBracket) or (temporaryStepString[h] = signCloseBracket)then
          begin
            Delete(temporaryStepString,h,1);
            h := h-digitTwo;
          end;
          inc(h);
        end;

        inc(countElements);
        massiveAllElements[countElements] := temporaryStepString;
        inc(y);
        temporaryStepString := signEmpty;
      end;
    end;
    analyzeString := signEmpty;
    temporaryString := signEmpty;
    temporaryStr := signEmpty;
    commaCount := 0;
  end;
end;


procedure TMetrika.Analyze_For();
const
  signPointComma = ';';
  operatorFor = 'for';
  digitTwo = 2;
  digitFour = 4;
  digitFive = 5;
var
  i, j, k, x, h : Integer;
  analyzeString, temporaryString, temporaryStr, temporaryStepString : String;
begin
  analyzeString := signEmpty;
  temporaryString := signEmpty;
  temporaryStr := signEmpty;
  h := 0;
  for i := 1 to Memo_Enter.Lines.Count-digitTwo do
  begin
    analyzeString := Memo_Enter.Lines[i];
    for j:=1 to length(analyzeString) do
      if analyzeString[j] = ' ' then break;

    temporaryString := copy(analyzeString,1,j-1);
    if temporaryString = operatorFor then temporaryStr := copy(analyzeString,j+digitTwo,length(analyzeString)-j);
    if temporaryStr <> signEmpty then
    begin

      for k := 1 to length(temporaryStr) do
        if temporaryStr[k] = signPointComma then break;
      Delete(temporaryStr,k-digitFour,length(temporaryStr)-k+digitFive);

      for x := 1 to length(temporaryStr) do
        if temporaryStr[x] = signSpace then break;
      temporaryStepString := copy(temporaryStr,1,x-1);

      for x := 1 to TypesCount do
      begin
        if temporaryStepString = massiveOfType[x] then h := x;
        if h <> 0 then break;
      end;

      if h <> 0 then
      begin
        for x := 1 to length(temporaryStr) do
          if temporaryStr[x] = signSpace then break;
        Delete(temporaryStr,1,x);
        for x := 1 to elementsCount do
          if massiveAllElements[x] = signEmpty then break;
        massiveAllElements[x] := temporaryStr;
      end;
    end;
    h := 0;
    temporaryStr := signEmpty;
    analyzeString := signEmpty;
    temporaryString := signEmpty;
    temporaryStepString := signEmpty;
  end;
end;


procedure TMetrika.Watch_Input_Output();
const
  operatorPrint = 'printf';
  operatorScanf = 'scanf';
  signComma = ',';
  signSeparate = ', ';
  digitTwo = 2;
var
  i, j, k, h, x, z, count, temporaryPlace : Integer;
  analyzeString, temporaryString : String;
begin
  analyzeString := signEmpty;
  for j := 1 to elementsCount do
    if massiveAllElements[j] = signEmpty then break;
  k := j-1;

  for j := 1 to k do
  begin
    temporaryString := massiveAllElements[j];

    for i := 1 to Memo_Enter.Lines.Count-digitTwo do
    begin
      analyzeString := Memo_Enter.Lines[i];
      z := Pos(temporaryString,analyzeString);

      if z > 0 then
      begin
        x := Pos(operatorPrint, analyzeString);
        if x > 0 then
        begin
          for h := 1 to length(analyzeString) do
            if analyzeString[h] = signComma then break;
          Delete(analyzeString,1,h);
          count := Pos(temporaryString, analyzeString);
          if count > 0 then
          begin
            temporaryPlace := Pos(temporaryString, Edit_P.Text);
            if temporaryPlace = 0 then
              if Edit_P.Text = signEmpty then Edit_P.Text := temporaryString
              else
                Edit_P.Text := Edit_P.Text + signSeparate + temporaryString;
          end;
        end;

        x := Pos(operatorScanf, analyzeString);
        if x > 0 then
        begin
          for h := 1 to length(analyzeString) do
            if analyzeString[h] = signComma then break;
          Delete(analyzeString,1,h);
          count := Pos(temporaryString, analyzeString);
          if count > 0 then
          begin
            temporaryPlace := Pos(temporaryString, Edit_P.Text);
            if temporaryPlace = 0 then
              if Edit_P.Text = signEmpty then Edit_P.Text := temporaryString
              else
                Edit_P.Text := Edit_P.Text + signSeparate + temporaryString;
          end;
        end;
      end;
      analyzeString := signEmpty;
    end;
  end;
end;


procedure TMetrika.Watch_Modificate();
const
  signEqual = '=';
  signDoubleEqual = '==';
  signNotEqual = '!=';
  digitTwo = 2;
  signSeparate = ', ';
  signDoubleMinus = '--';
  signDoublePlus = '++';
  signOpenSquareBracket = '[';
  signOpenCircleBracket = '(';
var
  i, j, k, x, h, temporaryPlace, p, q : Integer;
  analyzeString, temporaryString : String;
begin
  analyzeString := signEmpty;
  for j := 1 to elementsCount do
    if massiveAllElements[j] = signEmpty then break;
  k := j-1;

  for i := 1 to Memo_Enter.Lines.Count-digitTwo do
  begin
    temporaryString := signEmpty;
    analyzeString := Memo_Enter.Lines[i];

    x := Pos(signEqual, analyzeString);
    p := Pos(signDoubleEqual, analyzeString);
    q := Pos(signNotEqual, analyzeString);
    if (x > 0) and ((p = 0) and (q = 0))then
    begin
      for h := x-2 downto 1 do
        if (analyzeString[h] = signSpace) or (analyzeString[h] = signOpenCircleBracket) then break;
      temporaryString := copy(analyzeString,h+1,x-digitTwo);

      for h:= 1 to length(temporaryString) do
        if temporaryString[h] = signSpace then break;
      Delete(temporaryString,h,length(temporaryString)-h+1);

      for h:= 1 to length(temporaryString) do
        if temporaryString[h] =signOpenSquareBracket then break;
      Delete(temporaryString,h,length(temporaryString)-h+1);

      for h := 1 to k do
        if temporaryString = massiveAllElements[h] then break;
      temporaryPlace := Pos(temporaryString, Edit_M.Text);
      if temporaryPlace = 0 then
        if Edit_M.Text = signEmpty then Edit_M.Text := temporaryString
        else
          Edit_M.Text := Edit_M.Text + signSeparate + temporaryString;
    end;

    x := Pos(signDoublePlus, analyzeString);
    if x > 0 then
    begin
      for h := x downto 1 do
        if (analyzeString[h] = signSpace)then break;
      temporaryString := copy(analyzeString,h+1,x-h-1);

      for h := 1 to k do
        if temporaryString = massiveAllElements[h] then break;
      temporaryPlace := Pos(temporaryString, Edit_M.Text);
      if temporaryPlace = 0 then
        if Edit_M.Text = signEmpty then Edit_M.Text := temporaryString
        else
          Edit_M.Text := Edit_M.Text + signSeparate + temporaryString;
    end;

    x := Pos(signDoubleMinus, analyzeString);
    if x > 0 then
    begin
      for h := x downto 1 do
        if (analyzeString[h] = signSpace)then break;
      temporaryString := copy(analyzeString,h+1,x-h-1);

      for h := 1 to k do
        if temporaryString = massiveAllElements[h] then break;
      temporaryPlace := Pos(temporaryString, Edit_M.Text);
      if temporaryPlace = 0 then
        if Edit_M.Text = signEmpty then Edit_M.Text := temporaryString
        else
          Edit_M.Text := Edit_M.Text + signSeparate + temporaryString;
    end;
    temporaryString := signEmpty;
    analyzeString := signEmpty;
  end;
end;


procedure TMetrika.Search(x: Integer; analyzeString: String; k: Integer; sender: Integer);
const
  digitTwo = 2;
  digitFive = 5;
  signSeparate = ', ';
  signOpenSquareBracket = '[';
  signOpenCircleBracket = '(';
  signCloseCircleBracket = ')';
  signPointComma = ';';
var
  i, j, temporaryPlace : Integer;
  temporaryFirstString, temporarySecondString : String;
begin
  if sender = 0 then
  begin
    for i := 1 to length(analyzeString) do
      if analyzeString[i] = signPointComma then break;
    Delete(analyzeString,1,i+1);

    for i := 1 to length(analyzeString) do
      if analyzeString[i] = signPointComma then break;
    Delete(analyzeString,i,length(analyzeString)-i+1);
  end;

  if sender = 1 then
  begin
    for i := x+digitTwo to length(analyzeString) do
      if analyzeString[i] = signOpenCircleBracket then break;
    Delete(analyzeString,1,i);
  end;

  if sender = digitTwo then
  begin
    for i := x+digitFive to length(analyzeString) do
      if analyzeString[i] = signOpenCircleBracket then break;
    Delete(analyzeString,1,i);
  end;

  if (sender = 1) or (sender = digitTwo) then
  begin
  for i := 1 to length(analyzeString) do
    if analyzeString[i] = signCloseCircleBracket then break;
  Delete(analyzeString,i,length(analyzeString)-i+1);
  end;

  for i := 1 to length(analyzeString) do
    if analyzeString[i] = signSpace then break;
  temporaryFirstString := Copy(analyzeString,1,i-1);

  for i := length(analyzeString) downto 1 do
    if analyzeString[i] = signSpace then break;
  temporarySecondString := Copy(analyzeString,i+1,length(analyzeString)-i+1);

  if sender = 1 then
  begin
    for i := 1 to length(temporarySecondString) do
      if temporarySecondString[i] = signOpenSquareBracket then break;
    Delete(temporarySecondString,i,length(temporarySecondString)-i+1);
  end;

  j := 0;
  for i := 1 to k do
    if temporaryFirstString = massiveAllElements[i] then
    begin
      j := 1;
      break;
    end;
  temporaryPlace := Pos(temporaryFirstString, Edit_C.Text);
  if (temporaryPlace = 0) and (j = 1) then
    if Edit_C.Text = signEmpty then Edit_C.Text := temporaryFirstString
    else
      Edit_C.Text := Edit_C.Text + signSeparate + temporaryFirstString;

  j := 0;
  for i := 1 to k do
    if temporarySecondString = massiveAllElements[i] then
    begin
      j := 1;
      break;
    end;
  temporaryPlace := Pos(temporarySecondString, Edit_C.Text);
  if (temporaryPlace = 0) and (j = 1) then
    if Edit_C.Text = signEmpty then Edit_C.Text := temporarySecondString
    else
      Edit_C.Text := Edit_C.Text + signSeparate + temporarySecondString;
end;


procedure TMetrika.Watch_Control();
const
  operatorFor = 'for';
  operatorIf = 'if';
  operatorWhile = 'while';
  operatorSwitch = 'switch';
  digitTwo = 2;
var
  i, j, k, x : Integer;
  analyzeString : String;
begin
  analyzeString := signEmpty;
  for j := 1 to elementsCount do
    if massiveAllElements[j] = '' then break;
  k := j-1;

  for i := 1 to Memo_Enter.Lines.Count-digitTwo do
  begin
    analyzeString := Memo_Enter.Lines[i];
    x := Pos(operatorFor, analyzeString);
    if x > 0 then Search(x, analyzeString, k, 0);

    x := Pos(operatorIf, analyzeString);
    if x > 0 then Search(x, analyzeString, k, 1);

    x := Pos(operatorWhile, analyzeString);
    if x > 0 then Search(x, analyzeString, k, digitTwo);

    x := Pos(operatorSwitch, analyzeString);
    if x > 0 then Search(x, analyzeString, k, digitTwo);
  end;
end;


procedure TMetrika.Analyze_ButClick(Sender: TObject);
const
  signComma = ',';
  signSeparate = ', ';
  signCountNull_T = '---';
  digitTwo = 2;
  digitThree = 3;
  digitHalf = 0.5;
var
  i, j, k, countElements_P, countElements_M, countElements_C, countElements_T : Integer;
  resultCount : Real;
  temporaryString : String;
begin
  for i := 1 to elementsCount do
    massiveAllElements[i] := signEmpty;
  Analyze();
  Analyze_For();
  for i := 1 to elementsCount do
  begin
    if massiveAllElements[i] = signEmpty then break;
    if i = 1 then Memo_Massive.Text := massiveAllElements[i]
    else
      Memo_Massive.Text := Memo_Massive.Text + signSeparate + massiveAllElements[i];
  end;
  Analyze_But.Enabled := False;
  Clean_But.Enabled := False;
  Watch_Input_Output();
  Watch_Modificate();
  Watch_Control();

  countElements_P := 0;
  temporaryString := Edit_P.Text;
  for j := 1 to i do
  begin
    k := Pos(massiveAllElements[j], temporaryString);
    if (k = 0) and (massiveAllElements[j] <> signEmpty) then
    begin
      inc(countElements_P);
      massiveNotFound_P[countElements_P] := massiveAllElements[j];
    end;
  end;

  countElements_M := 0;
  temporaryString := Edit_M.Text;
  for j := 1 to countElements_P do
  begin
    k := Pos(massiveNotFound_P[j], temporaryString);
    if (k = 0) and (massiveNotFound_P[j] <> signEmpty) then
    begin
      inc(countElements_M);
      massiveNotFound_M[countElements_M] := massiveNotFound_P[j];
    end;
  end;

  countElements_C := 0;
  temporaryString := Edit_C.Text;
  for j := 1 to countElements_M do
  begin
    k := Pos(massiveNotFound_M[j], temporaryString);
    if (k = 0) and (massiveNotFound_M[j] <> signEmpty) then
    begin
      inc(countElements_C);
      massiveNotFound_C[countElements_C] := massiveNotFound_M[j];
    end;
  end;

  countElements_T := 0;
  if countElements_C = 0 then Edit_T.Text :=  signCountNull_T
  else
  for j := 1 to countElements_C do
    if j = 1 then
      Edit_T.Text := massiveNotFound_C[j]
    else
      Edit_T.Text := Edit_T.Text + signSeparate + massiveNotFound_C[j];

  temporaryString := Edit_T.Text;
  if temporaryString <> signCountNull_T then countElements_T := 1;

  countElements_P := 0;
  temporaryString := Edit_P.Text;
  for i := 1 to length(temporaryString) do
    if temporaryString[i] = signComma then inc(countElements_P);
  if countElements_P <> 0 then inc(countElements_P);

  countElements_M := 0;
  temporaryString := Edit_M.Text;
  for i := 1 to length(temporaryString) do
    if temporaryString[i] = signComma then inc(countElements_M);
  if countElements_M <> 0 then inc(countElements_M);

  countElements_C := 0;
  temporaryString := Edit_C.Text;
  for i := 1 to length(temporaryString) do
    if temporaryString[i] = signComma then inc(countElements_C);
  if countElements_C <> 0 then inc(countElements_C);

  temporaryString := Edit_T.Text;
  for i := 1 to length(temporaryString) do
    if temporaryString[i] = signComma then inc(countElements_T);

  resultCount := countElements_P + digitTwo*countElements_M + digitThree*countElements_C + digitHalf*countElements_T;
  Edit_Result.Text := floattostr(resultCount);
end;
end.
