procedure GRAD(var s,x:nar);
  const h=1E-03;
  var x1:nar;
      i:integer;
begin
  x1:=x;
  for i:=1 to n do
    begin
      x1[i]:=x[i]+h;
      s[i]:=(f(x1)-f(x))/h;
      x1[i]:=x[i];
    end;
end;