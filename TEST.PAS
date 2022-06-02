{Функция вычисления бикубического сплайна в точках a,b }
function BicubSpl1(a,b:real):real;
  label 2;
  type tdd=array [1..14,1..6] of real;
  const maxbicub=600;
  const fa:tdd =
         ((134,167,205,230,260,280),
          (150,184,220,247,279,300),
          (166,201,234,263,297,320),
          (182,216,249,280,312,340),
          (199,233,266,297,330,360),
          (214,249,282,314,348,380),
          (230,265,298,330,364,400),
          (246,282,313,347,382,420),
          (264,297,330,364,400,438),
          (282,313,347,382,417,460),
          (300,329,366,400,437,478),
          (316,348,382,415,455,496),
          (332,370,401,434,478,514),
          (350,388,420,455,500,532)
         );

  type
    td=array [1..25] of real;

  var
    N,M,IG1,N1,M1,I,J,IFAL:INTEGER ;
    CC,DD,VAL,VALL:real;
    XX,WORK,W,D,X1,Y1:td;
    {FA:tdd;}

  FUNCTION BICUBICZ(var N:integer; X, Y, W:td; T:real; IG:integer):real;
    var
       K,k1, N2:integer;
       A, B, C, V:real;
  begin
      K := 2;
      N2 := N;
      while not((T<=X[K]) OR (K=N2)) do
        K := K + 1;
      K1 := K - 1;
      A := X[K] - X[K1];
      B := X[K] - T;
      C := T - X[K1];
      V := (W[K1]*B*B*B+W[K]*C*C*C+(6.0*Y[K]-W[K]*A*A)*C+(6.0*Y[K1]-W[K1]*A*A)*B)/(6.0*A);
      BICUBICZ := V;
  end;
  procedure BICUBICY(var NP1:integer; X, Y, W, D:td; IG:integer);
     label 40;
     var
       NM, N,N1, I, I1, I2:integer;
       A, B, C, E, DI1:real;
    begin
      N := NP1 - 1;
      NM := N - 1;
      N1 := N + 1;
      for I:=1 to NM do
        D[I] := 0.0;
      I := N;
   40:I := I - 1;
      I1 := I + 1;
      I2 := I + 2;
      A := X[I2] - X[I1];
      B := X[I1] - X[I];
      C := Y[I2] - Y[I1];
      E := Y[I1] - Y[I];
      IF (I-N+1)=0 then
        begin
          D[I]:= (X[I2]-X[I])/3.0;
          W[I1]:= C/A - E/B;
        end
      else
        begin
          DI1:= D[I1];
          D[I]:=(12.0*DI1*(X[I2]-X[I])-A*A)/(36.0*DI1);
          W[I1]:=C/A-E/B-A*W[I2]/(6.0*DI1);
        end;
      IF (I-1)>0 then goto 40;
      W[1]:=0.0;
      W[N1]:=0.0;
      for I:=1 to NM do
        begin
          I1:=I+1;
          IF (I-1)=0 then W[I1]:=W[I1]/D[I]
            else W[I1]:=(6.0*W[I1]-(X[I1]-X[I])*W[I])/(6.0*D[I]);
        end;
  END;
  procedure BICUBICF(var A, B:real; X, Y:td; F:tdd; XX, WORK,W,D:td;
                IG1, M1, N1:integer; var VAL, VALL:real;var IFAIL:integer);
    var
      M, N, J, I:integer;
    begin
      IF ((A<X[1]) OR (A>X[N1])) then begin ifail:=1; exit; end;
      IF ((B<Y[1]) OR (B>Y[M1])) then begin ifail:=1; exit; end;
      IFAIL := 0;
      M := M1 - 1;
      N := N1 - 1;
      for J:=1 to M1 do
        begin
          for i:=1 to N1 do
              WORK[I]:=F[I,J];
           BICUBICY(N1, X, WORK, W, D, IG1);
           XX[J]:=BICUBICZ(N1,X,WORK,W,A,IG1);
        end;
      BICUBICY(M1, Y, XX, W, D, IG1);
      VAL:=BICUBICZ(M1,Y,XX,W,B,IG1);
      for I:=1 to N1 do
        begin
           for J:=1 to M1 do
             WORK[J]:=F[I,J];
           BICUBICY(M1, Y, WORK, W, D, IG1);
           XX[I]:=BICUBICZ(M1,Y,WORK,W,B,IG1);
        end;
      BICUBICY(N1, X, XX, W, D, IG1);
      VALL:=BICUBICZ(N1,X,XX,W,A,IG1);
  END;

begin
N:=0;
M:=0;
IG1:=0;
N1:=0;
M1:=0;
IFAL:=0;
CC:=0;
DD:=0;
VAL:=0;
VALL:=0;
for i:=1 to 25 do
begin
XX[i]:=0;
WORK[i]:=0;
W[i]:=0;
D[i]:=0;
X1[i]:=0;
Y1[i]:=0;
end;
{write('Ввести N ');
  READln(N);}
  n:=13;
  IF N<=0 then exit;
  {write('Ввести M ');
  READ(M);}
  m:=5;
  IF (N-M)<=0 then ig1:=m
    else ig1:=n;
{  write('Ввести A,B ');
  READln(A,B);}
  N1:=N+1;
  M1:=M+1;
  IG1:=IG1+1;
  {for I:=1 to N1 do
    begin
      CC:=I;
      X1[I]:=CC*0.5;
      for J:=1 to M1 do
        begin
          DD:=J;
          Y1[J]:=1.0+DD*0.25;
          FA[I,J]:=X1[I]*X1[I]+Y1[J];
        end;
    end; }
    for i:=0 to 5 do
      y1[i+1]:=i*30;
    for i:=0 to 13 do
      x1[i+1]:=30+i*5;
 { writeln('point at vhich function is evaluated(',A:11:5,B:11:5,')');}
  BICUBICF(A,B,X1,Y1,FA,XX,WORK,W,D,IG1,M1,N1,VAL,VALL,IFAL);
  IF (IFAL-1)<>0 then
    begin
      BicubSpl1:=VAL;
    end
  else BicubSpl1:=maxbicub;
END;
