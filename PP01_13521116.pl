/*Untuk File .pl*/

/* Bagian I */
/* Deklarasi Fakta */
pria(gede).
pria(gojo).
pria(vonneumann).
pria(vanrossum).
pria(bambang).
pria(vito).
pria(ave).
pria(wesly).
pria(elonmusk).
pria(patrick).

wanita(indah).
wanita(lovelace).
wanita(khelli).
wanita(power).
wanita(aqua).
wanita(wulandari).
wanita(anya).

usia(gede, 96).
usia(indah, 92).
usia(gojo, 90).
usia(lovelace, 79).
usia(khelli, 89).
usia(vonneumann, 92).
usia(vanrossum, 65).
usia(bambang, 60).
usia(vito, 56).
usia(power, 50).
usia(ave, 54).
usia(aqua, 50).
usia(wulandari, 24).
usia(wesly, 26).
usia(elonmusk, 28).
usia(patrick, 24).
usia(anya, 4).


menikah(gede, indah).
menikah(indah, gede).
menikah(gojo, lovelace).
menikah(lovelace, gojo).
menikah(khelli, vonneumann).
menikah(vonneumann, khelli).
menikah(vito, power).
menikah(power, vito).
menikah(ave, aqua).
menikah(aqua, ave).
menikah(wulandari, wesly).
menikah(wesly, wulandari).

anak(vanrossum, gede).
anak(bambang, gede).
anak(vito, gede).
anak(vanrossum, indah).
anak(bambang, indah).
anak(vito, indah).
anak(power, gojo).
anak(ave, gojo).
anak(power, lovelace).
anak(ave, lovelace).
anak(aqua, khelli).
anak(aqua, vonneumann).
anak(wesly, vito).
anak(wesly, power).
anak(elonmusk, ave).
anak(patrick, ave).
anak(elonmusk, aqua).
anak(patrick, aqua).
anak(anya, wesly).
anak(anya, wulandari).

saudara(vanrossum, bambang).
saudara(vanrossum, vito).
saudara(bambang, vanrossum).
saudara(bambang, vito).
saudara(vito, vanrossum).
saudara(vito, bambang).
saudara(power, ave).
saudara(ave, power).
saudara(elonmusk, patrick).
saudara(patrick, elonmusk).
 
/* Deklarasi Rules */
/* No 2.a */
/* X adalah kakak dari Y apabila X adalah saudara Y dan usia X > usia Y */
kakak(X,Y) :- saudara(X,Y), usia(X,A), usia(Y,B), A>B.

/* No 2.b */
/* X adalah keponakan dari Y apabila X adalah anak dari saudara Y */
/* X keponakan bagi seseorang, maka X juga keponakan untuk si Pasangan (suami atau istri) */
keponakan(X,Y) :- (anak(X,Z), saudara(Z,Y));(anak(X,Z), saudara(Z,W), menikah(W,Y)).

/* No 2.c */
/* X suami Y apabila X menikah dengan Y, X adalah pria dan Y adalah wanita */
suami(X,Y) :- pria(X), menikah(X,Y).

/* No 2.d */
/* X sepupu y apabila X adalah anak dari Z, Y adalah anak dari W, dan Z adalah saudara W */
sepupu(X,Y) :- anak(X,Z), anak(Y,W), saudara(Z,W).

/* No 2.e */
/* X menantu dari Y apabila X menikah dengan Z dan Z adalah anak dari Y*/
menantu(X,Y) :- menikah(X,Z), anak(Z,Y).
/* X dan Z sudah pasti bukan saudara kandung, maka anak(Z,Y) pasti bukan anak(X,Y);

/* No 2.f */
/* X adalah orang tua dari Y, bila Y adalah anak dari X */
orangtua(X,Y) :- anak(Y,X).

/* No 2.g */
/* X adalah bibi dari Y apabila Y keponakan X dan X adalah wanita */
bibi(X,Y) :- keponakan(Y,X), wanita(X).

/* No 2.h */
/* X adalah cucu dari Y apabila X anak dari Z dan Z anak dari Y */
cucu(X,Y) :- anak(X,Z), anak(Z,Y).

/* No 2.i */
/* X keturunan dari Y apabila X anak dari Y atau X adalah keturunan dari Z dimana Z anak Y */
keturunan(X,Y) :- anak(X,Y).
keturunan(X,Y) :- anak(X,Z), keturunan(Z,Y).

/* No 2.j */
/* X adalah anak sulung apa bila  X adalah kakak dari semua kemungkinan dan bukanlah adik */
/* X adalah anak tunggal bila x adalah anak dari seseorang (entah ibu atau ayah) dan tidak punya saudara. anak tunggal adalah anak sulung */
anaksulung(X) :- (kakak(X,_), \+kakak(_,X)); anak(X,Y), \+saudara(_,X), pria(Y).

/* No 2.k */
/* X adalah anak bungsu apabila X adalah adik dari semua kemungkinan yang ada, dan bukanlah kakak */
/* Anak tunggal adalah anak bungsu */
anakbungsu(X) :- kakak(_,X), \+kakak(X,_); anak(X,Y), \+saudara(_,X), pria(Y).


/* Bagian II */

/* No 1 - Combination */
/* Deklarasi Fakta */
combination(N, 1, N).
combination(N, N, 1).

/* Deklarasi Rules */
/* nCr = (n-1)C(r-1) + (n-1)Cr rumus dari penggunaan segitiga paskal untuk penentuan nilai kombinasi*/
combination(N, C, X) :- NA is N-1, CA is C-1, NA >0, CA >0, combination(NA, CA, ZA),
                        NB is N-1, NB > 0, C > 0, combination(NB, C, ZB),
                        X is ZA + ZB.

/* No 2 - Change */
/* Deklarasi Fakta */
change(1, 1).
change(1, 2).
change(1, 5).

/* Deklarasi Rules */
change(X,Y) :- (YA is Y-5, Y >= 5, change(XA, YA), X is XA + 1,!);
               (YB is Y-2, Y >= 2, change(XB, YB), X is XB + 1,!);
               (YC is Y-1, Y >= 1, change(XC, YC), X is XC + 1,!).

/* No 3 - FPB */
/* Deklarasi Fakta */
fpb(_,1,1).
fpb(_,0,0).

/* Deklarasi Rules */
fpb(A,B,X):- (B > A, fpb(B,A,X),!);
            /* Memastikan bahwa A tetap lebih besar dari B */
            (C is A mod B, C = 0, X is B,!);
            /* Jika A mod B adalah 0, mengembalikan B */
            (A1 is B, B1 is A mod B, fpb(A1, B1, Z), X is Z).
            /* Rumus euclidean */

/* No 4 - Mod */
/* Deklarasi Fakta */
mod(_,1,0).
mod(A,A,0).

/* Deklarasi Rules */
mod(A,B,X) :- ((B > A, B > 0, A >=0, X is A, !);
            /* Mengembalikan bila B lebih kecil dari A */
            ( A1 is A-B, mod(A1, B, X))),!.
            /* Nilai A dikurangi terus */


/* No 5 - Deret */
/* Deklarasi Fakta */
deret(1,1).

/* Deklarasi Rules */
deret(A,X) :- (A1 is A mod 2, (A1 = 0, Y is A -1, deret(Y, Z), X is Z+1), !;
            /* untuk suku yang genap, nilai ditambah 1 */
            ( A \= 1, A1 = 1, Y is A-1, deret(Y,Z), X is Z*2)),!.
            /*untuk suku ganjil , nilai di kali 2 */

/* Bagian III */

/* No A - Statistik List - Min*/
/* Deklarasi Fakta */
min([H], H).

/* Deklarasi Rules */
min([H|T], Min) :- (min(T, NewMin), H < NewMin,  Min is H); (min(T, Min), H >= Min), !.
                /* Kondisi pertama, program akan masuk hingga ke basis, lalu melakukan rekursif ulang ke atas */
                /* Bila nilai H (head) lebih kecil dari nilai NewMin yang dikembalikan, maka nilai H menjadi Min yang baru */
                /* Bila nilai H lebih besar atau sama dengan nilai Min, maka nilai Min tidak diubah */

/* No A - Statistik List - Max*/
/* Deklarasi Fakta */
max([H], H).

/* Deklarasi Rules */
max([H|T], Max) :- (max(T, NewMax), H > NewMax,  Max is H); (max(T, Max), H =< Max), !.
                /* Kondisi pertama, program akan masuk hingga ke basis, lalu melakukan rekursif ulang ke atas */
                /* Bila nilai H (head) lebih besar dari nilai NewMax yang dikembalikan, maka nilai H menjadi Max yang baru */
                /* Bila nilai H lebih kecil atau sama dengan nilai Max, maka nilai Max tidak diubah */

/* No A - Statistik List - Range*/
/* Deklarasi Fakta */

/* Deklarasi Rules */
range(List, Range) :- max(List, MaxVal), min(List, MinVal), Range is MaxVal - MinVal.
                /* Range adalah selisih dari nilai maksimum dan nilai minimum pada list, */
                /* Maka dari itu, gunakan fungsi yang telah dibuat */


/* No A - Statistik List - Count*/
/* Deklarasi Fakta */
count([], 0).

/* Deklarasi Rules */
count([_|T], Count) :- count(T, NewCount), Count is NewCount + 1.
                /* Untuk setiap iterasi elemen pada list, nilai count ditambah 1 */

/* No A - Statistik List - Sum*/
/* Deklarasi Fakta */       
sum([], 0).

/* Deklarasi Rules */
sum([H|T], Sum) :- sum(T, NewSum), Sum is NewSum + H.
                /* Untuk setiap iterasi elemen pada list, nilai sum ditambah dengan nilai H (head) */

/* No B - List and Queue Manipulation - Get Index*/
/* Deklarasi Fakta */    
getIndex([H], H, 1).
getIndex([H|_], H, 1).

/* Deklarasi Rules */
getIndex([_|T], Elmt, Result) :- getIndex(T, Elmt, NewResult),  Result is NewResult+1, !.
                /* Melakukan cek untuk setiap iterasi, nilai Result ditambah 1 ( seperti count ) */

/* No B - List and Queue Manipulation - Swap*/

/* Menggunakan bantuan fungsi lain */
/* Menghapus element pada list dengan index tertentu, 
mengembalikan elemen yang dihapus (E) dan list setelah penghapusan */
/* Fakta */
delListIndex([E], E ,1, []).
delListIndex([E|Tail], E ,1,Tail).
/* Rules */
delListIndex([H|T], E,  X, [H|ResTail]) :- delListIndex(T, E, XNew, ResTail), X is XNew + 1.

/* Memasukkan element tertentu (E) pada list dengan index tertentu, 
mengembalikan list setelah penambahan */
/* Fakta */
addListIndex([], E, 1,[E]).
addListIndex(List, E, 1, [E|List]).
/* Rules */
addListIndex([H|T], E, X, [H|ResTail]) :- addListIndex(T, E, XNew, ResTail), X is XNew + 1.

/* Deklarasi Fakta */
swap([],_,_,[]).
swap(List,X,X,List).

/* Deklarasi Rules */
/*swap(List, Idx1, Idx2, ResultList) :- */

swap(List, Idx1, Idx2, Result) :- count(List, Nelmt), Idx1 =< Nelmt, Idx2 =< Nelmt, Idx1 > 0, Idx2 > 0,
                                Idx1 < Idx2, swap(List, Idx2, Idx1, Result), !.
                            /* Memastikan bahwa Idx1 dan Idx2 adalah Index yang valid */
                            /* Memastikan bahwa Idx1 lebih besar dari Idx2 */

swap(List, Idx1, Idx2, Result) :- count(List, Nelmt), Idx1 =< Nelmt, Idx2 =< Nelmt, Idx1 > 0, Idx2 > 0,
                                Idx1 > Idx2,
                            /* Memastikan bahwa Idx1 dan Idx2 adalah Index yang valid */
                            /* Menghapus terlebih dahulu elemen index yang ingin di swap */
                            delListIndex(List, Elmt1, Idx1, Temp1),
                            delListIndex(Temp1, Elmt2, Idx2, Temp2),
                            /* Memasukkan kembali elemen dengan index yang ditukar */
                            addListIndex(Temp2, Elmt1, Idx2, Temp3),
                            addListIndex(Temp3, Elmt2, Idx1, Result), !.

/* No B - List and Queue Manipulation - SplitList*/
/* Deklarasi Fakta */
splitList([],[],[]).

/* Deklarasi Rules */
splitList([H|T], Odd, [H|TEven]) :- ( Test is H mod 2, Test = 0, splitList(T, Odd, TEven)), !.
                                /* Untuk kasus genap, nilai H dimasukkan ke list genap */
splitList([H|T], [H|TOdd], Even) :- ( Test is H mod 2, Test = 1, splitList(T, TOdd, Even)), !.
                                /* Untuk kasus ganjil, nilai H dimasukkan ke list ganjil */  




/* Bagian Bonus */

/* Deklarasi Variabel Global */
:- dynamic(program/1).
:- dynamic(currentVal/1).

/* Assign nilai untuk variabel global */
currentVal(0).
program(0).

/* Untuk setiap program (selain start dan exit) perlu dipastikan 
bahwa program sedang dalam keadaan aktif (program(1)) */
/* Untuk setiap program yang tidak tertera pada spek Pra Praktikum aspek bonus,
tidak perlu di check statenya (state tentang apakah program sedang aktif atau tidak),
karena dianggap tidak accessible untuk user */

startCalculator :-
    /* Mengubah state program menjadi 1, program dijalankan atau diaktifkan */
    /* Memberi pesan selamat datang dan menampilkan current value */
    changeState(1),
    currentVal(OldVal),
    changeCurrentVal(OldVal, 0),
    write('Selamat Datang di Kalkulator Prolog!'), nl,
    getValue, !.

add(X) :-
    program(1),
    currentVal(OldVal),
    printOldVal,
    NewVal is OldVal + X,
    /* Mengubah current value dengan hasil penjumlahan */
    changeCurrentVal(OldVal, NewVal),
    printNewVal,!.

subtract(X) :-
    program(1),
    currentVal(OldVal),
    printOldVal,
    NewVal is OldVal - X,
    /* Mengubah current value dengan hasil pengurangan */
    changeCurrentVal(OldVal, NewVal),
    printNewVal,!.

multiply(X) :-
    /* Memastikan bahwa program sedang dalam keadaan aktif (program(1)) */
    program(1),
    currentVal(OldVal),
    printOldVal,
    NewVal is OldVal * X,
    /* Mengubah current value dengan hasil perkalian */
    changeCurrentVal(OldVal, NewVal),
    printNewVal,!.

divide(X) :-
    program(1),
    currentVal(OldVal),
    printOldVal,
    NewVal is OldVal / X,
    /* Mengubah current value dengan hasil pembagian */
    changeCurrentVal(OldVal, NewVal),
    printNewVal,!.

clearCalculator :-
    program(1),
    currentVal(OldVal),
    printOldVal,
    NewVal is 0,
    /* Mengubah current value menjadi 0 */
    changeCurrentVal(OldVal, NewVal),
    printNewVal,!.

getValue :-
    /* Mengembalikan current value */
    program(1),
    printCurrentVal,!.

changeCurrentVal( Old, New) :-
    /* Mengubah nilai current value */
    retract(currentVal(Old)),
    asserta(currentVal(New)),!.

printCurrentVal :-
    /* Menampilkan nilai current value */
    currentVal(X),
    write('Current Saved Value is '), write(X), nl,!.

printOldVal :-
    /* Menampilkan nilai old value */
    currentVal(X),
    write('Old Saved Value is '), write(X), nl,!.

printNewVal :-
    /* Menampilkan nilai new value */
    currentVal(X),
    write('New Saved Value is '), write(X), nl,!.

changeState(NewState):-
    /* Mengubah state dari state lama menjadi state baru 
    bisa digunakan untuk mengaktifkan atau mengnonaktifkan program */
    retractall(program(_)), 
    asserta(program(NewState)),!.

exitCalculator :-
    /* Perlu dicek bahwa program sedang aktif 
    Kalkulator tidak bisa dimatikan, bila kalkulator tidak dinyalakan */
    program(1), 
    /* Menampilkan pesan selamat tinggal dan mengubah state */
    write('Terima Kasih telah Menggunakan Kalkulator Prolog'),
    changeState(0),!.
