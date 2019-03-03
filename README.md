# DisAssemble
Generated two optimized executables by dissasembling the original executable and finding what every mystery function does.

*(Readme is written in **Romanian language**)*

mystery1() - functie ce calculeaza lungimea sirului de input
@string: adresa de inceput a sirului

Analizand codul dezasamblat, se observa ca functia are un singur argument. In
urma analizei dinamice, reiese ca acest argument este adresa unui sir de
caractere, functia calculand lungimea acestuia.
Sirul trebuie sa fie unul ASCIIZ, deoarece, din bucla de calculare a lungimii
sirului, singura conditie de iesire este atunci cand s-a ajuns la caracterul
NULL (0x00).
Astfel, functia parcurge sirul si creste un contor pana la intalnirea
caracterului NULL, oprindu-se la intalnirea acestuia.
Prin urmare, functia este similara cu functia "strlen" din limbajul C ca
functionalitate, ea intorcand la final lungimea sirului.

Return: lungimea sirului

prototip: int length(char *string);
________________________________________________________________________________

mystery2() - functie ce intoarce pozitia unui caracter in cadrul sirului de
             input
@string: adresa de inceput a sirului
@searched_char: caracterul cautat

Functia primeste doua argumente, care, in urma analizarii codului, se dovedesc
a fi adresa unui sir si un caracter.
Se determina lungimea sirului prin apel catre functia length(mystery1), iar
apoi se parcurge sirul si se incrementeaza un contor cu fiecare caracter care
difera de cel primit ca argument. Astfel, cand s-a gasit in sir prima aparitie
a caracterului, se intoarce valoarea contorului, aceasta fiind prima pozitie a
caracterului cautat in cadrul sirului.
Codul prezinta, insa, un bug: daca sirul nu contine caracterul, parcurgerea
continua si dupa terminarea acestuia deoarece nu se testeaza nicaieri
terminarea sirului, permitand astfel exploatarea datelor aflate in memorie in
continuarea sirului.
Se testeaza in urma cautarii daca sirul este vid, caz in care se returneaza -1.

Return: pozitia din sir a caracterului cautat sau -1 daca sirul are lungimea 0

prototip: int index_of(char *string, char searched_char);
________________________________________________________________________________

mystery3() - functie care verifica daca cele doua siruri de input difera pe o
             anumita lungime
@string1: adresa de inceput a sirului 1
@string2: adresa de inceput a sirului 2
@length: lungimea de verificare

In urma analizei functiei, se observa ca aceasta are 3 argumente. Primul si al
doilea sunt adresele sirurilor care vor fi comparate, iar al treilea o valoare
reprezentand lungimea pe care se verifica egalitatea dintre cele doua siruri.
Functia compara byte cu byte cele doua siruri, iar conditia de iesire din bucla
este cazul in care s-au gasit doua caractere diferite pe aceeasi pozitie sau
daca s-a ajuns la lungimea specificata.
Daca se iese din bucla in mod normal (s-a ajuns la lungimea specificata), adica
cele doua siruri sunt identice pe lungimea data, functia returneaza 0. Daca,
insa, se iese din bucla pentru ca au fost gasite doua caractere diferite,
functia returneaza 1.

Return: 1 daca sirurile difera, 0 daca sunt identice

prototip: bool are_different(char *string1, char *string2, int length);
________________________________________________________________________________

mystery4() - functie ce copiaza sirul de la adresa sursa la adresa destinatie
@destination: adresa de inceput a sirului destinatie
@source: adresa de inceput a sirului sursa
@length: lungimea care se copiaza din sursa in destinatie

Functia primeste trei argumente. Analiza codului, atat statica, cat si
dinamica, arata ca acestea sunt doua adrese de siruri si o lungime.
Functia parcurge al doilea sir in limita lungimii precizate si copiaza byte cu
byte din acesta in sirul destination.
In cod s-a strecurat o eroare care poate fi exploatata in mod negativ: nu se
testeaza daca s-a ajuns la sfarsitul sirului sursa, astfel se pot copia date
din alte locatii de memorie decat cea rezervata sirului sursa daca lungimea
precizata depaseste lungimea sirului sursa.

prototip: void copy(char *destination, char *source, int length);
________________________________________________________________________________

mystery5() - functie ce verifica daca caracterul dat este cifra
@digit_char : caracterul verificat

Analizand functia in limbaj de asamblare se observa ca aceasta primeste un
singur argument, de asteptat un caracter, lucru confirmat si de analiza in
timpul executiei.
Functia verifica daca acesta este cifra prin comparatia cu 0x30 (cifra 0 in
codul ASCII) si 0x39 (cifra 9 in codul ASCII). In cazul in care caracterul este
egal cu una din cele doua valori sau se afla intre acestea, functia returneaza
1. In schimb, returneaza 0.
Prin urmare functia intoarce o valoare de adevar asupra situatiei in care
caracterul trimis ca argument este o cifra din codul ASCII (este intre
0x30(inclusiv) si 0x39(inclusiv)).

Return: 1 in cazul in care caracterul este cifra, 0 in caz contrar

prototip: bool is_digit(char digit_char);
________________________________________________________________________________

mystery6() - functie ce inverseaza sirul de input
@string : adresa de inceput a sirului

In urma analizarii functiei reiese ca aceasta are un singur argument, anume
adresa unui sir de caractere.
Functia determina lungimea sirului (prin apelul functiei corespunzatoare),
aloca pe stiva spatiul necesar, apoi pune sirul pe stiva astfel: cate un
caracter de la stanga la dreapta incepand de la valori mari ale stivei catre
valori mici.
Functia apeleaza apoi functia copy(mystery4), oferind ca argument al
destinatiei chiar adresa de inceput a sirului initial. Asadar, la iesirea din
functie, in zona de memorie unde se afla sirul de la intrarea in functie se va
afla sirul inversat. Caracterul terminator de sir (0x00, NULL) isi pastreaza
pozitia si nu este inclus in vreuna dintre operatiile executate de functie.

prototip: void reverse(char* string);
________________________________________________________________________________

mystery7() - functie ce transforma in reprezentare binara sirul de caractere
             din input daca acesta reprezinta un numar natural
@string: adresa de inceput a sirului

Analizand codul dezasamblat, se observa ca functia are un singur argument care
se dovedeste a fi adresa de inceput a unui sir in urma analizelor statice si
dinamice asupra codului.
Functia calculeaza lungimea acestui sir si apoi il inverseaza. Va lua apoi
fiecare byte de la sfarsitul sirului spre inceput, va verifica daca este cifra
prin intermediul functiei is_digit(mystery5). In cazul in care caracterul nu
reprezinta o cifra, functia se incheie intorcand -1. Daca reprezinta o cifra,
se scade 0x30 pentru a avea efectiv cifra, nu codul ASCII corespunzator
acesteia.
Apoi rezultatul partial obtinut pana la acel moment se inmulteste cu 10 urmand
sa se adune cifra nou gasita. Astfel, la finalul functiei, daca sirul de input
reprezinta un numar, functia intoarce acest numar efectiv, ca un intreg, nu ca
un sir de caractere.
Functia opereaza strict pe caractere ce reprezinta cifre, asadar introducerea
oricarui alt numar in afara de unul natural va face ca functia ce verifica daca
un caracter este cifra sa returneze fals la intalnirea minusului (pentru numere
negative) sau la intalnirea virgulei/punctului (pentru numere zecimale), iar
functia curenta va returna la randul ei -1. Situatie similara este si in cazul
intalnirii unui caracter in afara intervalului de la 0x30 la 0x39.

Return: numarul natural din sirul de caractere sau -1 daca sirul nu este
        reprezentat de un numar natural

prototip: int to_uint(char* string);
________________________________________________________________________________

mystery8() - functie ce verifica daca un numar specificat de caractere dintr-un
             subsir se regaseste in sirul de input
@string: adresa de inceput a sirului
@substring: adresa de inceput a subsirului
@length: numarul primelor caractere din subsir pentru care se face verificarea

Functia primeste 3 argumente. Analiza statica efectuata asupra codului si cea
dinamica in cadrul executiei arata ca cele 3 argumente sunt doua siruri si un
numar. Primul sir este sirul in care se cauta primele <length> caractere din
cel de-al doilea sir.
In cadrul functiei exista un contor care arata cate caractere consecutive au
fost identificate identice intre sir si subsir.
Functia incepe prin a compara acest contor cu numarul primit ca argument. Daca
s-a atins numarul cerut de caractere identice, functia returneaza 1, semn ca
s-a gasit ceea ce s-a dorit. Daca inca nu s-a atins numarul, functia preia
mereu urmatorul caracter din sir si testeaza daca este caracterul de linie
noua(0x0a \n) sau terminator de sir(0x00 NULL).
Daca s-a ajuns la capatul sirului (unul din caracterele anterioare a fost
intalnit), inseamna ca nu s-a gasit ceea ce a fost cerut spre verificare, deci
functia intoarce 0. Daca nu s-a ajuns la finalul sirului, se verifica in
continuare daca acesta contine partea precizata din subsir. Astfel ca la
intalnirea unei perechi de caractere care difera, contorul redevine 0. Daca s-a
gasit o pereche de caractere egale, contorul este incrementat.
Prin urmare, functia verifica daca in <string> exista subsirul reprezentat de
primele <length> caractere din <substring>.

Return: 1 daca s-au gasit primele length caractere din subsir in sir, 0 in caz
        contrar

prototip: bool contains(char *string, char *substring, int length);
________________________________________________________________________________

mystery9() - functie ce afiseaza liniile din limita specificata a sirului de
             input in care se afla subsirul dat
@string: adresa de inceput a sirului
@start_index: indexul de la care incepe cautarea
@end_index: indexul la care se opreste cautarea
@substring: subsirul cautat

Analizand codul atat static, cat si dinamic, se observa ca functia primeste 4
argumente. Acestea sunt: un sir, doi intregi si inca un sir.
Executia functiei arata ca functia afiseaza fiecare linie completa(adica se
termina cu 0x0a (\n)) din limitele specificate ale sirului de input(de la
caracterul de pe pozitia egala cu al doilea argument si pana la caracterul de
pe pozitia egala cu al treilea argument) in care se regaseste subsirul dat.
Functia porneste cautarea de la pozitia de start precizata si o incheie la
pozitia de sfarsit, astfel, se poate considera ca functia, cu toate ca primeste
un intreg sir de caractere, ea lucreaza doar cu o portiune a acestuia. Aceasta
portiune este impartita in functie de caracterul separator de linii (0x0a \n),
iar fiecare linie este trimisa impreuna cu subsirul dat ca argument si lungimea
lui(deoarece se cauta tot subsirul) in functia contains(mystery8).
Aceasta intoarce daca exista sau nu subsirul in linia trimisa la verificare si,
daca exista, functia curenta afiseaza linia. In caz contrar, nu se afiseaza
nimic si se trece la linia urmatoare.

prototip: void find(char *string, int start_index, int end_index,
                    char *substring);
________________________________________________________________________________

TEMA3                          Comanda utilizator                          TEMA3

NUME
        tema3 - cauta subsir in sir

REZUMAT
        ./tema3 [-f subsir] [-i fisier] [-s index] [-e index]

DESCRIERE
        Cauta un subsir in sirul citit de la mediul de intrare standard sau in
        sirul din fisier, in ambele situatii intre indecsii optionali precizati.

        -f subsir
            specifica subsirul care va fi cautat

        -i fisier
            specifica fisierul in care va fi efectuata cautarea

        -s index
            specifica indexul in sir de la care incepe cautarea

        -e index
            specifica indexul din sir la care se opreste cautarea. Caracterul
            linie noua \n pozitionat la sfarsitul sirului este considerat parte
            din sir.
            
    Utilizare:
        Fara argumente, programul este echivalentul comenzii echo. Citeste un
        rand de la mediul de intrare si il afiseaza.
        Folosirea oricarui argument fara ce trebuie sa il succeada va duce la
        Segmentation Fault.
        Rularea cu argumentul [-f subsir] va cauta <subsir> in sirul ce va fi
        citit de la mediul de intrare. Completarea comenzii cu [-s index] va
        porni cautarea de la caracterul din sir aflat la indexul precizat.
        Caz similar si pentru [-e index], cautarea oprindu-se la caracterul de
        la indexul precizat (caracterul de linie noua este luat in calcul).
        Argumentele -s si -e pot fi folosite simultan. Comanda prezinta acelasi
        comportament daca se completeaza cu [-i fisier], numai ca sirul in care
        se cauta nu mai este preluat de la mediul de intrare, ci din fisier.
        In cazul citirii de la mediul de intrare se trateaza linia citita. In
        schimb, in cazul citirii din fisier, se trateaza separat fiecare linie a
        acestuia. Liniile trebuie sa contina toate caracterul de linie noua \n.
        Comanda preia sirul si se ocupa doar de portiunea precizata de [-s
        index] si [-e index]. Daca acestea nu sunt precizate, comanda se executa
        asemanator cu [-s 0] [-e <lungime sir + 1>], adica se cauta in tot sirul
        citit. Din sirul ramas, se preia fiecare linie individual si se afiseaza
        doar daca aceasta contine subsirul precizat prin [-f subsir].

    Exemple de utilizare:                                        ____________
        Se considera fisierul "file" cu urmatoarea structura:   |abcdefg     |
                                                                |iocla       |
                                                                |tema3 abcd  |
                                                                |____________|

        Ce introduce utilizatorul este marcat cu <
        Ce se afiseaza este marcat cu >

        1:    <./tema3
              <in cazul asta face echo
              >in cazul asta face echo

              Prin urmare se afiseaza ce s-a citit de la linia de comanda.

        2.    <./tema3 -f
              >Segmentation fault (core dumped)

              <./tema3 -f subsir -i
              >Segmentation fault (core dumped)

              Indiferent de argument, scrierea incompleta a acestuia duce la
              eroarea Segmentation fault.

        3.    <./tema3 -f abc
              <abcdef
              >abcdef

              <./tema3 -f abc
              <xyz
              |Nu se afiseaza nimic|

              <./tema3 -f abc -s 2
              <abcdef
              |Nu se afiseaza nimic|

              <./tema3 -f abc -s 2
              <12abcdef
              >abcdef

              <./tema3 -f abc -s 2 -e 8
              <12abcdef
              |Nu se afiseaza nimic|

              <./tema3 -f abc -s 2 -e 9
              <12abcdef
              >abcdef

              <./tema3 -i file
              |Nu se afiseaza nimic|

              <./tema3 -f abc -i file
              >abcdefg
              >tema3 abcd

              <./tema3 -f abc -i file -s 3
              > tema3 abcd

              <./tema3 -f abc -i file -e 4
              |Nu se afiseaza nimic|

              <./tema3 -f abc -i file -e 8
              >abcdefg

              <./tema3 -f iocla -i file
              >iocla

              <./tema3 -f iocla -i file -s 8 -e 14
              >iocla


    Status iesire:
        0        daca OK,

        139      daca cel putin un argument nu este complet,

        249      daca s-a rulat cu argumentul -i si fisierul precizat nu a putut
                 fi deschis.

IOCLA                            Decembrie 2018                            TEMA3
________________________________________________________________________________

Optimizari de viteza:
        Am urmarit, in general, sa lucrez cat mai mult cu operatii pe siruri,
        deoarece acestea se executa mai rapid decat prelucrarea normala a
        sirurilor. Astfel functiile precum cea de determinare a lungimii unui
        sir (mystery1) sau de a identifica daca doua siruri difera (mystery3)
        le-am implementat cu operatii pe siruri. Cel mai mult timp economisit a
        fost la rescrierea functiei mystery8, ajungand de la ~22s la ~14s. O
        alta imbunatatire a fost la functia mystery9, ajungand de la ~14s la
        ~10s. Am constatat astfel ca nu doar folosirea operatiilor pe siruri m-a
        ajutat, dar si scaderea drastica a apelurilor pe stiva, cat si a
        folosirii ei. In mystery7 am inlocuit inmultirea cu 10 prin
        instructiunea "mul" cu shift-area la dreapta a numarului cu 3 biti si cu
        1 bit (echivalent inmultirii cu 8, respectiv cu 2), adunand apoi
        rezultatele obtinute. De asemenea, nu am mai inversat sirul prin functia
        mystery6 deoarece reprezenta timp de executie in plus. Alte apeluri 
        numeroase catre stiva au fost scoase prin imbunatatirea functiei
        mystery9.

Optimizari de dimensiune:
        La construirea celor doua programe optimizate am inceput prin a optimiza
        mai intai viteza. Insa de fiecare data cand puteam inlocui o
        instructiune de genul "mov eax, 0" cu "xor eax, eax", am facut-o inca
        din programul optimizat pentru viteza (de asemenea, "xor eax, eax" este
        mai rapida ca "mov eax, 0" pentru ca nu se prelucreaza imediatul 0).
        Astfel, codul de dimensiune este asemanator cu cel de viteza.
        Imbunatatind viteza de executie, am folosit instructiuni mai putine,
        am apelat stiva de cat mai putine ori, am urmarit un cod care face
        strict ce trebuie si astfel am ajuns sa am un cod atat care se executa
        mai rapid, cat si care genereaza un executabil de dimensiuni reduse fata
        de cel generat prin folosirea functiilor din "tema3.o" sau "tema3". Prin
        urmare, imbunatatirea a fost de la ~5300 bytes la ~4800 bytes.
