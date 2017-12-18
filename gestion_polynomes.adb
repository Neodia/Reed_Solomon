with Text_IO; use Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with gestion_fractions; use gestion_fractions;

package body gestion_polynomes is


    procedure Get(Poly : in out T_Polynome) is
    begin
        null;
    end Get;

    procedure Put(Poly : in T_Polynome) is
    begin
        if Poly.Degre /= 0 or Poly.Coeff(0).Num /= 0 then
            for I in Poly.Coeff'Range loop
                if Poly.Coeff(I).Num /= 0 then
                    Put(Poly.Coeff(I));
                else
                    Put(" 0 1");
                end if;
            end loop;
        else
            Put("0");
        end if;
    end Put;

    procedure Sort_Polyn(Poly1, Poly2 : in T_Polynome; Little, Bigger : in out T_Polynome) is
    begin
        if Poly1.Degre < Poly2.Degre then
            Little := Poly1;
            Bigger := Poly2;
        else
            Little := Poly2;
            Bigger := Poly1;
        end if;
    end Sort_Polyn;

    function Alloc_Polyn (N : Natural) return T_Polynome is
    begin
        return (Degre => N, Coeff => (others => (0, 1)));
    end Alloc_Polyn;


    function "+" (Left, Right : T_Polynome) return T_Polynome is
        Little : T_Polynome;
        Bigger : T_Polynome;
        Result : T_Polynome;
    begin
        Sort_Polyn(Left, Right, Little, Bigger);
        Result := Bigger;
        for I in Little.Coeff'Range loop -- On parcout uniquement le plus petit des deux polynomes.
            Result.Coeff(I) := Result.Coeff(I) + Little.Coeff(I);
        end loop;
        return Result;
    end "+";

    function "-" (Left, Right : T_Polynome) return T_Polynome is
        Little : T_Polynome;
        Bigger : T_Polynome;
        Result : T_Polynome;
        I : Integer;
    begin
        if Left.Degre = Right.Degre then -- Si les deux polynomes ont la meme taille.
            I := Left.Degre;
            -- Si le polynome de fin sera de degre plus petit, alors on cree un polynome a la bonne taille.
            while Left.Coeff(I).Num - Right.Coeff(I).Num = 0 and I > 0 loop
                I := I - 1;
            end loop;

            Result := Alloc_Polyn(I);
            for I in Result.Coeff'Range loop
                Result.Coeff(I) := Left.Coeff(I) - Right.Coeff(I);
            end loop;
        else
            Result := Left + (Right * T_Fraction'(-1, 1));
        end if;
        return Result;
    end "-";

    function "*" (Left, Right : T_Polynome) return T_Polynome is
        Result : T_Polynome := Alloc_Polyn(Left.Degre + Right.Degre);
    begin
        for I in Left.Coeff'Range loop
            for J in Right.Coeff'Range loop
                Result.Coeff(I + J) := Result.Coeff(I + J) + Left.Coeff(I) * Right.Coeff(J);
            end loop;
        end loop;
        return Result;
    end "*";

    function "*" (Left : T_Fraction; Right : T_Polynome) return T_Polynome is
    begin
        return T_Polynome'(Degre => 0, Coeff => (0 => Left)) * Right;
    end "*";

    function "*" (Left : T_PolyNome; Right : T_Fraction) return T_Polynome is
    begin
        return T_Polynome'(Degre => 0, Coeff => (0 => Right)) * Left;
    end "*";

    function "/" (Left, Right : T_Polynome) return T_Polynome is
        Quotient : T_Polynome; -- Quotient a retourner a la fin.
        Result : T_Polynome;   -- Resultat de la soustraction.
    begin
	if Right.Degre > Left.Degre then -- Si le diviseur est de degre plus grand que le divisé, on retourne directement le diviseur.
	    Quotient := T_Polynome'(Degre => 0, Coeff => (0 => T_Fraction'(0, 1)));
	else
	    Quotient := Alloc_Polyn(Left.Degre - Right.Degre);
	    Result := Left;
	    for I in reverse Quotient.Coeff'Range loop
		if Result.Degre >= Right.Degre then
		    Quotient.Coeff(I) := Result.Coeff(Result.Degre) / Right.Coeff(Right.Degre);
		    Result := Left -(Quotient * Right);
		end if;
	    end loop;
	end if;
	    return Quotient;
	end "/";

    -- Cette fonction a procede de la meme facon que la division, mais retourne
    -- le dernier resultat de la soustraction trouve au lieu de retourner le quotient.
    function Reste (Left, Right : T_Polynome) return T_Polynome is
        Quotient : T_Polynome; -- Quotient a retourner a la fin.
        Result : T_Polynome;   -- Resultat de la soustraction.
    begin
       if Right.Degre > Left.Degre then -- Si le diviseur est de degre plus grand que le divisé, on retourne directement le diviseur.
	    Quotient := T_Polynome'(Degre => 0, Coeff => (0 => T_Fraction'(0, 1)));
	else
	    Quotient := Alloc_Polyn(Left.Degre - Right.Degre);
	    Result := Left;
	    for I in reverse Quotient.Coeff'Range loop
		if Result.Degre >= Right.Degre then
		    Quotient.Coeff(I) := Result.Coeff(Result.Degre) / Right.Coeff(Right.Degre);
		    Result := Left -(Quotient * Right);
		end if;
	    end loop;
	end if;
	    return Result;
    end Reste;

    function Eval (Poly : T_Polynome; Value : T_Fraction) return T_Fraction is
        Result : T_Fraction := (0, 1);
    begin
	for I in reverse Poly.Coeff'Range loop
            Result := Result * Value + Poly.Coeff(I);
        end loop;
        return Result;
    end Eval;

end gestion_polynomes;
