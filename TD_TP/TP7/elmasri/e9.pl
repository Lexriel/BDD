schema([a,b,c,d,e,f,g,h,i,j]).

fds(
[
[[a,b],[c]],
[[a],[d,e]],
[[b],[f]],
[[f],[g,h]],
[[d],[i,j]]
]
).

%candidate keys
%schema(R),fds(F),candkey(R,F,K).
% K=[a,b].
% schema(R),fds(F),mincover(R,F,MinF).
% il y en a un grand nombre!

%schema(R),fds(F),threenf(R,F,R3NF).
% il y en a un grand nombre

% 19:16.
