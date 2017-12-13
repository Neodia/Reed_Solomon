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
	if Poly.Degre /= 0 then
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
	    Sort_Polyn(Left, Right, Little, Bigger);
	    Result := Bigger;
	    if Bigger.Degre = Right.Degre then  -- Si c'est le plus grand qui soustrait, on met au négatif les Coefficients qui sont plus grand que le degre du petit polynome.
		Result * (-1);
	    end if;

	    for I in Little.Coeff'Range loop -- On parcourt uniquement le plus petit des deux polynomes.
		Result.Coeff(I) := Left.Coeff(I) - Right.Coeff(I);
	    end loop;
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
	Tmp : T_Polynome := (Degre => 0, Coeff => (0 => Left));
    begin
	return Tmp * Right;
    end "*";

    function "*" (Left : T_PolyNome; Right : T_Fraction) return T_Polynome is
	Tmp : T_Polynome := (Degre => 0, Coeff => (0 => Right));
    begin
	return Tmp * Left;
    end "*";

    function "/" (Left, Right : T_Polynome) return T_Polynome is
    begin
	return Left;
    end "/";

    function Reste (Left, Right : T_Polynome) return T_Polynome is
    begin
	return Left;
    end Reste;

    function Eval (Poly : T_Polynome; Value : T_Fraction) return T_Fraction is
    begin
	return Value;
    end Eval;

    function Alloc_Polyn (Poly : T_Polynome; Value : T_Fraction) return T_Polynome is
    begin
	return Poly;
    end Alloc_Polyn;

end gestion_polynomes;
