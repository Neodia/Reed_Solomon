with Text_IO; use Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with gestion_fractions; use gestion_fractions;
with gestion_polynomes; use gestion_polynomes;

procedure calcul_polynomes is

    I : Integer := 1;
    Poly1 : T_Polynome;
    Poly2 : T_Polynome;

    INVALID_OPERATION : Exception;
begin

    if Argument_Count > 0 then
	while not (Character'Pos(Argument(I)(1)) < 48 or Character'Pos(Argument(I)(1)) > 57) or (Character'Pos(Argument(I)(1)) = 45 and Argument(I)'Length > 1) loop -- Tant que l'agument est un entier.
	    I := I + 1;
	end loop;

	Poly1 := Alloc_Polyn((I - 3) / 2);
	if not (I = 2) then -- S'il y a un polynome a gauche.
	    if not (I mod 2 = 0) then -- Si le polynome est correct.
		for J in 1..((Poly1.Degre + 1) * 2) loop
		    if J mod 2 = 0 then
			Poly1.Coeff((J - 2) / 2) := T_Fraction'(Integer'Value(Argument(J - 1)), Integer'Value(Argument(J)));
		    end if;
		end loop;
	    else -- Si le polynome est incorrect.
		raise INVALID_OPERATION;
	    end if;
	else -- S'il y a un entier a gauche.
	    Poly1.Coeff(0) := T_Fraction'(Integer'Value(Argument(1)), 1);
	end if;

	Poly2 := Alloc_Polyn((Argument_Count - I - 2) / 2);
	if not (Argument_Count - I = 1) then -- S'il y a un polynome a droite.
	    if not ((Argument_Count - I) mod 2 = 1) then -- Si le polynome est correct.
		for J in (I + 1)..Argument_Count loop
		    if (Argument_Count - J) mod 2 = 1 then
			Poly2.Coeff((J - I) / 2) := T_Fraction'(Integer'Value(Argument(J)), Integer'Value(Argument(J + 1)));
		    end if;
		end loop;
	    else -- Si le polynome est incorrect.
		raise INVALID_OPERATION;
	    end if;
	else -- S'il y a un entier a droite.
	    Poly2.Coeff(0) := T_Fraction'(Integer'Value(Argument(I + 1)), 1);
	end if;
    end if;

    case Argument(I)(1) is
    when '+' => Put(Poly1 + Poly2);
    when '-' => Put(Poly1 - Poly2);
    when 'x' => Put(Poly1 * Poly2);
    when '/' => Put(Poly1 / Poly2);
    when 'r' => Put(Reste(Poly1, Poly2));
    when 'e' => Put(Eval(Poly1, Poly2.Coeff(0)));
    when others => raise INVALID_OPERATION;
    end case;

exception
    when others => Put("Operation invalide.");
end calcul_polynomes;
