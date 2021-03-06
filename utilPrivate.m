(* Yi Wang, 2013, tririverwangyi@gmail.com, GPLv3 *)
BeginPackage["MathGR`utilPrivate`"]

defQ
plus2list
expand2list
apply2term
replaceTo
getSampleTerm
times2prod
prod2times
prod
add2set
add2pattern
take

Begin["`Private`"]

SetAttributes[defQ, HoldAll];
defQ[x_]:= {OwnValues[x],UpValues[x],DownValues[x]} =!= {{},{},{}};

plus2list = If[Head[#]===Plus||Head[#]===List, List@@#, {#}]&
expand2list = plus2list[Expand@#]&

times2list = If[Head[#] === Times || Head[#] === List, List @@ #, {#}] &;

apply2term = Total[#1/@expand2list[#2]]&
replaceTo = Thread[RuleDelayed[##]]&
getSampleTerm = Function[e, If[Head@#===Plus, #[[1]], #]&[Expand@e]] 

SetAttributes[prod,Flat]
times2prod[expr_]:= expr /. {Times->prod,Power[a_,n_/;IntegerQ[n]&&n>0]:>prod@@ConstantArray[a,n]}
times2prod[expr_, t_]:= times2prod[expr] /. prod->t
prod2times[expr_, t_:prod]:= expr /. t->Times

SetAttributes[{add2set, add2pattern}, HoldFirst]
add2set[li_, elem_]:= If[Head[li]===List, li=Union[li,Flatten@{elem}], li = Flatten@{elem}]
add2pattern[pi_, elem_]:= If[ValueQ[pi], pi=pi|elem, pi=elem]

take[list_, n_] := If[Length@list > n, Take[list, n], list]

End[]
EndPackage[]