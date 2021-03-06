{���᫥��� ����᫮����� �����㬠 ��⮤�� ᮯ�殮���� �ࠤ���⮢ ������-����;
  nar � mar - ���譨� ⨯�, ������� � �᭮���� �ணࠬ�� OPTIM}
procedure SOPRGRAD(var x:nar; l:mar; r:real);
  var x1,k,k1,s,p:nar;   { x - �窠 ����࠭�⢠}
      i,j:integer;
      l1,b:real;

{*****************************************************************}
   {�����୮� �ந�������� ����஢}
   function SCAL(a,c:nar):real;
     var t:real;
         i:integer;
   begin
     t:=0;
     for i:=1 to n do
       t:=t+a[i]*c[i];
     SCAL:=t;
   end;
{****************************************************************}
  function norm(x:nar):real; {��稫���� ���� �᫠}
    var i:integer;
        t:real;
  begin
    t:=0;
    for i:=1 to n do
      t:=t+sqr(x[i]);
    norm:=sqrt(t);
  end;
{*****************************************************************}
  function f(x:nar):real;  {��饭�� ���� �㭪樨 ML}
    begin f:=ML(x,l,r); end;

{$I golds1} {��⮤ ����⮣� �祭�� ��� ������୮� ��������樨 - GOLDSECH}
{$I grad.pas}  {���᫥��� ��⭮� �ந�������}

begin {SOPRGRAD}
{���砫� ��।��塞 ��砫��� ��� x}
  x[1]:=50;
  x[2]:=40;
{����塞 � � X0  S0=-f'(X0)   }
  GRAD(s,x);
  for i:=1 to n do
    s[i]:=-s[i];
  j:=0;
  repeat
    {�� �-� 蠣� �蠥� ������ ��������樨 �� l>=0 �㭪樨 f(Xk+lSk),
      � १���� 祣� ��।��塞 蠣 l � ��� Xk+1=Xk+lSk}
    l1:=GOLDSECH(x,s);   {������ୠ� ���������� ��⮤�� ����⮣� �祭��}
    for i:=1 to n do
      x1[i]:=x[i]+l1*s[i];
    {����塞 ����稭� f'(Xk)}
    GRAD(k,x);
    GRAD(k1,x1);
    { �᫨ � f'(Xk+1) � < e , � Xk+1 - �襭�� �����}
    for i:=1 to n do p[i]:=k1[i]-k[i];
    if (j mod n)<>0 then b:=scal(k1,p)/scal(k,k) else b:=0;
    for i:=1 to n do s[i]:=-k1[i]+b*s[i];
    x:=x1;
    writeln(k1[1],k1[2],norm(k1));
    inc(j);
  until norm(k1)<e;
end; {SOPRGRAD}