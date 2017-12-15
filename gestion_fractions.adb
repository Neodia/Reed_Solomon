WITH Ada.Text_IO;
USE Ada.Text_IO;
WITH Ada.Integer_Text_IO;
USE Ada.Integer_Text_IO;

-- Les entêtes des fonctions sont sur le fichier ads.
PACKAGE BODY Gestion_Fractions IS

    -- Ne fonctionne pas avec des compostantes composees de plus de deux chiffres.
    procedure Get(Frac : in out T_Fraction) is
        User_Input : String(1..5) := (others => ' ');
        Last : Integer;
        Result : T_Fraction;
    begin
        Get_Line(User_Input, Last);
        if Last = 1 then -- S'il a entre un entier.
            Result := (Integer'Value(String'(1 => User_Input(1))), 1);
        elsif Last = 3 then -- S'il a entre une fraction avec deux chiffres.
            Result := (Integer'Value(String'(1 => User_Input(1))), Integer'Value(String'(1 => User_Input(3))));
        elsif Last = 4 then -- Si une des composantes de la fraction êst composé de 2 chiffres.
            if Character'Pos(User_Input(2)) < 48 OR Character'Pos(User_Input(2)) > 57 then -- Si c'est le denumerateur.
              Result := (Integer'Value(String'(1 => User_Input(1))), Integer'Value(String'(1 => User_Input(3), 2=> User_Input(4))));
            else -- Si c'est le denumerateur.
                Result := (Integer'Value(String'(1 => User_Input(1), 2 => User_Input(2))), Integer'Value(String'(1 => User_Input(4))));
            end if;
        elsif Last = 5 then
            Result := (Integer'Value(String'(1 => User_Input(1), 2 => User_Input(2))), Integer'Value(String'(1 => User_Input(4), 2 => User_Input(5))));
        else
            raise Constraint_Error;
        end if;
        Reduire(Result);
        Frac :=  Result;
    end Get;

    PROCEDURE Get (
		   Frac   : IN OUT T_Fraction;
		   Nume,
		   Denume : IN     Integer) IS
	Result : T_Fraction := (Num => Nume, Denum => Denume);
    BEGIN
	Frac := Result;
    END Get;

    PROCEDURE Put (Frac : IN     T_Fraction) IS
    BEGIN
	if Frac.Num >= 0 then
	    Put(Integer'Image(Frac.Num) & Integer'Image(Frac.Denum));
	else
	    Put(" " & Integer'Image(Frac.Num) & Integer'Image(Frac.Denum));
	end if;
    END Put;

    FUNCTION PGCD (Nb1,
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

    PROCEDURE Reduire (Frac : IN OUT T_Fraction) IS
	Divisor : Positive;
    BEGIN
        if Frac.Denum = 0 then
            raise DIV_PAR_ZERO;
        end if;

	if Frac.Num /= 0 then
	    Divisor := PGCD (abs(Frac.Num), abs(Frac.Denum));
        else
	    Divisor := Frac.Denum;
	end if;
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
	Tmp : T_Fraction := (Left, 1);
    BEGIN
	    RETURN Tmp * Right; -- On appelle la fonction qui multiplie deux fractions.
	END "*";

	FUNCTION "*" (
	       Left  : T_Fraction;
	       Right : Integer)
		  RETURN T_Fraction IS
	    Tmp : T_Fraction := (Right, 1);
	BEGIN
	    RETURN Tmp * Left; -- On appelle la fonction qui multiplie deux fractions.
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
