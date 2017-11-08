schema([a,b,c,d,e,f,g,h,i,j]).

fds(
[
[[a,b],[c]],
[[b,d],[d,f]],
[[b],[f]],
[[f],[g,h]],
[[d],[i,j]]
]
).


%candidate keys
%schema(R),fds(F),candkey(R,F,K).


%?- schema(R),fds(F),candkey(R,F,K).
%R = [a, b, c, d, e, f, g, h, i|...],
%F = [[[a, b], [c]], [[b, d], [d, f]], [[b], [f]], [[f], [g, h]], [[d], [i, j]]],
%K = [a, b, d, e] ;
%false.
% il y a une seule cle candidate

% schema(R),fds(F),mincover(R,F,MinF).
% encore cette fois il y en a un grand nombre

%schema(R),fds(F),threenf(R,F,R3NF).
% il y en a plusieurs

% 19:21
