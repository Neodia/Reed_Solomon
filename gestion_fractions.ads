PACKAGE Gestion_Fractions IS
   TYPE T_Fraction IS
      RECORD
         Num   : Integer;
         Denum : Integer;
      END RECORD;
   DIV_PAR_ZERO : EXCEPTION;

   -- Procedure qui affecte les valeurs données dans une variable T_Fraction.
   -- Parametre <Frac>    : Fraction à initialiser.
   --           <Nume>    : Numerateur de la fonction.
   --           <Denume>  : Denumerateur de la fonction.
   PROCEDURE Get (
         Frac   : IN OUT T_Fraction;
         Nume,
         Denume :        Integer);

   -- Procedure qui affiche une fraction donnee.
   -- Parametre <Frac>    : Fraction à afficher.
   PROCEDURE Put (
         Frac : IN     T_Fraction);

   -- Procedure qui reduit une fraction donnee.
   -- Parametre <Frac>    : Fraction à reduire.
   PROCEDURE Reduire (
         Frac : IN OUT T_Fraction);

   -- Fonction qui additionne deux fractions.
   -- Parametre <Left>    : Premiere fraction a additionner.
   -- Parametre <Right>   : Deuxieme fraction.
   -- Retourne l'addition des deux fractions.
   FUNCTION "+" (
         Left,
         Right : T_Fraction)
     RETURN T_Fraction;

   -- Fonction qui soustrait deux fractions.
   -- Parametre <Left>     : Fraction de gauche.
   -- Parametre <Right>    : Fraction de droite.
   -- Retourne la soustraction des deux fractions. (T_Fraction)
   FUNCTION "-" (
         Left,
         Right : T_Fraction)
     RETURN T_Fraction;

   -- Fonction qui multiplie deux fractions.
   -- Parametre <Left>     : Fraction de gauche.
   -- Parametre <Right>    : Fraction de droite.
   -- Retourne la multiplication des deux fractions. (T_Fraction)
   FUNCTION "*" (
         Left,
         Right : T_Fraction)
     RETURN T_Fraction;

   -- Fonction qui multiplie un entier par une fraction.
   -- Parametre <Left>     : Entier a multiplier.
   -- Parametre <Right>    : Fraction multiplicatrice.
   -- Retourne la multiplication de l'entier par la fraction. (T_Fraction)
   FUNCTION "*" (
         Left  : Integer;
         Right : T_Fraction)
     RETURN T_Fraction;

   -- Fonction qui multiplie une fraction par un entier.
   -- Parametre <Left>     : Fraction a multiplier.
   -- Parametre <Right>    : Entier multiplicateur.
   -- Retourne la multiplication de la fraction par l'entier. (T_Fraction)
   FUNCTION "*" (
         Left  : T_Fraction;
         Right : Integer)
     RETURN T_Fraction;

   -- Fonction qui divise une fraction par une autre.
   -- Parametre <Left>     : Fraction de gauche.
   -- Parametre <Right>    : Fraction de droite.
   -- Retourne la division des deux fractions. (T_Fraction)
   FUNCTION "/" (
         Left,
         Right : T_Fraction)
     RETURN T_Fraction;

   -- Fonction qui divise un entier par une fraction.
   -- Parametre <Left>     : Entier à diviser.
   -- Parametre <Right>    : Fraction qui divise.
   -- Retourne la division de l'entier par la fraction. (T_Fraction)
   FUNCTION "/" (
         Left  : Integer;
         Right : T_Fraction)
     RETURN T_Fraction;

   -- Fonction qui divise une fraction par un entier.
   -- Parametre <Left>     : Fraction a diviser.
   -- Parametre <Right>    : Entier qui divise.
   -- Retourne la division de la fraction par l'entier. (T_Fraction)
   FUNCTION "/" (
         Left  : T_Fraction;
         Right : Integer)
     RETURN T_Fraction;

   -- Fonction qui met à la puissance entiere une fraction.
   -- Parametre <Left>     : Fraction a mettre a la puissance.
   -- Parametre <Right>    : Puissance entiere.
   -- Retourne la fraction a la puissance entiere. (T_Fraction)
   FUNCTION "**" (
         Left  : T_Fraction;
         Right : Integer)
     RETURN T_Fraction;

   -- Fonction qui trouve le plus grand commun diviseur entre deux Positifs..
   -- Parametre <Nb1>     : Fraction de gauche.
   -- Parametre <Nb1>     : Fraction de droite.
   -- Retourne le plus grand commun diviseur. (Positif)
   FUNCTION PGCD (
         Nb1,
         Nb2 : Positive)
     RETURN Positive;

END Gestion_Fractions;
