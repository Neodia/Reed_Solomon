WITH Ada.Text_IO;
USE Ada.Text_IO;
WITH Ada.Integer_Text_IO;
USE Ada.Integer_Text_IO;

-- Les entêtes des fonctions sont sur le fichier ads.
PACKAGE BODY Gestion_Fractions IS

   PROCEDURE Get (
         Frac   : IN OUT T_Fraction;
         Nume,
         Denume : IN     Integer) IS
      Result : T_Fraction := (Num => Nume, Denum => Denume);
   BEGIN
      Frac := Result;
   END Get;

   PROCEDURE Put (
         Frac : IN     T_Fraction) IS
   BEGIN
      Put(Integer'Image(Frac.Num) & " " & Integer'Image(Frac.Denum));
   END Put;

   FUNCTION PGCD (
         Nb1,
         Nb2 : Positive)
     RETURN Positive IS
      Rest   : Natural  := 1;
      Little : Positive;
      Big    : Positive;
   BEGIN
      -- Met le bonnes valeurs dans les bonnes variables.
      IF Nb1 < Nb2 THEN
         Little := Nb1;
         Big := Nb2;
      ELSE
         Little := Nb2;
         Big := Nb1;
      END IF;

      -- Algorithme d'Euclide
      Rest := Big mod Little;
      WHILE Rest /= 0 LOOP
         Big := Little;
         Little := Positive(Rest);
         Rest := Big mod Little;
      END LOOP;
      RETURN Little;
   END PGCD;

   PROCEDURE Reduire (
         Frac : IN OUT T_Fraction) IS
      Divisor : Natural := PGCD (Frac.Num, Frac.Denum);
   BEGIN
      Frac.Num := Frac.Num / Divisor;
      Frac.Denum := Frac.Denum / Divisor;
   END Reduire;

   FUNCTION "+" (
         Left,
         Right : T_Fraction)
     RETURN T_Fraction IS
      Result : T_Fraction;
   BEGIN
      Result.Num := (Left.Num * Right.Denum) + (Right.Num * Left.Denum);
      Result.Denum := Left.Denum * Right.Denum;
      Reduire(Result);
      RETURN Result;
   END "+";

   FUNCTION "-" (
         Left,
         Right : T_Fraction)
     RETURN T_Fraction IS
      Result : T_Fraction;
   BEGIN
      Result.Num := (Left.Num * Right.Denum) - (Right.Num * Left.Denum);
      Result.Denum := Left.Denum * Right.Denum;
      Reduire (Result);
      RETURN Result;
   END "-";

   FUNCTION "*" (
         Left,
         Right : T_Fraction)
     RETURN T_Fraction IS
      Result : T_Fraction;
   BEGIN
      Result.Num := Left.Num * Right.Num;
      Result.Denum := Left.Denum * Right.Denum;
      Reduire (Result);
      RETURN Result;
   END "*";

   FUNCTION "*" (
         Left  : Integer;
         Right : T_Fraction)
     RETURN T_Fraction IS
      Result : T_Fraction;
   BEGIN
      Result.Num := Left * Right.Num;
      Result.Denum := Right.Denum;
      Reduire (Result);
      RETURN Result;
   END "*";

   FUNCTION "*" (
         Left  : T_Fraction;
         Right : Integer)
     RETURN T_Fraction IS
      Result : T_Fraction;
   BEGIN
      Result.Num := Left.Num * Right;
      Result.Denum := Left.Denum;
      Reduire (Result);
      RETURN Result;
   END "*";

   FUNCTION "/" (
         Left,
         Right : T_Fraction)
     RETURN T_Fraction IS
      Result : T_Fraction;
   BEGIN
      Result.Num := Left.Num * Right.Denum;
      Result.Denum := Left.Denum * Right.Num;
      Reduire (Result);
      RETURN Result;
   END "/";

   FUNCTION "/" (
         Left  : Integer;
         Right : T_Fraction)
     RETURN T_Fraction IS
      Result : T_Fraction;
   BEGIN
      Result.Num := Left * Right.Denum;
      Result.Denum := Right.Num;
      Reduire (Result);
      RETURN Result;
   END "/";

   FUNCTION "/" (
         Left  : T_Fraction;
         Right : Integer)
     RETURN T_Fraction IS
      Result : T_Fraction;
   BEGIN
      IF Right /= 0 THEN
         Result.Num := Left.Num;
         Result.Denum := Left.Denum * Right;
         Reduire (Result);
         RETURN Result;
      ELSE
         RAISE DIV_PAR_ZERO;
      END IF;
   END "/";

   FUNCTION "**" (
         Left  :        T_Fraction;
         Right : IN     Integer)
     RETURN T_Fraction IS
      Result : T_Fraction;
   BEGIN
      -- Ada n'accepte pas les puissances négatives, c'est pour cela que je regarde si celle-ci est négative ou pas, puis je traite selon dans quel cas on se trouve.
      IF Right >= 0 THEN
         Result.Num := Left.Num ** Right;
         Result.Denum := Left.Denum ** Right;
      ELSE
         Result.Num := Left.Denum ** (Right * (-1));
         Result.Denum := Left.Num ** (Right * (-1));
      END IF;
      Reduire (Result);
      RETURN Result;
   END "**";
END Gestion_Fractions;