(*^

::[	Information =

	"This is a Mathematica Notebook file.  It contains ASCII text, and can be
	transferred by email, ftp, or other text-file transfer utility.  It should
	be read or edited using a copy of Mathematica or MathReader.  If you 
	received this as email, use your mail application or copy/paste to save 
	everything from the line containing (*^ down to the line containing ^*)
	into a plain text file.  On some systems you may have to give the file a 
	name ending with ".ma" to allow Mathematica to recognize it as a Notebook.
	The line below identifies what version of Mathematica created this file,
	but it can be opened using any other version as well.";

	FrontEndVersion = "NeXT Mathematica Notebook Front End Version 2.2";

	NeXTStandardFontEncoding; 
	
	fontset = title, inactive, noPageBreakBelow, noPageBreakInGroup, nohscroll, preserveAspect, groupLikeTitle, center, M7, L1, e8,  24, "Times"; ;
	fontset = subtitle, inactive, noPageBreakBelow, noPageBreakInGroup, nohscroll, preserveAspect, groupLikeTitle, center, M7, L1, e6,  18, "Times"; ;
	fontset = subsubtitle, inactive, noPageBreakBelow, noPageBreakInGroup, nohscroll, preserveAspect, groupLikeTitle, center, M7, L1, e6,  14, "Times"; ;
	fontset = section, inactive, noPageBreakBelow, nohscroll, preserveAspect, groupLikeSection, grayBox, M22, L1, a20,  18, "Times"; ;
	fontset = subsection, inactive, noPageBreakBelow, nohscroll, preserveAspect, groupLikeSection, blackBox, M19, L1, a15,  14, "Times"; ;
	fontset = subsubsection, inactive, noPageBreakBelow, nohscroll, preserveAspect, groupLikeSection, whiteBox, M18, bold, L1, a12,  12, "Times"; ;
	fontset = text, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7, L1,  12;
	fontset = smalltext, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7, L1,  10, "Times"; ;
	fontset = input, noPageBreakInGroup, nowordwrap, preserveAspect, groupLikeInput, M42, N23, bold, L-4,  12, "Courier"; ;
	fontset = output, output, inactive, noPageBreakInGroup, nowordwrap, preserveAspect, groupLikeOutput, M42, N23, L-4,  9, "Courier"; ;
	fontset = message, inactive, noPageBreakInGroup, nowordwrap, preserveAspect, groupLikeOutput, M42, N23, R32768, L-4,  12, "Courier"; ;
	fontset = print, inactive, noPageBreakInGroup, nowordwrap, preserveAspect, groupLikeOutput, M42, N23, L-4,  12, "Courier"; ;
	fontset = info, inactive, noPageBreakInGroup, nowordwrap, preserveAspect, groupLikeOutput, M42, N23, B32768, L-4,  12, "Courier"; ;
	fontset = postscript, PostScript, formatAsPostScript, output, inactive, noPageBreakInGroup, nowordwrap, preserveAspect, groupLikeGraphics, M7, l34, w282, h287, L1,  12, "Courier"; ;
	fontset = name, inactive, noPageBreakInGroup, nohscroll, noKeepOnOnePage, preserveAspect, M7, B32768, L1,  10, "Times"; ;
	fontset = header, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7, L1,  12;
	fontset = leftheader, inactive,  12;
	fontset = footer, inactive, nohscroll, noKeepOnOnePage, preserveAspect, center, M7, L1,  12;
	fontset = leftfooter, inactive,  12;
	fontset = help, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7, L1,  10, "Times"; ;
	fontset = clipboard, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7, L1,  12;
	fontset = completions, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7, L1,  12, "Courier"; ;
	fontset = special1, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7, L1,  12;
	fontset = special2, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7, L1,  12;
	fontset = special3, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7, L1,  12;
	fontset = special4, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7, L1,  12;
	fontset = special5, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7, L1,  12;
	paletteColors = 128; currentKernel; 
]
:[font = title; inactive; preserveAspect]
Mathematica and cddmathlink
Using cddmathlink to compute complex convex hulls and drawing with Mathematica
by Komei Fukuda
with 
a nice zonotope example
of Russell Towle
 (March 14, 1999)
;[s]
4:0,0;11,1;95,2;106,3;187,-1;
4:1,21,16,Times,2,24,0,0,0;1,21,16,Times,0,24,0,0,0;1,21,16,Times,2,24,0,0,0;1,21,16,Times,0,24,0,0,0;
:[font = input; initialization; Cclosed; preserveAspect; startGroup]
*)
Off[General::spell1];Off[General::spell]
(*
:[font = input; initialization; preserveAspect]
*)

(* Russell Towle's codes to create projections (zonotopes) of
hypercubes.  *)

cross[ {ax_, ay_, az_}, {bx_, by_, bz_} ] := (*cross product*)
   {ay bz - az by, az bx - ax bz, ax by - ay bx}

mag[v_]:= Sqrt[Plus@@(v^2)] (*magnitude of a vector*)

unit[v_]:= v/Sqrt[v.v] (*make unit vector*)

tolerance=0.000001;
collinear[ v1_, v2_ ] := (*test for collinearity*)
   Apply[And, Map[Abs[#]<tolerance&, cross[v1,v2]]]

setStar[vlist_] := (*discard collinear vectors*)
   Module[{selected={}},
    Scan[Function[v, If[v!={0,0,0} &&
                        Select[selected,
                               collinear[v,#]&]=={},
                        AppendTo[selected,v]] ],
         vlist];

    Print[Length[selected]," zonal directions."];
    gStar=selected] (*gStar is global, list of non-collinear vectors*)


(*
:[font = input; initialization; preserveAspect; startGroup]
*)
(* Here I set to a directory where I store
the packages I need *)

SetDirectory["~/Math"]
(*
:[font = output; output; inactive; preserveAspect; endGroup]
"/Users/fukuda/Math"
;[o]
/Users/fukuda/Math
:[font = input; initialization; preserveAspect; startGroup]
*)
cddml=Install["~/Math/cddmathlink"]
(*
:[font = output; output; inactive; initialization; preserveAspect; endGroup]
LinkObject["~/Math/cddmathlink", 17, 17]
;[o]
LinkObject[~/Math/cddmathlink, 17, 17]
:[font = input; initialization; preserveAspect]
*)
Needs["ExtendGraphics`View3D`"];
(*
:[font = input; initialization; preserveAspect]
*)
<<UnfoldPolytope.m
(*
:[font = input; initialization; preserveAspect]
*)
<<Combinatorica5.m
(*
:[font = input; initialization; preserveAspect]
*)
<<PolytopeSkeleton.m
(*
:[font = input; initialization; preserveAspect]
*)
<<IOPolyhedra.m
(*
:[font = input; preserveAspect]
(*the vectors which determine an n-merous polar zonohedron*)
(*3<=n, 0<=pitch<=90 degrees*)

vectors[n_Integer,pitch_]:=
Table[N[{Cos[Degree pitch] Cos[2Pi i/n],
	Cos[Degree pitch] Sin[2Pi i/n],
	-Sin[Degree pitch]},15],
	{i,n}]      (* modified by KF, precision 15 added *)
:[font = input; preserveAspect]
(*the pitch at which a polar zonohedron is
an isometric shadow of an n-cube*)

N[1/Degree * ArcTan[(1/2)^(1/2)],15];

:[font = input; preserveAspect]
(*Here, we obtain the vectors for an isometric projection of
a d-cube into cyclic symmetry*)

dim=8;
gen=Zonotope[vectors[dim, N[ 1/Degree * ArcTan[(1/2)^(1/2)],15 ] ] ];
genc = Chop[gen,10^(-12)];
:[font = input; preserveAspect; startGroup]
extlist=Map[Prepend[#,1]&,genc];
{n,d}=Dimensions[extlist]
:[font = output; output; inactive; preserveAspect; endGroup; endGroup]
{256, 4}
;[o]
{256, 4}
:[font = input; Cclosed; preserveAspect; startGroup]
{{inelist,equalities}, icdlist, iadlist}=
	AllFacetsWithAdjacency[n,d,Flatten[extlist]];
:[font = input; preserveAspect]
amat=-Map[Drop[#,1]&, inelist];
bvec=Map[First[#]&, inelist];

:[font = input; preserveAspect; startGroup]
{m,d}=Dimensions[inelist]
:[font = output; output; inactive; preserveAspect; endGroup]
{56, 4}
;[o]
{56, 4}
:[font = input; preserveAspect]
{{extlist2,equalities2}, ecdlist, eadlist}=
	AllVerticesWithAdjacency[m,d,Flatten[inelist]];
:[font = input; preserveAspect; startGroup]
facets=Map[(Part[genc,#]) &, icdlist];
:[font = input; preserveAspect; startGroup]
Length[facets]
:[font = output; output; inactive; preserveAspect; endGroup]
56
;[o]
56
:[font = input; preserveAspect]
facets1=OrderFacets[facets];
:[font = input; preserveAspect; startGroup]
viewpt={2, -2.4, 1}
:[font = output; output; inactive; preserveAspect; endGroup]
{2, -2.4, 1}
;[o]
{2, -2.4, 1}
:[font = input; preserveAspect; startGroup]
Show[poly=Graphics3D[Polygon /@ facets1],Boxed->False,
ViewPoint->viewpt];
:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 269; pictureHeight = 285; endGroup]
%!
%%Creator: Mathematica
%%AspectRatio: 1.05969 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
-0.05793 1.131557 0.028289 1.131557 [
[ 0 0 0 0 ]
[ 1 1.05969 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1.05969 L
0 1.05969 L
closepath
clip
newpath
p
P
p
.002 w
.49731 .39421 m .40971 .49714 L .48346 .60071 L p
.714 .663 .798 r
F P
s
P
p
.002 w
.48346 .60071 m .57031 .50212 L .49731 .39421 L p
.714 .663 .798 r
F P
s
P
p
.002 w
.57031 .50212 m .48346 .60071 L .59511 .67945 L p
.651 .564 .744 r
F P
s
P
p
.002 w
.59511 .67945 m .48346 .60071 L .37043 .67388 L p
.722 .54 .643 r
F P
s
P
p
.002 w
.48346 .60071 m .40971 .49714 L .29287 .57062 L p
.787 .68 .746 r
F P
s
P
p
.002 w
.29287 .57062 m .37043 .67388 L .48346 .60071 L p
.787 .68 .746 r
F P
s
P
p
.002 w
.59511 .67945 m .68454 .58172 L .57031 .50212 L p
.651 .564 .744 r
F P
s
P
p
.002 w
.68454 .58172 m .59511 .67945 L .68816 .7386 L p
.53 .386 .63 r
F P
s
P
p
.002 w
.37043 .67388 m .48297 .75416 L .59511 .67945 L p
.722 .54 .643 r
F P
s
P
p
.002 w
.68816 .7386 m .59511 .67945 L .48297 .75416 L p
.608 .341 .488 r
F P
s
P
p
.002 w
.48297 .75416 m .37043 .67388 L .28841 .7295 L p
.786 .48 .472 r
F P
s
P
p
.002 w
.37043 .67388 m .28841 .7295 L .20513 .62282 L p
.886 .679 .617 r
F P
s
P
p
.002 w
.20513 .62282 m .29287 .57062 L .37043 .67388 L p
.886 .679 .617 r
F P
s
P
p
.002 w
.58315 .38397 m .57031 .50212 L .49731 .39421 L p
.651 .641 .827 r
F P
s
P
p
.002 w
.57031 .50212 m .58315 .38397 L .7015 .46563 L p
.575 .572 .812 r
F P
s
P
p
.002 w
.7015 .46563 m .68454 .58172 L .57031 .50212 L p
.575 .572 .812 r
F P
s
P
p
.002 w
.4056 .81382 m .48297 .75416 L .57291 .81714 L p
.66 .291 .334 r
F P
s
P
p
.002 w
.28841 .7295 m .4056 .81382 L .48297 .75416 L p
.786 .48 .472 r
F P
s
P
p
.002 w
.48297 .75416 m .57291 .81714 L .68816 .7386 L p
.608 .341 .488 r
F P
s
P
p
.002 w
.41695 .37811 m .40971 .49714 L .49731 .39421 L p
.757 .735 .832 r
F P
s
P
p
.002 w
.40971 .49714 m .41695 .37811 L .29604 .45247 L p
.824 .791 .821 r
F P
s
P
p
.002 w
.29604 .45247 m .29287 .57062 L .40971 .49714 L p
.824 .791 .821 r
F P
s
P
p
.002 w
.68816 .7386 m .78294 .63809 L .68454 .58172 L p
.53 .386 .63 r
F P
s
P
p
.002 w
.68454 .58172 m .7015 .46563 L .80422 .51927 L p
.418 .424 .759 r
F P
s
P
p
.002 w
.80422 .51927 m .78294 .63809 L .68454 .58172 L p
.418 .424 .759 r
F P
s
P
p
.002 w
.29287 .57062 m .29604 .45247 L .20514 .50089 L p
.93 .872 .758 r
F P
s
P
p
.002 w
.20514 .50089 m .20513 .62282 L .29287 .57062 L p
.93 .872 .758 r
F P
s
P
p
.002 w
.49731 .39421 m .50785 .26916 L .41695 .37811 L p
.757 .735 .832 r
F P
s
P
p
.002 w
.49731 .39421 m .50785 .26916 L .58315 .38397 L p
.651 .641 .827 r
F P
s
P
p
.002 w
.78294 .63809 m .68816 .7386 L .7099 .79274 L p
.189 0 .281 r
F P
s
P
p
.002 w
.7099 .79274 m .68816 .7386 L .57291 .81714 L p
.387 .024 .222 r
F P
s
P
p
.002 w
.58315 .38397 m .50785 .26916 L .62873 .35218 L p
.481 .567 .865 r
F P
s
P
p
.002 w
.62873 .35218 m .7015 .46563 L .58315 .38397 L p
.481 .567 .865 r
F P
s
P
p
.002 w
.4056 .81382 m .28841 .7295 L .28671 .78391 L p
.788 .322 .13 r
F P
s
P
p
.002 w
.28841 .7295 m .28671 .78391 L .19829 .67219 L p
.899 .485 .112 r
F P
s
P
p
.002 w
.19829 .67219 m .20513 .62282 L .28841 .7295 L p
.899 .485 .112 r
F P
s
P
p
.002 w
.41695 .37811 m .50785 .26916 L .38592 .34334 L p
.836 .889 .879 r
F P
s
P
p
.002 w
.38592 .34334 m .29604 .45247 L .41695 .37811 L p
.836 .889 .879 r
F P
s
P
p
.002 w
.49662 .8823 m .57291 .81714 L .58813 .87679 L p
.509 .097 .194 r
F P
s
P
p
.002 w
.57291 .81714 m .58813 .87679 L .7099 .79274 L p
.387 .024 .222 r
F P
s
P
p
.002 w
.57291 .81714 m .49662 .8823 L .4056 .81382 L p
.66 .291 .334 r
F P
s
P
p
.002 w
.7015 .46563 m .80422 .51927 L .7311 .40241 L p
.254 .443 .854 r
F P
s
P
p
.002 w
.7311 .40241 m .62873 .35218 L .7015 .46563 L p
.254 .443 .854 r
F P
s
P
p
.002 w
.7099 .79274 m .81079 .68732 L .78294 .63809 L p
.189 0 .281 r
F P
s
P
p
.002 w
.78294 .63809 m .80422 .51927 L .83448 .56304 L p
0 0 .386 r
F P
s
P
p
.002 w
.83448 .56304 m .81079 .68732 L .78294 .63809 L p
0 0 .386 r
F P
s
P
p
.002 w
.41091 .87364 m .4056 .81382 L .49662 .8823 L p
.688 .228 .153 r
F P
s
P
p
.002 w
.28671 .78391 m .41091 .87364 L .4056 .81382 L p
.788 .322 .13 r
F P
s
P
p
.002 w
.29604 .45247 m .20514 .50089 L .29761 .38735 L p
.847 .994 .841 r
F P
s
P
p
.002 w
.29761 .38735 m .38592 .34334 L .29604 .45247 L p
.847 .994 .841 r
F P
s
P
p
.002 w
.62873 .35218 m .50785 .26916 L .60442 .31555 L p
.016 .415 .859 r
F P
s
P
p
.002 w
.60442 .31555 m .50785 .26916 L .51943 .29676 L p
.514 0 0 r
F P
s
P
p
.002 w
.50785 .26916 m .42686 .30886 L .29761 .38735 L p
.562 .927 .769 r
F P
s
P
p
.002 w
.29761 .38735 m .38592 .34334 L .50785 .26916 L p
.562 .927 .769 r
F P
s
P
p
.002 w
.42686 .30886 m .50785 .26916 L .51943 .29676 L p
.284 0 0 r
F P
s
P
p
.002 w
.20513 .62282 m .20514 .50089 L .19804 .54449 L p
.789 .66 .107 r
F P
s
P
p
.002 w
.19804 .54449 m .19829 .67219 L .20513 .62282 L p
.789 .66 .107 r
F P
s
P
p
.002 w
.60442 .31555 m .7311 .40241 L .62873 .35218 L p
.016 .415 .859 r
F P
s
P
p
.002 w
.80422 .51927 m .83448 .56304 L .75754 .43997 L p
0 0 .411 r
F P
s
P
p
.002 w
.75754 .43997 m .7311 .40241 L .80422 .51927 L p
0 0 .411 r
F P
s
P
p
.002 w
.7099 .79274 m .637 .85965 L .50785 .94906 L p
0 0 0 r
F P
s
P
p
.002 w
.50785 .94906 m .58813 .87679 L .7099 .79274 L p
0 0 0 r
F P
s
P
p
.002 w
.637 .85965 m .7099 .79274 L .81079 .68732 L p
.595 .887 .587 r
F P
s
P
p
.002 w
.58813 .87679 m .50785 .94906 L .49662 .8823 L p
.509 .097 .194 r
F P
s
P
p
.002 w
.49662 .8823 m .50785 .94906 L .41091 .87364 L p
.688 .228 .153 r
F P
s
P
p
.002 w
.37751 .85486 m .28671 .78391 L .41091 .87364 L p
.511 0 0 r
F P
s
P
p
.002 w
.28671 .78391 m .37751 .85486 L .28767 .7401 L p
0 .255 .765 r
F P
s
P
p
.002 w
.28767 .7401 m .19829 .67219 L .28671 .78391 L p
0 .255 .765 r
F P
s
P
p
.002 w
.7311 .40241 m .60442 .31555 L .62265 .34733 L p
.602 .038 0 r
F P
s
P
p
.002 w
.51943 .29676 m .62265 .34733 L .60442 .31555 L p
.514 0 0 r
F P
s
P
p
.002 w
.20514 .50089 m .29761 .38735 L .29635 .42454 L p
0 0 0 r
F P
s
P
p
.002 w
.29635 .42454 m .19804 .54449 L .20514 .50089 L p
0 0 0 r
F P
s
P
p
.002 w
.81079 .68732 m .74149 .75026 L .637 .85965 L p
.595 .887 .587 r
F P
s
P
p
.002 w
.81079 .68732 m .74149 .75026 L .76359 .62196 L p
.957 .948 .701 r
F P
s
P
p
.002 w
.76359 .62196 m .83448 .56304 L .81079 .68732 L p
.957 .948 .701 r
F P
s
P
p
.002 w
.41091 .87364 m .50785 .94906 L .37751 .85486 L p
.511 0 0 r
F P
s
P
p
.002 w
.51943 .29676 m .43388 .34043 L .42686 .30886 L p
.284 0 0 r
F P
s
P
p
.002 w
.42686 .30886 m .43388 .34043 L .29635 .42454 L p
.103 0 0 r
F P
s
P
p
.002 w
.29635 .42454 m .29761 .38735 L .42686 .30886 L p
.103 0 0 r
F P
s
P
p
.002 w
.62265 .34733 m .75754 .43997 L .7311 .40241 L p
.602 .038 0 r
F P
s
P
p
.002 w
.43388 .34043 m .51943 .29676 L .62265 .34733 L p
.585 .12 .115 r
F P
s
P
p
.002 w
.19829 .67219 m .19804 .54449 L .29114 .60922 L p
.259 .329 .746 r
F P
s
P
p
.002 w
.29114 .60922 m .28767 .7401 L .19829 .67219 L p
.259 .329 .746 r
F P
s
P
p
.002 w
.637 .85965 m .74149 .75026 L .61128 .83979 L p
.825 .976 .889 r
F P
s
P
p
.002 w
.61128 .83979 m .50785 .94906 L .637 .85965 L p
.825 .976 .889 r
F P
s
P
p
.002 w
.37751 .85486 m .50785 .94906 L .42108 .83616 L p
.345 .53 .894 r
F P
s
P
p
.002 w
.42108 .83616 m .28767 .7401 L .37751 .85486 L p
.345 .53 .894 r
F P
s
P
p
.002 w
.83448 .56304 m .76359 .62196 L .68032 .4939 L p
.938 .703 .556 r
F P
s
P
p
.002 w
.68032 .4939 m .75754 .43997 L .83448 .56304 L p
.938 .703 .556 r
F P
s
P
p
.002 w
.42108 .83616 m .50785 .94906 L .52027 .82957 L p
.627 .657 .86 r
F P
s
P
p
.002 w
.61128 .83979 m .50785 .94906 L .52027 .82957 L p
.766 .781 .865 r
F P
s
P
p
.002 w
.76359 .62196 m .74149 .75026 L .61128 .83979 L p
.849 .856 .847 r
F P
s
P
p
.002 w
.53866 .39582 m .62265 .34733 L .75754 .43997 L p
.794 .422 .353 r
F P
s
P
p
.002 w
.62265 .34733 m .53866 .39582 L .43388 .34043 L p
.585 .12 .115 r
F P
s
P
p
.002 w
.19804 .54449 m .29114 .60922 L .39635 .48497 L p
.454 .307 .59 r
F P
s
P
p
.002 w
.39635 .48497 m .29635 .42454 L .19804 .54449 L p
.454 .307 .59 r
F P
s
P
p
.002 w
.28767 .7401 m .29114 .60922 L .43021 .70836 L p
.521 .562 .838 r
F P
s
P
p
.002 w
.43021 .70836 m .42108 .83616 L .28767 .7401 L p
.521 .562 .838 r
F P
s
P
p
.002 w
.43388 .34043 m .53866 .39582 L .39635 .48497 L p
.553 .238 .388 r
F P
s
P
p
.002 w
.39635 .48497 m .29635 .42454 L .43388 .34043 L p
.553 .238 .388 r
F P
s
P
p
.002 w
.52027 .82957 m .62831 .71304 L .61128 .83979 L p
.766 .781 .865 r
F P
s
P
p
.002 w
.61128 .83979 m .62831 .71304 L .76359 .62196 L p
.849 .856 .847 r
F P
s
P
p
.002 w
.75754 .43997 m .68032 .4939 L .53866 .39582 L p
.794 .422 .353 r
F P
s
P
p
.002 w
.52027 .82957 m .43021 .70836 L .42108 .83616 L p
.627 .657 .86 r
F P
s
P
p
.002 w
.43021 .70836 m .52027 .82957 L .62831 .71304 L p
.713 .685 .821 r
F P
s
P
p
.002 w
.68032 .4939 m .76359 .62196 L .62831 .71304 L p
.808 .709 .755 r
F P
s
P
p
.002 w
.29114 .60922 m .39635 .48497 L .53944 .58546 L p
.634 .56 .753 r
F P
s
P
p
.002 w
.53944 .58546 m .43021 .70836 L .29114 .60922 L p
.634 .56 .753 r
F P
s
P
p
.002 w
.62831 .71304 m .53944 .58546 L .43021 .70836 L p
.713 .685 .821 r
F P
s
P
p
.002 w
.62831 .71304 m .53944 .58546 L .68032 .4939 L p
.808 .709 .755 r
F P
s
P
p
.002 w
.53866 .39582 m .68032 .4939 L .53944 .58546 L p
.726 .528 .623 r
F P
s
P
p
.002 w
.53944 .58546 m .39635 .48497 L .53866 .39582 L p
.726 .528 .623 r
F P
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = input; preserveAspect; startGroup]
Show[poly0=
	Graphics3D[
	Join[{PointSize[0.02]},
		Point /@ genc]
	],Boxed->True,ViewPoint->viewpt];
:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 266; pictureHeight = 282; endGroup; endGroup]
%!
%%Creator: Mathematica
%%AspectRatio: 1.05969 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
-0.05793 1.131557 0.028289 1.131557 [
[ 0 0 0 0 ]
[ 1 1.05969 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1.05969 L
0 1.05969 L
closepath
clip
newpath
p
.002 w
.07153 .23631 m
.02829 .96071 L
s
.02829 .96071 m
.47161 1.0314 L
s
.47161 1.0314 m
.47437 .41457 L
s
.47437 .41457 m
.07153 .23631 L
s
.55473 .02829 m
.93113 .27045 L
s
.93113 .27045 m
.97171 .97442 L
s
.97171 .97442 m
.56032 .8754 L
s
.56032 .8754 m
.55473 .02829 L
s
.07153 .23631 m
.02829 .96071 L
s
.02829 .96071 m
.56032 .8754 L
s
.56032 .8754 m
.55473 .02829 L
s
.55473 .02829 m
.07153 .23631 L
s
.47437 .41457 m
.93113 .27045 L
s
.93113 .27045 m
.97171 .97442 L
s
.97171 .97442 m
.47161 1.0314 L
s
.47161 1.0314 m
.47437 .41457 L
s
P
p
.02 w
.48346 .60071 Mdot
P
p
.02 w
.59511 .67945 Mdot
P
p
.02 w
.37043 .67388 Mdot
P
p
.02 w
.57031 .50212 Mdot
P
p
.02 w
.48297 .75416 Mdot
P
p
.02 w
.40971 .49714 Mdot
P
p
.02 w
.68454 .58172 Mdot
P
p
.02 w
.52362 .57716 Mdot
P
p
.02 w
.45642 .57525 Mdot
P
p
.02 w
.49307 .48814 Mdot
P
p
.02 w
.29287 .57062 Mdot
P
p
.02 w
.57158 .65643 Mdot
P
p
.02 w
.57158 .65643 Mdot
P
p
.02 w
.60865 .56892 Mdot
P
p
.02 w
.49731 .39421 Mdot
P
p
.02 w
.4077 .65223 Mdot
P
p
.02 w
.4077 .65223 Mdot
P
p
.02 w
.68816 .7386 Mdot
P
p
.02 w
.37623 .56225 Mdot
P
p
.02 w
.6139 .47509 Mdot
P
p
.02 w
.52394 .73486 Mdot
P
p
.02 w
.45536 .7333 Mdot
P
p
.02 w
.58315 .38397 Mdot
P
p
.02 w
.49276 .64466 Mdot
P
p
.02 w
.49276 .64466 Mdot
P
p
.02 w
.37953 .46758 Mdot
P
p
.02 w
.66356 .55498 Mdot
P
p
.02 w
.28841 .7295 Mdot
P
p
.02 w
.41695 .37811 Mdot
P
p
.02 w
.57291 .81714 Mdot
P
p
.02 w
.7015 .46563 Mdot
P
p
.02 w
.61075 .7281 Mdot
P
p
.02 w
.49709 .55011 Mdot
P
p
.02 w
.49709 .55011 Mdot
P
p
.02 w
.49709 .55011 Mdot
P
p
.02 w
.78294 .63809 Mdot
P
p
.02 w
.4056 .81382 Mdot
P
p
.02 w
.53496 .46023 Mdot
P
p
.02 w
.46539 .45797 Mdot
P
p
.02 w
.32864 .54518 Mdot
P
p
.02 w
.37346 .72263 Mdot
P
p
.02 w
.61613 .63368 Mdot
P
p
.02 w
.61613 .63368 Mdot
P
p
.02 w
.54645 .63184 Mdot
P
p
.02 w
.29604 .45247 Mdot
P
p
.02 w
.58474 .54131 Mdot
P
p
.02 w
.58474 .54131 Mdot
P
p
.02 w
.58474 .54131 Mdot
P
p
.02 w
.44733 .62922 Mdot
P
p
.02 w
.49244 .8078 Mdot
P
p
.02 w
.37681 .62736 Mdot
P
p
.02 w
.37681 .62736 Mdot
P
p
.02 w
.50785 .26916 Mdot
P
p
.02 w
.66686 .71666 Mdot
P
p
.02 w
.41502 .53628 Mdot
P
p
.02 w
.41502 .53628 Mdot
P
p
.02 w
.41502 .53628 Mdot
P
p
.02 w
.70561 .62571 Mdot
P
p
.02 w
.70561 .62571 Mdot
P
p
.02 w
.58996 .44401 Mdot
P
p
.02 w
.20513 .62282 Mdot
P
p
.02 w
.49686 .71267 Mdot
P
p
.02 w
.49686 .71267 Mdot
P
p
.02 w
.49686 .71267 Mdot
P
p
.02 w
.62873 .35218 Mdot
P
p
.02 w
.53553 .62116 Mdot
P
p
.02 w
.53553 .62116 Mdot
P
p
.02 w
.41878 .43835 Mdot
P
p
.02 w
.46448 .61925 Mdot
P
p
.02 w
.46448 .61925 Mdot
P
p
.02 w
.71193 .52854 Mdot
P
p
.02 w
.3248 .70862 Mdot
P
p
.02 w
.50327 .52717 Mdot
P
p
.02 w
.61845 .79907 Mdot
P
p
.02 w
.38592 .34334 Mdot
P
p
.02 w
.68034 .43389 Mdot
P
p
.02 w
.29147 .61462 Mdot
P
p
.02 w
.29147 .61462 Mdot
P
p
.02 w
.54038 .52335 Mdot
P
p
.02 w
.5864 .70544 Mdot
P
p
.02 w
.5864 .70544 Mdot
P
p
.02 w
.5864 .70544 Mdot
P
p
.02 w
.62566 .61292 Mdot
P
p
.02 w
.46871 .52118 Mdot
P
p
.02 w
.37398 .79405 Mdot
P
p
.02 w
.50785 .4281 Mdot
P
p
.02 w
.50785 .4281 Mdot
P
p
.02 w
.50785 .4281 Mdot
P
p
.02 w
.50785 .4281 Mdot
P
p
.02 w
.80422 .51927 Mdot
P
p
.02 w
.41301 .7013 Mdot
P
p
.02 w
.41301 .7013 Mdot
P
p
.02 w
.41301 .7013 Mdot
P
p
.02 w
.7099 .79274 Mdot
P
p
.02 w
.29418 .5159 Mdot
P
p
.02 w
.59174 .60749 Mdot
P
p
.02 w
.59174 .60749 Mdot
P
p
.02 w
.33323 .42224 Mdot
P
p
.02 w
.37971 .60624 Mdot
P
p
.02 w
.49662 .8823 Mdot
P
p
.02 w
.63137 .51396 Mdot
P
p
.02 w
.63137 .51396 Mdot
P
p
.02 w
.63137 .51396 Mdot
P
p
.02 w
.53614 .78911 Mdot
P
p
.02 w
.55914 .51175 Mdot
P
p
.02 w
.41683 .60271 Mdot
P
p
.02 w
.41683 .60271 Mdot
P
p
.02 w
.46353 .7876 Mdot
P
p
.02 w
.59888 .41762 Mdot
P
p
.02 w
.71639 .69494 Mdot
P
p
.02 w
.45637 .5086 Mdot
P
p
.02 w
.50317 .69382 Mdot
P
p
.02 w
.38324 .50635 Mdot
P
p
.02 w
.38324 .50635 Mdot
P
p
.02 w
.38324 .50635 Mdot
P
p
.02 w
.68413 .59895 Mdot
P
p
.02 w
.68413 .59895 Mdot
P
p
.02 w
.28671 .78391 Mdot
P
p
.02 w
.4229 .41163 Mdot
P
p
.02 w
.5411 .69067 Mdot
P
p
.02 w
.58813 .87679 Mdot
P
p
.02 w
.72437 .50437 Mdot
P
p
.02 w
.46785 .68889 Mdot
P
p
.02 w
.60442 .31555 Mdot
P
p
.02 w
.20514 .50089 Mdot
P
p
.02 w
.50785 .59407 Mdot
P
p
.02 w
.50785 .59407 Mdot
P
p
.02 w
.50785 .59407 Mdot
P
p
.02 w
.50785 .59407 Mdot
P
p
.02 w
.50785 .59407 Mdot
P
p
.02 w
.50785 .59407 Mdot
P
p
.02 w
.81079 .68732 Mdot
P
p
.02 w
.41091 .87364 Mdot
P
p
.02 w
.548 .49888 Mdot
P
p
.02 w
.28943 .68455 Mdot
P
p
.02 w
.42686 .30886 Mdot
P
p
.02 w
.4743 .49659 Mdot
P
p
.02 w
.59361 .77824 Mdot
P
p
.02 w
.7311 .40241 Mdot
P
p
.02 w
.32934 .58912 Mdot
P
p
.02 w
.32934 .58912 Mdot
P
p
.02 w
.63412 .68295 Mdot
P
p
.02 w
.63412 .68295 Mdot
P
p
.02 w
.63412 .68295 Mdot
P
p
.02 w
.51262 .49248 Mdot
P
p
.02 w
.56029 .68113 Mdot
P
p
.02 w
.29477 .491 Mdot
P
p
.02 w
.41479 .77443 Mdot
P
p
.02 w
.55315 .39623 Mdot
P
p
.02 w
.60092 .58523 Mdot
P
p
.02 w
.60092 .58523 Mdot
P
p
.02 w
.45521 .67854 Mdot
P
p
.02 w
.47878 .39364 Mdot
P
p
.02 w
.38044 .67669 Mdot
P
p
.02 w
.38044 .67669 Mdot
P
p
.02 w
.38044 .67669 Mdot
P
p
.02 w
.51943 .29676 Mdot
P
p
.02 w
.64009 .58151 Mdot
P
p
.02 w
.6881 .77144 Mdot
P
p
.02 w
.42098 .58017 Mdot
P
p
.02 w
.42098 .58017 Mdot
P
p
.02 w
.72925 .67506 Mdot
P
p
.02 w
.29761 .38735 Mdot
P
p
.02 w
.6066 .48241 Mdot
P
p
.02 w
.6066 .48241 Mdot
P
p
.02 w
.6066 .48241 Mdot
P
p
.02 w
.19829 .67219 Mdot
P
p
.02 w
.50785 .76755 Mdot
P
p
.02 w
.50785 .76755 Mdot
P
p
.02 w
.50785 .76755 Mdot
P
p
.02 w
.50785 .76755 Mdot
P
p
.02 w
.64778 .38504 Mdot
P
p
.02 w
.54891 .67054 Mdot
P
p
.02 w
.3841 .57426 Mdot
P
p
.02 w
.42502 .47664 Mdot
P
p
.02 w
.42502 .47664 Mdot
P
p
.02 w
.42502 .47664 Mdot
P
p
.02 w
.47354 .66866 Mdot
P
p
.02 w
.73617 .57238 Mdot
P
p
.02 w
.73617 .57238 Mdot
P
p
.02 w
.32528 .76361 Mdot
P
p
.02 w
.637 .85965 Mdot
P
p
.02 w
.39017 .37595 Mdot
P
p
.02 w
.51272 .66527 Mdot
P
p
.02 w
.70275 .4721 Mdot
P
p
.02 w
.2899 .66405 Mdot
P
p
.02 w
.55419 .56715 Mdot
P
p
.02 w
.55419 .56715 Mdot
P
p
.02 w
.60305 .7605 Mdot
P
p
.02 w
.47811 .56497 Mdot
P
p
.02 w
.47811 .56497 Mdot
P
p
.02 w
.37751 .85486 Mdot
P
p
.02 w
.5197 .4662 Mdot
P
p
.02 w
.5197 .4662 Mdot
P
p
.02 w
.5197 .4662 Mdot
P
p
.02 w
.83448 .56304 Mdot
P
p
.02 w
.41898 .75647 Mdot
P
p
.02 w
.29276 .55965 Mdot
P
p
.02 w
.29276 .55965 Mdot
P
p
.02 w
.60889 .65697 Mdot
P
p
.02 w
.60889 .65697 Mdot
P
p
.02 w
.60889 .65697 Mdot
P
p
.02 w
.33425 .46022 Mdot
P
p
.02 w
.50785 .94906 Mdot
P
p
.02 w
.65102 .55769 Mdot
P
p
.02 w
.65102 .55769 Mdot
P
p
.02 w
.52477 .35938 Mdot
P
p
.02 w
.57432 .55546 Mdot
P
p
.02 w
.4231 .65222 Mdot
P
p
.02 w
.4231 .65222 Mdot
P
p
.02 w
.4231 .65222 Mdot
P
p
.02 w
.74149 .75026 Mdot
P
p
.02 w
.46514 .55228 Mdot
P
p
.02 w
.38742 .55001 Mdot
P
p
.02 w
.38742 .55001 Mdot
P
p
.02 w
.65739 .45101 Mdot
P
p
.02 w
.70731 .64848 Mdot
P
p
.02 w
.55527 .74609 Mdot
P
p
.02 w
.47741 .74434 Mdot
P
p
.02 w
.62265 .34733 Mdot
P
p
.02 w
.19804 .54449 Mdot
P
p
.02 w
.51998 .64361 Mdot
P
p
.02 w
.51998 .64361 Mdot
P
p
.02 w
.51998 .64361 Mdot
P
p
.02 w
.39129 .44225 Mdot
P
p
.02 w
.28767 .7401 Mdot
P
p
.02 w
.43388 .34043 Mdot
P
p
.02 w
.61128 .83979 Mdot
P
p
.02 w
.75754 .43997 Mdot
P
p
.02 w
.33013 .63868 Mdot
P
p
.02 w
.65441 .73854 Mdot
P
p
.02 w
.52517 .53599 Mdot
P
p
.02 w
.52517 .53599 Mdot
P
p
.02 w
.42108 .83616 Mdot
P
p
.02 w
.56833 .43364 Mdot
P
p
.02 w
.48921 .43099 Mdot
P
p
.02 w
.38454 .7324 Mdot
P
p
.02 w
.66097 .63108 Mdot
P
p
.02 w
.29635 .42454 Mdot
P
p
.02 w
.62541 .52579 Mdot
P
p
.02 w
.62541 .52579 Mdot
P
p
.02 w
.52027 .82957 Mdot
P
p
.02 w
.38847 .62385 Mdot
P
p
.02 w
.43209 .51994 Mdot
P
p
.02 w
.43209 .51994 Mdot
P
p
.02 w
.76359 .62196 Mdot
P
p
.02 w
.52559 .7212 Mdot
P
p
.02 w
.56981 .61673 Mdot
P
p
.02 w
.48875 .61455 Mdot
P
p
.02 w
.29114 .60922 Mdot
P
p
.02 w
.62831 .71304 Mdot
P
p
.02 w
.53866 .39582 Mdot
P
p
.02 w
.43021 .70836 Mdot
P
p
.02 w
.68032 .4939 Mdot
P
p
.02 w
.39635 .48497 Mdot
P
p
.02 w
.53944 .58546 Mdot
P
p
.002 w
.55473 .02829 m
.93113 .27045 L
s
.93113 .27045 m
.97171 .97442 L
s
.97171 .97442 m
.56032 .8754 L
s
.56032 .8754 m
.55473 .02829 L
s
.07153 .23631 m
.02829 .96071 L
s
.02829 .96071 m
.56032 .8754 L
s
.56032 .8754 m
.55473 .02829 L
s
.55473 .02829 m
.07153 .23631 L
s
P
p
P
% End of Graphics
MathPictureEnd

:[font = input; preserveAspect]
vlist=Map[Drop[#,1]&, extlist2];
:[font = input; preserveAspect]
skel3D[vp_]:= 
	Graphics3D[
		VisibleSkeleton[vlist, ecdlist, eadlist, 
     	{amat, bvec}, vp]
     ]; 

:[font = input; preserveAspect; startGroup]
uvp={20,20,20};
Show[skel3D[uvp], 
		Boxed->False, 
 		ViewPoint -> getMmaViewPoint[uvp,skel3D[uvp]],
 		SphericalRegion->True
 	]
:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .57327 m
.40869 .62727 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56391 .48472 m
.5 .57327 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.43609 .48472 m
.5 .57327 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.59131 .62727 m
.5 .57327 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56391 .48472 m
.65702 .53755 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56504 .37823 m
.56391 .48472 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .39488 m
.56391 .48472 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.43609 .48472 m
.34298 .53755 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.43609 .48472 m
.43496 .37823 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.43609 .48472 m
.5 .39488 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .286 m
.5 .39488 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.59131 .62727 m
.5 .68322 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.59131 .62727 m
.65702 .53755 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.59131 .62727 m
.6628 .64905 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40869 .62727 m
.5 .68322 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34298 .53755 m
.40869 .62727 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3372 .64905 m
.40869 .62727 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65986 .4301 m
.65702 .53755 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.732 .55548 m
.65702 .53755 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.43496 .37823 m
.34014 .4301 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .286 m
.43496 .37823 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56504 .37823 m
.65986 .4301 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .286 m
.56504 .37823 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34014 .4301 m
.34298 .53755 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.268 .55548 m
.34298 .53755 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .286 m
.40565 .33658 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .286 m
.43152 .29273 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .286 m
.59435 .33658 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .286 m
.56848 .29273 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .286 m
.5 .27388 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5687 .70794 m
.5 .68322 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4313 .70794 m
.5 .68322 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40565 .33658 m
.34014 .4301 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.26362 .44347 m
.34014 .4301 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.59435 .33658 m
.65986 .4301 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.73638 .44347 m
.65986 .4301 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.66846 .34576 m
.59435 .33658 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33154 .34576 m
.40565 .33658 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3372 .64905 m
.4313 .70794 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3372 .64905 m
.268 .55548 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32769 .65776 m
.3372 .64905 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6628 .64905 m
.5687 .70794 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6628 .64905 m
.67231 .65776 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6628 .64905 m
.732 .55548 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.268 .55548 m
.25434 .55875 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.268 .55548 m
.26362 .44347 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.732 .55548 m
.74566 .55875 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.732 .55548 m
.73638 .44347 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56848 .29273 m
.66846 .34576 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.57254 .28043 m
.56848 .29273 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.43152 .29273 m
.42746 .28043 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33154 .34576 m
.43152 .29273 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .73499 m
.4313 .70794 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42721 .72032 m
.4313 .70794 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .73499 m
.5687 .70794 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.57279 .72032 m
.5687 .70794 L
s
P
p
.0085 w
.5 .27388 m
.42746 .28043 L
s
P
p
.0085 w
.57254 .28043 m
.5 .27388 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.73638 .44347 m
.75058 .44008 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.73638 .44347 m
.66846 .34576 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.26362 .44347 m
.24942 .44008 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.26362 .44347 m
.33154 .34576 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32134 .33642 m
.33154 .34576 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67866 .33642 m
.66846 .34576 L
s
P
p
.0085 w
.60591 .68344 m
.67231 .65776 L
s
P
p
.0085 w
.74566 .55875 m
.67231 .65776 L
s
P
p
.0085 w
.57279 .72032 m
.67231 .65776 L
s
P
p
.0085 w
.32769 .65776 m
.39409 .68344 L
s
P
p
.0085 w
.32769 .65776 m
.25434 .55875 L
s
P
p
.0085 w
.32769 .65776 m
.42721 .72032 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .74969 m
.5 .73499 L
s
P
p
.0085 w
.68235 .57973 m
.74566 .55875 L
s
P
p
.0085 w
.75058 .44008 m
.74566 .55875 L
s
P
p
.0085 w
.24942 .44008 m
.25434 .55875 L
s
P
p
.0085 w
.31765 .57973 m
.25434 .55875 L
s
P
p
.0085 w
.42746 .28043 m
.5 .28763 L
s
P
p
.0085 w
.32134 .33642 m
.42746 .28043 L
s
P
p
.0085 w
.57254 .28043 m
.5 .28763 L
s
P
p
.0085 w
.67866 .33642 m
.57254 .28043 L
s
P
p
.0085 w
.42721 .72032 m
.5 .74969 L
s
P
p
.0085 w
.57279 .72032 m
.5 .74969 L
s
P
p
.0085 w
.75058 .44008 m
.68618 .45548 L
s
P
p
.0085 w
.67866 .33642 m
.75058 .44008 L
s
P
p
.0085 w
.31382 .45548 m
.24942 .44008 L
s
P
p
.0085 w
.32134 .33642 m
.24942 .44008 L
s
P
p
.0085 w
.67866 .33642 m
.61002 .34665 L
s
P
p
.0085 w
.32134 .33642 m
.38998 .34665 L
s
P
p
.0085 w
.39409 .68344 m
.5 .74969 L
s
P
p
.0085 w
.31765 .57973 m
.39409 .68344 L
s
P
p
.0085 w
.60591 .68344 m
.5 .74969 L
s
P
p
.0085 w
.68235 .57973 m
.60591 .68344 L
s
P
p
.0085 w
.31765 .57973 m
.31382 .45548 L
s
P
p
.0085 w
.42288 .64438 m
.31765 .57973 L
s
P
p
.0085 w
.68235 .57973 m
.68618 .45548 L
s
P
p
.0085 w
.68235 .57973 m
.57712 .64438 L
s
P
p
.0085 w
.5 .28763 m
.61002 .34665 L
s
P
p
.0085 w
.38998 .34665 m
.5 .28763 L
s
P
p
.0085 w
.57712 .64438 m
.5 .74969 L
s
P
p
.0085 w
.5 .6275 m
.5 .74969 L
s
P
p
.0085 w
.42288 .64438 m
.5 .74969 L
s
P
p
.0085 w
.42122 .51884 m
.42288 .64438 L
s
P
p
.0085 w
.68618 .45548 m
.61002 .34665 L
s
P
p
.0085 w
.68618 .45548 m
.57878 .51884 L
s
P
p
.0085 w
.38998 .34665 m
.31382 .45548 L
s
P
p
.0085 w
.42122 .51884 m
.31382 .45548 L
s
P
p
.0085 w
.57712 .64438 m
.57878 .51884 L
s
P
p
.0085 w
.5 .40822 m
.38998 .34665 L
s
P
p
.0085 w
.5 .40822 m
.61002 .34665 L
s
P
p
.0085 w
.5 .6275 m
.57878 .51884 L
s
P
p
.0085 w
.42122 .51884 m
.5 .6275 L
s
P
p
.0085 w
.42122 .51884 m
.5 .40822 L
s
P
p
.0085 w
.57878 .51884 m
.5 .40822 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = output; output; inactive; preserveAspect; endGroup]
Graphics3D["<<>>"]
;[o]
-Graphics3D-
:[font = input; Cclosed; preserveAspect; startGroup; animationSpeed = 29]
Do[ vp=circle[a,10,2];
	Show[skel3D[getUserViewPoint[vp, skel3D[{0,0,0}]]], 
		Boxed->False, 
 		ViewPoint -> vp, SphericalRegion->True
 	],
 	{a,Pi/11,Pi,Pi/18}
 ]

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.47266 .54987 m
.38566 .60959 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.47266 .54987 m
.38616 .47267 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.47266 .54987 m
.56671 .47655 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.47266 .54987 m
.56701 .61307 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.61504 .3904 m
.56671 .47655 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48052 .39879 m
.56671 .47655 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.66189 .5394 m
.56671 .47655 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.38616 .47267 m
.29785 .53195 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48052 .39879 m
.38616 .47267 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.35661 .38446 m
.38616 .47267 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56701 .61307 m
.48035 .6738 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56701 .61307 m
.61607 .66708 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56701 .61307 m
.66189 .5394 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5281 .31127 m
.48052 .39879 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.45213 .30942 m
.48052 .39879 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.66189 .5394 m
.71261 .59234 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.66189 .5394 m
.71165 .45341 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48035 .6738 m
.38566 .60959 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.35532 .66232 m
.38566 .60959 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.29785 .53195 m
.38566 .60959 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5281 .31127 m
.61504 .3904 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58822 .30036 m
.61504 .3904 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.71165 .45341 m
.61504 .3904 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.26685 .44364 m
.29785 .53195 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.2658 .58359 m
.29785 .53195 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.45148 .72803 m
.48035 .6738 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52849 .72935 m
.48035 .6738 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.35661 .38446 m
.26685 .44364 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.35661 .38446 m
.40325 .29582 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.35661 .38446 m
.45213 .30942 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.5281 .31127 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.45213 .30942 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.71165 .45341 m
.76379 .50556 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.71165 .45341 m
.68592 .36358 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58943 .72154 m
.61607 .66708 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.71261 .59234 m
.61607 .66708 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52849 .72935 m
.61607 .66708 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68763 .64558 m
.71261 .59234 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.76379 .50556 m
.71261 .59234 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68592 .36358 m
.58822 .30036 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.58822 .30036 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.45148 .72803 m
.35532 .66232 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40192 .71829 m
.35532 .66232 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.2658 .58359 m
.35532 .66232 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31289 .35482 m
.26685 .44364 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.23382 .49439 m
.26685 .44364 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40325 .29582 m
.31289 .35482 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.40325 .29582 L
s
P
p
.0085 w
.5 .2197 m
.41041 .27807 L
s
P
p
.0085 w
.5 .2197 m
.47102 .26664 L
s
P
p
.0085 w
.5 .2197 m
.59763 .28272 L
s
P
p
.0085 w
.5 .2197 m
.54924 .2686 L
s
P
p
.0085 w
.2658 .58359 m
.23382 .49439 L
s
P
p
.0085 w
.31116 .63856 m
.2658 .58359 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52849 .72935 m
.5 .78548 L
s
P
p
.0085 w
.59763 .28272 m
.68592 .36358 L
s
P
p
.0085 w
.73833 .41494 m
.68592 .36358 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .78548 m
.45148 .72803 L
s
P
p
.0085 w
.76379 .50556 m
.73943 .55788 L
s
P
p
.0085 w
.73833 .41494 m
.76379 .50556 L
s
P
p
.0085 w
.64885 .33301 m
.59763 .28272 L
s
P
p
.0085 w
.41041 .27807 m
.31289 .35482 L
s
P
p
.0085 w
.28029 .40457 m
.31289 .35482 L
s
P
p
.0085 w
.58943 .72154 m
.5 .78548 L
s
P
p
.0085 w
.68763 .64558 m
.58943 .72154 L
s
P
p
.0085 w
.3795 .32655 m
.41041 .27807 L
s
P
p
.0085 w
.68763 .64558 m
.73943 .55788 L
s
P
p
.0085 w
.68763 .64558 m
.59899 .7089 L
s
P
p
.0085 w
.40192 .71829 m
.5 .78548 L
s
P
p
.0085 w
.31116 .63856 m
.40192 .71829 L
s
P
p
.0085 w
.23382 .49439 m
.27926 .5486 L
s
P
p
.0085 w
.23382 .49439 m
.28029 .40457 L
s
P
p
.0085 w
.54924 .2686 m
.52066 .31722 L
s
P
p
.0085 w
.64885 .33301 m
.54924 .2686 L
s
P
p
.0085 w
.31116 .63856 m
.40916 .70557 L
s
P
p
.0085 w
.31116 .63856 m
.27926 .5486 L
s
P
p
.0085 w
.47102 .26664 m
.52066 .31722 L
s
P
p
.0085 w
.3795 .32655 m
.47102 .26664 L
s
P
p
.0085 w
.73833 .41494 m
.71317 .46631 L
s
P
p
.0085 w
.73833 .41494 m
.64885 .33301 L
s
P
p
.0085 w
.40916 .70557 m
.5 .78548 L
s
P
p
.0085 w
.59899 .7089 m
.5 .78548 L
s
P
p
.0085 w
.54993 .69878 m
.5 .78548 L
s
P
p
.0085 w
.47061 .69738 m
.5 .78548 L
s
P
p
.0085 w
.59899 .7089 m
.65024 .62107 L
s
P
p
.0085 w
.73943 .55788 m
.71317 .46631 L
s
P
p
.0085 w
.73943 .55788 m
.65024 .62107 L
s
P
p
.0085 w
.64885 .33301 m
.6219 .38316 L
s
P
p
.0085 w
.37836 .61588 m
.40916 .70557 L
s
P
p
.0085 w
.28029 .40457 m
.32708 .45792 L
s
P
p
.0085 w
.28029 .40457 m
.3795 .32655 L
s
P
p
.0085 w
.4281 .37868 m
.3795 .32655 L
s
P
p
.0085 w
.32708 .45792 m
.27926 .5486 L
s
P
p
.0085 w
.37836 .61588 m
.27926 .5486 L
s
P
p
.0085 w
.54993 .69878 m
.65024 .62107 L
s
P
p
.0085 w
.52086 .60841 m
.54993 .69878 L
s
P
p
.0085 w
.47061 .69738 m
.37836 .61588 L
s
P
p
.0085 w
.52086 .60841 m
.47061 .69738 L
s
P
p
.0085 w
.65024 .62107 m
.62248 .52941 L
s
P
p
.0085 w
.52066 .31722 m
.6219 .38316 L
s
P
p
.0085 w
.4281 .37868 m
.52066 .31722 L
s
P
p
.0085 w
.6219 .38316 m
.71317 .46631 L
s
P
p
.0085 w
.62248 .52941 m
.71317 .46631 L
s
P
p
.0085 w
.37836 .61588 m
.42776 .52539 L
s
P
p
.0085 w
.52974 .44575 m
.6219 .38316 L
s
P
p
.0085 w
.42776 .52539 m
.32708 .45792 L
s
P
p
.0085 w
.4281 .37868 m
.32708 .45792 L
s
P
p
.0085 w
.52086 .60841 m
.42776 .52539 L
s
P
p
.0085 w
.52086 .60841 m
.62248 .52941 L
s
P
p
.0085 w
.4281 .37868 m
.52974 .44575 L
s
P
p
.0085 w
.62248 .52941 m
.52974 .44575 L
s
P
p
.0085 w
.52974 .44575 m
.42776 .52539 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51723 .55004 m
.42396 .61256 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51723 .55004 m
.42429 .47598 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51723 .55004 m
.60541 .47354 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51723 .55004 m
.60587 .61037 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42429 .47598 m
.33009 .53815 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51228 .39892 m
.42429 .47598 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3793 .3894 m
.42429 .47598 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.63857 .38565 m
.60541 .47354 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51228 .39892 m
.60541 .47354 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.69528 .53345 m
.60541 .47354 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51239 .67391 m
.42396 .61256 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.37821 .66628 m
.42396 .61256 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33009 .53815 m
.42396 .61256 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54434 .30984 m
.51228 .39892 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.46812 .311 m
.51228 .39892 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60587 .61037 m
.51239 .67391 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60587 .61037 m
.63982 .66328 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60587 .61037 m
.69528 .53345 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.28364 .45168 m
.33009 .53815 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.28266 .59079 m
.33009 .53815 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.69528 .53345 m
.73095 .58528 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.69528 .53345 m
.72991 .44552 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3793 .3894 m
.28364 .45168 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3793 .3894 m
.40989 .29955 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3793 .3894 m
.46812 .311 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.46768 .72916 m
.51239 .67391 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54495 .72832 m
.51239 .67391 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54434 .30984 m
.63857 .38565 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.59549 .29669 m
.63857 .38565 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.72991 .44552 m
.63857 .38565 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.46812 .311 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.54434 .30984 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31321 .36197 m
.28364 .45168 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.23485 .50351 m
.28364 .45168 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.46768 .72916 m
.37821 .66628 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40865 .72096 m
.37821 .66628 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.28266 .59079 m
.37821 .66628 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5968 .71891 m
.63982 .66328 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.73095 .58528 m
.63982 .66328 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54495 .72832 m
.63982 .66328 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.28266 .59079 m
.23485 .50351 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3115 .64429 m
.28266 .59079 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.72991 .44552 m
.76666 .49647 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.72991 .44552 m
.68754 .35645 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40989 .29955 m
.31321 .36197 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.40989 .29955 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68754 .35645 m
.59549 .29669 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.59549 .29669 L
s
P
p
.0085 w
.68927 .63986 m
.73095 .58528 L
s
P
p
.0085 w
.76666 .49647 m
.73095 .58528 L
s
P
p
.0085 w
.5 .2197 m
.40352 .28183 L
s
P
p
.0085 w
.5 .2197 m
.45436 .26816 L
s
P
p
.0085 w
.5 .2197 m
.59141 .2789 L
s
P
p
.0085 w
.5 .2197 m
.53287 .26693 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .78548 m
.46768 .72916 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54495 .72832 m
.5 .78548 L
s
P
p
.0085 w
.40352 .28183 m
.31321 .36197 L
s
P
p
.0085 w
.26429 .41297 m
.31321 .36197 L
s
P
p
.0085 w
.23485 .50351 m
.26319 .55611 L
s
P
p
.0085 w
.23485 .50351 m
.26429 .41297 L
s
P
p
.0085 w
.59141 .2789 m
.68754 .35645 L
s
P
p
.0085 w
.72399 .40643 m
.68754 .35645 L
s
P
p
.0085 w
.35589 .33171 m
.40352 .28183 L
s
P
p
.0085 w
.40865 .72096 m
.5 .78548 L
s
P
p
.0085 w
.3115 .64429 m
.40865 .72096 L
s
P
p
.0085 w
.62624 .32764 m
.59141 .2789 L
s
P
p
.0085 w
.5968 .71891 m
.5 .78548 L
s
P
p
.0085 w
.68927 .63986 m
.5968 .71891 L
s
P
p
.0085 w
.3115 .64429 m
.40218 .70826 L
s
P
p
.0085 w
.3115 .64429 m
.26319 .55611 L
s
P
p
.0085 w
.76666 .49647 m
.72503 .55026 L
s
P
p
.0085 w
.72399 .40643 m
.76666 .49647 L
s
P
p
.0085 w
.68927 .63986 m
.72503 .55026 L
s
P
p
.0085 w
.68927 .63986 m
.59268 .70616 L
s
P
p
.0085 w
.45436 .26816 m
.48697 .31707 L
s
P
p
.0085 w
.35589 .33171 m
.45436 .26816 L
s
P
p
.0085 w
.53287 .26693 m
.48697 .31707 L
s
P
p
.0085 w
.62624 .32764 m
.53287 .26693 L
s
P
p
.0085 w
.40218 .70826 m
.5 .78548 L
s
P
p
.0085 w
.59268 .70616 m
.5 .78548 L
s
P
p
.0085 w
.53333 .69758 m
.5 .78548 L
s
P
p
.0085 w
.45372 .69847 m
.5 .78548 L
s
P
p
.0085 w
.26429 .41297 m
.29354 .46463 L
s
P
p
.0085 w
.26429 .41297 m
.35589 .33171 L
s
P
p
.0085 w
.35454 .62003 m
.40218 .70826 L
s
P
p
.0085 w
.59268 .70616 m
.62743 .61676 L
s
P
p
.0085 w
.29354 .46463 m
.26319 .55611 L
s
P
p
.0085 w
.35454 .62003 m
.26319 .55611 L
s
P
p
.0085 w
.72399 .40643 m
.68109 .45934 L
s
P
p
.0085 w
.72399 .40643 m
.62624 .32764 L
s
P
p
.0085 w
.38696 .38216 m
.35589 .33171 L
s
P
p
.0085 w
.62624 .32764 m
.58151 .37934 L
s
P
p
.0085 w
.72503 .55026 m
.68109 .45934 L
s
P
p
.0085 w
.72503 .55026 m
.62743 .61676 L
s
P
p
.0085 w
.45372 .69847 m
.35454 .62003 L
s
P
p
.0085 w
.48685 .60829 m
.45372 .69847 L
s
P
p
.0085 w
.53333 .69758 m
.62743 .61676 L
s
P
p
.0085 w
.48685 .60829 m
.53333 .69758 L
s
P
p
.0085 w
.35454 .62003 m
.38642 .52851 L
s
P
p
.0085 w
.48697 .31707 m
.58151 .37934 L
s
P
p
.0085 w
.38696 .38216 m
.48697 .31707 L
s
P
p
.0085 w
.62743 .61676 m
.5819 .52598 L
s
P
p
.0085 w
.38642 .52851 m
.29354 .46463 L
s
P
p
.0085 w
.38696 .38216 m
.29354 .46463 L
s
P
p
.0085 w
.58151 .37934 m
.68109 .45934 L
s
P
p
.0085 w
.5819 .52598 m
.68109 .45934 L
s
P
p
.0085 w
.38696 .38216 m
.48125 .44555 L
s
P
p
.0085 w
.48685 .60829 m
.38642 .52851 L
s
P
p
.0085 w
.48685 .60829 m
.5819 .52598 L
s
P
p
.0085 w
.48125 .44555 m
.58151 .37934 L
s
P
p
.0085 w
.48125 .44555 m
.38642 .52851 L
s
P
p
.0085 w
.5819 .52598 m
.48125 .44555 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56134 .54874 m
.46432 .6143 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56134 .54874 m
.46448 .47793 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56134 .54874 m
.64122 .46921 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56134 .54874 m
.64185 .60649 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.46448 .47793 m
.36701 .54317 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54369 .39788 m
.46448 .47793 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40541 .39342 m
.46448 .47793 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54408 .67308 m
.46432 .6143 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40456 .6695 m
.46432 .6143 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36701 .54317 m
.46432 .6143 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.30665 .45896 m
.36701 .54317 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.30578 .59731 m
.36701 .54317 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65813 .38008 m
.64122 .46921 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54369 .39788 m
.64122 .46921 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.72323 .52645 m
.64122 .46921 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55929 .30779 m
.54369 .39788 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48503 .31193 m
.54369 .39788 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40541 .39342 m
.30665 .45896 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40541 .39342 m
.4192 .30296 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40541 .39342 m
.48503 .31193 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64185 .60649 m
.54408 .67308 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64185 .60649 m
.65956 .65881 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64185 .60649 m
.72323 .52645 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31917 .36896 m
.30665 .45896 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.24385 .5124 m
.30665 .45896 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48482 .72982 m
.54408 .67308 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5601 .72685 m
.54408 .67308 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.48503 .31193 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.72323 .52645 m
.74256 .57769 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.72323 .52645 m
.74146 .43705 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48482 .72982 m
.40456 .6695 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4181 .7234 m
.40456 .6695 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.30578 .59731 m
.40456 .6695 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.30578 .59731 m
.24385 .5124 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31751 .6499 m
.30578 .59731 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55929 .30779 m
.65813 .38008 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5999 .29278 m
.65813 .38008 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.74146 .43705 m
.65813 .38008 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.55929 .30779 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4192 .30296 m
.31917 .36896 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.4192 .30296 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.39961 .2858 m
.31917 .36896 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.2557 .42175 m
.31917 .36896 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60128 .71611 m
.65956 .65881 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.74256 .57769 m
.65956 .65881 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5601 .72685 m
.65956 .65881 L
s
P
p
.0085 w
.24385 .5124 m
.25457 .56399 L
s
P
p
.0085 w
.24385 .5124 m
.2557 .42175 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68343 .34932 m
.5999 .29278 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.5999 .29278 L
s
P
p
.0085 w
.5 .2197 m
.39961 .2858 L
s
P
p
.0085 w
.5 .2197 m
.43916 .27033 L
s
P
p
.0085 w
.5 .2197 m
.58235 .27538 L
s
P
p
.0085 w
.5 .2197 m
.51546 .26594 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .78548 m
.48482 .72982 L
s
P
p
.0085 w
.74146 .43705 m
.76139 .48735 L
s
P
p
.0085 w
.74146 .43705 m
.68343 .34932 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5601 .72685 m
.5 .78548 L
s
P
p
.0085 w
.33692 .33769 m
.39961 .2858 L
s
P
p
.0085 w
.68513 .63415 m
.74256 .57769 L
s
P
p
.0085 w
.76139 .48735 m
.74256 .57769 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4181 .7234 m
.5 .78548 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31751 .6499 m
.4181 .7234 L
s
P
p
.0085 w
.31751 .6499 m
.39822 .71111 L
s
P
p
.0085 w
.31751 .6499 m
.25457 .56399 L
s
P
p
.0085 w
.58235 .27538 m
.68343 .34932 L
s
P
p
.0085 w
.7025 .39854 m
.68343 .34932 L
s
P
p
.0085 w
.59954 .32322 m
.58235 .27538 L
s
P
p
.0085 w
.2557 .42175 m
.26679 .47237 L
s
P
p
.0085 w
.2557 .42175 m
.33692 .33769 L
s
P
p
.0085 w
.60128 .71611 m
.5 .78548 L
s
P
p
.0085 w
.68513 .63415 m
.60128 .71611 L
s
P
p
.0085 w
.43916 .27033 m
.45371 .31824 L
s
P
p
.0085 w
.33692 .33769 m
.43916 .27033 L
s
P
p
.0085 w
.26679 .47237 m
.25457 .56399 L
s
P
p
.0085 w
.3354 .62482 m
.25457 .56399 L
s
P
p
.0085 w
.51546 .26594 m
.45371 .31824 L
s
P
p
.0085 w
.59954 .32322 m
.51546 .26594 L
s
P
p
.0085 w
.39822 .71111 m
.5 .78548 L
s
P
p
.0085 w
.5835 .70364 m
.5 .78548 L
s
P
p
.0085 w
.51567 .69688 m
.5 .78548 L
s
P
p
.0085 w
.4383 .70002 m
.5 .78548 L
s
P
p
.0085 w
.3354 .62482 m
.39822 .71111 L
s
P
p
.0085 w
.76139 .48735 m
.70345 .54319 L
s
P
p
.0085 w
.7025 .39854 m
.76139 .48735 L
s
P
p
.0085 w
.34963 .3871 m
.33692 .33769 L
s
P
p
.0085 w
.68513 .63415 m
.70345 .54319 L
s
P
p
.0085 w
.68513 .63415 m
.5835 .70364 L
s
P
p
.0085 w
.5835 .70364 m
.60047 .61321 L
s
P
p
.0085 w
.4383 .70002 m
.3354 .62482 L
s
P
p
.0085 w
.45327 .60922 m
.4383 .70002 L
s
P
p
.0085 w
.3354 .62482 m
.34891 .53294 L
s
P
p
.0085 w
.7025 .39854 m
.64298 .45358 L
s
P
p
.0085 w
.7025 .39854 m
.59954 .32322 L
s
P
p
.0085 w
.59954 .32322 m
.53837 .37708 L
s
P
p
.0085 w
.34891 .53294 m
.26679 .47237 L
s
P
p
.0085 w
.34963 .3871 m
.26679 .47237 L
s
P
p
.0085 w
.51567 .69688 m
.60047 .61321 L
s
P
p
.0085 w
.45327 .60922 m
.51567 .69688 L
s
P
p
.0085 w
.45371 .31824 m
.53837 .37708 L
s
P
p
.0085 w
.34963 .3871 m
.45371 .31824 L
s
P
p
.0085 w
.70345 .54319 m
.64298 .45358 L
s
P
p
.0085 w
.70345 .54319 m
.60047 .61321 L
s
P
p
.0085 w
.34963 .3871 m
.43341 .44708 L
s
P
p
.0085 w
.60047 .61321 m
.53855 .52396 L
s
P
p
.0085 w
.45327 .60922 m
.34891 .53294 L
s
P
p
.0085 w
.45327 .60922 m
.53855 .52396 L
s
P
p
.0085 w
.43341 .44708 m
.34891 .53294 L
s
P
p
.0085 w
.53837 .37708 m
.64298 .45358 L
s
P
p
.0085 w
.53855 .52396 m
.64298 .45358 L
s
P
p
.0085 w
.43341 .44708 m
.53837 .37708 L
s
P
p
.0085 w
.53855 .52396 m
.43341 .44708 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.50563 .47845 m
.40755 .5469 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.57388 .3957 m
.50563 .47845 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.43419 .3964 m
.50563 .47845 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6038 .54602 m
.50563 .47845 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40755 .5469 m
.50565 .61477 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33513 .46529 m
.40755 .5469 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33439 .60299 m
.40755 .5469 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6038 .54602 m
.50565 .61477 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6038 .54602 m
.67313 .46367 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6038 .54602 m
.67391 .60153 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.57454 .67133 m
.50565 .61477 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4336 .67189 m
.50565 .61477 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.43419 .3964 m
.33513 .46529 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.43419 .3964 m
.4309 .30593 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.43419 .3964 m
.50237 .31218 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.57388 .3957 m
.67313 .46367 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5725 .30517 m
.57388 .3957 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.50237 .31218 m
.57388 .3957 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33049 .3756 m
.33513 .46529 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.26038 .52079 m
.33513 .46529 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67311 .37383 m
.67313 .46367 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.74484 .51856 m
.67313 .46367 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33439 .60299 m
.4336 .67189 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33439 .60299 m
.26038 .52079 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32895 .65522 m
.33439 .60299 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67391 .60153 m
.57454 .67133 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67391 .60153 m
.67469 .6538 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67391 .60153 m
.74484 .51856 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5024 .73 m
.4336 .67189 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42996 .72553 m
.4336 .67189 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.50237 .31218 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5024 .73 m
.57454 .67133 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5735 .72498 m
.57454 .67133 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4309 .30593 m
.33049 .3756 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.4309 .30593 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5725 .30517 m
.67311 .37383 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.5725 .30517 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.26038 .52079 m
.25351 .57196 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.26038 .52079 m
.25464 .43066 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.39878 .28985 m
.33049 .3756 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.25464 .43066 m
.33049 .3756 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6013 .28875 m
.67311 .37383 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.74582 .42823 m
.67311 .37383 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.74484 .51856 m
.74695 .56979 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.74484 .51856 m
.74582 .42823 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .78548 m
.5024 .73 L
s
P
p
.0085 w
.5 .2197 m
.39878 .28985 L
s
P
p
.0085 w
.5 .2197 m
.42587 .27307 L
s
P
p
.0085 w
.5 .2197 m
.6013 .28875 L
s
P
p
.0085 w
.5 .2197 m
.57072 .27227 L
s
P
p
.0085 w
.5 .2197 m
.49755 .26567 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32895 .65522 m
.42996 .72553 L
s
P
p
.0085 w
.32895 .65522 m
.39738 .71401 L
s
P
p
.0085 w
.32895 .65522 m
.25351 .57196 L
s
P
p
.0085 w
.32313 .34428 m
.39878 .28985 L
s
P
p
.0085 w
.67364 .34243 m
.6013 .28875 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5735 .72498 m
.67469 .6538 L
s
P
p
.0085 w
.6027 .71322 m
.67469 .6538 L
s
P
p
.0085 w
.74695 .56979 m
.67469 .6538 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42996 .72553 m
.5 .78548 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5735 .72498 m
.5 .78548 L
s
P
p
.0085 w
.25464 .43066 m
.24757 .48086 L
s
P
p
.0085 w
.25464 .43066 m
.32313 .34428 L
s
P
p
.0085 w
.74582 .42823 m
.74797 .47849 L
s
P
p
.0085 w
.74582 .42823 m
.67364 .34243 L
s
P
p
.0085 w
.24757 .48086 m
.25351 .57196 L
s
P
p
.0085 w
.32149 .6301 m
.25351 .57196 L
s
P
p
.0085 w
.67526 .62863 m
.74695 .56979 L
s
P
p
.0085 w
.74797 .47849 m
.74695 .56979 L
s
P
p
.0085 w
.42587 .27307 m
.42198 .32069 L
s
P
p
.0085 w
.32313 .34428 m
.42587 .27307 L
s
P
p
.0085 w
.57072 .27227 m
.67364 .34243 L
s
P
p
.0085 w
.56958 .3199 m
.57072 .27227 L
s
P
p
.0085 w
.31729 .39333 m
.32313 .34428 L
s
P
p
.0085 w
.39738 .71401 m
.5 .78548 L
s
P
p
.0085 w
.32149 .6301 m
.39738 .71401 L
s
P
p
.0085 w
.6027 .71322 m
.5 .78548 L
s
P
p
.0085 w
.67526 .62863 m
.6027 .71322 L
s
P
p
.0085 w
.67445 .39152 m
.67364 .34243 L
s
P
p
.0085 w
.57171 .70141 m
.5 .78548 L
s
P
p
.0085 w
.49752 .69669 m
.5 .78548 L
s
P
p
.0085 w
.42483 .70199 m
.5 .78548 L
s
P
p
.0085 w
.49755 .26567 m
.42198 .32069 L
s
P
p
.0085 w
.56958 .3199 m
.49755 .26567 L
s
P
p
.0085 w
.31643 .53852 m
.24757 .48086 L
s
P
p
.0085 w
.31729 .39333 m
.24757 .48086 L
s
P
p
.0085 w
.32149 .6301 m
.31643 .53852 L
s
P
p
.0085 w
.42483 .70199 m
.32149 .6301 L
s
P
p
.0085 w
.67526 .62863 m
.67527 .5369 L
s
P
p
.0085 w
.67526 .62863 m
.57171 .70141 L
s
P
p
.0085 w
.74797 .47849 m
.67527 .5369 L
s
P
p
.0085 w
.67445 .39152 m
.74797 .47849 L
s
P
p
.0085 w
.42125 .61118 m
.42483 .70199 L
s
P
p
.0085 w
.57171 .70141 m
.57023 .61055 L
s
P
p
.0085 w
.42198 .32069 m
.49392 .37647 L
s
P
p
.0085 w
.31729 .39333 m
.42198 .32069 L
s
P
p
.0085 w
.49752 .69669 m
.57023 .61055 L
s
P
p
.0085 w
.42125 .61118 m
.49752 .69669 L
s
P
p
.0085 w
.56958 .3199 m
.49392 .37647 L
s
P
p
.0085 w
.67445 .39152 m
.56958 .3199 L
s
P
p
.0085 w
.31729 .39333 m
.38784 .45028 L
s
P
p
.0085 w
.67445 .39152 m
.60005 .44925 L
s
P
p
.0085 w
.38784 .45028 m
.31643 .53852 L
s
P
p
.0085 w
.42125 .61118 m
.31643 .53852 L
s
P
p
.0085 w
.67527 .5369 m
.60005 .44925 L
s
P
p
.0085 w
.67527 .5369 m
.57023 .61055 L
s
P
p
.0085 w
.42125 .61118 m
.49389 .52341 L
s
P
p
.0085 w
.57023 .61055 m
.49389 .52341 L
s
P
p
.0085 w
.49392 .37647 m
.60005 .44925 L
s
P
p
.0085 w
.38784 .45028 m
.49392 .37647 L
s
P
p
.0085 w
.49389 .52341 m
.38784 .45028 L
s
P
p
.0085 w
.49389 .52341 m
.60005 .44925 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.45058 .54924 m
.54683 .61395 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54662 .47754 m
.45058 .54924 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3682 .47051 m
.45058 .54924 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36762 .60766 m
.45058 .54924 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60201 .39242 m
.54662 .47754 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4648 .39828 m
.54662 .47754 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64346 .54193 m
.54662 .47754 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60292 .6687 m
.54683 .61395 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.46448 .6734 m
.54683 .61395 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64346 .54193 m
.54683 .61395 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64346 .54193 m
.7002 .45706 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64346 .54193 m
.7011 .59561 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34677 .38168 m
.3682 .47051 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4648 .39828 m
.3682 .47051 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.2838 .52845 m
.3682 .47051 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4648 .39828 m
.44463 .3084 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4648 .39828 m
.51965 .31174 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36762 .60766 m
.46448 .6734 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36762 .60766 m
.2838 .52845 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34539 .66009 m
.36762 .60766 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60201 .39242 m
.7002 .45706 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58359 .30207 m
.60201 .39242 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51965 .31174 m
.60201 .39242 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51992 .72969 m
.46448 .6734 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44388 .7273 m
.46448 .6734 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68301 .36708 m
.7002 .45706 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.75937 .51001 m
.7002 .45706 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.2838 .52845 m
.25991 .5798 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.2838 .52845 m
.26099 .4394 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.51965 .31174 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40101 .29387 m
.34677 .38168 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44463 .3084 m
.34677 .38168 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.26099 .4394 m
.34677 .38168 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.44463 .3084 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51992 .72969 m
.60292 .6687 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58473 .72276 m
.60292 .6687 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.7011 .59561 m
.60292 .6687 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.7011 .59561 m
.68468 .64839 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.7011 .59561 m
.75937 .51001 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58359 .30207 m
.68301 .36708 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.58359 .30207 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34539 .66009 m
.39964 .71689 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34539 .66009 m
.25991 .5798 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34539 .66009 m
.44388 .7273 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.59962 .2847 m
.68301 .36708 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.74271 .41933 m
.68301 .36708 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31488 .35125 m
.40101 .29387 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.40101 .29387 L
s
P
p
.0085 w
.26099 .4394 m
.23636 .48982 L
s
P
p
.0085 w
.26099 .4394 m
.31488 .35125 L
s
P
p
.0085 w
.5 .2197 m
.41491 .2763 L
s
P
p
.0085 w
.5 .2197 m
.59962 .2847 L
s
P
p
.0085 w
.5 .2197 m
.55687 .26968 L
s
P
p
.0085 w
.5 .2197 m
.47972 .26614 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .78548 m
.51992 .72969 L
s
P
p
.0085 w
.75937 .51001 m
.74383 .56182 L
s
P
p
.0085 w
.75937 .51001 m
.74271 .41933 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44388 .7273 m
.5 .78548 L
s
P
p
.0085 w
.23636 .48982 m
.25991 .5798 L
s
P
p
.0085 w
.31316 .6357 m
.25991 .5798 L
s
P
p
.0085 w
.6584 .33599 m
.59962 .2847 L
s
P
p
.0085 w
.58473 .72276 m
.5 .78548 L
s
P
p
.0085 w
.58473 .72276 m
.68468 .64839 L
s
P
p
.0085 w
.601 .71032 m
.68468 .64839 L
s
P
p
.0085 w
.74383 .56182 m
.68468 .64839 L
s
P
p
.0085 w
.31488 .35125 m
.41491 .2763 L
s
P
p
.0085 w
.29096 .40061 m
.31488 .35125 L
s
P
p
.0085 w
.41491 .2763 m
.39282 .32432 L
s
P
p
.0085 w
.39964 .71689 m
.5 .78548 L
s
P
p
.0085 w
.31316 .6357 m
.39964 .71689 L
s
P
p
.0085 w
.74271 .41933 m
.72664 .47017 L
s
P
p
.0085 w
.74271 .41933 m
.6584 .33599 L
s
P
p
.0085 w
.55687 .26968 m
.6584 .33599 L
s
P
p
.0085 w
.53732 .31779 m
.55687 .26968 L
s
P
p
.0085 w
.28998 .54505 m
.23636 .48982 L
s
P
p
.0085 w
.29096 .40061 m
.23636 .48982 L
s
P
p
.0085 w
.47972 .26614 m
.39282 .32432 L
s
P
p
.0085 w
.53732 .31779 m
.47972 .26614 L
s
P
p
.0085 w
.601 .71032 m
.5 .78548 L
s
P
p
.0085 w
.55767 .69955 m
.5 .78548 L
s
P
p
.0085 w
.47944 .69702 m
.5 .78548 L
s
P
p
.0085 w
.41372 .7043 m
.5 .78548 L
s
P
p
.0085 w
.65988 .62346 m
.74383 .56182 L
s
P
p
.0085 w
.72664 .47017 m
.74383 .56182 L
s
P
p
.0085 w
.65988 .62346 m
.601 .71032 L
s
P
p
.0085 w
.31316 .6357 m
.28998 .54505 L
s
P
p
.0085 w
.41372 .7043 m
.31316 .6357 L
s
P
p
.0085 w
.64064 .38562 m
.6584 .33599 L
s
P
p
.0085 w
.39181 .6141 m
.41372 .7043 L
s
P
p
.0085 w
.29096 .40061 m
.34609 .45502 L
s
P
p
.0085 w
.29096 .40061 m
.39282 .32432 L
s
P
p
.0085 w
.39282 .32432 m
.44967 .37753 L
s
P
p
.0085 w
.55767 .69955 m
.53768 .60886 L
s
P
p
.0085 w
.65988 .62346 m
.55767 .69955 L
s
P
p
.0085 w
.65988 .62346 m
.64131 .53161 L
s
P
p
.0085 w
.47944 .69702 m
.53768 .60886 L
s
P
p
.0085 w
.39181 .6141 m
.47944 .69702 L
s
P
p
.0085 w
.72664 .47017 m
.64131 .53161 L
s
P
p
.0085 w
.64064 .38562 m
.72664 .47017 L
s
P
p
.0085 w
.34609 .45502 m
.28998 .54505 L
s
P
p
.0085 w
.39181 .6141 m
.28998 .54505 L
s
P
p
.0085 w
.53732 .31779 m
.44967 .37753 L
s
P
p
.0085 w
.64064 .38562 m
.53732 .31779 L
s
P
p
.0085 w
.39181 .6141 m
.44943 .52436 L
s
P
p
.0085 w
.64064 .38562 m
.5537 .4465 L
s
P
p
.0085 w
.53768 .60886 m
.44943 .52436 L
s
P
p
.0085 w
.64131 .53161 m
.53768 .60886 L
s
P
p
.0085 w
.64131 .53161 m
.5537 .4465 L
s
P
p
.0085 w
.34609 .45502 m
.44967 .37753 L
s
P
p
.0085 w
.44943 .52436 m
.34609 .45502 L
s
P
p
.0085 w
.44967 .37753 m
.5537 .4465 L
s
P
p
.0085 w
.44943 .52436 m
.5537 .4465 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49493 .55014 m
.58674 .61187 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58635 .47521 m
.49493 .55014 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40491 .47449 m
.49493 .55014 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40448 .61122 m
.49493 .55014 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.62726 .38814 m
.58635 .47521 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49639 .399 m
.58635 .47521 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67921 .53657 m
.58635 .47521 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36748 .38704 m
.40491 .47449 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49639 .399 m
.40491 .47449 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31332 .53519 m
.40491 .47449 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49639 .399 m
.45998 .31029 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49639 .399 m
.53635 .31064 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6284 .66527 m
.58674 .61187 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49636 .67398 m
.58674 .61187 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67921 .53657 m
.58674 .61187 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40448 .61122 m
.49636 .67398 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40448 .61122 m
.31332 .53519 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36629 .66439 m
.40448 .61122 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67921 .53657 m
.72159 .44955 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67921 .53657 m
.72259 .58889 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31332 .53519 m
.27341 .58726 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31332 .53519 m
.27443 .44774 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.62726 .38814 m
.72159 .44955 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5922 .29856 m
.62726 .38814 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.53635 .31064 m
.62726 .38814 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.53685 .7289 m
.49636 .67398 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.45943 .72865 m
.49636 .67398 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40622 .29772 m
.36748 .38704 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.45998 .31029 m
.36748 .38704 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.27443 .44774 m
.36748 .38704 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.53635 .31064 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.45998 .31029 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68744 .36003 m
.72159 .44955 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.76623 .50104 m
.72159 .44955 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.53685 .7289 m
.6284 .66527 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.59347 .72025 m
.6284 .66527 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.72259 .58889 m
.6284 .66527 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.27443 .44774 m
.23332 .49896 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.27443 .44774 m
.31234 .3584 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36629 .66439 m
.40493 .71965 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36629 .66439 m
.27341 .58726 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36629 .66439 m
.45943 .72865 L
s
P
p
.0085 w
.72259 .58889 m
.68917 .64273 L
s
P
p
.0085 w
.72259 .58889 m
.76623 .50104 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5922 .29856 m
.68744 .36003 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.5922 .29856 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31234 .3584 m
.40622 .29772 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.40622 .29772 L
s
P
p
.0085 w
.23332 .49896 m
.27341 .58726 L
s
P
p
.0085 w
.31061 .64143 m
.27341 .58726 L
s
P
p
.0085 w
.5 .2197 m
.4066 .27992 L
s
P
p
.0085 w
.5 .2197 m
.59489 .28078 L
s
P
p
.0085 w
.5 .2197 m
.54122 .26768 L
s
P
p
.0085 w
.5 .2197 m
.46254 .26732 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .78548 m
.53685 .7289 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.45943 .72865 m
.5 .78548 L
s
P
p
.0085 w
.59489 .28078 m
.68744 .36003 L
s
P
p
.0085 w
.73207 .41063 m
.68744 .36003 L
s
P
p
.0085 w
.31234 .3584 m
.4066 .27992 L
s
P
p
.0085 w
.27138 .4087 m
.31234 .3584 L
s
P
p
.0085 w
.6381 .33022 m
.59489 .28078 L
s
P
p
.0085 w
.76623 .50104 m
.73315 .55402 L
s
P
p
.0085 w
.76623 .50104 m
.73207 .41063 L
s
P
p
.0085 w
.4066 .27992 m
.36716 .32902 L
s
P
p
.0085 w
.59347 .72025 m
.5 .78548 L
s
P
p
.0085 w
.59347 .72025 m
.68917 .64273 L
s
P
p
.0085 w
.27031 .55229 m
.23332 .49896 L
s
P
p
.0085 w
.27138 .4087 m
.23332 .49896 L
s
P
p
.0085 w
.40493 .71965 m
.5 .78548 L
s
P
p
.0085 w
.31061 .64143 m
.40493 .71965 L
s
P
p
.0085 w
.59621 .70751 m
.68917 .64273 L
s
P
p
.0085 w
.73315 .55402 m
.68917 .64273 L
s
P
p
.0085 w
.31061 .64143 m
.27031 .55229 L
s
P
p
.0085 w
.4053 .70689 m
.31061 .64143 L
s
P
p
.0085 w
.54122 .26768 m
.6381 .33022 L
s
P
p
.0085 w
.50383 .31698 m
.54122 .26768 L
s
P
p
.0085 w
.46254 .26732 m
.36716 .32902 L
s
P
p
.0085 w
.50383 .31698 m
.46254 .26732 L
s
P
p
.0085 w
.59621 .70751 m
.5 .78548 L
s
P
p
.0085 w
.5418 .69812 m
.5 .78548 L
s
P
p
.0085 w
.46201 .69786 m
.5 .78548 L
s
P
p
.0085 w
.4053 .70689 m
.5 .78548 L
s
P
p
.0085 w
.73207 .41063 m
.69795 .46269 L
s
P
p
.0085 w
.73207 .41063 m
.6381 .33022 L
s
P
p
.0085 w
.6394 .61883 m
.59621 .70751 L
s
P
p
.0085 w
.36591 .61787 m
.4053 .70689 L
s
P
p
.0085 w
.27138 .4087 m
.30952 .46113 L
s
P
p
.0085 w
.27138 .4087 m
.36716 .32902 L
s
P
p
.0085 w
.60214 .38106 m
.6381 .33022 L
s
P
p
.0085 w
.6394 .61883 m
.73315 .55402 L
s
P
p
.0085 w
.69795 .46269 m
.73315 .55402 L
s
P
p
.0085 w
.36716 .32902 m
.40714 .38023 L
s
P
p
.0085 w
.30952 .46113 m
.27031 .55229 L
s
P
p
.0085 w
.36591 .61787 m
.27031 .55229 L
s
P
p
.0085 w
.5418 .69812 m
.50387 .60821 L
s
P
p
.0085 w
.6394 .61883 m
.5418 .69812 L
s
P
p
.0085 w
.46201 .69786 m
.50387 .60821 L
s
P
p
.0085 w
.36591 .61787 m
.46201 .69786 L
s
P
p
.0085 w
.6394 .61883 m
.60263 .52753 L
s
P
p
.0085 w
.50383 .31698 m
.40714 .38023 L
s
P
p
.0085 w
.60214 .38106 m
.50383 .31698 L
s
P
p
.0085 w
.36591 .61787 m
.4067 .52678 L
s
P
p
.0085 w
.69795 .46269 m
.60263 .52753 L
s
P
p
.0085 w
.60214 .38106 m
.69795 .46269 L
s
P
p
.0085 w
.30952 .46113 m
.40714 .38023 L
s
P
p
.0085 w
.4067 .52678 m
.30952 .46113 L
s
P
p
.0085 w
.60214 .38106 m
.50552 .44544 L
s
P
p
.0085 w
.40714 .38023 m
.50552 .44544 L
s
P
p
.0085 w
.50387 .60821 m
.4067 .52678 L
s
P
p
.0085 w
.60263 .52753 m
.50387 .60821 L
s
P
p
.0085 w
.60263 .52753 m
.50552 .44544 L
s
P
p
.0085 w
.4067 .52678 m
.50552 .44544 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.53942 .54957 m
.62429 .60857 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.62374 .47153 m
.53942 .54957 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4442 .47713 m
.53942 .54957 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44395 .61359 m
.53942 .54957 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.39197 .39153 m
.4442 .47713 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52808 .39855 m
.4442 .47713 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34803 .54082 m
.4442 .47713 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44395 .61359 m
.52833 .67361 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44395 .61359 m
.34803 .54082 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.391 .66799 m
.44395 .61359 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64889 .38296 m
.62374 .47153 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52808 .39855 m
.62374 .47153 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.71 .53007 m
.62374 .47153 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34803 .54082 m
.29349 .59415 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34803 .54082 m
.29441 .45543 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52808 .39855 m
.47649 .31155 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52808 .39855 m
.55201 .30889 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65023 .66112 m
.62429 .60857 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52833 .67361 m
.62429 .60857 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.71 .53007 m
.62429 .60857 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.41423 .3013 m
.39197 .39153 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.47649 .31155 m
.39197 .39153 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.29441 .45543 m
.39197 .39153 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55271 .72764 m
.52833 .67361 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.47617 .72955 m
.52833 .67361 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.71 .53007 m
.73656 .44134 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.71 .53007 m
.73763 .58154 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.29441 .45543 m
.23838 .508 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.29441 .45543 m
.3155 .3655 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.47649 .31155 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64889 .38296 m
.73656 .44134 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.59807 .29476 m
.64889 .38296 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55201 .30889 m
.64889 .38296 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.55201 .30889 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.391 .66799 m
.41305 .72221 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.391 .66799 m
.29349 .59415 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.391 .66799 m
.47617 .72955 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.23838 .508 m
.29349 .59415 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31381 .64712 m
.29349 .59415 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3155 .3655 m
.41423 .3013 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.41423 .3013 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55271 .72764 m
.65023 .66112 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.59942 .71753 m
.65023 .66112 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.73763 .58154 m
.65023 .66112 L
s
P
p
.0085 w
.6862 .35287 m
.73656 .44134 L
s
P
p
.0085 w
.76505 .49189 m
.73656 .44134 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.59807 .29476 m
.6862 .35287 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.59807 .29476 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3155 .3655 m
.40119 .2838 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.25905 .41733 m
.3155 .3655 L
s
P
p
.0085 w
.5 .2197 m
.40119 .2838 L
s
P
p
.0085 w
.5 .2197 m
.58722 .2771 L
s
P
p
.0085 w
.5 .2197 m
.52426 .26634 L
s
P
p
.0085 w
.5 .2197 m
.44655 .26917 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.47617 .72955 m
.5 .78548 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .78548 m
.55271 .72764 L
s
P
p
.0085 w
.73763 .58154 m
.68792 .637 L
s
P
p
.0085 w
.73763 .58154 m
.76505 .49189 L
s
P
p
.0085 w
.25794 .56002 m
.23838 .508 L
s
P
p
.0085 w
.25905 .41733 m
.23838 .508 L
s
P
p
.0085 w
.40119 .2838 m
.34579 .33461 L
s
P
p
.0085 w
.41305 .72221 m
.5 .78548 L
s
P
p
.0085 w
.31381 .64712 m
.41305 .72221 L
s
P
p
.0085 w
.31381 .64712 m
.25794 .56002 L
s
P
p
.0085 w
.39982 .70967 m
.31381 .64712 L
s
P
p
.0085 w
.58722 .2771 m
.6862 .35287 L
s
P
p
.0085 w
.71411 .40239 m
.6862 .35287 L
s
P
p
.0085 w
.61335 .3253 m
.58722 .2771 L
s
P
p
.0085 w
.59942 .71753 m
.5 .78548 L
s
P
p
.0085 w
.59942 .71753 m
.68792 .637 L
s
P
p
.0085 w
.76505 .49189 m
.71511 .54664 L
s
P
p
.0085 w
.76505 .49189 m
.71411 .40239 L
s
P
p
.0085 w
.25905 .41733 m
.27926 .46839 L
s
P
p
.0085 w
.25905 .41733 m
.34579 .33461 L
s
P
p
.0085 w
.44655 .26917 m
.34579 .33461 L
s
P
p
.0085 w
.47022 .31749 m
.44655 .26917 L
s
P
p
.0085 w
.52426 .26634 m
.61335 .3253 L
s
P
p
.0085 w
.47022 .31749 m
.52426 .26634 L
s
P
p
.0085 w
.58844 .70487 m
.5 .78548 L
s
P
p
.0085 w
.5246 .69717 m
.5 .78548 L
s
P
p
.0085 w
.4458 .69919 m
.5 .78548 L
s
P
p
.0085 w
.39982 .70967 m
.5 .78548 L
s
P
p
.0085 w
.58844 .70487 m
.68792 .637 L
s
P
p
.0085 w
.71511 .54664 m
.68792 .637 L
s
P
p
.0085 w
.34435 .62236 m
.39982 .70967 L
s
P
p
.0085 w
.27926 .46839 m
.25794 .56002 L
s
P
p
.0085 w
.34435 .62236 m
.25794 .56002 L
s
P
p
.0085 w
.34579 .33461 m
.36774 .38446 L
s
P
p
.0085 w
.61442 .61489 m
.58844 .70487 L
s
P
p
.0085 w
.71411 .40239 m
.66272 .4563 L
s
P
p
.0085 w
.71411 .40239 m
.61335 .3253 L
s
P
p
.0085 w
.5602 .378 m
.61335 .3253 L
s
P
p
.0085 w
.4458 .69919 m
.46994 .60862 L
s
P
p
.0085 w
.34435 .62236 m
.4458 .69919 L
s
P
p
.0085 w
.34435 .62236 m
.36711 .53057 L
s
P
p
.0085 w
.5246 .69717 m
.46994 .60862 L
s
P
p
.0085 w
.61442 .61489 m
.5246 .69717 L
s
P
p
.0085 w
.61442 .61489 m
.71511 .54664 L
s
P
p
.0085 w
.66272 .4563 m
.71511 .54664 L
s
P
p
.0085 w
.27926 .46839 m
.36774 .38446 L
s
P
p
.0085 w
.36711 .53057 m
.27926 .46839 L
s
P
p
.0085 w
.47022 .31749 m
.36774 .38446 L
s
P
p
.0085 w
.5602 .378 m
.47022 .31749 L
s
P
p
.0085 w
.61442 .61489 m
.56048 .52479 L
s
P
p
.0085 w
.36774 .38446 m
.45714 .44611 L
s
P
p
.0085 w
.46994 .60862 m
.36711 .53057 L
s
P
p
.0085 w
.56048 .52479 m
.46994 .60862 L
s
P
p
.0085 w
.66272 .4563 m
.56048 .52479 L
s
P
p
.0085 w
.5602 .378 m
.66272 .4563 L
s
P
p
.0085 w
.36711 .53057 m
.45714 .44611 L
s
P
p
.0085 w
.5602 .378 m
.45714 .44611 L
s
P
p
.0085 w
.56048 .52479 m
.45714 .44611 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.485 .47837 m
.58285 .54756 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.41952 .39505 m
.485 .47837 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55899 .39693 m
.485 .47837 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3869 .54521 m
.485 .47837 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58285 .54756 m
.65843 .60414 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65772 .46658 m
.58285 .54756 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48494 .6147 m
.58285 .54756 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3869 .54521 m
.31945 .60027 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3869 .54521 m
.32026 .46226 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48494 .6147 m
.3869 .54521 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48494 .6147 m
.55952 .67232 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4188 .67081 m
.48494 .6147 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55899 .39693 m
.65772 .46658 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55899 .39693 m
.49368 .31214 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55899 .39693 m
.56614 .30654 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.66623 .37703 m
.65772 .46658 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.73488 .5226 m
.65772 .46658 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42478 .3045 m
.41952 .39505 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49368 .31214 m
.41952 .39505 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32026 .46226 m
.41952 .39505 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32026 .46226 m
.25121 .51667 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32026 .46226 m
.32418 .37234 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.66774 .65637 m
.65843 .60414 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55952 .67232 m
.65843 .60414 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.73488 .5226 m
.65843 .60414 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56704 .72597 m
.55952 .67232 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49359 .72997 m
.55952 .67232 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.25121 .51667 m
.31945 .60027 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32258 .6526 m
.31945 .60027 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4188 .67081 m
.31945 .60027 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.49368 .31214 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4188 .67081 m
.42375 .72451 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4188 .67081 m
.49359 .72997 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56614 .30654 m
.66623 .37703 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.56614 .30654 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.73488 .5226 m
.74456 .43267 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.73488 .5226 m
.74568 .57376 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.66623 .37703 m
.74456 .43267 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60099 .29077 m
.66623 .37703 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32418 .37234 m
.42478 .3045 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.42478 .3045 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32418 .37234 m
.39881 .28782 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.25423 .42621 m
.32418 .37234 L
s
P
p
.0085 w
.2531 .56798 m
.25121 .51667 L
s
P
p
.0085 w
.25423 .42621 m
.25121 .51667 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49359 .72997 m
.5 .78548 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.60099 .29077 L
s
P
p
.0085 w
.5 .2197 m
.39881 .28782 L
s
P
p
.0085 w
.5 .2197 m
.57684 .27377 L
s
P
p
.0085 w
.5 .2197 m
.50653 .26572 L
s
P
p
.0085 w
.5 .2197 m
.43224 .27163 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56704 .72597 m
.66774 .65637 L
s
P
p
.0085 w
.60238 .71467 m
.66774 .65637 L
s
P
p
.0085 w
.74568 .57376 m
.66774 .65637 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60099 .29077 m
.67924 .34583 L
s
P
p
.0085 w
.39881 .28782 m
.32935 .34092 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .78548 m
.56704 .72597 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32258 .6526 m
.42375 .72451 L
s
P
p
.0085 w
.32258 .6526 m
.2531 .56798 L
s
P
p
.0085 w
.39741 .71256 m
.32258 .6526 L
s
P
p
.0085 w
.67924 .34583 m
.74456 .43267 L
s
P
p
.0085 w
.75569 .48287 m
.74456 .43267 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42375 .72451 m
.5 .78548 L
s
P
p
.0085 w
.74568 .57376 m
.68091 .63135 L
s
P
p
.0085 w
.74568 .57376 m
.75569 .48287 L
s
P
p
.0085 w
.25423 .42621 m
.2562 .47654 L
s
P
p
.0085 w
.25423 .42621 m
.32935 .34092 L
s
P
p
.0085 w
.57684 .27377 m
.67924 .34583 L
s
P
p
.0085 w
.5849 .32141 m
.57684 .27377 L
s
P
p
.0085 w
.2562 .47654 m
.2531 .56798 L
s
P
p
.0085 w
.32776 .62741 m
.2531 .56798 L
s
P
p
.0085 w
.68925 .3949 m
.67924 .34583 L
s
P
p
.0085 w
.43224 .27163 m
.32935 .34092 L
s
P
p
.0085 w
.43759 .31931 m
.43224 .27163 L
s
P
p
.0085 w
.60238 .71467 m
.5 .78548 L
s
P
p
.0085 w
.60238 .71467 m
.68091 .63135 L
s
P
p
.0085 w
.39741 .71256 m
.5 .78548 L
s
P
p
.0085 w
.32776 .62741 m
.39741 .71256 L
s
P
p
.0085 w
.32935 .34092 m
.33277 .39007 L
s
P
p
.0085 w
.57791 .70249 m
.5 .78548 L
s
P
p
.0085 w
.50662 .69672 m
.5 .78548 L
s
P
p
.0085 w
.4313 .70096 m
.5 .78548 L
s
P
p
.0085 w
.50653 .26572 m
.5849 .32141 L
s
P
p
.0085 w
.43759 .31931 m
.50653 .26572 L
s
P
p
.0085 w
.75569 .48287 m
.69014 .53993 L
s
P
p
.0085 w
.75569 .48287 m
.68925 .3949 L
s
P
p
.0085 w
.57791 .70249 m
.68091 .63135 L
s
P
p
.0085 w
.69014 .53993 m
.68091 .63135 L
s
P
p
.0085 w
.58571 .61177 m
.57791 .70249 L
s
P
p
.0085 w
.32776 .62741 m
.33198 .5356 L
s
P
p
.0085 w
.32776 .62741 m
.4313 .70096 L
s
P
p
.0085 w
.2562 .47654 m
.33277 .39007 L
s
P
p
.0085 w
.33198 .5356 m
.2562 .47654 L
s
P
p
.0085 w
.4313 .70096 m
.437 .61008 L
s
P
p
.0085 w
.51621 .37656 m
.5849 .32141 L
s
P
p
.0085 w
.68925 .3949 m
.5849 .32141 L
s
P
p
.0085 w
.50662 .69672 m
.437 .61008 L
s
P
p
.0085 w
.58571 .61177 m
.50662 .69672 L
s
P
p
.0085 w
.68925 .3949 m
.62203 .45123 L
s
P
p
.0085 w
.43759 .31931 m
.33277 .39007 L
s
P
p
.0085 w
.51621 .37656 m
.43759 .31931 L
s
P
p
.0085 w
.33277 .39007 m
.41024 .44848 L
s
P
p
.0085 w
.58571 .61177 m
.69014 .53993 L
s
P
p
.0085 w
.62203 .45123 m
.69014 .53993 L
s
P
p
.0085 w
.58571 .61177 m
.51629 .5235 L
s
P
p
.0085 w
.33198 .5356 m
.41024 .44848 L
s
P
p
.0085 w
.437 .61008 m
.33198 .5356 L
s
P
p
.0085 w
.51629 .5235 m
.437 .61008 L
s
P
p
.0085 w
.51621 .37656 m
.41024 .44848 L
s
P
p
.0085 w
.51621 .37656 m
.62203 .45123 L
s
P
p
.0085 w
.62203 .45123 m
.51629 .5235 L
s
P
p
.0085 w
.51629 .5235 m
.41024 .44848 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52621 .47817 m
.62405 .54414 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44931 .39749 m
.52621 .47817 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58825 .39419 m
.52621 .47817 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42882 .54825 m
.52621 .47817 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42882 .54825 m
.35049 .60546 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42882 .54825 m
.35115 .46805 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52633 .61452 m
.42882 .54825 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.62405 .54414 m
.68817 .59868 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68733 .46049 m
.62405 .54414 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52633 .61452 m
.62405 .54414 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52633 .61452 m
.58904 .67012 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44886 .67276 m
.52633 .61452 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.43754 .30724 m
.44931 .39749 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51105 .31205 m
.44931 .39749 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.35115 .46805 m
.44931 .39749 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.35115 .46805 m
.27127 .52473 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.35115 .46805 m
.33804 .37872 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58825 .39419 m
.68733 .46049 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58825 .39419 m
.51105 .31205 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58825 .39419 m
.57834 .30367 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.27127 .52473 m
.35049 .60546 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33657 .65772 m
.35049 .60546 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44886 .67276 m
.35049 .60546 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67872 .37051 m
.68733 .46049 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.75303 .51436 m
.68733 .46049 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44886 .67276 m
.43669 .72646 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44886 .67276 m
.5112 .72991 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.51105 .31205 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68035 .65114 m
.68817 .59868 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58904 .67012 m
.68817 .59868 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.75303 .51436 m
.68817 .59868 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.57941 .72391 m
.58904 .67012 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5112 .72991 m
.58904 .67012 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.2558 .57591 m
.27127 .52473 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.25691 .43507 m
.27127 .52473 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33804 .37872 m
.43754 .30724 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.43754 .30724 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33804 .37872 m
.39951 .29187 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.25691 .43507 m
.33804 .37872 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.57834 .30367 m
.67872 .37051 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.57834 .30367 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67872 .37051 m
.7452 .42378 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60085 .28672 m
.67872 .37051 L
s
P
p
.0085 w
.75303 .51436 m
.7452 .42378 L
s
P
p
.0085 w
.75303 .51436 m
.74633 .5658 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33657 .65772 m
.43669 .72646 L
s
P
p
.0085 w
.33657 .65772 m
.2558 .57591 L
s
P
p
.0085 w
.39812 .71546 m
.33657 .65772 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5112 .72991 m
.5 .78548 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.39951 .29187 L
s
P
p
.0085 w
.5 .2197 m
.60085 .28672 L
s
P
p
.0085 w
.5 .2197 m
.56405 .27091 L
s
P
p
.0085 w
.5 .2197 m
.48859 .26582 L
s
P
p
.0085 w
.5 .2197 m
.42008 .27463 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.39951 .29187 m
.3183 .34773 L
s
P
p
.0085 w
.25691 .43507 m
.24095 .4853 L
s
P
p
.0085 w
.25691 .43507 m
.3183 .34773 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.43669 .72646 m
.5 .78548 L
s
P
p
.0085 w
.60085 .28672 m
.66668 .33914 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.57941 .72391 m
.68035 .65114 L
s
P
p
.0085 w
.60225 .71176 m
.68035 .65114 L
s
P
p
.0085 w
.74633 .5658 m
.68035 .65114 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .78548 m
.57941 .72391 L
s
P
p
.0085 w
.24095 .4853 m
.2558 .57591 L
s
P
p
.0085 w
.31661 .63287 m
.2558 .57591 L
s
P
p
.0085 w
.66668 .33914 m
.7452 .42378 L
s
P
p
.0085 w
.73826 .47424 m
.7452 .42378 L
s
P
p
.0085 w
.42008 .27463 m
.3183 .34773 L
s
P
p
.0085 w
.40702 .32236 m
.42008 .27463 L
s
P
p
.0085 w
.3183 .34773 m
.30332 .39685 L
s
P
p
.0085 w
.39812 .71546 m
.5 .78548 L
s
P
p
.0085 w
.31661 .63287 m
.39812 .71546 L
s
P
p
.0085 w
.56405 .27091 m
.66668 .33914 L
s
P
p
.0085 w
.55367 .31869 m
.56405 .27091 L
s
P
p
.0085 w
.74633 .5658 m
.66824 .62599 L
s
P
p
.0085 w
.74633 .5658 m
.73826 .47424 L
s
P
p
.0085 w
.60225 .71176 m
.5 .78548 L
s
P
p
.0085 w
.60225 .71176 m
.66824 .62599 L
s
P
p
.0085 w
.56495 .70043 m
.5 .78548 L
s
P
p
.0085 w
.48843 .69679 m
.5 .78548 L
s
P
p
.0085 w
.41896 .70311 m
.5 .78548 L
s
P
p
.0085 w
.48859 .26582 m
.55367 .31869 L
s
P
p
.0085 w
.40702 .32236 m
.48859 .26582 L
s
P
p
.0085 w
.6582 .38841 m
.66668 .33914 L
s
P
p
.0085 w
.24095 .4853 m
.30332 .39685 L
s
P
p
.0085 w
.3024 .54168 m
.24095 .4853 L
s
P
p
.0085 w
.31661 .63287 m
.3024 .54168 L
s
P
p
.0085 w
.31661 .63287 m
.41896 .70311 L
s
P
p
.0085 w
.41896 .70311 m
.40614 .61253 L
s
P
p
.0085 w
.56495 .70043 m
.66824 .62599 L
s
P
p
.0085 w
.65895 .53412 m
.66824 .62599 L
s
P
p
.0085 w
.55418 .60958 m
.56495 .70043 L
s
P
p
.0085 w
.73826 .47424 m
.65895 .53412 L
s
P
p
.0085 w
.73826 .47424 m
.6582 .38841 L
s
P
p
.0085 w
.40702 .32236 m
.30332 .39685 L
s
P
p
.0085 w
.47167 .37679 m
.40702 .32236 L
s
P
p
.0085 w
.30332 .39685 m
.3664 .45247 L
s
P
p
.0085 w
.48843 .69679 m
.40614 .61253 L
s
P
p
.0085 w
.55418 .60958 m
.48843 .69679 L
s
P
p
.0085 w
.47167 .37679 m
.55367 .31869 L
s
P
p
.0085 w
.6582 .38841 m
.55367 .31869 L
s
P
p
.0085 w
.3024 .54168 m
.3664 .45247 L
s
P
p
.0085 w
.40614 .61253 m
.3024 .54168 L
s
P
p
.0085 w
.6582 .38841 m
.57721 .44767 L
s
P
p
.0085 w
.47154 .5237 m
.40614 .61253 L
s
P
p
.0085 w
.55418 .60958 m
.65895 .53412 L
s
P
p
.0085 w
.57721 .44767 m
.65895 .53412 L
s
P
p
.0085 w
.55418 .60958 m
.47154 .5237 L
s
P
p
.0085 w
.47167 .37679 m
.3664 .45247 L
s
P
p
.0085 w
.47167 .37679 m
.57721 .44767 L
s
P
p
.0085 w
.47154 .5237 m
.3664 .45247 L
s
P
p
.0085 w
.57721 .44767 m
.47154 .5237 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.47266 .54987 m
.38566 .60959 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.47266 .54987 m
.56671 .47655 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.47266 .54987 m
.38616 .47267 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56701 .61307 m
.47266 .54987 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56671 .47655 m
.66189 .5394 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48052 .39879 m
.56671 .47655 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.61504 .3904 m
.56671 .47655 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.38616 .47267 m
.29785 .53195 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.38616 .47267 m
.48052 .39879 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.38616 .47267 m
.35661 .38446 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56701 .61307 m
.61607 .66708 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56701 .61307 m
.66189 .5394 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48035 .6738 m
.56701 .61307 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.45213 .30942 m
.48052 .39879 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5281 .31127 m
.48052 .39879 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.66189 .5394 m
.71261 .59234 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.71165 .45341 m
.66189 .5394 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.29785 .53195 m
.38566 .60959 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.35532 .66232 m
.38566 .60959 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48035 .6738 m
.38566 .60959 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.61504 .3904 m
.71165 .45341 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.61504 .3904 m
.5281 .31127 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.61504 .3904 m
.58822 .30036 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.2658 .58359 m
.29785 .53195 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.26685 .44364 m
.29785 .53195 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48035 .6738 m
.45148 .72803 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48035 .6738 m
.52849 .72935 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.35661 .38446 m
.45213 .30942 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.35661 .38446 m
.40325 .29582 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.26685 .44364 m
.35661 .38446 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.5281 .31127 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.45213 .30942 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68592 .36358 m
.71165 .45341 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.76379 .50556 m
.71165 .45341 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.61607 .66708 m
.71261 .59234 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58943 .72154 m
.61607 .66708 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52849 .72935 m
.61607 .66708 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68763 .64558 m
.71261 .59234 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.76379 .50556 m
.71261 .59234 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58822 .30036 m
.68592 .36358 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.58822 .30036 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.35532 .66232 m
.45148 .72803 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.35532 .66232 m
.2658 .58359 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40192 .71829 m
.35532 .66232 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.26685 .44364 m
.23382 .49439 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.26685 .44364 m
.31289 .35482 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40325 .29582 m
.31289 .35482 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.40325 .29582 L
s
P
p
.0085 w
.5 .2197 m
.59763 .28272 L
s
P
p
.0085 w
.5 .2197 m
.54924 .2686 L
s
P
p
.0085 w
.5 .2197 m
.47102 .26664 L
s
P
p
.0085 w
.5 .2197 m
.41041 .27807 L
s
P
p
.0085 w
.23382 .49439 m
.2658 .58359 L
s
P
p
.0085 w
.31116 .63856 m
.2658 .58359 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52849 .72935 m
.5 .78548 L
s
P
p
.0085 w
.68592 .36358 m
.73833 .41494 L
s
P
p
.0085 w
.59763 .28272 m
.68592 .36358 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.45148 .72803 m
.5 .78548 L
s
P
p
.0085 w
.76379 .50556 m
.73833 .41494 L
s
P
p
.0085 w
.76379 .50556 m
.73943 .55788 L
s
P
p
.0085 w
.59763 .28272 m
.64885 .33301 L
s
P
p
.0085 w
.31289 .35482 m
.28029 .40457 L
s
P
p
.0085 w
.41041 .27807 m
.31289 .35482 L
s
P
p
.0085 w
.58943 .72154 m
.68763 .64558 L
s
P
p
.0085 w
.5 .78548 m
.58943 .72154 L
s
P
p
.0085 w
.3795 .32655 m
.41041 .27807 L
s
P
p
.0085 w
.59899 .7089 m
.68763 .64558 L
s
P
p
.0085 w
.73943 .55788 m
.68763 .64558 L
s
P
p
.0085 w
.40192 .71829 m
.5 .78548 L
s
P
p
.0085 w
.31116 .63856 m
.40192 .71829 L
s
P
p
.0085 w
.23382 .49439 m
.28029 .40457 L
s
P
p
.0085 w
.27926 .5486 m
.23382 .49439 L
s
P
p
.0085 w
.54924 .2686 m
.64885 .33301 L
s
P
p
.0085 w
.52066 .31722 m
.54924 .2686 L
s
P
p
.0085 w
.31116 .63856 m
.27926 .5486 L
s
P
p
.0085 w
.31116 .63856 m
.40916 .70557 L
s
P
p
.0085 w
.47102 .26664 m
.52066 .31722 L
s
P
p
.0085 w
.3795 .32655 m
.47102 .26664 L
s
P
p
.0085 w
.64885 .33301 m
.73833 .41494 L
s
P
p
.0085 w
.71317 .46631 m
.73833 .41494 L
s
P
p
.0085 w
.54993 .69878 m
.5 .78548 L
s
P
p
.0085 w
.47061 .69738 m
.5 .78548 L
s
P
p
.0085 w
.40916 .70557 m
.5 .78548 L
s
P
p
.0085 w
.59899 .7089 m
.5 .78548 L
s
P
p
.0085 w
.59899 .7089 m
.65024 .62107 L
s
P
p
.0085 w
.73943 .55788 m
.65024 .62107 L
s
P
p
.0085 w
.73943 .55788 m
.71317 .46631 L
s
P
p
.0085 w
.6219 .38316 m
.64885 .33301 L
s
P
p
.0085 w
.40916 .70557 m
.37836 .61588 L
s
P
p
.0085 w
.28029 .40457 m
.32708 .45792 L
s
P
p
.0085 w
.3795 .32655 m
.28029 .40457 L
s
P
p
.0085 w
.4281 .37868 m
.3795 .32655 L
s
P
p
.0085 w
.27926 .5486 m
.32708 .45792 L
s
P
p
.0085 w
.37836 .61588 m
.27926 .5486 L
s
P
p
.0085 w
.54993 .69878 m
.65024 .62107 L
s
P
p
.0085 w
.52086 .60841 m
.54993 .69878 L
s
P
p
.0085 w
.47061 .69738 m
.37836 .61588 L
s
P
p
.0085 w
.52086 .60841 m
.47061 .69738 L
s
P
p
.0085 w
.62248 .52941 m
.65024 .62107 L
s
P
p
.0085 w
.4281 .37868 m
.52066 .31722 L
s
P
p
.0085 w
.6219 .38316 m
.52066 .31722 L
s
P
p
.0085 w
.71317 .46631 m
.62248 .52941 L
s
P
p
.0085 w
.71317 .46631 m
.6219 .38316 L
s
P
p
.0085 w
.42776 .52539 m
.37836 .61588 L
s
P
p
.0085 w
.6219 .38316 m
.52974 .44575 L
s
P
p
.0085 w
.42776 .52539 m
.32708 .45792 L
s
P
p
.0085 w
.4281 .37868 m
.32708 .45792 L
s
P
p
.0085 w
.52086 .60841 m
.42776 .52539 L
s
P
p
.0085 w
.52086 .60841 m
.62248 .52941 L
s
P
p
.0085 w
.4281 .37868 m
.52974 .44575 L
s
P
p
.0085 w
.52974 .44575 m
.62248 .52941 L
s
P
p
.0085 w
.52974 .44575 m
.42776 .52539 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51723 .55004 m
.42396 .61256 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51723 .55004 m
.60541 .47354 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51723 .55004 m
.42429 .47598 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60587 .61037 m
.51723 .55004 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42429 .47598 m
.33009 .53815 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42429 .47598 m
.51228 .39892 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42429 .47598 m
.3793 .3894 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60541 .47354 m
.69528 .53345 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51228 .39892 m
.60541 .47354 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.63857 .38565 m
.60541 .47354 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33009 .53815 m
.42396 .61256 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.37821 .66628 m
.42396 .61256 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51239 .67391 m
.42396 .61256 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.46812 .311 m
.51228 .39892 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54434 .30984 m
.51228 .39892 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60587 .61037 m
.63982 .66328 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60587 .61037 m
.69528 .53345 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51239 .67391 m
.60587 .61037 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.28266 .59079 m
.33009 .53815 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.28364 .45168 m
.33009 .53815 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.69528 .53345 m
.73095 .58528 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.72991 .44552 m
.69528 .53345 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3793 .3894 m
.46812 .311 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3793 .3894 m
.40989 .29955 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.28364 .45168 m
.3793 .3894 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51239 .67391 m
.46768 .72916 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51239 .67391 m
.54495 .72832 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.63857 .38565 m
.72991 .44552 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.63857 .38565 m
.54434 .30984 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.63857 .38565 m
.59549 .29669 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.46812 .311 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.54434 .30984 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.28364 .45168 m
.23485 .50351 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.28364 .45168 m
.31321 .36197 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.37821 .66628 m
.46768 .72916 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.37821 .66628 m
.28266 .59079 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40865 .72096 m
.37821 .66628 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.63982 .66328 m
.73095 .58528 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5968 .71891 m
.63982 .66328 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54495 .72832 m
.63982 .66328 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.23485 .50351 m
.28266 .59079 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3115 .64429 m
.28266 .59079 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68754 .35645 m
.72991 .44552 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.76666 .49647 m
.72991 .44552 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40989 .29955 m
.31321 .36197 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.40989 .29955 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.59549 .29669 m
.68754 .35645 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.59549 .29669 L
s
P
p
.0085 w
.68927 .63986 m
.73095 .58528 L
s
P
p
.0085 w
.76666 .49647 m
.73095 .58528 L
s
P
p
.0085 w
.5 .2197 m
.59141 .2789 L
s
P
p
.0085 w
.5 .2197 m
.53287 .26693 L
s
P
p
.0085 w
.5 .2197 m
.45436 .26816 L
s
P
p
.0085 w
.5 .2197 m
.40352 .28183 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.46768 .72916 m
.5 .78548 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54495 .72832 m
.5 .78548 L
s
P
p
.0085 w
.31321 .36197 m
.26429 .41297 L
s
P
p
.0085 w
.40352 .28183 m
.31321 .36197 L
s
P
p
.0085 w
.23485 .50351 m
.26429 .41297 L
s
P
p
.0085 w
.26319 .55611 m
.23485 .50351 L
s
P
p
.0085 w
.68754 .35645 m
.72399 .40643 L
s
P
p
.0085 w
.59141 .2789 m
.68754 .35645 L
s
P
p
.0085 w
.35589 .33171 m
.40352 .28183 L
s
P
p
.0085 w
.40865 .72096 m
.5 .78548 L
s
P
p
.0085 w
.3115 .64429 m
.40865 .72096 L
s
P
p
.0085 w
.59141 .2789 m
.62624 .32764 L
s
P
p
.0085 w
.5968 .71891 m
.68927 .63986 L
s
P
p
.0085 w
.5 .78548 m
.5968 .71891 L
s
P
p
.0085 w
.3115 .64429 m
.26319 .55611 L
s
P
p
.0085 w
.3115 .64429 m
.40218 .70826 L
s
P
p
.0085 w
.76666 .49647 m
.72399 .40643 L
s
P
p
.0085 w
.76666 .49647 m
.72503 .55026 L
s
P
p
.0085 w
.59268 .70616 m
.68927 .63986 L
s
P
p
.0085 w
.72503 .55026 m
.68927 .63986 L
s
P
p
.0085 w
.45436 .26816 m
.48697 .31707 L
s
P
p
.0085 w
.35589 .33171 m
.45436 .26816 L
s
P
p
.0085 w
.53287 .26693 m
.62624 .32764 L
s
P
p
.0085 w
.48697 .31707 m
.53287 .26693 L
s
P
p
.0085 w
.53333 .69758 m
.5 .78548 L
s
P
p
.0085 w
.45372 .69847 m
.5 .78548 L
s
P
p
.0085 w
.40218 .70826 m
.5 .78548 L
s
P
p
.0085 w
.59268 .70616 m
.5 .78548 L
s
P
p
.0085 w
.26429 .41297 m
.29354 .46463 L
s
P
p
.0085 w
.35589 .33171 m
.26429 .41297 L
s
P
p
.0085 w
.40218 .70826 m
.35454 .62003 L
s
P
p
.0085 w
.59268 .70616 m
.62743 .61676 L
s
P
p
.0085 w
.26319 .55611 m
.29354 .46463 L
s
P
p
.0085 w
.35454 .62003 m
.26319 .55611 L
s
P
p
.0085 w
.62624 .32764 m
.72399 .40643 L
s
P
p
.0085 w
.68109 .45934 m
.72399 .40643 L
s
P
p
.0085 w
.38696 .38216 m
.35589 .33171 L
s
P
p
.0085 w
.58151 .37934 m
.62624 .32764 L
s
P
p
.0085 w
.72503 .55026 m
.62743 .61676 L
s
P
p
.0085 w
.72503 .55026 m
.68109 .45934 L
s
P
p
.0085 w
.45372 .69847 m
.35454 .62003 L
s
P
p
.0085 w
.48685 .60829 m
.45372 .69847 L
s
P
p
.0085 w
.53333 .69758 m
.62743 .61676 L
s
P
p
.0085 w
.48685 .60829 m
.53333 .69758 L
s
P
p
.0085 w
.38642 .52851 m
.35454 .62003 L
s
P
p
.0085 w
.38696 .38216 m
.48697 .31707 L
s
P
p
.0085 w
.58151 .37934 m
.48697 .31707 L
s
P
p
.0085 w
.5819 .52598 m
.62743 .61676 L
s
P
p
.0085 w
.38642 .52851 m
.29354 .46463 L
s
P
p
.0085 w
.38696 .38216 m
.29354 .46463 L
s
P
p
.0085 w
.68109 .45934 m
.5819 .52598 L
s
P
p
.0085 w
.68109 .45934 m
.58151 .37934 L
s
P
p
.0085 w
.38696 .38216 m
.48125 .44555 L
s
P
p
.0085 w
.48685 .60829 m
.38642 .52851 L
s
P
p
.0085 w
.48685 .60829 m
.5819 .52598 L
s
P
p
.0085 w
.58151 .37934 m
.48125 .44555 L
s
P
p
.0085 w
.48125 .44555 m
.38642 .52851 L
s
P
p
.0085 w
.48125 .44555 m
.5819 .52598 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56134 .54874 m
.46432 .6143 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56134 .54874 m
.64122 .46921 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56134 .54874 m
.46448 .47793 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64185 .60649 m
.56134 .54874 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.46448 .47793 m
.36701 .54317 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.46448 .47793 m
.54369 .39788 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.46448 .47793 m
.40541 .39342 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36701 .54317 m
.46432 .6143 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40456 .6695 m
.46432 .6143 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54408 .67308 m
.46432 .6143 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.30578 .59731 m
.36701 .54317 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.30665 .45896 m
.36701 .54317 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64122 .46921 m
.72323 .52645 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54369 .39788 m
.64122 .46921 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65813 .38008 m
.64122 .46921 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48503 .31193 m
.54369 .39788 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55929 .30779 m
.54369 .39788 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40541 .39342 m
.48503 .31193 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40541 .39342 m
.4192 .30296 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.30665 .45896 m
.40541 .39342 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64185 .60649 m
.65956 .65881 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64185 .60649 m
.72323 .52645 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54408 .67308 m
.64185 .60649 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.30665 .45896 m
.24385 .5124 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.30665 .45896 m
.31917 .36896 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54408 .67308 m
.48482 .72982 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54408 .67308 m
.5601 .72685 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.48503 .31193 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.72323 .52645 m
.74256 .57769 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.74146 .43705 m
.72323 .52645 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40456 .6695 m
.48482 .72982 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40456 .6695 m
.30578 .59731 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4181 .7234 m
.40456 .6695 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.24385 .5124 m
.30578 .59731 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31751 .6499 m
.30578 .59731 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65813 .38008 m
.74146 .43705 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65813 .38008 m
.55929 .30779 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65813 .38008 m
.5999 .29278 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.55929 .30779 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4192 .30296 m
.31917 .36896 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.4192 .30296 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31917 .36896 m
.2557 .42175 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.39961 .2858 m
.31917 .36896 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65956 .65881 m
.74256 .57769 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60128 .71611 m
.65956 .65881 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5601 .72685 m
.65956 .65881 L
s
P
p
.0085 w
.24385 .5124 m
.2557 .42175 L
s
P
p
.0085 w
.25457 .56399 m
.24385 .5124 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5999 .29278 m
.68343 .34932 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.5999 .29278 L
s
P
p
.0085 w
.5 .2197 m
.58235 .27538 L
s
P
p
.0085 w
.5 .2197 m
.51546 .26594 L
s
P
p
.0085 w
.5 .2197 m
.43916 .27033 L
s
P
p
.0085 w
.5 .2197 m
.39961 .2858 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48482 .72982 m
.5 .78548 L
s
P
p
.0085 w
.68343 .34932 m
.74146 .43705 L
s
P
p
.0085 w
.76139 .48735 m
.74146 .43705 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5601 .72685 m
.5 .78548 L
s
P
p
.0085 w
.33692 .33769 m
.39961 .2858 L
s
P
p
.0085 w
.68513 .63415 m
.74256 .57769 L
s
P
p
.0085 w
.76139 .48735 m
.74256 .57769 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4181 .7234 m
.5 .78548 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31751 .6499 m
.4181 .7234 L
s
P
p
.0085 w
.31751 .6499 m
.25457 .56399 L
s
P
p
.0085 w
.31751 .6499 m
.39822 .71111 L
s
P
p
.0085 w
.68343 .34932 m
.7025 .39854 L
s
P
p
.0085 w
.58235 .27538 m
.68343 .34932 L
s
P
p
.0085 w
.58235 .27538 m
.59954 .32322 L
s
P
p
.0085 w
.2557 .42175 m
.26679 .47237 L
s
P
p
.0085 w
.33692 .33769 m
.2557 .42175 L
s
P
p
.0085 w
.60128 .71611 m
.68513 .63415 L
s
P
p
.0085 w
.5 .78548 m
.60128 .71611 L
s
P
p
.0085 w
.43916 .27033 m
.45371 .31824 L
s
P
p
.0085 w
.33692 .33769 m
.43916 .27033 L
s
P
p
.0085 w
.25457 .56399 m
.26679 .47237 L
s
P
p
.0085 w
.3354 .62482 m
.25457 .56399 L
s
P
p
.0085 w
.51546 .26594 m
.59954 .32322 L
s
P
p
.0085 w
.45371 .31824 m
.51546 .26594 L
s
P
p
.0085 w
.51567 .69688 m
.5 .78548 L
s
P
p
.0085 w
.4383 .70002 m
.5 .78548 L
s
P
p
.0085 w
.39822 .71111 m
.5 .78548 L
s
P
p
.0085 w
.5835 .70364 m
.5 .78548 L
s
P
p
.0085 w
.39822 .71111 m
.3354 .62482 L
s
P
p
.0085 w
.76139 .48735 m
.7025 .39854 L
s
P
p
.0085 w
.76139 .48735 m
.70345 .54319 L
s
P
p
.0085 w
.34963 .3871 m
.33692 .33769 L
s
P
p
.0085 w
.5835 .70364 m
.68513 .63415 L
s
P
p
.0085 w
.70345 .54319 m
.68513 .63415 L
s
P
p
.0085 w
.5835 .70364 m
.60047 .61321 L
s
P
p
.0085 w
.4383 .70002 m
.3354 .62482 L
s
P
p
.0085 w
.45327 .60922 m
.4383 .70002 L
s
P
p
.0085 w
.34891 .53294 m
.3354 .62482 L
s
P
p
.0085 w
.59954 .32322 m
.7025 .39854 L
s
P
p
.0085 w
.64298 .45358 m
.7025 .39854 L
s
P
p
.0085 w
.53837 .37708 m
.59954 .32322 L
s
P
p
.0085 w
.34891 .53294 m
.26679 .47237 L
s
P
p
.0085 w
.34963 .3871 m
.26679 .47237 L
s
P
p
.0085 w
.51567 .69688 m
.60047 .61321 L
s
P
p
.0085 w
.45327 .60922 m
.51567 .69688 L
s
P
p
.0085 w
.34963 .3871 m
.45371 .31824 L
s
P
p
.0085 w
.53837 .37708 m
.45371 .31824 L
s
P
p
.0085 w
.70345 .54319 m
.60047 .61321 L
s
P
p
.0085 w
.70345 .54319 m
.64298 .45358 L
s
P
p
.0085 w
.34963 .3871 m
.43341 .44708 L
s
P
p
.0085 w
.53855 .52396 m
.60047 .61321 L
s
P
p
.0085 w
.45327 .60922 m
.34891 .53294 L
s
P
p
.0085 w
.45327 .60922 m
.53855 .52396 L
s
P
p
.0085 w
.43341 .44708 m
.34891 .53294 L
s
P
p
.0085 w
.64298 .45358 m
.53855 .52396 L
s
P
p
.0085 w
.64298 .45358 m
.53837 .37708 L
s
P
p
.0085 w
.53837 .37708 m
.43341 .44708 L
s
P
p
.0085 w
.43341 .44708 m
.53855 .52396 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.50563 .47845 m
.40755 .5469 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.50563 .47845 m
.57388 .3957 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.50563 .47845 m
.43419 .3964 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6038 .54602 m
.50563 .47845 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40755 .5469 m
.50565 .61477 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33439 .60299 m
.40755 .5469 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33513 .46529 m
.40755 .5469 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6038 .54602 m
.50565 .61477 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6038 .54602 m
.67313 .46367 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67391 .60153 m
.6038 .54602 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4336 .67189 m
.50565 .61477 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.57454 .67133 m
.50565 .61477 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.43419 .3964 m
.50237 .31218 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.43419 .3964 m
.4309 .30593 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33513 .46529 m
.43419 .3964 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.57388 .3957 m
.67313 .46367 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.50237 .31218 m
.57388 .3957 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5725 .30517 m
.57388 .3957 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33513 .46529 m
.26038 .52079 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33513 .46529 m
.33049 .3756 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67313 .46367 m
.74484 .51856 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67311 .37383 m
.67313 .46367 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4336 .67189 m
.33439 .60299 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.26038 .52079 m
.33439 .60299 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32895 .65522 m
.33439 .60299 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67391 .60153 m
.67469 .6538 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67391 .60153 m
.74484 .51856 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.57454 .67133 m
.67391 .60153 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4336 .67189 m
.5024 .73 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42996 .72553 m
.4336 .67189 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.50237 .31218 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.57454 .67133 m
.5024 .73 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.57454 .67133 m
.5735 .72498 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4309 .30593 m
.33049 .3756 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.4309 .30593 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.5725 .30517 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67311 .37383 m
.5725 .30517 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.26038 .52079 m
.25464 .43066 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.25351 .57196 m
.26038 .52079 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.33049 .3756 m
.25464 .43066 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.39878 .28985 m
.33049 .3756 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67311 .37383 m
.74582 .42823 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67311 .37383 m
.6013 .28875 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.74484 .51856 m
.74695 .56979 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.74582 .42823 m
.74484 .51856 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5024 .73 m
.5 .78548 L
s
P
p
.0085 w
.5 .2197 m
.57072 .27227 L
s
P
p
.0085 w
.5 .2197 m
.49755 .26567 L
s
P
p
.0085 w
.5 .2197 m
.42587 .27307 L
s
P
p
.0085 w
.5 .2197 m
.39878 .28985 L
s
P
p
.0085 w
.5 .2197 m
.6013 .28875 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32895 .65522 m
.42996 .72553 L
s
P
p
.0085 w
.32895 .65522 m
.25351 .57196 L
s
P
p
.0085 w
.32895 .65522 m
.39738 .71401 L
s
P
p
.0085 w
.32313 .34428 m
.39878 .28985 L
s
P
p
.0085 w
.6013 .28875 m
.67364 .34243 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5735 .72498 m
.67469 .6538 L
s
P
p
.0085 w
.67469 .6538 m
.74695 .56979 L
s
P
p
.0085 w
.6027 .71322 m
.67469 .6538 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42996 .72553 m
.5 .78548 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5735 .72498 m
.5 .78548 L
s
P
p
.0085 w
.25464 .43066 m
.24757 .48086 L
s
P
p
.0085 w
.32313 .34428 m
.25464 .43066 L
s
P
p
.0085 w
.67364 .34243 m
.74582 .42823 L
s
P
p
.0085 w
.74797 .47849 m
.74582 .42823 L
s
P
p
.0085 w
.25351 .57196 m
.24757 .48086 L
s
P
p
.0085 w
.32149 .6301 m
.25351 .57196 L
s
P
p
.0085 w
.67526 .62863 m
.74695 .56979 L
s
P
p
.0085 w
.74797 .47849 m
.74695 .56979 L
s
P
p
.0085 w
.42587 .27307 m
.42198 .32069 L
s
P
p
.0085 w
.32313 .34428 m
.42587 .27307 L
s
P
p
.0085 w
.57072 .27227 m
.56958 .3199 L
s
P
p
.0085 w
.57072 .27227 m
.67364 .34243 L
s
P
p
.0085 w
.31729 .39333 m
.32313 .34428 L
s
P
p
.0085 w
.39738 .71401 m
.5 .78548 L
s
P
p
.0085 w
.39738 .71401 m
.32149 .6301 L
s
P
p
.0085 w
.6027 .71322 m
.67526 .62863 L
s
P
p
.0085 w
.5 .78548 m
.6027 .71322 L
s
P
p
.0085 w
.67364 .34243 m
.67445 .39152 L
s
P
p
.0085 w
.49752 .69669 m
.5 .78548 L
s
P
p
.0085 w
.42483 .70199 m
.5 .78548 L
s
P
p
.0085 w
.57171 .70141 m
.5 .78548 L
s
P
p
.0085 w
.49755 .26567 m
.56958 .3199 L
s
P
p
.0085 w
.42198 .32069 m
.49755 .26567 L
s
P
p
.0085 w
.31643 .53852 m
.24757 .48086 L
s
P
p
.0085 w
.31729 .39333 m
.24757 .48086 L
s
P
p
.0085 w
.31643 .53852 m
.32149 .6301 L
s
P
p
.0085 w
.42483 .70199 m
.32149 .6301 L
s
P
p
.0085 w
.57171 .70141 m
.67526 .62863 L
s
P
p
.0085 w
.67527 .5369 m
.67526 .62863 L
s
P
p
.0085 w
.74797 .47849 m
.67445 .39152 L
s
P
p
.0085 w
.74797 .47849 m
.67527 .5369 L
s
P
p
.0085 w
.42125 .61118 m
.42483 .70199 L
s
P
p
.0085 w
.57171 .70141 m
.57023 .61055 L
s
P
p
.0085 w
.31729 .39333 m
.42198 .32069 L
s
P
p
.0085 w
.49392 .37647 m
.42198 .32069 L
s
P
p
.0085 w
.49752 .69669 m
.57023 .61055 L
s
P
p
.0085 w
.42125 .61118 m
.49752 .69669 L
s
P
p
.0085 w
.56958 .3199 m
.67445 .39152 L
s
P
p
.0085 w
.49392 .37647 m
.56958 .3199 L
s
P
p
.0085 w
.31729 .39333 m
.38784 .45028 L
s
P
p
.0085 w
.60005 .44925 m
.67445 .39152 L
s
P
p
.0085 w
.42125 .61118 m
.31643 .53852 L
s
P
p
.0085 w
.38784 .45028 m
.31643 .53852 L
s
P
p
.0085 w
.67527 .5369 m
.57023 .61055 L
s
P
p
.0085 w
.67527 .5369 m
.60005 .44925 L
s
P
p
.0085 w
.42125 .61118 m
.49389 .52341 L
s
P
p
.0085 w
.49389 .52341 m
.57023 .61055 L
s
P
p
.0085 w
.49392 .37647 m
.38784 .45028 L
s
P
p
.0085 w
.60005 .44925 m
.49392 .37647 L
s
P
p
.0085 w
.38784 .45028 m
.49389 .52341 L
s
P
p
.0085 w
.60005 .44925 m
.49389 .52341 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.45058 .54924 m
.54683 .61395 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36762 .60766 m
.45058 .54924 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3682 .47051 m
.45058 .54924 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54662 .47754 m
.45058 .54924 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54662 .47754 m
.60201 .39242 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.54662 .47754 m
.4648 .39828 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64346 .54193 m
.54662 .47754 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.46448 .6734 m
.54683 .61395 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64346 .54193 m
.54683 .61395 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60292 .6687 m
.54683 .61395 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64346 .54193 m
.7002 .45706 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.7011 .59561 m
.64346 .54193 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3682 .47051 m
.2838 .52845 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3682 .47051 m
.34677 .38168 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3682 .47051 m
.4648 .39828 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4648 .39828 m
.51965 .31174 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4648 .39828 m
.44463 .3084 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.46448 .6734 m
.36762 .60766 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.2838 .52845 m
.36762 .60766 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34539 .66009 m
.36762 .60766 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60201 .39242 m
.7002 .45706 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51965 .31174 m
.60201 .39242 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58359 .30207 m
.60201 .39242 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.46448 .6734 m
.51992 .72969 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44388 .7273 m
.46448 .6734 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.7002 .45706 m
.75937 .51001 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68301 .36708 m
.7002 .45706 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.2838 .52845 m
.26099 .4394 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.25991 .5798 m
.2838 .52845 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.51965 .31174 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34677 .38168 m
.26099 .4394 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44463 .3084 m
.34677 .38168 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40101 .29387 m
.34677 .38168 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.44463 .3084 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60292 .6687 m
.51992 .72969 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60292 .6687 m
.58473 .72276 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60292 .6687 m
.7011 .59561 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.7011 .59561 m
.68468 .64839 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.7011 .59561 m
.75937 .51001 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.58359 .30207 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68301 .36708 m
.58359 .30207 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34539 .66009 m
.25991 .5798 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34539 .66009 m
.39964 .71689 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34539 .66009 m
.44388 .7273 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68301 .36708 m
.74271 .41933 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68301 .36708 m
.59962 .2847 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31488 .35125 m
.40101 .29387 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.40101 .29387 L
s
P
p
.0085 w
.26099 .4394 m
.23636 .48982 L
s
P
p
.0085 w
.31488 .35125 m
.26099 .4394 L
s
P
p
.0085 w
.5 .2197 m
.55687 .26968 L
s
P
p
.0085 w
.5 .2197 m
.47972 .26614 L
s
P
p
.0085 w
.5 .2197 m
.41491 .2763 L
s
P
p
.0085 w
.5 .2197 m
.59962 .2847 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.51992 .72969 m
.5 .78548 L
s
P
p
.0085 w
.75937 .51001 m
.74383 .56182 L
s
P
p
.0085 w
.74271 .41933 m
.75937 .51001 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44388 .7273 m
.5 .78548 L
s
P
p
.0085 w
.25991 .5798 m
.23636 .48982 L
s
P
p
.0085 w
.31316 .6357 m
.25991 .5798 L
s
P
p
.0085 w
.59962 .2847 m
.6584 .33599 L
s
P
p
.0085 w
.58473 .72276 m
.68468 .64839 L
s
P
p
.0085 w
.58473 .72276 m
.5 .78548 L
s
P
p
.0085 w
.68468 .64839 m
.74383 .56182 L
s
P
p
.0085 w
.601 .71032 m
.68468 .64839 L
s
P
p
.0085 w
.31488 .35125 m
.41491 .2763 L
s
P
p
.0085 w
.29096 .40061 m
.31488 .35125 L
s
P
p
.0085 w
.41491 .2763 m
.39282 .32432 L
s
P
p
.0085 w
.39964 .71689 m
.5 .78548 L
s
P
p
.0085 w
.39964 .71689 m
.31316 .6357 L
s
P
p
.0085 w
.6584 .33599 m
.74271 .41933 L
s
P
p
.0085 w
.72664 .47017 m
.74271 .41933 L
s
P
p
.0085 w
.55687 .26968 m
.53732 .31779 L
s
P
p
.0085 w
.55687 .26968 m
.6584 .33599 L
s
P
p
.0085 w
.28998 .54505 m
.23636 .48982 L
s
P
p
.0085 w
.29096 .40061 m
.23636 .48982 L
s
P
p
.0085 w
.47972 .26614 m
.53732 .31779 L
s
P
p
.0085 w
.39282 .32432 m
.47972 .26614 L
s
P
p
.0085 w
.5 .78548 m
.601 .71032 L
s
P
p
.0085 w
.47944 .69702 m
.5 .78548 L
s
P
p
.0085 w
.41372 .7043 m
.5 .78548 L
s
P
p
.0085 w
.55767 .69955 m
.5 .78548 L
s
P
p
.0085 w
.65988 .62346 m
.74383 .56182 L
s
P
p
.0085 w
.72664 .47017 m
.74383 .56182 L
s
P
p
.0085 w
.601 .71032 m
.65988 .62346 L
s
P
p
.0085 w
.28998 .54505 m
.31316 .6357 L
s
P
p
.0085 w
.41372 .7043 m
.31316 .6357 L
s
P
p
.0085 w
.6584 .33599 m
.64064 .38562 L
s
P
p
.0085 w
.39181 .6141 m
.41372 .7043 L
s
P
p
.0085 w
.29096 .40061 m
.34609 .45502 L
s
P
p
.0085 w
.29096 .40061 m
.39282 .32432 L
s
P
p
.0085 w
.44967 .37753 m
.39282 .32432 L
s
P
p
.0085 w
.55767 .69955 m
.65988 .62346 L
s
P
p
.0085 w
.55767 .69955 m
.53768 .60886 L
s
P
p
.0085 w
.64131 .53161 m
.65988 .62346 L
s
P
p
.0085 w
.47944 .69702 m
.53768 .60886 L
s
P
p
.0085 w
.39181 .6141 m
.47944 .69702 L
s
P
p
.0085 w
.72664 .47017 m
.64064 .38562 L
s
P
p
.0085 w
.72664 .47017 m
.64131 .53161 L
s
P
p
.0085 w
.39181 .6141 m
.28998 .54505 L
s
P
p
.0085 w
.34609 .45502 m
.28998 .54505 L
s
P
p
.0085 w
.53732 .31779 m
.64064 .38562 L
s
P
p
.0085 w
.44967 .37753 m
.53732 .31779 L
s
P
p
.0085 w
.39181 .6141 m
.44943 .52436 L
s
P
p
.0085 w
.5537 .4465 m
.64064 .38562 L
s
P
p
.0085 w
.44943 .52436 m
.53768 .60886 L
s
P
p
.0085 w
.64131 .53161 m
.53768 .60886 L
s
P
p
.0085 w
.64131 .53161 m
.5537 .4465 L
s
P
p
.0085 w
.34609 .45502 m
.44943 .52436 L
s
P
p
.0085 w
.44967 .37753 m
.34609 .45502 L
s
P
p
.0085 w
.5537 .4465 m
.44967 .37753 L
s
P
p
.0085 w
.5537 .4465 m
.44943 .52436 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49493 .55014 m
.58674 .61187 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40448 .61122 m
.49493 .55014 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40491 .47449 m
.49493 .55014 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58635 .47521 m
.49493 .55014 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58635 .47521 m
.62726 .38814 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58635 .47521 m
.49639 .399 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67921 .53657 m
.58635 .47521 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40491 .47449 m
.31332 .53519 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40491 .47449 m
.36748 .38704 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40491 .47449 m
.49639 .399 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49639 .399 m
.53635 .31064 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49639 .399 m
.45998 .31029 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49636 .67398 m
.58674 .61187 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67921 .53657 m
.58674 .61187 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6284 .66527 m
.58674 .61187 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49636 .67398 m
.40448 .61122 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31332 .53519 m
.40448 .61122 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36629 .66439 m
.40448 .61122 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67921 .53657 m
.72159 .44955 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.72259 .58889 m
.67921 .53657 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31332 .53519 m
.27443 .44774 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.27341 .58726 m
.31332 .53519 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.62726 .38814 m
.72159 .44955 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.53635 .31064 m
.62726 .38814 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5922 .29856 m
.62726 .38814 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49636 .67398 m
.53685 .7289 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.45943 .72865 m
.49636 .67398 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36748 .38704 m
.27443 .44774 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.45998 .31029 m
.36748 .38704 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.40622 .29772 m
.36748 .38704 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.53635 .31064 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.45998 .31029 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.72159 .44955 m
.76623 .50104 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68744 .36003 m
.72159 .44955 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6284 .66527 m
.53685 .7289 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6284 .66527 m
.59347 .72025 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6284 .66527 m
.72259 .58889 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.27443 .44774 m
.23332 .49896 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31234 .3584 m
.27443 .44774 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36629 .66439 m
.27341 .58726 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36629 .66439 m
.40493 .71965 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.36629 .66439 m
.45943 .72865 L
s
P
p
.0085 w
.72259 .58889 m
.68917 .64273 L
s
P
p
.0085 w
.72259 .58889 m
.76623 .50104 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.5922 .29856 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.68744 .36003 m
.5922 .29856 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31234 .3584 m
.40622 .29772 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.40622 .29772 L
s
P
p
.0085 w
.27341 .58726 m
.23332 .49896 L
s
P
p
.0085 w
.31061 .64143 m
.27341 .58726 L
s
P
p
.0085 w
.5 .2197 m
.54122 .26768 L
s
P
p
.0085 w
.5 .2197 m
.46254 .26732 L
s
P
p
.0085 w
.5 .2197 m
.4066 .27992 L
s
P
p
.0085 w
.5 .2197 m
.59489 .28078 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.53685 .7289 m
.5 .78548 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.45943 .72865 m
.5 .78548 L
s
P
p
.0085 w
.68744 .36003 m
.73207 .41063 L
s
P
p
.0085 w
.68744 .36003 m
.59489 .28078 L
s
P
p
.0085 w
.31234 .3584 m
.4066 .27992 L
s
P
p
.0085 w
.27138 .4087 m
.31234 .3584 L
s
P
p
.0085 w
.59489 .28078 m
.6381 .33022 L
s
P
p
.0085 w
.76623 .50104 m
.73315 .55402 L
s
P
p
.0085 w
.73207 .41063 m
.76623 .50104 L
s
P
p
.0085 w
.4066 .27992 m
.36716 .32902 L
s
P
p
.0085 w
.59347 .72025 m
.68917 .64273 L
s
P
p
.0085 w
.59347 .72025 m
.5 .78548 L
s
P
p
.0085 w
.27031 .55229 m
.23332 .49896 L
s
P
p
.0085 w
.27138 .4087 m
.23332 .49896 L
s
P
p
.0085 w
.40493 .71965 m
.5 .78548 L
s
P
p
.0085 w
.40493 .71965 m
.31061 .64143 L
s
P
p
.0085 w
.68917 .64273 m
.73315 .55402 L
s
P
p
.0085 w
.59621 .70751 m
.68917 .64273 L
s
P
p
.0085 w
.27031 .55229 m
.31061 .64143 L
s
P
p
.0085 w
.4053 .70689 m
.31061 .64143 L
s
P
p
.0085 w
.54122 .26768 m
.50383 .31698 L
s
P
p
.0085 w
.54122 .26768 m
.6381 .33022 L
s
P
p
.0085 w
.46254 .26732 m
.50383 .31698 L
s
P
p
.0085 w
.36716 .32902 m
.46254 .26732 L
s
P
p
.0085 w
.5 .78548 m
.59621 .70751 L
s
P
p
.0085 w
.46201 .69786 m
.5 .78548 L
s
P
p
.0085 w
.4053 .70689 m
.5 .78548 L
s
P
p
.0085 w
.5418 .69812 m
.5 .78548 L
s
P
p
.0085 w
.6381 .33022 m
.73207 .41063 L
s
P
p
.0085 w
.69795 .46269 m
.73207 .41063 L
s
P
p
.0085 w
.59621 .70751 m
.6394 .61883 L
s
P
p
.0085 w
.36591 .61787 m
.4053 .70689 L
s
P
p
.0085 w
.27138 .4087 m
.30952 .46113 L
s
P
p
.0085 w
.27138 .4087 m
.36716 .32902 L
s
P
p
.0085 w
.6381 .33022 m
.60214 .38106 L
s
P
p
.0085 w
.6394 .61883 m
.73315 .55402 L
s
P
p
.0085 w
.69795 .46269 m
.73315 .55402 L
s
P
p
.0085 w
.40714 .38023 m
.36716 .32902 L
s
P
p
.0085 w
.36591 .61787 m
.27031 .55229 L
s
P
p
.0085 w
.30952 .46113 m
.27031 .55229 L
s
P
p
.0085 w
.5418 .69812 m
.6394 .61883 L
s
P
p
.0085 w
.5418 .69812 m
.50387 .60821 L
s
P
p
.0085 w
.46201 .69786 m
.50387 .60821 L
s
P
p
.0085 w
.36591 .61787 m
.46201 .69786 L
s
P
p
.0085 w
.60263 .52753 m
.6394 .61883 L
s
P
p
.0085 w
.50383 .31698 m
.60214 .38106 L
s
P
p
.0085 w
.40714 .38023 m
.50383 .31698 L
s
P
p
.0085 w
.36591 .61787 m
.4067 .52678 L
s
P
p
.0085 w
.69795 .46269 m
.60214 .38106 L
s
P
p
.0085 w
.69795 .46269 m
.60263 .52753 L
s
P
p
.0085 w
.30952 .46113 m
.4067 .52678 L
s
P
p
.0085 w
.40714 .38023 m
.30952 .46113 L
s
P
p
.0085 w
.50552 .44544 m
.60214 .38106 L
s
P
p
.0085 w
.50552 .44544 m
.40714 .38023 L
s
P
p
.0085 w
.4067 .52678 m
.50387 .60821 L
s
P
p
.0085 w
.60263 .52753 m
.50387 .60821 L
s
P
p
.0085 w
.60263 .52753 m
.50552 .44544 L
s
P
p
.0085 w
.50552 .44544 m
.4067 .52678 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.53942 .54957 m
.62429 .60857 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.44395 .61359 m
.53942 .54957 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4442 .47713 m
.53942 .54957 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.62374 .47153 m
.53942 .54957 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4442 .47713 m
.34803 .54082 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4442 .47713 m
.39197 .39153 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4442 .47713 m
.52808 .39855 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52833 .67361 m
.44395 .61359 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34803 .54082 m
.44395 .61359 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.391 .66799 m
.44395 .61359 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.62374 .47153 m
.64889 .38296 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.62374 .47153 m
.52808 .39855 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.71 .53007 m
.62374 .47153 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.34803 .54082 m
.29441 .45543 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.29349 .59415 m
.34803 .54082 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52808 .39855 m
.55201 .30889 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52808 .39855 m
.47649 .31155 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52833 .67361 m
.62429 .60857 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.71 .53007 m
.62429 .60857 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65023 .66112 m
.62429 .60857 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.39197 .39153 m
.29441 .45543 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.47649 .31155 m
.39197 .39153 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.41423 .3013 m
.39197 .39153 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.52833 .67361 m
.55271 .72764 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.47617 .72955 m
.52833 .67361 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.71 .53007 m
.73656 .44134 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.73763 .58154 m
.71 .53007 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.29441 .45543 m
.23838 .508 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3155 .3655 m
.29441 .45543 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.47649 .31155 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.64889 .38296 m
.73656 .44134 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55201 .30889 m
.64889 .38296 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.59807 .29476 m
.64889 .38296 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.55201 .30889 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.391 .66799 m
.29349 .59415 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.391 .66799 m
.41305 .72221 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.391 .66799 m
.47617 .72955 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.29349 .59415 m
.23838 .508 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31381 .64712 m
.29349 .59415 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3155 .3655 m
.41423 .3013 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.41423 .3013 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65023 .66112 m
.55271 .72764 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65023 .66112 m
.59942 .71753 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65023 .66112 m
.73763 .58154 L
s
P
p
.0085 w
.73656 .44134 m
.76505 .49189 L
s
P
p
.0085 w
.6862 .35287 m
.73656 .44134 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.59807 .29476 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.6862 .35287 m
.59807 .29476 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3155 .3655 m
.40119 .2838 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.25905 .41733 m
.3155 .3655 L
s
P
p
.0085 w
.5 .2197 m
.52426 .26634 L
s
P
p
.0085 w
.5 .2197 m
.44655 .26917 L
s
P
p
.0085 w
.5 .2197 m
.40119 .2838 L
s
P
p
.0085 w
.5 .2197 m
.58722 .2771 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.47617 .72955 m
.5 .78548 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55271 .72764 m
.5 .78548 L
s
P
p
.0085 w
.73763 .58154 m
.68792 .637 L
s
P
p
.0085 w
.73763 .58154 m
.76505 .49189 L
s
P
p
.0085 w
.25794 .56002 m
.23838 .508 L
s
P
p
.0085 w
.25905 .41733 m
.23838 .508 L
s
P
p
.0085 w
.40119 .2838 m
.34579 .33461 L
s
P
p
.0085 w
.41305 .72221 m
.5 .78548 L
s
P
p
.0085 w
.41305 .72221 m
.31381 .64712 L
s
P
p
.0085 w
.25794 .56002 m
.31381 .64712 L
s
P
p
.0085 w
.39982 .70967 m
.31381 .64712 L
s
P
p
.0085 w
.6862 .35287 m
.71411 .40239 L
s
P
p
.0085 w
.6862 .35287 m
.58722 .2771 L
s
P
p
.0085 w
.58722 .2771 m
.61335 .3253 L
s
P
p
.0085 w
.59942 .71753 m
.68792 .637 L
s
P
p
.0085 w
.59942 .71753 m
.5 .78548 L
s
P
p
.0085 w
.76505 .49189 m
.71511 .54664 L
s
P
p
.0085 w
.71411 .40239 m
.76505 .49189 L
s
P
p
.0085 w
.25905 .41733 m
.27926 .46839 L
s
P
p
.0085 w
.25905 .41733 m
.34579 .33461 L
s
P
p
.0085 w
.44655 .26917 m
.47022 .31749 L
s
P
p
.0085 w
.34579 .33461 m
.44655 .26917 L
s
P
p
.0085 w
.52426 .26634 m
.47022 .31749 L
s
P
p
.0085 w
.52426 .26634 m
.61335 .3253 L
s
P
p
.0085 w
.5 .78548 m
.58844 .70487 L
s
P
p
.0085 w
.4458 .69919 m
.5 .78548 L
s
P
p
.0085 w
.39982 .70967 m
.5 .78548 L
s
P
p
.0085 w
.5246 .69717 m
.5 .78548 L
s
P
p
.0085 w
.68792 .637 m
.71511 .54664 L
s
P
p
.0085 w
.58844 .70487 m
.68792 .637 L
s
P
p
.0085 w
.34435 .62236 m
.39982 .70967 L
s
P
p
.0085 w
.34435 .62236 m
.25794 .56002 L
s
P
p
.0085 w
.27926 .46839 m
.25794 .56002 L
s
P
p
.0085 w
.36774 .38446 m
.34579 .33461 L
s
P
p
.0085 w
.58844 .70487 m
.61442 .61489 L
s
P
p
.0085 w
.61335 .3253 m
.71411 .40239 L
s
P
p
.0085 w
.66272 .4563 m
.71411 .40239 L
s
P
p
.0085 w
.61335 .3253 m
.5602 .378 L
s
P
p
.0085 w
.4458 .69919 m
.46994 .60862 L
s
P
p
.0085 w
.34435 .62236 m
.4458 .69919 L
s
P
p
.0085 w
.34435 .62236 m
.36711 .53057 L
s
P
p
.0085 w
.5246 .69717 m
.61442 .61489 L
s
P
p
.0085 w
.5246 .69717 m
.46994 .60862 L
s
P
p
.0085 w
.61442 .61489 m
.71511 .54664 L
s
P
p
.0085 w
.66272 .4563 m
.71511 .54664 L
s
P
p
.0085 w
.27926 .46839 m
.36711 .53057 L
s
P
p
.0085 w
.36774 .38446 m
.27926 .46839 L
s
P
p
.0085 w
.47022 .31749 m
.5602 .378 L
s
P
p
.0085 w
.36774 .38446 m
.47022 .31749 L
s
P
p
.0085 w
.56048 .52479 m
.61442 .61489 L
s
P
p
.0085 w
.45714 .44611 m
.36774 .38446 L
s
P
p
.0085 w
.36711 .53057 m
.46994 .60862 L
s
P
p
.0085 w
.56048 .52479 m
.46994 .60862 L
s
P
p
.0085 w
.66272 .4563 m
.5602 .378 L
s
P
p
.0085 w
.66272 .4563 m
.56048 .52479 L
s
P
p
.0085 w
.45714 .44611 m
.36711 .53057 L
s
P
p
.0085 w
.45714 .44611 m
.5602 .378 L
s
P
p
.0085 w
.56048 .52479 m
.45714 .44611 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; endGroup; animationSpeed = 6]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics3D
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.02381 0.952381 0.02381 0.952381 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
P
p
[ .01 .012 ] 0 setdash
.0035 w
.485 .47837 m
.58285 .54756 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.485 .47837 m
.3869 .54521 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.485 .47837 m
.41952 .39505 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.485 .47837 m
.55899 .39693 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.58285 .54756 m
.65843 .60414 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.48494 .6147 m
.58285 .54756 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65772 .46658 m
.58285 .54756 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3869 .54521 m
.48494 .6147 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.3869 .54521 m
.32026 .46226 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31945 .60027 m
.3869 .54521 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55952 .67232 m
.48494 .6147 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4188 .67081 m
.48494 .6147 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55899 .39693 m
.56614 .30654 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55899 .39693 m
.49368 .31214 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65772 .46658 m
.55899 .39693 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.65772 .46658 m
.66623 .37703 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.73488 .5226 m
.65772 .46658 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.41952 .39505 m
.32026 .46226 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49368 .31214 m
.41952 .39505 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42478 .3045 m
.41952 .39505 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32026 .46226 m
.25121 .51667 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32418 .37234 m
.32026 .46226 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55952 .67232 m
.65843 .60414 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.73488 .5226 m
.65843 .60414 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.66774 .65637 m
.65843 .60414 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.55952 .67232 m
.56704 .72597 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49359 .72997 m
.55952 .67232 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.31945 .60027 m
.25121 .51667 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32258 .6526 m
.31945 .60027 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4188 .67081 m
.31945 .60027 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.49368 .31214 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4188 .67081 m
.42375 .72451 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.4188 .67081 m
.49359 .72997 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56614 .30654 m
.66623 .37703 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.56614 .30654 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.73488 .5226 m
.74456 .43267 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.74568 .57376 m
.73488 .5226 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.66623 .37703 m
.74456 .43267 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.60099 .29077 m
.66623 .37703 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32418 .37234 m
.42478 .3045 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.42478 .3045 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.32418 .37234 m
.39881 .28782 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.25423 .42621 m
.32418 .37234 L
s
P
p
.0085 w
.2531 .56798 m
.25121 .51667 L
s
P
p
.0085 w
.25423 .42621 m
.25121 .51667 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.49359 .72997 m
.5 .78548 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.5 .2197 m
.60099 .29077 L
s
P
p
.0085 w
.5 .2197 m
.50653 .26572 L
s
P
p
.0085 w
.5 .2197 m
.43224 .27163 L
s
P
p
.0085 w
.5 .2197 m
.39881 .28782 L
s
P
p
.0085 w
.5 .2197 m
.57684 .27377 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.66774 .65637 m
.56704 .72597 L
s
P
p
.0085 w
.66774 .65637 m
.60238 .71467 L
s
P
p
.0085 w
.66774 .65637 m
.74568 .57376 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.67924 .34583 m
.60099 .29077 L
s
P
p
.0085 w
.39881 .28782 m
.32935 .34092 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.56704 .72597 m
.5 .78548 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42375 .72451 m
.32258 .6526 L
s
P
p
.0085 w
.2531 .56798 m
.32258 .6526 L
s
P
p
.0085 w
.39741 .71256 m
.32258 .6526 L
s
P
p
.0085 w
.74456 .43267 m
.75569 .48287 L
s
P
p
.0085 w
.67924 .34583 m
.74456 .43267 L
s
P
p
[ .01 .012 ] 0 setdash
.0035 w
.42375 .72451 m
.5 .78548 L
s
P
p
.0085 w
.74568 .57376 m
.68091 .63135 L
s
P
p
.0085 w
.74568 .57376 m
.75569 .48287 L
s
P
p
.0085 w
.25423 .42621 m
.2562 .47654 L
s
P
p
.0085 w
.25423 .42621 m
.32935 .34092 L
s
P
p
.0085 w
.57684 .27377 m
.5849 .32141 L
s
P
p
.0085 w
.67924 .34583 m
.57684 .27377 L
s
P
p
.0085 w
.32776 .62741 m
.2531 .56798 L
s
P
p
.0085 w
.2562 .47654 m
.2531 .56798 L
s
P
p
.0085 w
.67924 .34583 m
.68925 .3949 L
s
P
p
.0085 w
.43224 .27163 m
.43759 .31931 L
s
P
p
.0085 w
.32935 .34092 m
.43224 .27163 L
s
P
p
.0085 w
.60238 .71467 m
.68091 .63135 L
s
P
p
.0085 w
.60238 .71467 m
.5 .78548 L
s
P
p
.0085 w
.39741 .71256 m
.5 .78548 L
s
P
p
.0085 w
.32776 .62741 m
.39741 .71256 L
s
P
p
.0085 w
.33277 .39007 m
.32935 .34092 L
s
P
p
.0085 w
.5 .78548 m
.57791 .70249 L
s
P
p
.0085 w
.4313 .70096 m
.5 .78548 L
s
P
p
.0085 w
.50662 .69672 m
.5 .78548 L
s
P
p
.0085 w
.50653 .26572 m
.43759 .31931 L
s
P
p
.0085 w
.50653 .26572 m
.5849 .32141 L
s
P
p
.0085 w
.75569 .48287 m
.69014 .53993 L
s
P
p
.0085 w
.68925 .3949 m
.75569 .48287 L
s
P
p
.0085 w
.68091 .63135 m
.69014 .53993 L
s
P
p
.0085 w
.57791 .70249 m
.68091 .63135 L
s
P
p
.0085 w
.57791 .70249 m
.58571 .61177 L
s
P
p
.0085 w
.32776 .62741 m
.4313 .70096 L
s
P
p
.0085 w
.32776 .62741 m
.33198 .5356 L
s
P
p
.0085 w
.2562 .47654 m
.33198 .5356 L
s
P
p
.0085 w
.33277 .39007 m
.2562 .47654 L
s
P
p
.0085 w
.4313 .70096 m
.437 .61008 L
s
P
p
.0085 w
.5849 .32141 m
.68925 .3949 L
s
P
p
.0085 w
.5849 .32141 m
.51621 .37656 L
s
P
p
.0085 w
.50662 .69672 m
.58571 .61177 L
s
P
p
.0085 w
.50662 .69672 m
.437 .61008 L
s
P
p
.0085 w
.62203 .45123 m
.68925 .3949 L
s
P
p
.0085 w
.43759 .31931 m
.51621 .37656 L
s
P
p
.0085 w
.33277 .39007 m
.43759 .31931 L
s
P
p
.0085 w
.41024 .44848 m
.33277 .39007 L
s
P
p
.0085 w
.58571 .61177 m
.69014 .53993 L
s
P
p
.0085 w
.62203 .45123 m
.69014 .53993 L
s
P
p
.0085 w
.51629 .5235 m
.58571 .61177 L
s
P
p
.0085 w
.33198 .5356 m
.437 .61008 L
s
P
p
.0085 w
.41024 .44848 m
.33198 .5356 L
s
P
p
.0085 w
.51629 .5235 m
.437 .61008 L
s
P
p
.0085 w
.41024 .44848 m
.51621 .37656 L
s
P
p
.0085 w
.62203 .45123 m
.51621 .37656 L
s
P
p
.0085 w
.62203 .45123 m
.51629 .5235 L
s
P
p
.0085 w
.51629 .5235 m
.41024 .44848 L
s
P
p
P
p
P
% End of Graphics
MathPictureEnd

:[font = input; preserveAspect; startGroup]
polygraph=FromAdjacencyLists[eadlist];
:[font = input; preserveAspect; startGroup]
ShowGraph[polygraph];
:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282; endGroup]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.132353 0.735294 0.132353 0.735294 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
p
P
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
.02 w
.86549 .53981 Mdot
.85905 .57915 Mdot
.8484 .61756 Mdot
.83367 .6546 Mdot
.81502 .68982 Mdot
.79268 .72282 Mdot
.76691 .7532 Mdot
.73801 .78062 Mdot
.70632 .80474 Mdot
.67221 .8253 Mdot
.63608 .84204 Mdot
.59836 .85477 Mdot
.55948 .86334 Mdot
.5199 .86765 Mdot
.4801 .86765 Mdot
.44052 .86334 Mdot
.40164 .85477 Mdot
.36392 .84204 Mdot
.32779 .8253 Mdot
.29368 .80474 Mdot
.26199 .78062 Mdot
.23309 .7532 Mdot
.20732 .72282 Mdot
.18498 .68982 Mdot
.16633 .6546 Mdot
.1516 .61756 Mdot
.14095 .57915 Mdot
.13451 .53981 Mdot
.13235 .5 Mdot
.13451 .46019 Mdot
.14095 .42085 Mdot
.1516 .38244 Mdot
.16633 .3454 Mdot
.18498 .31018 Mdot
.20732 .27718 Mdot
.23309 .2468 Mdot
.26199 .21938 Mdot
.29368 .19526 Mdot
.32779 .1747 Mdot
.36392 .15796 Mdot
.40164 .14523 Mdot
.44052 .13666 Mdot
.4801 .13235 Mdot
.5199 .13235 Mdot
.55948 .13666 Mdot
.59836 .14523 Mdot
.63608 .15796 Mdot
.67221 .1747 Mdot
.70632 .19526 Mdot
.73801 .21938 Mdot
.76691 .2468 Mdot
.79268 .27718 Mdot
.81502 .31018 Mdot
.83367 .3454 Mdot
.8484 .38244 Mdot
.85905 .42085 Mdot
.86549 .46019 Mdot
.86765 .5 Mdot
.0025 w
.86549 .53981 m
.85905 .57915 L
s
.86549 .53981 m
.67221 .1747 L
s
.86549 .53981 m
.81502 .31018 L
s
.86549 .53981 m
.86765 .5 L
s
.85905 .57915 m
.86549 .53981 L
s
.85905 .57915 m
.76691 .7532 L
s
.85905 .57915 m
.73801 .21938 L
s
.85905 .57915 m
.86549 .46019 L
s
.8484 .61756 m
.83367 .6546 L
s
.8484 .61756 m
.81502 .68982 L
s
.8484 .61756 m
.5199 .13235 L
s
.8484 .61756 m
.76691 .2468 L
s
.83367 .6546 m
.8484 .61756 L
s
.83367 .6546 m
.70632 .80474 L
s
.83367 .6546 m
.83367 .3454 L
s
.83367 .6546 m
.85905 .42085 L
s
.81502 .68982 m
.8484 .61756 L
s
.81502 .68982 m
.79268 .27718 L
s
.81502 .68982 m
.85905 .42085 L
s
.79268 .72282 m
.73801 .21938 L
s
.79268 .72282 m
.79268 .27718 L
s
.79268 .72282 m
.86549 .46019 L
s
.76691 .7532 m
.85905 .57915 L
s
.76691 .7532 m
.73801 .78062 L
s
.76691 .7532 m
.1516 .61756 L
s
.76691 .7532 m
.67221 .1747 L
s
.73801 .78062 m
.76691 .7532 L
s
.73801 .78062 m
.23309 .7532 L
s
.73801 .78062 m
.18498 .68982 L
s
.73801 .78062 m
.63608 .15796 L
s
.70632 .80474 m
.83367 .6546 L
s
.70632 .80474 m
.55948 .86334 L
s
.70632 .80474 m
.36392 .15796 L
s
.70632 .80474 m
.5199 .13235 L
s
.67221 .8253 m
.63608 .84204 L
s
.67221 .8253 m
.59836 .85477 L
s
.67221 .8253 m
.20732 .27718 L
s
.67221 .8253 m
.44052 .13666 L
s
.63608 .84204 m
.67221 .8253 L
s
.63608 .84204 m
.40164 .14523 L
s
.63608 .84204 m
.79268 .27718 L
s
.59836 .85477 m
.67221 .8253 L
s
.59836 .85477 m
.18498 .31018 L
s
.59836 .85477 m
.79268 .27718 L
s
.55948 .86334 m
.70632 .80474 L
s
.55948 .86334 m
.13451 .53981 L
s
.55948 .86334 m
.32779 .1747 L
s
.55948 .86334 m
.4801 .13235 L
s
.5199 .86765 m
.44052 .86334 L
s
.5199 .86765 m
.40164 .85477 L
s
.5199 .86765 m
.36392 .15796 L
s
.5199 .86765 m
.81502 .31018 L
s
.4801 .86765 m
.44052 .86334 L
s
.4801 .86765 m
.40164 .85477 L
s
.4801 .86765 m
.29368 .80474 L
s
.4801 .86765 m
.26199 .78062 L
s
.4801 .86765 m
.20732 .72282 L
s
.4801 .86765 m
.13235 .5 L
s
.4801 .86765 m
.13451 .46019 L
s
.4801 .86765 m
.55948 .13666 L
s
.44052 .86334 m
.5199 .86765 L
s
.44052 .86334 m
.4801 .86765 L
s
.44052 .86334 m
.59836 .14523 L
s
.40164 .85477 m
.5199 .86765 L
s
.40164 .85477 m
.4801 .86765 L
s
.40164 .85477 m
.32779 .1747 L
s
.36392 .84204 m
.32779 .8253 L
s
.36392 .84204 m
.23309 .7532 L
s
.36392 .84204 m
.18498 .68982 L
s
.36392 .84204 m
.29368 .19526 L
s
.32779 .8253 m
.36392 .84204 L
s
.32779 .8253 m
.29368 .80474 L
s
.32779 .8253 m
.26199 .78062 L
s
.32779 .8253 m
.26199 .21938 L
s
.29368 .80474 m
.4801 .86765 L
s
.29368 .80474 m
.32779 .8253 L
s
.29368 .80474 m
.1516 .38244 L
s
.26199 .78062 m
.4801 .86765 L
s
.26199 .78062 m
.32779 .8253 L
s
.26199 .78062 m
.23309 .7532 L
s
.23309 .7532 m
.73801 .78062 L
s
.23309 .7532 m
.36392 .84204 L
s
.23309 .7532 m
.26199 .78062 L
s
.23309 .7532 m
.20732 .72282 L
s
.20732 .72282 m
.4801 .86765 L
s
.20732 .72282 m
.23309 .7532 L
s
.20732 .72282 m
.63608 .15796 L
s
.18498 .68982 m
.73801 .78062 L
s
.18498 .68982 m
.36392 .84204 L
s
.18498 .68982 m
.1516 .61756 L
s
.18498 .68982 m
.16633 .3454 L
s
.16633 .6546 m
.1516 .61756 L
s
.16633 .6546 m
.14095 .42085 L
s
.16633 .6546 m
.16633 .3454 L
s
.16633 .6546 m
.70632 .19526 L
s
.1516 .61756 m
.76691 .7532 L
s
.1516 .61756 m
.18498 .68982 L
s
.1516 .61756 m
.16633 .6546 L
s
.1516 .61756 m
.73801 .21938 L
s
.14095 .57915 m
.13451 .53981 L
s
.14095 .57915 m
.1516 .38244 L
s
.14095 .57915 m
.23309 .2468 L
s
.14095 .57915 m
.4801 .13235 L
s
.13451 .53981 m
.55948 .86334 L
s
.13451 .53981 m
.14095 .57915 L
s
.13451 .53981 m
.13235 .5 L
s
.13451 .53981 m
.13451 .46019 L
s
.13235 .5 m
.4801 .86765 L
s
.13235 .5 m
.13451 .53981 L
s
.13235 .5 m
.1516 .38244 L
s
.13451 .46019 m
.4801 .86765 L
s
.13451 .46019 m
.13451 .53981 L
s
.13451 .46019 m
.32779 .1747 L
s
.14095 .42085 m
.16633 .6546 L
s
.14095 .42085 m
.18498 .31018 L
s
.14095 .42085 m
.79268 .27718 L
s
.1516 .38244 m
.29368 .80474 L
s
.1516 .38244 m
.14095 .57915 L
s
.1516 .38244 m
.13235 .5 L
s
.1516 .38244 m
.26199 .21938 L
s
.16633 .3454 m
.18498 .68982 L
s
.16633 .3454 m
.16633 .6546 L
s
.16633 .3454 m
.18498 .31018 L
s
.16633 .3454 m
.29368 .19526 L
s
.18498 .31018 m
.59836 .85477 L
s
.18498 .31018 m
.14095 .42085 L
s
.18498 .31018 m
.16633 .3454 L
s
.18498 .31018 m
.20732 .27718 L
s
.20732 .27718 m
.67221 .8253 L
s
.20732 .27718 m
.18498 .31018 L
s
.20732 .27718 m
.23309 .2468 L
s
.20732 .27718 m
.29368 .19526 L
s
.23309 .2468 m
.14095 .57915 L
s
.23309 .2468 m
.20732 .27718 L
s
.23309 .2468 m
.26199 .21938 L
s
.23309 .2468 m
.44052 .13666 L
s
.26199 .21938 m
.32779 .8253 L
s
.26199 .21938 m
.1516 .38244 L
s
.26199 .21938 m
.23309 .2468 L
s
.26199 .21938 m
.29368 .19526 L
s
.29368 .19526 m
.36392 .84204 L
s
.29368 .19526 m
.16633 .3454 L
s
.29368 .19526 m
.20732 .27718 L
s
.29368 .19526 m
.26199 .21938 L
s
.32779 .1747 m
.55948 .86334 L
s
.32779 .1747 m
.40164 .85477 L
s
.32779 .1747 m
.13451 .46019 L
s
.32779 .1747 m
.36392 .15796 L
s
.36392 .15796 m
.70632 .80474 L
s
.36392 .15796 m
.5199 .86765 L
s
.36392 .15796 m
.32779 .1747 L
s
.36392 .15796 m
.83367 .3454 L
s
.40164 .14523 m
.63608 .84204 L
s
.40164 .14523 m
.44052 .13666 L
s
.40164 .14523 m
.5199 .13235 L
s
.40164 .14523 m
.76691 .2468 L
s
.44052 .13666 m
.67221 .8253 L
s
.44052 .13666 m
.23309 .2468 L
s
.44052 .13666 m
.40164 .14523 L
s
.44052 .13666 m
.4801 .13235 L
s
.4801 .13235 m
.55948 .86334 L
s
.4801 .13235 m
.14095 .57915 L
s
.4801 .13235 m
.44052 .13666 L
s
.4801 .13235 m
.5199 .13235 L
s
.5199 .13235 m
.8484 .61756 L
s
.5199 .13235 m
.70632 .80474 L
s
.5199 .13235 m
.40164 .14523 L
s
.5199 .13235 m
.4801 .13235 L
s
.55948 .13666 m
.4801 .86765 L
s
.55948 .13666 m
.59836 .14523 L
s
.55948 .13666 m
.63608 .15796 L
s
.59836 .14523 m
.44052 .86334 L
s
.59836 .14523 m
.55948 .13666 L
s
.59836 .14523 m
.67221 .1747 L
s
.59836 .14523 m
.81502 .31018 L
s
.63608 .15796 m
.73801 .78062 L
s
.63608 .15796 m
.20732 .72282 L
s
.63608 .15796 m
.55948 .13666 L
s
.63608 .15796 m
.67221 .1747 L
s
.67221 .1747 m
.86549 .53981 L
s
.67221 .1747 m
.76691 .7532 L
s
.67221 .1747 m
.59836 .14523 L
s
.67221 .1747 m
.63608 .15796 L
s
.70632 .19526 m
.16633 .6546 L
s
.70632 .19526 m
.73801 .21938 L
s
.70632 .19526 m
.79268 .27718 L
s
.73801 .21938 m
.85905 .57915 L
s
.73801 .21938 m
.79268 .72282 L
s
.73801 .21938 m
.1516 .61756 L
s
.73801 .21938 m
.70632 .19526 L
s
.76691 .2468 m
.8484 .61756 L
s
.76691 .2468 m
.40164 .14523 L
s
.76691 .2468 m
.79268 .27718 L
s
.79268 .27718 m
.81502 .68982 L
s
.79268 .27718 m
.79268 .72282 L
s
.79268 .27718 m
.63608 .84204 L
s
.79268 .27718 m
.59836 .85477 L
s
.79268 .27718 m
.14095 .42085 L
s
.79268 .27718 m
.70632 .19526 L
s
.79268 .27718 m
.76691 .2468 L
s
.79268 .27718 m
.8484 .38244 L
s
.81502 .31018 m
.86549 .53981 L
s
.81502 .31018 m
.5199 .86765 L
s
.81502 .31018 m
.59836 .14523 L
s
.81502 .31018 m
.83367 .3454 L
s
.83367 .3454 m
.83367 .6546 L
s
.83367 .3454 m
.36392 .15796 L
s
.83367 .3454 m
.81502 .31018 L
s
.83367 .3454 m
.86765 .5 L
s
.8484 .38244 m
.79268 .27718 L
s
.8484 .38244 m
.85905 .42085 L
s
.8484 .38244 m
.86549 .46019 L
s
.85905 .42085 m
.83367 .6546 L
s
.85905 .42085 m
.81502 .68982 L
s
.85905 .42085 m
.8484 .38244 L
s
.85905 .42085 m
.86765 .5 L
s
.86549 .46019 m
.85905 .57915 L
s
.86549 .46019 m
.79268 .72282 L
s
.86549 .46019 m
.8484 .38244 L
s
.86549 .46019 m
.86765 .5 L
s
.86765 .5 m
.86549 .53981 L
s
.86765 .5 m
.83367 .3454 L
s
.86765 .5 m
.85905 .42085 L
s
.86765 .5 m
.86549 .46019 L
s
P
% End of Graphics
MathPictureEnd

:[font = input; preserveAspect; startGroup]
ShowLabeledGraph[RankedEmbedding[polygraph,{52}]]
:[font = postscript; PostScript; formatAsPostScript; output; inactive; preserveAspect; pictureLeft = 34; pictureWidth = 282; pictureHeight = 282]
%!
%%Creator: Mathematica
%%AspectRatio: 1 
MathPictureStart
%% Graphics
/Courier findfont 10  scalefont  setfont
% Scaling calculations
0.132353 0.735294 0.132353 0.735294 [
[ 0 0 0 0 ]
[ 1 1 0 0 ]
] MathScale
% Start of Graphics
1 setlinecap
1 setlinejoin
newpath
[ ] 0 setdash
0 g
p
P
0 0 m
1 0 L
1 1 L
0 1 L
closepath
clip
newpath
p
.02 w
.5 .13235 Mdot
.40809 .13235 Mdot
.31618 .13235 Mdot
.40809 .23739 Mdot
.22426 .13235 Mdot
.22426 .23739 Mdot
.5 .23739 Mdot
.59191 .13235 Mdot
.5 .34244 Mdot
.31618 .23739 Mdot
.22426 .34244 Mdot
.22426 .44748 Mdot
.59191 .23739 Mdot
.68382 .13235 Mdot
.86765 .5 Mdot
.77574 .13235 Mdot
.77574 .23739 Mdot
.59191 .34244 Mdot
.68382 .23739 Mdot
.77574 .34244 Mdot
.77574 .44748 Mdot
.68382 .34244 Mdot
.77574 .55252 Mdot
.5 .44748 Mdot
.31618 .34244 Mdot
.40809 .34244 Mdot
.59191 .44748 Mdot
.68382 .44748 Mdot
.77574 .65756 Mdot
.77574 .76261 Mdot
.22426 .55252 Mdot
.68382 .55252 Mdot
.40809 .44748 Mdot
.31618 .44748 Mdot
.40809 .55252 Mdot
.5 .55252 Mdot
.59191 .55252 Mdot
.5 .65756 Mdot
.68382 .65756 Mdot
.59191 .65756 Mdot
.31618 .55252 Mdot
.40809 .65756 Mdot
.5 .76261 Mdot
.40809 .76261 Mdot
.77574 .86765 Mdot
.68382 .76261 Mdot
.68382 .86765 Mdot
.59191 .76261 Mdot
.22426 .65756 Mdot
.31618 .65756 Mdot
.22426 .76261 Mdot
.13235 .5 Mdot
.59191 .86765 Mdot
.5 .86765 Mdot
.22426 .86765 Mdot
.31618 .76261 Mdot
.31618 .86765 Mdot
.40809 .86765 Mdot
.0025 w
.5 .13235 m
.40809 .13235 L
s
.5 .13235 m
.59191 .76261 L
s
.5 .13235 m
.59191 .86765 L
s
.5 .13235 m
.40809 .86765 L
s
.40809 .13235 m
.5 .13235 L
s
.40809 .13235 m
.5 .23739 L
s
.40809 .13235 m
.31618 .65756 L
s
.40809 .13235 m
.31618 .86765 L
s
.31618 .13235 m
.40809 .23739 L
s
.31618 .13235 m
.22426 .13235 L
s
.31618 .13235 m
.40809 .76261 L
s
.31618 .13235 m
.22426 .76261 L
s
.40809 .23739 m
.31618 .13235 L
s
.40809 .23739 m
.5 .34244 L
s
.40809 .23739 m
.5 .86765 L
s
.40809 .23739 m
.31618 .76261 L
s
.22426 .13235 m
.31618 .13235 L
s
.22426 .13235 m
.13235 .5 L
s
.22426 .13235 m
.31618 .76261 L
s
.22426 .23739 m
.31618 .65756 L
s
.22426 .23739 m
.13235 .5 L
s
.22426 .23739 m
.31618 .86765 L
s
.5 .23739 m
.40809 .13235 L
s
.5 .23739 m
.59191 .13235 L
s
.5 .23739 m
.40809 .34244 L
s
.5 .23739 m
.59191 .76261 L
s
.59191 .13235 m
.5 .23739 L
s
.59191 .13235 m
.68382 .34244 L
s
.59191 .13235 m
.5 .44748 L
s
.59191 .13235 m
.68382 .86765 L
s
.5 .34244 m
.40809 .23739 L
s
.5 .34244 m
.59191 .23739 L
s
.5 .34244 m
.59191 .65756 L
s
.5 .34244 m
.40809 .76261 L
s
.31618 .23739 m
.22426 .34244 L
s
.31618 .23739 m
.22426 .44748 L
s
.31618 .23739 m
.40809 .55252 L
s
.31618 .23739 m
.40809 .65756 L
s
.22426 .34244 m
.31618 .23739 L
s
.22426 .34244 m
.31618 .55252 L
s
.22426 .34244 m
.13235 .5 L
s
.22426 .44748 m
.31618 .23739 L
s
.22426 .44748 m
.31618 .44748 L
s
.22426 .44748 m
.13235 .5 L
s
.59191 .23739 m
.5 .34244 L
s
.59191 .23739 m
.68382 .44748 L
s
.59191 .23739 m
.68382 .65756 L
s
.59191 .23739 m
.5 .76261 L
s
.68382 .13235 m
.77574 .13235 L
s
.68382 .13235 m
.77574 .23739 L
s
.68382 .13235 m
.59191 .65756 L
s
.68382 .13235 m
.59191 .86765 L
s
.86765 .5 m
.77574 .13235 L
s
.86765 .5 m
.77574 .23739 L
s
.86765 .5 m
.77574 .34244 L
s
.86765 .5 m
.77574 .44748 L
s
.86765 .5 m
.77574 .55252 L
s
.86765 .5 m
.77574 .65756 L
s
.86765 .5 m
.77574 .76261 L
s
.86765 .5 m
.77574 .86765 L
s
.77574 .13235 m
.68382 .13235 L
s
.77574 .13235 m
.86765 .5 L
s
.77574 .13235 m
.68382 .76261 L
s
.77574 .23739 m
.68382 .13235 L
s
.77574 .23739 m
.86765 .5 L
s
.77574 .23739 m
.68382 .65756 L
s
.59191 .34244 m
.68382 .23739 L
s
.59191 .34244 m
.68382 .34244 L
s
.59191 .34244 m
.5 .44748 L
s
.59191 .34244 m
.5 .65756 L
s
.68382 .23739 m
.59191 .34244 L
s
.68382 .23739 m
.77574 .34244 L
s
.68382 .23739 m
.77574 .44748 L
s
.68382 .23739 m
.59191 .55252 L
s
.77574 .34244 m
.86765 .5 L
s
.77574 .34244 m
.68382 .23739 L
s
.77574 .34244 m
.68382 .55252 L
s
.77574 .44748 m
.86765 .5 L
s
.77574 .44748 m
.68382 .23739 L
s
.77574 .44748 m
.68382 .34244 L
s
.68382 .34244 m
.59191 .13235 L
s
.68382 .34244 m
.59191 .34244 L
s
.68382 .34244 m
.77574 .44748 L
s
.68382 .34244 m
.77574 .55252 L
s
.77574 .55252 m
.86765 .5 L
s
.77574 .55252 m
.68382 .34244 L
s
.77574 .55252 m
.68382 .86765 L
s
.5 .44748 m
.59191 .13235 L
s
.5 .44748 m
.59191 .34244 L
s
.5 .44748 m
.40809 .34244 L
s
.5 .44748 m
.40809 .44748 L
s
.31618 .34244 m
.40809 .34244 L
s
.31618 .34244 m
.22426 .55252 L
s
.31618 .34244 m
.40809 .44748 L
s
.31618 .34244 m
.22426 .65756 L
s
.40809 .34244 m
.5 .23739 L
s
.40809 .34244 m
.5 .44748 L
s
.40809 .34244 m
.31618 .34244 L
s
.40809 .34244 m
.31618 .65756 L
s
.59191 .44748 m
.68382 .44748 L
s
.59191 .44748 m
.68382 .55252 L
s
.59191 .44748 m
.5 .55252 L
s
.59191 .44748 m
.5 .76261 L
s
.68382 .44748 m
.59191 .23739 L
s
.68382 .44748 m
.59191 .44748 L
s
.68382 .44748 m
.77574 .65756 L
s
.68382 .44748 m
.77574 .76261 L
s
.77574 .65756 m
.86765 .5 L
s
.77574 .65756 m
.68382 .44748 L
s
.77574 .65756 m
.68382 .55252 L
s
.77574 .76261 m
.86765 .5 L
s
.77574 .76261 m
.68382 .44748 L
s
.77574 .76261 m
.68382 .65756 L
s
.22426 .55252 m
.31618 .34244 L
s
.22426 .55252 m
.31618 .44748 L
s
.22426 .55252 m
.13235 .5 L
s
.68382 .55252 m
.77574 .34244 L
s
.68382 .55252 m
.59191 .44748 L
s
.68382 .55252 m
.77574 .65756 L
s
.68382 .55252 m
.59191 .55252 L
s
.40809 .44748 m
.5 .44748 L
s
.40809 .44748 m
.31618 .34244 L
s
.40809 .44748 m
.31618 .44748 L
s
.40809 .44748 m
.5 .65756 L
s
.31618 .44748 m
.22426 .44748 L
s
.31618 .44748 m
.22426 .55252 L
s
.31618 .44748 m
.40809 .44748 L
s
.31618 .44748 m
.40809 .55252 L
s
.40809 .55252 m
.31618 .23739 L
s
.40809 .55252 m
.31618 .44748 L
s
.40809 .55252 m
.5 .55252 L
s
.40809 .55252 m
.5 .65756 L
s
.5 .55252 m
.59191 .44748 L
s
.5 .55252 m
.40809 .55252 L
s
.5 .55252 m
.59191 .55252 L
s
.5 .55252 m
.40809 .65756 L
s
.59191 .55252 m
.68382 .23739 L
s
.59191 .55252 m
.68382 .55252 L
s
.59191 .55252 m
.5 .55252 L
s
.59191 .55252 m
.5 .65756 L
s
.5 .65756 m
.59191 .34244 L
s
.5 .65756 m
.40809 .44748 L
s
.5 .65756 m
.40809 .55252 L
s
.5 .65756 m
.59191 .55252 L
s
.68382 .65756 m
.59191 .23739 L
s
.68382 .65756 m
.77574 .23739 L
s
.68382 .65756 m
.77574 .76261 L
s
.68382 .65756 m
.59191 .65756 L
s
.59191 .65756 m
.5 .34244 L
s
.59191 .65756 m
.68382 .13235 L
s
.59191 .65756 m
.68382 .65756 L
s
.59191 .65756 m
.5 .86765 L
s
.31618 .55252 m
.22426 .34244 L
s
.31618 .55252 m
.40809 .65756 L
s
.31618 .55252 m
.40809 .76261 L
s
.31618 .55252 m
.22426 .76261 L
s
.40809 .65756 m
.31618 .23739 L
s
.40809 .65756 m
.5 .55252 L
s
.40809 .65756 m
.31618 .55252 L
s
.40809 .65756 m
.5 .76261 L
s
.5 .76261 m
.59191 .23739 L
s
.5 .76261 m
.59191 .44748 L
s
.5 .76261 m
.40809 .65756 L
s
.5 .76261 m
.40809 .76261 L
s
.40809 .76261 m
.31618 .13235 L
s
.40809 .76261 m
.5 .34244 L
s
.40809 .76261 m
.31618 .55252 L
s
.40809 .76261 m
.5 .76261 L
s
.77574 .86765 m
.86765 .5 L
s
.77574 .86765 m
.68382 .76261 L
s
.77574 .86765 m
.68382 .86765 L
s
.68382 .76261 m
.77574 .13235 L
s
.68382 .76261 m
.77574 .86765 L
s
.68382 .76261 m
.59191 .76261 L
s
.68382 .76261 m
.59191 .86765 L
s
.68382 .86765 m
.59191 .13235 L
s
.68382 .86765 m
.77574 .55252 L
s
.68382 .86765 m
.77574 .86765 L
s
.68382 .86765 m
.59191 .76261 L
s
.59191 .76261 m
.5 .13235 L
s
.59191 .76261 m
.5 .23739 L
s
.59191 .76261 m
.68382 .76261 L
s
.59191 .76261 m
.68382 .86765 L
s
.22426 .65756 m
.31618 .34244 L
s
.22426 .65756 m
.31618 .65756 L
s
.22426 .65756 m
.13235 .5 L
s
.31618 .65756 m
.40809 .13235 L
s
.31618 .65756 m
.22426 .23739 L
s
.31618 .65756 m
.40809 .34244 L
s
.31618 .65756 m
.22426 .65756 L
s
.22426 .76261 m
.31618 .13235 L
s
.22426 .76261 m
.31618 .55252 L
s
.22426 .76261 m
.13235 .5 L
s
.13235 .5 m
.22426 .13235 L
s
.13235 .5 m
.22426 .23739 L
s
.13235 .5 m
.22426 .34244 L
s
.13235 .5 m
.22426 .44748 L
s
.13235 .5 m
.22426 .55252 L
s
.13235 .5 m
.22426 .65756 L
s
.13235 .5 m
.22426 .76261 L
s
.13235 .5 m
.22426 .86765 L
s
.59191 .86765 m
.5 .13235 L
s
.59191 .86765 m
.68382 .13235 L
s
.59191 .86765 m
.68382 .76261 L
s
.59191 .86765 m
.5 .86765 L
s
.5 .86765 m
.40809 .23739 L
s
.5 .86765 m
.59191 .65756 L
s
.5 .86765 m
.59191 .86765 L
s
.5 .86765 m
.40809 .86765 L
s
.22426 .86765 m
.13235 .5 L
s
.22426 .86765 m
.31618 .76261 L
s
.22426 .86765 m
.31618 .86765 L
s
.31618 .76261 m
.40809 .23739 L
s
.31618 .76261 m
.22426 .13235 L
s
.31618 .76261 m
.22426 .86765 L
s
.31618 .76261 m
.40809 .86765 L
s
.31618 .86765 m
.40809 .13235 L
s
.31618 .86765 m
.22426 .23739 L
s
.31618 .86765 m
.22426 .86765 L
s
.31618 .86765 m
.40809 .86765 L
s
.40809 .86765 m
.5 .13235 L
s
.40809 .86765 m
.5 .86765 L
s
.40809 .86765 m
.31618 .76261 L
s
.40809 .86765 m
.31618 .86765 L
s
.5 .13235 m
.40809 .13235 L
s
.5 .13235 m
.59191 .76261 L
s
.5 .13235 m
.59191 .86765 L
s
.5 .13235 m
.40809 .86765 L
s
.40809 .13235 m
.5 .13235 L
s
.40809 .13235 m
.5 .23739 L
s
.40809 .13235 m
.31618 .65756 L
s
.40809 .13235 m
.31618 .86765 L
s
.31618 .13235 m
.40809 .23739 L
s
.31618 .13235 m
.22426 .13235 L
s
.31618 .13235 m
.40809 .76261 L
s
.31618 .13235 m
.22426 .76261 L
s
.40809 .23739 m
.31618 .13235 L
s
.40809 .23739 m
.5 .34244 L
s
.40809 .23739 m
.5 .86765 L
s
.40809 .23739 m
.31618 .76261 L
s
.22426 .13235 m
.31618 .13235 L
s
.22426 .13235 m
.13235 .5 L
s
.22426 .13235 m
.31618 .76261 L
s
.22426 .23739 m
.31618 .65756 L
s
.22426 .23739 m
.13235 .5 L
s
.22426 .23739 m
.31618 .86765 L
s
.5 .23739 m
.40809 .13235 L
s
.5 .23739 m
.59191 .13235 L
s
.5 .23739 m
.40809 .34244 L
s
.5 .23739 m
.59191 .76261 L
s
.59191 .13235 m
.5 .23739 L
s
.59191 .13235 m
.68382 .34244 L
s
.59191 .13235 m
.5 .44748 L
s
.59191 .13235 m
.68382 .86765 L
s
.5 .34244 m
.40809 .23739 L
s
.5 .34244 m
.59191 .23739 L
s
.5 .34244 m
.59191 .65756 L
s
.5 .34244 m
.40809 .76261 L
s
.31618 .23739 m
.22426 .34244 L
s
.31618 .23739 m
.22426 .44748 L
s
.31618 .23739 m
.40809 .55252 L
s
.31618 .23739 m
.40809 .65756 L
s
.22426 .34244 m
.31618 .23739 L
s
.22426 .34244 m
.31618 .55252 L
s
.22426 .34244 m
.13235 .5 L
s
.22426 .44748 m
.31618 .23739 L
s
.22426 .44748 m
.31618 .44748 L
s
.22426 .44748 m
.13235 .5 L
s
.59191 .23739 m
.5 .34244 L
s
.59191 .23739 m
.68382 .44748 L
s
.59191 .23739 m
.68382 .65756 L
s
.59191 .23739 m
.5 .76261 L
s
.68382 .13235 m
.77574 .13235 L
s
.68382 .13235 m
.77574 .23739 L
s
.68382 .13235 m
.59191 .65756 L
s
.68382 .13235 m
.59191 .86765 L
s
.86765 .5 m
.77574 .13235 L
s
.86765 .5 m
.77574 .23739 L
s
.86765 .5 m
.77574 .34244 L
s
.86765 .5 m
.77574 .44748 L
s
.86765 .5 m
.77574 .55252 L
s
.86765 .5 m
.77574 .65756 L
s
.86765 .5 m
.77574 .76261 L
s
.86765 .5 m
.77574 .86765 L
s
.77574 .13235 m
.68382 .13235 L
s
.77574 .13235 m
.86765 .5 L
s
.77574 .13235 m
.68382 .76261 L
s
.77574 .23739 m
.68382 .13235 L
s
.77574 .23739 m
.86765 .5 L
s
.77574 .23739 m
.68382 .65756 L
s
.59191 .34244 m
.68382 .23739 L
s
.59191 .34244 m
.68382 .34244 L
s
.59191 .34244 m
.5 .44748 L
s
.59191 .34244 m
.5 .65756 L
s
.68382 .23739 m
.59191 .34244 L
s
.68382 .23739 m
.77574 .34244 L
s
.68382 .23739 m
.77574 .44748 L
s
.68382 .23739 m
.59191 .55252 L
s
.77574 .34244 m
.86765 .5 L
s
.77574 .34244 m
.68382 .23739 L
s
.77574 .34244 m
.68382 .55252 L
s
.77574 .44748 m
.86765 .5 L
s
.77574 .44748 m
.68382 .23739 L
s
.77574 .44748 m
.68382 .34244 L
s
.68382 .34244 m
.59191 .13235 L
s
.68382 .34244 m
.59191 .34244 L
s
.68382 .34244 m
.77574 .44748 L
s
.68382 .34244 m
.77574 .55252 L
s
.77574 .55252 m
.86765 .5 L
s
.77574 .55252 m
.68382 .34244 L
s
.77574 .55252 m
.68382 .86765 L
s
.5 .44748 m
.59191 .13235 L
s
.5 .44748 m
.59191 .34244 L
s
.5 .44748 m
.40809 .34244 L
s
.5 .44748 m
.40809 .44748 L
s
.31618 .34244 m
.40809 .34244 L
s
.31618 .34244 m
.22426 .55252 L
s
.31618 .34244 m
.40809 .44748 L
s
.31618 .34244 m
.22426 .65756 L
s
.40809 .34244 m
.5 .23739 L
s
.40809 .34244 m
.5 .44748 L
s
.40809 .34244 m
.31618 .34244 L
s
.40809 .34244 m
.31618 .65756 L
s
.59191 .44748 m
.68382 .44748 L
s
.59191 .44748 m
.68382 .55252 L
s
.59191 .44748 m
.5 .55252 L
s
.59191 .44748 m
.5 .76261 L
s
.68382 .44748 m
.59191 .23739 L
s
.68382 .44748 m
.59191 .44748 L
s
.68382 .44748 m
.77574 .65756 L
s
.68382 .44748 m
.77574 .76261 L
s
.77574 .65756 m
.86765 .5 L
s
.77574 .65756 m
.68382 .44748 L
s
.77574 .65756 m
.68382 .55252 L
s
.77574 .76261 m
.86765 .5 L
s
.77574 .76261 m
.68382 .44748 L
s
.77574 .76261 m
.68382 .65756 L
s
.22426 .55252 m
.31618 .34244 L
s
.22426 .55252 m
.31618 .44748 L
s
.22426 .55252 m
.13235 .5 L
s
.68382 .55252 m
.77574 .34244 L
s
.68382 .55252 m
.59191 .44748 L
s
.68382 .55252 m
.77574 .65756 L
s
.68382 .55252 m
.59191 .55252 L
s
.40809 .44748 m
.5 .44748 L
s
.40809 .44748 m
.31618 .34244 L
s
.40809 .44748 m
.31618 .44748 L
s
.40809 .44748 m
.5 .65756 L
s
.31618 .44748 m
.22426 .44748 L
s
.31618 .44748 m
.22426 .55252 L
s
.31618 .44748 m
.40809 .44748 L
s
.31618 .44748 m
.40809 .55252 L
s
.40809 .55252 m
.31618 .23739 L
s
.40809 .55252 m
.31618 .44748 L
s
.40809 .55252 m
.5 .55252 L
s
.40809 .55252 m
.5 .65756 L
s
.5 .55252 m
.59191 .44748 L
s
.5 .55252 m
.40809 .55252 L
s
.5 .55252 m
.59191 .55252 L
s
.5 .55252 m
.40809 .65756 L
s
.59191 .55252 m
.68382 .23739 L
s
.59191 .55252 m
.68382 .55252 L
s
.59191 .55252 m
.5 .55252 L
s
.59191 .55252 m
.5 .65756 L
s
.5 .65756 m
.59191 .34244 L
s
.5 .65756 m
.40809 .44748 L
s
.5 .65756 m
.40809 .55252 L
s
.5 .65756 m
.59191 .55252 L
s
.68382 .65756 m
.59191 .23739 L
s
.68382 .65756 m
.77574 .23739 L
s
.68382 .65756 m
.77574 .76261 L
s
.68382 .65756 m
.59191 .65756 L
s
.59191 .65756 m
.5 .34244 L
s
.59191 .65756 m
.68382 .13235 L
s
.59191 .65756 m
.68382 .65756 L
s
.59191 .65756 m
.5 .86765 L
s
.31618 .55252 m
.22426 .34244 L
s
.31618 .55252 m
.40809 .65756 L
s
.31618 .55252 m
.40809 .76261 L
s
.31618 .55252 m
.22426 .76261 L
s
.40809 .65756 m
.31618 .23739 L
s
.40809 .65756 m
.5 .55252 L
s
.40809 .65756 m
.31618 .55252 L
s
.40809 .65756 m
.5 .76261 L
s
.5 .76261 m
.59191 .23739 L
s
.5 .76261 m
.59191 .44748 L
s
.5 .76261 m
.40809 .65756 L
s
.5 .76261 m
.40809 .76261 L
s
.40809 .76261 m
.31618 .13235 L
s
.40809 .76261 m
.5 .34244 L
s
.40809 .76261 m
.31618 .55252 L
s
.40809 .76261 m
.5 .76261 L
s
.77574 .86765 m
.86765 .5 L
s
.77574 .86765 m
.68382 .76261 L
s
.77574 .86765 m
.68382 .86765 L
s
.68382 .76261 m
.77574 .13235 L
s
.68382 .76261 m
.77574 .86765 L
s
.68382 .76261 m
.59191 .76261 L
s
.68382 .76261 m
.59191 .86765 L
s
.68382 .86765 m
.59191 .13235 L
s
.68382 .86765 m
.77574 .55252 L
s
.68382 .86765 m
.77574 .86765 L
s
.68382 .86765 m
.59191 .76261 L
s
.59191 .76261 m
.5 .13235 L
s
.59191 .76261 m
.5 .23739 L
s
.59191 .76261 m
.68382 .76261 L
s
.59191 .76261 m
.68382 .86765 L
s
.22426 .65756 m
.31618 .34244 L
s
.22426 .65756 m
.31618 .65756 L
s
.22426 .65756 m
.13235 .5 L
s
.31618 .65756 m
.40809 .13235 L
s
.31618 .65756 m
.22426 .23739 L
s
.31618 .65756 m
.40809 .34244 L
s
.31618 .65756 m
.22426 .65756 L
s
.22426 .76261 m
.31618 .13235 L
s
.22426 .76261 m
.31618 .55252 L
s
.22426 .76261 m
.13235 .5 L
s
.13235 .5 m
.22426 .13235 L
s
.13235 .5 m
.22426 .23739 L
s
.13235 .5 m
.22426 .34244 L
s
.13235 .5 m
.22426 .44748 L
s
.13235 .5 m
.22426 .55252 L
s
.13235 .5 m
.22426 .65756 L
s
.13235 .5 m
.22426 .76261 L
s
.13235 .5 m
.22426 .86765 L
s
.59191 .86765 m
.5 .13235 L
s
.59191 .86765 m
.68382 .13235 L
s
.59191 .86765 m
.68382 .76261 L
s
.59191 .86765 m
.5 .86765 L
s
.5 .86765 m
.40809 .23739 L
s
.5 .86765 m
.59191 .65756 L
s
.5 .86765 m
.59191 .86765 L
s
.5 .86765 m
.40809 .86765 L
s
.22426 .86765 m
.13235 .5 L
s
.22426 .86765 m
.31618 .76261 L
s
.22426 .86765 m
.31618 .86765 L
s
.31618 .76261 m
.40809 .23739 L
s
.31618 .76261 m
.22426 .13235 L
s
.31618 .76261 m
.22426 .86765 L
s
.31618 .76261 m
.40809 .86765 L
s
.31618 .86765 m
.40809 .13235 L
s
.31618 .86765 m
.22426 .23739 L
s
.31618 .86765 m
.22426 .86765 L
s
.31618 .86765 m
.40809 .86765 L
s
.40809 .86765 m
.5 .13235 L
s
.40809 .86765 m
.5 .86765 L
s
.40809 .86765 m
.31618 .76261 L
s
.40809 .86765 m
.31618 .86765 L
s
[(1)] .48162 .11397 0 1 Mshowa
[(2)] .38971 .11397 0 1 Mshowa
[(3)] .29779 .11397 0 1 Mshowa
[(4)] .38971 .21901 0 1 Mshowa
[(5)] .20588 .11397 0 1 Mshowa
[(6)] .20588 .21901 0 1 Mshowa
[(7)] .48162 .21901 0 1 Mshowa
[(8)] .57353 .11397 0 1 Mshowa
[(9)] .48162 .32405 0 1 Mshowa
[(10)] .29779 .21901 0 1 Mshowa
[(11)] .20588 .32405 0 1 Mshowa
[(12)] .20588 .4291 0 1 Mshowa
[(13)] .57353 .21901 0 1 Mshowa
[(14)] .66544 .11397 0 1 Mshowa
[(15)] .84926 .48162 0 1 Mshowa
[(16)] .75735 .11397 0 1 Mshowa
[(17)] .75735 .21901 0 1 Mshowa
[(18)] .57353 .32405 0 1 Mshowa
[(19)] .66544 .21901 0 1 Mshowa
[(20)] .75735 .32405 0 1 Mshowa
[(21)] .75735 .4291 0 1 Mshowa
[(22)] .66544 .32405 0 1 Mshowa
[(23)] .75735 .53414 0 1 Mshowa
[(24)] .48162 .4291 0 1 Mshowa
[(25)] .29779 .32405 0 1 Mshowa
[(26)] .38971 .32405 0 1 Mshowa
[(27)] .57353 .4291 0 1 Mshowa
[(28)] .66544 .4291 0 1 Mshowa
[(29)] .75735 .63918 0 1 Mshowa
[(30)] .75735 .74422 0 1 Mshowa
[(31)] .20588 .53414 0 1 Mshowa
[(32)] .66544 .53414 0 1 Mshowa
[(33)] .38971 .4291 0 1 Mshowa
[(34)] .29779 .4291 0 1 Mshowa
[(35)] .38971 .53414 0 1 Mshowa
[(36)] .48162 .53414 0 1 Mshowa
[(37)] .57353 .53414 0 1 Mshowa
[(38)] .48162 .63918 0 1 Mshowa
[(39)] .66544 .63918 0 1 Mshowa
[(40)] .57353 .63918 0 1 Mshowa
[(41)] .29779 .53414 0 1 Mshowa
[(42)] .38971 .63918 0 1 Mshowa
[(43)] .48162 .74422 0 1 Mshowa
[(44)] .38971 .74422 0 1 Mshowa
[(45)] .75735 .84926 0 1 Mshowa
[(46)] .66544 .74422 0 1 Mshowa
[(47)] .66544 .84926 0 1 Mshowa
[(48)] .57353 .74422 0 1 Mshowa
[(49)] .20588 .63918 0 1 Mshowa
[(50)] .29779 .63918 0 1 Mshowa
[(51)] .20588 .74422 0 1 Mshowa
[(52)] .11397 .48162 0 1 Mshowa
[(53)] .57353 .84926 0 1 Mshowa
[(54)] .48162 .84926 0 1 Mshowa
[(55)] .20588 .84926 0 1 Mshowa
[(56)] .29779 .74422 0 1 Mshowa
[(57)] .29779 .84926 0 1 Mshowa
[(58)] .38971 .84926 0 1 Mshowa
P
% End of Graphics
MathPictureEnd

:[font = output; output; inactive; preserveAspect; endGroup; endGroup; endGroup]
Graphics["<<>>"]
;[o]
-Graphics-
:[font = input; preserveAspect]
UnfoldPolytope[facets1]
^*)
