with Text_IO; use Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Numerics.Float_Random;
use Ada.Numerics.Float_Random;
with gestion_fractions; use gestion_fractions;
with gestion_polynomes; use gestion_polynomes;

procedure reed_solomon is

    subtype T_Size is Positive range 1..15;
    type T_Points is array (Positive range <>) of Integer;
    type T_Reed_Points(Size : T_Size := 1) is record
	Points : T_Points(1..Size);
    end record;

    procedure Put_Array(Points : T_Points) is
    begin
	for I in Points'Range loop
	    if Points(I) < 0 then
		Put(" " & Integer'Image(Points(I)));
	    else
		Put(Integer'Image(Points(I)));
	    end if;
	end loop;
    end Put_Array;

    function Produit(Points : T_Points; Interpolation_Current : Integer; Current : Integer) return T_Polynome is
	Result : T_Polynome := (Degre => Points'Length, Coeff => (others => (1, 1)));
    begin
	if not (Current > Points'Length) then -- Si on est encore dans le tableau.
	    if Current /= Interpolation_Current then -- On ne prend pas le point qu'on interpole.
		Result := ( T_Polynome'(Degre => 1, Coeff => (0 => (-Current, 1), 1 => (1, 1))) / T_Polynome'(Degre => 0, Coeff => ( 0 => (Interpolation_Current - Current, 1))) );
		return Result * Produit(Points, Interpolation_Current, Current + 1);
	    else
		return Produit(Points, Interpolation_Current, Current + 1);
	    end if;
	else -- Si on est a la fin du tableau.
	    return T_Polynome'(Degre => 0, Coeff => (0 => (1, 1)));
	end if;
    end Produit;

    function Interpolate(Points : T_Points) return T_Polynome is
	Result : T_Polynome := Alloc_Polyn(Points'Length - 1);
    begin
	for J in Points'Range loop
	    Result := Result + T_Fraction'(Points(J), 1) * Produit(Points, J, 1);
	end loop;
	return Result;
    end Interpolate;

    User_Input : T_Reed_Points;
    All_Points : T_Reed_Points;
    K : Positive := 2; -- Points de base a entrer.
    N : Positive := 2; -- Points a ajouter, le nombre d'erreurs qui pourront etre corrigees = N/2.
    Interpolation : T_Polynome;
    Gen : Generator;
    Rnd_Result : Integer;

begin
    if Argument_Count > 0 then
	User_Input := (Size => Argument_Count, Points => (others => 0));
	for I in 1..Argument_Count loop
	    User_Input.Points(I) := Integer'Value(Argument(I));
	end loop;
	Put(Interpolate(User_Input.Points));
    else
	User_Input := (Size => K, Points => (others => 0));
	All_Points := (Size => K + N, Points => (others => 0));

	Put("Bienvenue dans le programme Reed Solomon.");
	New_Line;
	Put("Nous allons maintenant proceder a la selection des" &  Integer'Image(K) & " nombres (0 - 255).");
	New_Line(2);

	for I in 1..K loop
	    Put("Veuillez entrer le point n" & Integer'Image(I) & " : ");
	    Get(User_Input.Points(I));
	end loop;
	All_Points.Points(1..K) := User_Input.Points;

	New_Line;
	Put("Voici le polynome d'interpolation pour les valeurs entrees : ");
	Interpolation := Interpolate(User_Input.Points);
	Put(Interpolation);
	New_Line;
	Put("Avec ce polynome, le programme a calcule les" & Integer'Image(N) & " prochains points, voici le tableau complet :");
	for I in K..(K + N) loop
	    All_Points.Points(I) := Eval(Interpolation, T_Fraction'(I, 1)).Num;
	end loop;
	Put_Array(All_Points.Points);

	New_Line;
	Put("Avec" & Integer'Image(N) & " valeurs en plus, l'algorithme peut corriger jusqu'a" & Integer'Image(N / 2) & " erreur(s).");
	New_Line;
	Put("Bruitage de" & Integer'Image(N / 2) & " erreurs : ");
	New_Line;

	Reset(Gen);
	for I in 1..(N/2) loop
	    Rnd_Result := Integer(0.5 + (Random(Gen) * Float(All_Points.Size)));
	    Put(Integer'Image(All_Points.Points(Rnd_Result)) & " =>");
	    All_Points.Points(Rnd_Result) := Integer(Random(Gen) * Float(255));
	    Put(Integer'Image(All_Points.Points(Rnd_Result)));
	    New_Line;
	end loop;

	New_Line;
	Put("Voici le tableau bruite : ");
	Put_Array(All_Points.Points);

	New_Line(2);
	Put("Debruitage en cours :");
	Put(" TO_DO");
    end if;
end reed_solomon;
