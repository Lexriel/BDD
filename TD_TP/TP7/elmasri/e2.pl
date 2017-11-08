schema([ename,bdate,address,dnumber,dname,dmgrssn]).

fds(
[
[[ssn],[ename,bdate,address,dnumber]],
[[dnumber],[dname,dmgrssn]]
]
).

% closure ssn+ and dnumber+
%schema(R),fds(F),xplus(R,F,[ssn],Xplus).

%R = [ename, bdate, address, dnumber, dname, dmgrssn],
%F = [[[ssn], [ename, bdate, address, dnumber]], [[dnumber], [dname, dmgrssn]]],
%Xplus = [address, bdate, dmgrssn, dname, dnumber, ename, ssn].
%?- 

%schema(R),fds(F),xplus(R,F,[dnumber],Xplus).
%Xplus = [dmgrssn, dname, dnumber].
