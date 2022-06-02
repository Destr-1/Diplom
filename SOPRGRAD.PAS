{Вычисление безусловного минимума методом сопряженных градиентов Флетчера-Ривса;
  nar и mar - внешние типы, обьявленные в основной программе OPTIM}
procedure SOPRGRAD(var x:nar; l:mar; r:real);
  var x1,k,k1,s,p:nar;   { x - точка пространства}
      i,j:integer;
      l1,b:real;

{*****************************************************************}
   {Скалярное произведение векторов}
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
  function norm(x:nar):real; {Вычиление нормы числа}
    var i:integer;
        t:real;
  begin
    t:=0;
    for i:=1 to n do
      t:=t+sqr(x[i]);
    norm:=sqrt(t);
  end;
{*****************************************************************}
  function f(x:nar):real;  {упрощение вида функции ML}
    begin f:=ML(x,l,r); end;

{$I golds1} {метод золотого сечения для одномерной минимизации - GOLDSECH}
{$I grad.pas}  {Вычисление частной производной}

begin {SOPRGRAD}
{вначале определяем начальную точку x}
  x[1]:=50;
  x[2]:=40;
{Вычисляем в т X0  S0=-f'(X0)   }
  GRAD(s,x);
  for i:=1 to n do
    s[i]:=-s[i];
  j:=0;
  repeat
    {На К-м шаге решаем задачу минимизации по l>=0 функции f(Xk+lSk),
      в результате чего определяем шаг l и точку Xk+1=Xk+lSk}
    l1:=GOLDSECH(x,s);   {одномерная минимизация методом золотого сечения}
    for i:=1 to n do
      x1[i]:=x[i]+l1*s[i];
    {Вычисляем величины f'(Xk)}
    GRAD(k,x);
    GRAD(k1,x1);
    { если ║ f'(Xk+1) ║ < e , то Xk+1 - решение задачи}
    for i:=1 to n do p[i]:=k1[i]-k[i];
    if (j mod n)<>0 then b:=scal(k1,p)/scal(k,k) else b:=0;
    for i:=1 to n do s[i]:=-k1[i]+b*s[i];
    x:=x1;
    writeln(k1[1],k1[2],norm(k1));
    inc(j);
  until norm(k1)<e;
end; {SOPRGRAD}