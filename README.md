Create executable: swift build --configuration release
    
Usage: smidi [channel] [data1] [data2] [command]   
    
Commands: cc, on, off, sysex    
    
Example:    
smidi 1 20 127 cc  |  On channel 1, send CC command 20 value 127    
smidi 5 36 75 on   |  On channel 5, send NoteOn 36 velocity 75    
smidi 5 36 75 off  |  Send NoteOff     
    
Note: channel numbers are not zero indexed. Use 1 for channel 1, 2 for channel 2, etc.
