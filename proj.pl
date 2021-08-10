voo(
    sao_paulo,
    mexico,
    1111,
    8:00,
    (mesmo,16:00),
    0,
    azul,
    [ter,qua,sex]
).
voo(
    sao_paulo,
    nova_york,
    2222,
    6:00,
    (mesmo,16:00),
    1,
    tam,
    [ter,qua,sab]
).
voo(
    sao_paulo,
    lisboa,
    3333,
    8:00,
    (mesmo,14:00),
    0,
    gol,
    [ter,qua,sex]
).
voo(
    sao_paulo,
    madrid,
    4444,
    22:00,
    (seguinte,8:00),
    5,
    tam,
    [ter,qua,sex]
).

voo(
    sao_paulo,
    londres,
    5555,
    14:30,
    (seguinte,1:00),
    0,
    gol,
    [seg,qui,dom]
).
voo(
    sao_paulo,
    paris,
    6666,
    14:00,
    (seguinte,1:00),
    0,
    azul,
    [sab,ter,qui]
).
voo(
    mexico,
    nova_york,
    7777,
    14:00,
    (seguinte,1:00),
    0,
    tam,
    [sab,ter,qui]
).
voo(
    mexico,
    madrid,
    8888,
    14:00,
    (seguinte,1:00),
    0,
    gol,
    [sab,ter,qui]
).
voo(
    nova_york,
    londres,
    9999,
    14:00,
    (seguinte,1:00),
    0,
    azul,
    [sab,ter,qui]
).
voo(
    londres,
    lisboa,
    1010,
    14:00,
    (seguinte,1:00),
    0,
    gol,
    [sab,ter,qui]
).
voo(
    londres,
    paris,
    1212,
    14:00,
    (seguinte,1:00),
    0,
    azul,
    [sab,ter,qui]
).
voo(
    londres,
    estocolmo,
    1313,
    14:00,
    (seguinte,1:00),
    0,
    tam,
    [sab,ter,qui]
).
voo(
    madrid,
    paris,
    1414,
    14:00,
    (seguinte,1:00),
    0,
    tam,
    [sab,ter,qui]
).
voo(
    madrid,
    roma,
    1515,
    14:00,
    (seguinte,1:00),
    0,
    gol,
    [sab,ter,qui]
).
voo(
    madrid,
    frankfurt,
    1616,
    14:00,
    (seguinte,1:00),
    0,
    azul,
    [sab,ter,qui]
).
voo(
    frankfurt,
    estocolmo,
    1818,
    14:00,
    (seguinte,1:00),
    0,
    gol,
    [sab,ter,qui]
).
voo(
    frankfurt,
    roma,
    1919,
    14:00,
    (seguinte,1:00),
    0,
    azul,
    [sab,ter,qui]
).

pertence(Item,[Item|_]).
pertence(Item,[_|Cauda]) :-
    pertence(Item,Cauda).

hora(X:Y,X,Y).
pegahorario((D,H),D,H).

transformahorario(Hora,Trans) :-
    hora(Hora,X,Y),
    Trans is 60*X+Y.

duracao(HorarioSaida,HorarioChegada,Dura) :-
    transformahorario(HorarioSaida,S),
    pegahorario(HorarioChegada,mesmo,HC),
    transformahorario(HC,C),
    Dura is C - S.
duracao(HorarioSaida,HorarioChegada,Dura) :-
    transformahorario(HorarioSaida,S),
    pegahorario(HorarioChegada,seguinte,HC),
    transformahorario(HC,C),
    Dura is 24*60 - S + C.

voo_direto(Origem,Destino,Comp,Dia,Horario) :-
    voo(Origem,Destino,_,Horario,_,Esc,Comp,Dias),
    pertence(Dia,Dias),
    Esc =:= 0.

filtra_voo_dia_semana(Origem,Destino,DiaSemana,HorarioSaida,HorarioChegada,Companhia) :-
    voo(Origem,Destino,_,HorarioSaida,HorarioChegada,_,Companhia,Dias),
    pertence(DiaSemana,Dias).

roteiro(Origem, Destino,[Cod]) :-
    voo(Origem,Destino,Cod,_,_,_,_,_).
roteiro(Origem, Destino, [Cod|Cauda]) :-
    voo(Origem,Prov,Cod,_,_,_,_,_),
    roteiro(Prov,Destino,Cauda).

roteiro(Origem, Destino, DiaSaida, HorSaida, Duracao) :-
    voo(Origem,Destino,_,HorSaida,HorCheg,_,_,DiaSaida),
    duracao(HorSaida,HorCheg,Duracao).
roteiro(Origem, Destino, DiaSaida, HorSaida, Duracao) :-
    voo(Origem,Prov,_,HorSaida,HorCheg,_,_,DiaSaida),
    duracao(HorSaida,HorCheg,Dura1),
    roteiro(Prov, Destino,_,_,Duracao1),
    Duracao is Duracao1 + Dura1.

