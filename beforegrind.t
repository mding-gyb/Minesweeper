%%%%%%%% VARIABLES %%%%%%%%%%%%%%
var title : int := Pic.FileNew ("title.jpg")
var gamemode : string

var easy : array 0 .. 9 of array 0 .. 11 of int
var easyshow : array 1 .. 8 of array 1 .. 10 of string
var display : array 1 .. 8 of array 1 .. 10 of boolean
var flags : array 1 .. 8 of array 1 .. 10 of boolean
var losee : int

var mousex, mousey, dummy1, dummy2, col, row, button : int
var newone := Pic.Scale (Pic.FileNew ("1.bmp"), 50, 50)
var newtwo := Pic.Scale (Pic.FileNew ("2.bmp"), 50, 50)
var newthree := Pic.Scale (Pic.FileNew ("3.bmp"), 50, 50)
var newfour := Pic.Scale (Pic.FileNew ("4.bmp"), 50, 50)
var newfive := Pic.Scale (Pic.FileNew ("5.bmp"), 50, 50)
var newemp := Pic.Scale (Pic.FileNew ("empty.bmp"), 50, 50)
var newPic := Pic.Scale (Pic.FileNew ("Block.bmp"), 50, 50)
var newbomb := Pic.Scale (Pic.FileNew ("Bomb.bmp"), 50, 50)
var flag := Pic.Scale (Pic.FileNew ("flag.jpg"), 50, 50)
var bad := Pic.Scale (Pic.FileNew ("Bad.bmp"), 50, 50)
var flagged := Pic.Scale (Pic.FileNew ("flagged.bmp"), 50, 50)


var counter : int := 10
%%%%%%%% FUNCTIONS %%%%%%%%%%%%%%

proc tutorial ()
    var menu : int := Pic.FileNew ("htp11.jpg")
    var menu2 : int := Pic.FileNew ("htp22.jpg")
    var d1, d2, d3, d4 : int
    cls
    View.Set ("graphics:800,600,offscreenonly")
    Pic.Draw (menu, 0, 0, picCopy)
    View.Update
    Mouse.ButtonWait ("down", d1, d2, d3, d4)
    Mouse.ButtonWait ("down", d1, d2, d3, d4)
    cls
    Pic.Draw (menu2, 0, 0, picCopy)
    View.Update
    Mouse.ButtonWait ("down", d1, d2, d3, d4)
    cls
end tutorial


function win () : boolean
    for y : 1 .. 8
	for x : 1 .. 10
	    if easyshow (y) (x) ~= "B" then
		if display (y) (x) = true then
		    result false
		end if
	    end if
	end for
    end for
    result true
end win

procedure check (row, col : int)
    if row > 0 and col > 0 and row < 9 and col < 11 and display (row) (col) = true then
	if easyshow (row) (col) = "0" then
	    display (row) (col) := false
	    check (row - 1, col)
	    check (row - 1, col - 1)
	    check (row, col - 1)
	    check (row + 1, col - 1)
	    check (row + 1, col)
	    check (row + 1, col + 1)
	    check (row, col + 1)
	    check (row - 1, col + 1)
	else
	    display (row) (col) := false
	end if
    end if
end check

procedure lose ()
    for x : 1 .. 10
	for y : 1 .. 8
	    if flags (y) (x) = true and easyshow (y) (x) ~= "B" then
		Pic.Draw (flagged, 50 * (x - 1) + 25, 50 * (y - 1) + 25, picCopy)
	    elsif display (y) (x) = true and flags (y) (x) = false and easyshow (y) (x) = "B" then
		Pic.Draw (newbomb, 50 * (x - 1) + 25, 50 * (y - 1) + 25, picCopy)
	    elsif flags (y) (x) = true and easyshow (y) (x) = "B" then
		Pic.Draw (flag, 50 * (x - 1) + 25, 50 * (y - 1) + 25, picCopy)
	    end if
	    View.Update
	    delay (20)
	end for
    end for

end lose

proc clicks (n : int)
    if mousex > 25 and mousex < 525 and mousey > 25 and mousey < 425 then
	if n = 1 and flags (row) (col) = false then
	    check (row, col)
	elsif n = 3 and display (row) (col) = true then
	    if flags (row) (col) = false then
		flags (row) (col) := true
	    elsif flags (row) (col) = true then
		flags (row) (col) := false
	    end if
	end if
    end if

    for x : 1 .. 10
	for y : 1 .. 8
	    if display (y) (x) = true and flags (y) (x) = true then
		Pic.Draw (flag, 50 * (x - 1) + 25, 50 * (y - 1) + 25, picCopy)
	    elsif display (y) (x) = true and flags (y) (x) = false then
		Pic.Draw (newPic, 50 * (x - 1) + 25, 50 * (y - 1) + 25, picCopy)
	    elsif display (y) (x) = false and flags (y) (x) = false then
		if easyshow (y) (x) = "1" then
		    Pic.Draw (newone, 50 * (x - 1) + 25, 50 * (y - 1) + 25, picCopy)
		elsif easyshow (y) (x) = "2" then
		    Pic.Draw (newtwo, 50 * (x - 1) + 25, 50 * (y - 1) + 25, picCopy)
		elsif easyshow (y) (x) = "3" then
		    Pic.Draw (newthree, 50 * (x - 1) + 25, 50 * (y - 1) + 25, picCopy)
		elsif easyshow (y) (x) = "4" then
		    Pic.Draw (newfour, 50 * (x - 1) + 25, 50 * (y - 1) + 25, picCopy)
		elsif easyshow (y) (x) = "5" then
		    Pic.Draw (newfive, 50 * (x - 1) + 25, 50 * (y - 1) + 25, picCopy)
		elsif easyshow (y) (x) = "0" then
		    Pic.Draw (newemp, 50 * (x - 1) + 25, 50 * (y - 1) + 25, picCopy)
		elsif easyshow (y) (x) = "B" then
		    Pic.Draw (bad, 50 * (x - 1) + 25, 50 * (y - 1) + 25, picCopy)
		    losee += 1
		end if
	    end if
	end for
    end for
end clicks


%%%%%%%%%%%%%        MENU           %%%%%%%%%%%%%%%%%%%

loop
    loop
	View.Set ("graphics:800;670,offscreenonly")
	losee := 0
	counter := 10
	Pic.Draw (title, 0, 0, picCopy)
	Mouse.Where (mousex, mousey, button)
	if mousex >= 210 and mousex <= 257 and mousey <= 225 and mousey >= 200 then
	    Draw.ThickLine (207, 200, 260, 200, 2, 29)
	    View.Update     %Easy
	    if button = 1 then
		exit
	    end if
	end if
	if mousex >= 210 and mousex <= 289 and mousey <= 200 and mousey >= 161 then
	    Draw.ThickLine (205, 166, 292, 166, 2, 29)
	    View.Update     %Medium
	    if button = 1 then
		exit
	    end if
	end if
	if mousex >= 210 and mousex <= 256 and mousey <= 161 and mousey >= 129 then
	    Draw.ThickLine (207, 134, 259, 134, 2, 29)
	    View.Update     %Hard
	    if button = 1 then
		exit
	    end if
	end if
	if mousex >= 194 and mousex <= 272 and mousey <= 129 and mousey >= 95 then
	    Draw.ThickLine (191, 100, 275, 100, 2, 29)
	    View.Update     %Tutorial
	    if button = 1 then
		tutorial
	    end if
	end if
	View.Update
    end loop
    %%%%% CHANGE SETTING %%%%%


    %%%%%%%%%% MAP %%%%%%%%%%%%
    Mouse.ButtonChoose ("multibutton")

    for c : 0 .. 9     %Generates Array for data and visuals
	for r : 0 .. 11
	    easy (c) (r) := 0
	end for
    end for

    loop             %Generates bombs
	for c : 1 .. 8
	    for r : 1 .. 10
		var random : int := Rand.Int (1, 8)
		if random = 1 and easy (c) (r) ~= 1 then
		    easy (c) (r) := 1
		    counter -= 1
		    exit when counter = 0
		end if
	    end for
	    exit when counter = 0
	end for
	exit when counter = 0
    end loop

    for c : 1 .. 8     %Sets coverscreen/blocks on top
	for r : 1 .. 10
	    display (c) (r) := true
	    flags (c) (r) := false
	end for
    end for


    for c : 1 .. 8     %Counting Bomb amount around square and setting bomb
	for r : 1 .. 10
	    if easy (c) (r) = 1 then
		easyshow (c) (r) := "B"
	    else
		easyshow (c) (r) := intstr (easy (c - 1) (r) + easy (c - 1) (r - 1) + easy (c) (r - 1) + easy (c + 1) (r - 1) + easy (c + 1) (r) + easy (c + 1) (r + 1) + easy (c) (r + 1) +
		    easy (c -
		    1) (r + 1))
	    end if
	end for
    end for
    setscreen ("graphics: 550,450,offscreenonly")




    for x : 1 .. 10
	for y : 1 .. 8
	    Pic.Draw (newPic, 50 * (x - 1) + 25, 50 * (y - 1) + 25, picCopy)
	    flags (y) (x) := false
	end for
    end for
    Mouse.ButtonWait ("up", mousex, mousey, dummy1, dummy2)
    col := (mousex - 25) div 50 + 1
    row := (mousey + 25) div 50

    loop
	View.Update
	Mouse.ButtonWait ("up", mousex, mousey, dummy1, dummy2)
	col := (mousex - 25) div 50 + 1
	row := (mousey + 25) div 50
	cls
	clicks (dummy1)
	exit when win ()
	if losee ~= 0 then
	    lose ()
	    exit
	end if
    end loop
    exit when win ()
end loop

if win () then
    for y : 1 .. 8
	for x : 1 .. 10
	    if easyshow (y) (x) = "B" then
		if display (y) (x) = true then
		    flags (y) (x) := true
		end if
	    end if
	end for
    end for
end if











