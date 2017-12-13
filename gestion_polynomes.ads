with Text_IO; use Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with gestion_fractions; use gestion_fractions;

package gestion_polynomes is

    subtype T_Degre is Natural range 0..10000; 
    type T_Coeff is array (Integer range <>) of T_Fraction; 
    type T_Polynome(Degre : T_Degre := 0) is record
	Coeff : T_Coeff(0..Degre); 
    end record;
	
    -- Procedure qui affecte les valeurs données dans une variable T_Polynome.
    -- Parametre <Poly>    : Polynome a initialiser.
    procedure Get(Poly : in out T_Polynome);

    -- Procedure qui affiche une variable T_Polynome donnee.
    -- Parametre <Poly>    : Polynome a afficher.
    procedure Put(Poly : in T_Polynome);
   
    -- Procedure qui range le polynome de plus petit et plus grand degres dans les bonnes variables.
    -- Parametre <Poly1>   : Polynome.
    --           <Poly2>   : Polynome a afficher.
    --           <Little>  : Polynome a afficher.
    --           <Bigger>  : Polynome a afficher.
    procedure Sort_Polyn(Poly1, Poly2 : in T_Polynome; Little, Bigger : in out T_Polynome);


    -- Fonction qui additionne deux polynomes.
    -- Parametre <Left>    : Premier polynome.
    -- 	     <Right>   : Deuxieme polynome.
    -- Retourne le resultat de l'addition. (T_Polynome)
    function "+" (Left, Right : T_Polynome) return T_Polynome;

    -- Fonction qui soustrait deux polynomes.
    -- Parametre <Left>    : Premier polynome.
    -- 	     <Right>   : Deuxieme polynome.
    -- Retourne le resultat de la soustraction. (T_Polynome)
    function "-" (Left, Right : T_Polynome) return T_Polynome;

    -- Fonction qui multiplie deux polynomes.
    -- Parametre <Left>    : Premier polynome.
    -- 	     <Right>   : Deuxieme polynome.
    -- Retourne le resultat de la multiplication. (T_Polynome)
    function "*" (Left, Right : T_Polynome) return T_Polynome;

    -- Fonction qui multiplie un polynome par une fraction.
    -- Parametre <Left>    : Polynome a multiplier.
    -- 	     <Right>   : Fraction multiplicatrice.
    -- Retourne le resultat de la multiplication. (T_Polynome)
    function "*" (Left : T_Polynome; Right : T_Fraction) return T_Polynome;

    -- Fonction qui multiplie une fraction par un polynome.
    -- Parametre <Left>    : Fraction a multiplier.
    -- 	     <Right>   : Polynome multiplicateur.
    -- Retourne le resultat de la multiplication. (T_Polynome)
    function "*" (Left : T_Fraction; Right : T_Polynome) return T_Polynome;

    -- Fonction qui divise un polynome par un autre.
    -- Parametre <Left>    : Premier polynome.
    -- 	     <Right>   : Deuxieme polynome.
    -- Retourne le resultat de la division (Quotient). (T_Polynome)
    function "/" (Left, Right : T_Polynome) return T_Polynome;

    -- Fonction qui calcule le reste de la division d''un polynome par un autre.
    -- Parametre <Left>    : Premier polynome.
    -- 	     <Right>   : Deuxieme polynome.
    -- Retourne le reste de la division. (T_Polynome)
    function Reste (Left, Right : T_Polynome) return T_Polynome;

    -- Fonction qui evalue un polynome en une valeur.
    -- Parametre <Poly>    : Polynome a evaluer.
    -- 	     <Value>   : Valeur a laquelle le polynome sera evalue.
    -- Retourne le resultat de l'evaluation. (T_Fraction)
    function Eval (Poly : T_Polynome; Value : T_Fraction) return T_Fraction;

    -- Fonction qui cree un polynome vide de puissance n.
    -- Parametre <N>       : Degre du polynome a creer.
    -- Retourne le polynome de degre N cree. (T_Poylnome)
    function Alloc_Polyn (N : Natural) return T_Polynome;

end gestion_polynomes;
