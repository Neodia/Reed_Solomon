WITH Ada.Text_IO;
USE Ada.Text_IO;
WITH Ada.Integer_Text_IO;
USE Ada.Integer_Text_IO;
WITH Ada.Command_Line;
USE Ada.Command_Line;
WITH Gestion_Fractions;
USE Gestion_Fractions;

PROCEDURE Calcul_Fractions IS
   Frac1 : T_Fraction := (Num => 1, Denum => 1);
   Frac2 : T_Fraction := (Num => 1, Denum => 1);
   Nb    : Integer;

BEGIN
   -- Lecture des arguments et assignation des valeurs.
   IF Argument_Count = 4 THEN -- S'il y a seulement 4 arguments. (Fraction, operateur et scalaire)
      IF Character'Pos(Argument(2)(1)) < 48 OR Character'Pos(Argument(2)(1)) > 57 THEN -- Si l'operateur est a la deuxieme place. (Scalaire à gauche et fraction à droite.)
         Nb := Integer'Value(Argument(1));
         Get(Frac1, Integer'Value(Argument(3)), Integer'Value(Argument(4)));

         -- Seulement ces operations sont possibles dans cet ordre.
         IF Argument(2) = "x" THEN
            Put(Nb * Frac1);
         ELSIF Argument(2) = "/" THEN
            Put(Nb / Frac1);
         ELSE
            Put("Operation non valide.");
         END IF;
      ELSE  -- Si l'operateur est a la troixieme place. (Fraction à gauche et scalaire à droite.)
         Nb := Integer'Value(Argument(4));
         Get(Frac1, Integer'Value(Argument(1)), Integer'Value(Argument(2)));

         -- Seulement ces operations sont possibles dans cet ordre.
         IF Argument(3) = "x" THEN
            Put(Frac1 * Nb);
         ELSIF Argument(3) = "/" THEN
            Put(Frac1 / Nb);
         ELSIF Argument(3) = "p" THEN
            Put(Frac1 ** Nb);
         ELSE
            Put("Operation non valide.");
         END IF;
      END IF;
   ELSIF Argument_Count = 5 THEN -- S'il y a 5 arguments. (2 fractions & 1 scalaire)
      Get(Frac1, Integer'Value(Argument(1)), Integer'Value(Argument(2)));
      Get(Frac2, Integer'Value(Argument(4)), Integer'Value(Argument(5)));

      CASE Argument(3)(1) IS
         WHEN '+' =>
            Put(Frac1 + Frac2);
         WHEN '-' =>
            Put(Frac1 - Frac2);
         WHEN 'x' =>
            Put(Frac1 * Frac2);
         WHEN '/' =>
            Put(Frac1 / Frac2);
         WHEN OTHERS =>
            Put("Operation non valide.");
      END CASE;
   ELSIF Argument_Count = 3 THEN -- Si on veut faire un PGCD
      IF Argument(3) = "PGCD" THEN
         Put(Integer'Image(PGCD(Integer'Value(Argument(1)), Integer'Value(Argument(2)))));
      ELSE
         Put("Operation non valide.");
      END IF;
   ELSE
      Put("Operation non valide.");
   END IF;

EXCEPTION
   WHEN DIV_PAR_ZERO =>
      Put("Division par zero impossible !!!");
   WHEN OTHERS =>
      Put("Operation non valide.");
END Calcul_Fractions;
