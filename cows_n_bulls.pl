:- use_module(library(clpfd)).

intersect([],_,[]).
intersect([A|B], C, [A|D]) :- member(A, C), intersect(B,C,D).
intersect([A|B], C, D) :- not(member(A,C)), intersect(B,C,D).

match([], [], 0).
match([A|As], [Q|Qs], Num) :-
  A #= Q, Num #= N + 1, match(As, Qs, N).
match([A|As], [Q|Qs], Num) :-
  A #\= Q, match(As, Qs, Num).

present(Ans, Qn, Num) :-
  intersect(Ans, Qn, I),
  all_different(I),
  length(I, Num).

guess(Ans, Input) :-
  [Qn, Present, Match] = Input,
  present(Ans, Qn, Present),
  match(Ans, Qn, Match).

solve(Slots, Inputs) :-
  Slots = [A,B,C,D],
  Slots ins 0..9,
  all_different(Slots),
  A #\= 0,
  label(Slots),
  foreach(member(Input, Inputs), guess(Slots, Input)).

getList(Vals, GuessList) :-
  nl,
  writeln('Type in:'),
  writeln(Vals),
  nl,
  writeln('How many cows and how many bulls?'),
  read(C), read(B),
  Guess = [Vals,C,B],
  NewGuessList = [Guess|GuessList],
  solve(Ans, NewGuessList),
  getList(Ans, NewGuessList).

solve() :- getList([1,0,2,3], []).
