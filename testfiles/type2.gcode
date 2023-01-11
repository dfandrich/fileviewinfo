;PYCAM-META-DATA: Filename: C:\Users\Project\Desktop\Gcode_Title
;PYCAM-META-DATA: Timestamp: 2012-05-16 08:25:51.829000
;PYCAM-META-DATA: Version: 0.5.1.1
;Estimated machine time: 17 minutes
G40 (disable tool radius compensation)
G49 (disable tool length compensation)
G80 (cancel modal motion)
G54 (select coordinate system 1)
G90 (disable incremental moves)
G21 (metric)
G61 (exact path mode)
F500.00000
S1000.00000
;PYCAM_TOOLPATH_SETTINGS: START
;[Bounds]
;maxz = 0.0
;maxx = 194.472285
;maxy = 207.607451
;minx = -10.595135
;miny = -9.329961
;minz = 0.0
;PYCAM_TOOLPATH_SETTINGS: END
T4 M6
G0 Z2.0000
M5 (stop spindle)
G04 P3 (wait for 3 seconds)
G0 Z2.0000
M2 (end program)
