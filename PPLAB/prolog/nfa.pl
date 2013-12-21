final(s3).
tran(s1,_,s1).
tran(s1,'a',s2).
tran(s2,'b',s3).
epsilon(s2,s4).
tran(s3,'b',s4).
epsilon(s3,s1).

accepts(State,[]):-
		final(State),
	        write('String accepted').
accepts(State,[X|Rest]):-
		tran(State,X,State1),
		accepts(State1,Rest).
accepts(State,[X|Rest]):-
		epsilon(State,State1),
		accepts(State1,[X|Rest]).
main(A):-
		accepts(s1,A).
		
