with Text_IO; use Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with gestion_fractions; use gestion_fractions;
with gestion_polynomes; use gestion_polynomes;

procedure calcul_polynomes is
    polynome1 : T_Polynome := (Degre => 2, Coeff => (0 => (1, 2), 1 => (2, 3), 2 => (3, 4)));
    polynome2 : T_Polynome := (Degre => 3, Coeff => (0 => (1, 2), 1 => (5, 3), 2 => (3, 4), 3 => (3, 7)));
    frac : T_Fraction := (3, 1);
    f : T_Fraction := (3, 6);
begin
    Put("Addition : ");
    Put(polynome1 + polynome2);
    New_Line(1);

    Put("Soustraction : ");
    Put(polynome1 - polynome2);
    New_Line(1);

    Put("Multiplication : ");
    Put(polynome1 * polynome2);
    New_Line(1);

    Put("Multiplication par 3 : ");
    Put(polynome1 * frac);
    New_Line(1);
end calcul_polynomes;
