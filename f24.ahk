#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force
#include Tippy.ahk

#If GetKeyState("F24")
F24::return

A::Tippy("F24 A")
B::Tippy("F24 B")
C::Tippy("F24 C")
D::Tippy("F24 D")
E::Tippy("F24 E")
F::Tippy("F24 F")
G::Tippy("F24 G")
H::Tippy("F24 H")
I::Tippy("F24 I")
J::Tippy("F24 J")
K::Tippy("F24 K")
L::Tippy("F24 L")
M::Tippy("F24 M")
N::Tippy("F24 N")
O::Tippy("F24 O")
P::Tippy("F24 P")
Q::Tippy("F24 Q")
R::Tippy("F24 R")
S::Tippy("F24 S")
T::Tippy("F24 T")
U::Tippy("F24 U")
V::Tippy("F24 V")
W::Tippy("F24 W")
X::Tippy("F24 X")
Y::Tippy("F24 Y")
Z::Tippy("F24 Z")

1::Tippy("F24 1")
2::Tippy("F24 2")
3::Tippy("F24 3")
4::Tippy("F24 4")
5::Tippy("F24 5")
6::Tippy("F24 6")
7::Tippy("F24 7")
8::Tippy("F24 8")
9::Tippy("F24 9")
0::Tippy("F24 0")

Space::Tippy("F24 Space")
#If

#If GetKeyState("F23")
F23::return

A::Tippy("F23 A")
B::Tippy("F23 B")
C::Tippy("F23 C")
D::Tippy("F23 D")
E::Tippy("F23 E")
F::Tippy("F23 F")
G::Tippy("F23 G")
H::Tippy("F23 H")
I::Tippy("F23 I")
J::Tippy("F23 J")
K::Tippy("F23 K")
L::Tippy("F23 L")
M::Tippy("F23 M")
N::Tippy("F23 N")
O::Tippy("F23 O")
P::Tippy("F23 P")
Q::Tippy("F23 Q")
R::Tippy("F23 R")
S::Tippy("F23 S")
T::Tippy("F23 T")
U::Tippy("F23 U")
V::Tippy("F23 V")
W::Tippy("F23 W")
X::Tippy("F23 X")
Y::Tippy("F23 Y")
Z::Tippy("F23 Z")

^A::Tippy("F23 CtrlA")
^+A::Tippy("F23 CtrlShiftA")
^+!#A::Tippy("F23 CtrlShiftAltWinA")

1::Tippy("F23 1")
2::Tippy("F23 2")
3::Tippy("F23 3")
4::Tippy("F23 4")
5::Tippy("F23 5")
6::Tippy("F23 6")
7::Tippy("F23 7")
8::Tippy("F23 8")
9::Tippy("F23 9")
0::Tippy("F23 0")

Space::Tippy("F23 Space")
#If