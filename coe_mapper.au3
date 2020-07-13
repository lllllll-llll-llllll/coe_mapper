#include <GuiConstants.au3>

global $xprog = 0
global $yprog = 0

;gui
Opt("GUIOnEventMode", 1)
GUICreate("COE Mapper", 150, 135, -1, -1, $WS_THICKFRAME)

   GUICtrlCreateLabel("Progress", 100, 3, 50, 20)
   global $idxprog = GUICtrlCreateLabel('X: 0 / ?', 100, 23, 	100, 30)
   global $idyprog = GUICtrlCreateLabel('Y: 0 / ?', 100, 53, 	100, 30)

   GUICtrlCreateLabel("Min", 27, 3, 25, 20)
   GUICtrlCreateLabel("Max", 60, 3, 25, 20)

   GUICtrlCreateLabel("X", 5, 23, 15, 20)
   global $idxmin = GUICtrlCreateInput(-60, 20, 20, 30, 20)
   global $idxmax = GUICtrlCreateInput(+55, 55, 20, 30, 20)

   GUICtrlCreateLabel("Y", 5, 53, 15, 20)
   global $idymin = GUICtrlCreateInput(-97, 20, 50, 30, 20)
   global $idymax = GUICtrlCreateInput(+50, 55, 50, 30, 20)


   global $idstart = GUICtrlCreateButton("Start", 5,80,85,25)
   GUICtrlSetOnEvent(-1, 'download')

   global $idprogress = GUICtrlCreateLabel('', 0, 280, 300, 20, BitOR($SS_CENTER, $SS_CENTERIMAGE))

GUISetOnEvent($GUI_EVENT_CLOSE, "X")
GUISetState()

func X()
  exit
endfunc

;scraper
func download()
   disable()
   local $xmin 		= GUICtrlRead($idxmin)
   local $xmax 		= number(GUICtrlRead($idxmax) - $xmin)
   local $x 		= $xmin
   local $xcount 	= 1

   local $ymin 		= GUICtrlRead($idymin)
   local $ymax 		= number(GUICtrlRead($idymax) - $ymin)
   local $y 		= $ymin
   local $ycount 	= 1

   local $url 		= ''	; url to download
   local $location 	= ''	; location to save file
   local $delay  	= 300	; delay between images

   while $ycount <= $ymax
	  DirCreate(@scriptdir & '\' & $y)
	  while $xcount <= $xmax
		 $url = 'https://tiles.chroniclesofelyria.com/domains/map/2/8/'& $x &'/'& $y &'.png'		; this downloads from luna server, other servers use a different ".../map/#/#/..." format
		 $location = @scriptdir & '\' & $y & '\' & $xcount & '.png'
		 InetGet($url, $location, 1)
		 GUICtrlSetData($idxprog, $xcount & ' / ' & $xmax)
		 $x += 1
		 $xcount += 1
		 sleep($delay)

	  wend

	  $xcount = 1
	  $x = $xmin
	  GUICtrlSetData($idyprog, $ycount & ' / ' & $ymax)
	  $y+=1
	  $ycount+=1

   wend

   exit

endfunc


func disable()
   GUICtrlSetState($idstart, 		$GUI_DISABLE)
   GUICtrlSetState($idxmin, 		$GUI_DISABLE)
   GUICtrlSetState($idxmax, 		$GUI_DISABLE)
   GUICtrlSetState($idymin, 		$GUI_DISABLE)
   GUICtrlSetState($idymax, 		$GUI_DISABLE)

endfunc


while true
   sleep(1000)

wend
