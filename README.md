Create executable: swift build --configuration release
    
Usage: smidi [data1] [data2] [command]   
    
Commands: cc, on, off, sysex    
    
Example:    
20 127 cc  |  Send command 20 value 127 as CC command    
36 75 on   |  Send NoteOn 36 with velocity 75    
36 75 off  |  Send NoteOff     
