program statistic1;
uses crt,printer;
label 1;
{ Предварительная обработка исходных данных}
  const n1=63;n2=181;
{ Даны две выбррки a1 и b1}
  a1:array [1..n1] of byte=     (0,4,2,0,5,1,1,3,0,2,2,4,3,2,3,
                                 3,0,4,3,1,5,2,0,2,2,3,2,2,2,6,
                                 2,1,3,1,3,1,5,5,3,2,2,0,2,1,1,
                                 3,2,3,5,3,5,2,5,2,2,3,4,3,2,3,
                                 2,4,2);
  b1:array [1..n2] of byte =
       (135,133,124,132,104,152,134,130,129,120,122,124,
        117,123,123,129,121,122,125,131,147,124,137,112,
        126,128,111,129,115,147,131,132,137,119,125,120,
        129,125,123,127,132,118,133,132,132,134,131,120,
        135,132,125,132,108,114,121,133,133,135,131,125,
        114,115,122,131,125,132,120,126,115,117,118,118,
        132,134,127,127,124,135,128,127,115,144,129,120,
        137,127,125,116,132,120,117,127,118,109,127,122,
        120,135,116,118,133,136,125,126,119,126,129,127,
        129,124,127,132,126,131,127,130,126,124,135,132,
        124,123,123,130,132,143,122,139,120,134,108,136,
        121,111,123,140,137,120,125,131,118,120,120,134,
        129,127,116,138,128,133,122,131,128,140,138,124,
        120,126,109,137,111,115,117,130,113,126,115,135,
        125,118,115,128,123,129,128,120,115,134,118,127,
        134);
  var a: array [1..n1] of byte;
      b: array [1..n2] of byte;
      s1: array [1..n1,1..2] of byte;
      s2,s3: array [1..n2,1..2] of byte;
      s,t,w,i,j,j1,k,k1,ss1,ss2,ss3:byte;
      m,d:real;

{Эмпирические функции}
function f1(x:real):real;
  var f,i:integer;
  begin
    f:=0;
    for i:=1 to ss1 do
      if s1[i,1]<x then f:=f+s1[i,2];
    f1:=f/n1;
  end;

function f2(x:real):real;
  var f,i:integer;
  begin
    f:=0;
    for i:=1 to ss3 do
      if s3[i,1]<x then f:=f+s3[i,2];
    f2:=f/n2;
  end;

begin
  clrscr;
  writeln(lst,'Выборка A1');
  for i:=1 to n1 do a[i]:=a1[i];
{ Составим вариационный ряд}
  for i:=n1 downto 2 do
    begin
      k:=a[1];j1:=1;
      for j:=2 to i do
        if k<a[j] then begin k:=a[j]; j1:=j; end;
      k1:=a[i];
      a[i]:=k;
      a[j1]:=k1;
    end;
{  for i:=1 to n1 do write(a[i],' ');        }
{cтатистический ряд}
  s1[1,1]:=a[1];
  s1[1,2]:=1;
  ss1:=1;
  for i:=1 to n1-1 do
    if a[i]<>a[i+1] then begin
                           ss1:=ss1+1;
                           s1[ss1,1]:=a[i+1];
                           s1[ss1,2]:=1;
                         end
    else inc(s1[ss1,2]);
  writeln(lst,'Статистический ряд');
  for i:=1 to ss1 do
    writeln(lst,s1[i,1],'-',s1[i,2],' ');
{размах выборки}
  W:=s1[ss1,1]-s1[1,1];
  writeln(lst,'Размах выборки=',W);
{Матожидание}
  m:=0;
  for i:=1 to ss1 do
    m:=m+s1[i,1]*s1[i,2];
  m:=m/n1;
{ Дисперсия }
  d:=0;
  for i:=1 to ss1 do
    d:=d+sqr(s1[i,1]-m)*s1[i,2];
  d:=d/n1;
  writeln(lst,#13#10'Матожидание=',m,', Дисперсия=',d);
  writeln(lst,'Эмпирическая функция:');
  for i:=1 to ss1 do
    writeln(lst,f1(i-1),' при x<',s1[i,1]);
  writeln(lst,f1(ss1),' при x>',s1[ss1,1]);
{Часть программмы для выбоорки B1}
  writeln(lst,'Выборка B1');
  for i:=1 to n2 do b[i]:=b1[i];
{ Составим вариационный ряд}
  for i:=n2 downto 2 do
    begin
      k:=b[1];j1:=1;
      for j:=2 to i do
        if k<b[j] then begin k:=b[j]; j1:=j; end;
      k1:=b[i];
      b[i]:=k;
      b[j1]:=k1;
    end;
{  for i:=1 to n1 do write(b[i],' ');       }
{cтатистический ряд}
  s2[1,1]:=b[1];
  s2[1,2]:=1;
  ss2:=1;
  for i:=1 to n2-1 do
    if b[i]<>b[i+1] then begin
                           ss2:=ss2+1;
                           s2[ss2,1]:=b[i+1];
                           s2[ss2,2]:=1;
                         end
    else inc(s2[ss2,2]);
  writeln(lst,'Статистический ряд');;
  for i:=1 to ss2 do
    write(lst,s2[i,1],'-',s2[i,2],'  ');
{ Группированный статистический ряд }
  writeln(lst,'Группированный статистический ряд');
  t:=b[1]+4;
  s:=0;ss3:=1;
  for i:=1 to n2 do
  1:if b[i]<t then s:=s+1
      else begin {writeln(lst,t-4,'-',s);} s3[ss3,1]:=t-4; s3[ss3,2]:=s; inc(ss3);
                 writeln(lst,s3[ss3-1,1],'-',s3[ss3-1,2]);
            s:=0;t:=t+4;goto 1;end; writeln(lst,t-4,'-',s);
            s3[ss3,1]:=t-4; s3[ss3,2]:=s;
{размах выборки}
  W:=s2[ss2,1]-s2[1,1];
  writeln(lst,'Размах выборки=',W);

{Эмпирическмя функция}
  writeln(lst,'Эмпирическая функция:');
  for i:=1 to ss3 do
    writeln(lst,f2(s3[i,1]),' при x<',s3[i,1]);
  writeln(lst,f2(s3[ss3,1]+1),' при x>',s3[ss3,1]);
{Матожидание}
  m:=0;
  for i:=1 to ss2 do
    m:=m+s2[i,1]*s2[i,2];
  m:=m/n2;
{ Дисперсия }
  d:=0;
  for i:=1 to ss2 do
    d:=d+sqr(s2[i,1]-m)*s2[i,2];
  d:=d/n2;
  writeln(lst,'Матожидание=',m,', Дисперсия=',d);

end.